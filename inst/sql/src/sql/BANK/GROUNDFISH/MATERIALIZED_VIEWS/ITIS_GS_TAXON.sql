--------------------------------------------------------
--  DDL for Materialized View ITIS_GS_TAXON
--------------------------------------------------------

  CREATE MATERIALIZED VIEW "GROUNDFISH"."ITIS_GS_TAXON" ("ACCEPTED_SCIENT_NAME", "ACCEPTED_TSN", "ACCEPTED_RANK", "SUBSPECIES_", "SPECIES_", "SUBGENUS", "GENUS_", "FAMILY_", "ORDER_", "CLASS_", "PHYLUM_", "KINGDOM_", "FAO_CODE", "FAO_E_COMMON_NAME", "FAO_F_COMMON_NAME", "GIVEN_COMMON_NAME", "GIVEN_SCIENT_NAME", "SCIENT_NAME_UPDATED", "REASON_SCIENT_UPDATED", "GIVEN_TSN", "GIVEN_SPEC_CODE", "ACCEPTED_AUTHOR", "ITIS_LINK", "FAO_LINK")
  ORGANIZATION HEAP PCTFREE 10 PCTUSED 40 INITRANS 2 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "MFD_GROUNDFISH" 
  PARALLEL 2 
  BUILD IMMEDIATE
  USING INDEX 
  REFRESH FORCE ON DEMAND
  USING DEFAULT LOCAL ROLLBACK SEGMENT
  DISABLE QUERY REWRITE
  AS (
select
  trim(tu.unit_name1||' '||tu.unit_name2) accepted_scient_name,
  trim(ost.ACCEPTED_TSN) accepted_tsn,
  trim(tut.rank_name) accepted_rank,
  CASE
    WHEN ost.accepted_tsn is null
	THEN trim(ost.subspecies_)
	ELSE trim(substr(ITIS.get_taxon_group(ost.accepted_tsn, 230),1,35))
  END subspecies_,
  CASE
    WHEN ost.accepted_tsn is null
	THEN trim(ost.species_)
	ELSE trim(substr(ITIS.get_taxon_group(ost.accepted_tsn, 220),1,35))
  END species_,
  CASE
    WHEN ost.accepted_tsn is null
	THEN trim(ost.subgenus_)
	ELSE trim(substr(ITIS.get_taxon_group(ost.accepted_tsn, 190),1,35))
  END subgenus,
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
    WHEN ost.accepted_tsn is null
    THEN 'Y'
    WHEN upper(ost.given_scient_name) = upper(trim(tu.unit_name1||' '||tu.unit_name2))
    THEN 'N'
    WHEN instr(ost.given_scient_name, ' ') > 0
	     and upper(substr(ost.given_scient_name, instr(ost.given_scient_name, ' ')+1, length(ost.given_scient_name)))
		 IN('SP.','F.','O.','S.O.','C.','P','S.F.','S.C.','SPP','S.','P.','SO.','SP','SPP.','S.P.')
             and upper(substr(ost.given_scient_name, 1, instr(ost.given_scient_name, ' ')-1))
                = upper(trim(tu.unit_name1||' '||tu.unit_name2))
    THEN 'N'
	ELSE 'Y'
  END scient_name_updated,
  trim(ost.unaccept_reason) reason_scient_updated,
  trim(ost.GIVEN_TSN) given_tsn,
  trim(ost.given_spec_code) given_spec_code,
  TRIM(tal.taxon_author) accepted_author,
  CASE
    WHEN trim(coalesce(ost.accepted_tsn, ost.given_tsn)) > 0
	THEN 'http://www.cbif.gc.ca/pls/itisca/next?v_tsn='||trim(coalesce(ost.accepted_tsn, ost.given_tsn))||'&'||'p_ifx=cbif'
    ELSE null
  END itis_link,
  CASE
    WHEN trim(coalesce(f.a3_code,ost.fao_code)) is not null
    THEN vdc.checkFigis('http://www.fao.org/figis/servlet/species?code='||trim(coalesce(f.a3_code,ost.fao_code))||'')
    ELSE null
  END fao_link
from
(select o.*, null subspecies_, null species_, null subgenus_, null genus_,
       null family_, null order_, null class_,
	   null phylum_, null kingdom_
 from itis_gs_taxon_accepted_vw o
where o.given_spec_code not in
        (select distinct given_spec_code from itis_gs_taxon_manual)
union
select *
 from itis_gs_taxon_manual) ost
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
)

;
 

   COMMENT ON MATERIALIZED VIEW "GROUNDFISH"."ITIS_GS_TAXON"  IS 'snapshot table for snapshot GROUNDFISH.ITIS_GS_TAXON';
  GRANT SELECT ON "GROUNDFISH"."ITIS_GS_TAXON" TO PUBLIC;
 
  GRANT SELECT ON "GROUNDFISH"."ITIS_GS_TAXON" TO "MFLIB";
 
  GRANT SELECT ON "GROUNDFISH"."ITIS_GS_TAXON" TO "VDC";
 
  GRANT SELECT ON "GROUNDFISH"."ITIS_GS_TAXON" TO "CHOIJ";
 
  GRANT SELECT ON "GROUNDFISH"."ITIS_GS_TAXON" TO "VDC_DEV";
 
  GRANT SELECT ON "GROUNDFISH"."ITIS_GS_TAXON" TO "RICARDD";
 
  GRANT SELECT ON "GROUNDFISH"."ITIS_GS_TAXON" TO "DIGIRDEV" WITH GRANT OPTION;
 
  GRANT SELECT ON "GROUNDFISH"."ITIS_GS_TAXON" TO "PED_HALIBUT";
 
  GRANT SELECT ON "GROUNDFISH"."ITIS_GS_TAXON" TO "HUBLEYB";
 
  GRANT SELECT ON "GROUNDFISH"."ITIS_GS_TAXON" TO "GREYSONP";
