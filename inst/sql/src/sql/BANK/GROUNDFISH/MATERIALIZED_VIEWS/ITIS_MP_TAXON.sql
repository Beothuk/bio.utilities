--------------------------------------------------------
--  DDL for Materialized View ITIS_MP_TAXON
--------------------------------------------------------

  CREATE MATERIALIZED VIEW "GROUNDFISH"."ITIS_MP_TAXON" ("ACCEPTED_SCIENT_NAME", "ACCEPTED_TSN", "ACCEPTED_RANK", "SPECIES_", "GENUS_", "FAMILY_", "ORDER_", "CLASS_", "PHYLUM_", "KINGDOM_", "FAO_CODE", "FAO_E_COMMON_NAME", "FAO_F_COMMON_NAME", "GIVEN_COMMON_NAME", "GIVEN_SCIENT_NAME", "SCIENT_NAME_UPDATED", "REASON_SCIENT_UPDATED", "GIVEN_TSN", "GIVEN_SPEC_CODE", "ACCEPTED_AUTHOR", "ITIS_LINK", "FAO_LINK")
  ORGANIZATION HEAP PCTFREE 10 PCTUSED 40 INITRANS 2 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "MFD_GROUNDFISH" 
  PARALLEL 2 
  BUILD IMMEDIATE
  USING INDEX 
  REFRESH FORCE ON DEMAND NEXT null
  USING DEFAULT LOCAL ROLLBACK SEGMENT
  DISABLE QUERY REWRITE
  AS (
select
  trim(tu.unit_name1||' '||tu.unit_name2) accepted_scient_name, 
  trim(ost.ACCEPTED_TSN) accepted_tsn, 
  trim(tut.rank_name) accepted_rank,
  CASE
    WHEN ost.accepted_tsn is null
	THEN trim(ost.species_)
	ELSE trim(substr(ITIS.get_taxon_group(ost.accepted_tsn, 220),1,35))
  END species_,
  CASE
    WHEN ost.accepted_tsn is null
	THEN trim(ost.genus_)
	ELSE trim(substr(ITIS.get_taxon_group(ost.accepted_tsn, 180),1,35))
  END genus_,
  CASE
    WHEN ost.accepted_tsn is null
	THEN trim(ost.family_)
	ELSE trim(substr(ITIS.get_taxon_group(ost.accepted_tsn, 140),1,35))
  END family_,
  CASE
    WHEN ost.accepted_tsn is null
	THEN trim(ost.order_)
	ELSE trim(substr(ITIS.get_taxon_group(ost.accepted_tsn, 100),1,35))
  END order_,
  CASE
    WHEN ost.accepted_tsn is null
	THEN trim(ost.class_)
	ELSE trim(substr(ITIS.get_taxon_group(ost.accepted_tsn, 60),1,35))
  END class_,  
  CASE
    WHEN ost.accepted_tsn is null
	THEN trim(ost.phylum_)
	ELSE trim(substr(ITIS.get_taxon_group(ost.accepted_tsn, 30),1,35))
  END phylum_, 
  CASE
    WHEN ost.accepted_tsn is null
	THEN trim(ost.kingdom_)
	ELSE trim(substr(ITIS.get_taxon_group(ost.accepted_tsn, 10),1,35))
  END kingdom_,   
  trim(coalesce(f.a3_code,ost.fao_code)) fao_code,
  trim(coalesce(f.english_name, ost.fao_e_common_name)) fao_e_common_name,
  trim(coalesce(f.french_name, ost.fao_f_common_name)) fao_f_common_name, 
  trim(ost.given_common_name) given_common_name,
  trim(ost.given_scient_name) given_scient_name,
  CASE
    WHEN ost.scient_name_updated is null and ost.accepted_tsn != ost.given_tsn
    THEN 'I'
    ELSE ost.scient_name_updated
  END scient_name_updated,
  trim(ost.unaccept_reason) reason_scient_updated,  
  trim(ost.GIVEN_TSN) given_tsn,
  trim(ost.given_spec_code) given_spec_code,
  TRIM(tal.taxon_author) accepted_author,
  CASE
    WHEN trim(coalesce(ost.accepted_tsn, ost.given_tsn)) > 0
	THEN 'http://www.cbif.gc.ca/pls/itisca/next?v_tsn='||trim(coalesce(ost.accepted_tsn, ost.given_tsn))||'\&'||'p_ifx=cbif'
    ELSE null
  END itis_link,
  CASE
    WHEN trim(coalesce(f.a3_code,ost.fao_code)) is not null
    THEN vdc.checkFigis('http://www.fao.org/figis/servlet/species?code='||trim(coalesce(f.a3_code,ost.fao_code))||'')
    ELSE null
  END fao_link
from 
(select o.*, null species_, null genus_, 
       null family_, null order_, null class_, 
	   null phylum_, null kingdom_, null scient_name_updated
 from itis_MP_taxon_accepted_vw o
where accepted_tsn is not null and
      o.given_spec_code not in 
        (select distinct given_spec_code from itis_MP_taxon_manual)
union
select *
 from itis_MP_taxon_manual) ost
LEFT OUTER JOIN
ITIS.taxonomic_units tu
ON ost.accepted_tsn = tu.tsn
LEFT OUTER JOIN
(select f2.scientific_name, a3_code, french_name, english_name
from mflib.fao_spcodes f2
INNER JOIN
  (select scientific_name, count(a3_code) cnt
  from mflib.fao_spcodes  
  group by scientific_name) f1
ON f2.scientific_name = f1.scientific_name and f1.cnt = 1
) f
-- as some Genus in FAO append spp to scientific name, need to compare with both just accepted name and
-- accepted name||' spp'
ON f.scientific_name IN (trim(tu.unit_name1||' '||tu.unit_name2),trim(trim(tu.unit_name1||' '||tu.unit_name2)||' spp'))
LEFT OUTER JOIN
ITIS.taxon_unit_types tut
on tu.rank_id = tut.rank_id and tu.kingdom_id = tut.kingdom_id
left outer join ITIS.taxon_authors_lkp tal
on   tal.TAXON_AUTHOR_ID = tu.taxon_author_id
);
 

  CREATE INDEX "GROUNDFISH"."ITIS_MP_TAXON_PK_IDX" ON "GROUNDFISH"."ITIS_MP_TAXON" ("GIVEN_SPEC_CODE", "GIVEN_SCIENT_NAME") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "MFD_GROUNDFISH" ;
 
  CREATE INDEX "GROUNDFISH"."ITIS_MP_TAXON_SCIENT_2_IDX" ON "GROUNDFISH"."ITIS_MP_TAXON" ("ACCEPTED_SCIENT_NAME") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "MFD_GROUNDFISH" ;
 
  CREATE INDEX "GROUNDFISH"."ITIS_MP_TAXON_SCIENT_IDX" ON "GROUNDFISH"."ITIS_MP_TAXON" ("GIVEN_SCIENT_NAME") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "MFD_GROUNDFISH" ;
 
  CREATE INDEX "GROUNDFISH"."ITIS_MP_TAXON_SPEC_IDX" ON "GROUNDFISH"."ITIS_MP_TAXON" ("GIVEN_SPEC_CODE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "MFD_GROUNDFISH" ;
 

   COMMENT ON COLUMN "GROUNDFISH"."ITIS_MP_TAXON"."ACCEPTED_SCIENT_NAME" IS 'ITIS provided accepted name for provided given_scient_name';
 
   COMMENT ON COLUMN "GROUNDFISH"."ITIS_MP_TAXON"."ACCEPTED_TSN" IS 'ITIS provided accepted TSN for provided given_scient_name';
 
   COMMENT ON COLUMN "GROUNDFISH"."ITIS_MP_TAXON"."ACCEPTED_RANK" IS 'ITIS provided accepted Rank per accepted TSN for provided given_scient_name';
 
   COMMENT ON COLUMN "GROUNDFISH"."ITIS_MP_TAXON"."SPECIES_" IS 'ITIS provided accepted specific epithet of the organism.';
 
   COMMENT ON COLUMN "GROUNDFISH"."ITIS_MP_TAXON"."GENUS_" IS 'ITIS provided accepted genus name of the organism.';
 
   COMMENT ON COLUMN "GROUNDFISH"."ITIS_MP_TAXON"."FAMILY_" IS 'ITIS provided accepted family to which the organism belongs.';
 
   COMMENT ON COLUMN "GROUNDFISH"."ITIS_MP_TAXON"."ORDER_" IS 'ITIS provided accepted order to which the organism belongs.';
 
   COMMENT ON COLUMN "GROUNDFISH"."ITIS_MP_TAXON"."CLASS_" IS 'ITIS provided accepted class to which the organism belongs.';
 
   COMMENT ON COLUMN "GROUNDFISH"."ITIS_MP_TAXON"."PHYLUM_" IS 'ITIS provided accepted phylum to which the organism belongs.';
 
   COMMENT ON COLUMN "GROUNDFISH"."ITIS_MP_TAXON"."KINGDOM_" IS 'ITIS provided accepted kingdom to which the organism belongs.';
 
   COMMENT ON COLUMN "GROUNDFISH"."ITIS_MP_TAXON"."FAO_CODE" IS 'Field abbrev from MFLIB.FAO_SPCODES associated with accepted_scient_name';
 
   COMMENT ON COLUMN "GROUNDFISH"."ITIS_MP_TAXON"."FAO_E_COMMON_NAME" IS 'English_name from MFLIB.FAO_SPCODES associated with FAO_CODE';
 
   COMMENT ON COLUMN "GROUNDFISH"."ITIS_MP_TAXON"."FAO_F_COMMON_NAME" IS 'French_name from MFLIB.FAO_SPCODES associated with FAO_CODE';
 
   COMMENT ON COLUMN "GROUNDFISH"."ITIS_MP_TAXON"."GIVEN_COMMON_NAME" IS 'Field comm from GSSPECIES associated with given_spec_code';
 
   COMMENT ON COLUMN "GROUNDFISH"."ITIS_MP_TAXON"."GIVEN_SCIENT_NAME" IS 'Field sspec from GSSPECIES associated with given_spec_code';
 
   COMMENT ON COLUMN "GROUNDFISH"."ITIS_MP_TAXON"."SCIENT_NAME_UPDATED" IS 'Y/N flag indicating if given_scient_name changed per accepted_scient_name';
 
   COMMENT ON COLUMN "GROUNDFISH"."ITIS_MP_TAXON"."REASON_SCIENT_UPDATED" IS 'Comments from ITIS and/or manual entry per reason scient_name_updated (=Y)';
 
   COMMENT ON COLUMN "GROUNDFISH"."ITIS_MP_TAXON"."GIVEN_TSN" IS 'ITIS provided TSN for provided given_scient_name, may have been provided from originating species list (e.g.Biochem)';
 
   COMMENT ON COLUMN "GROUNDFISH"."ITIS_MP_TAXON"."GIVEN_SPEC_CODE" IS 'A unique identifier for the provided given_scient_name, links to table GSSPECIES';
 
   COMMENT ON COLUMN "GROUNDFISH"."ITIS_MP_TAXON"."ACCEPTED_AUTHOR" IS 'ITIS provided accepted author of the ITIS accepted scientific name.';
 
   COMMENT ON COLUMN "GROUNDFISH"."ITIS_MP_TAXON"."ITIS_LINK" IS 'URL to ITIS Factsheet for accepted/given TSN.';
 
   COMMENT ON COLUMN "GROUNDFISH"."ITIS_MP_TAXON"."FAO_LINK" IS 'URL to FAO Factsheet, if exists, for FAO_CODE.';
 
   COMMENT ON MATERIALIZED VIEW "GROUNDFISH"."ITIS_MP_TAXON"  IS 'snapshot table for snapshot GROUNDFISH.ITIS_MP_TAXON';
  GRANT SELECT ON "GROUNDFISH"."ITIS_MP_TAXON" TO "BAJONAL";
 
  GRANT SELECT ON "GROUNDFISH"."ITIS_MP_TAXON" TO "MFLIB";
 
  GRANT SELECT ON "GROUNDFISH"."ITIS_MP_TAXON" TO "VDC";
 
  GRANT SELECT ON "GROUNDFISH"."ITIS_MP_TAXON" TO "VDC_DEV";
 
  GRANT SELECT ON "GROUNDFISH"."ITIS_MP_TAXON" TO "DIGIRDEV";
 
  GRANT SELECT ON "GROUNDFISH"."ITIS_MP_TAXON" TO "DIGIR";
 
  GRANT SELECT ON "GROUNDFISH"."ITIS_MP_TAXON" TO "HUBLEYB";
 
  GRANT SELECT ON "GROUNDFISH"."ITIS_MP_TAXON" TO "GREYSONP";
