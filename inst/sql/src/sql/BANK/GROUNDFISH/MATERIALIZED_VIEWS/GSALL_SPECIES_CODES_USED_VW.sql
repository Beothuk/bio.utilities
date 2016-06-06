--------------------------------------------------------
--  DDL for Materialized View GSALL_SPECIES_CODES_USED_VW
--------------------------------------------------------

  CREATE MATERIALIZED VIEW "GROUNDFISH"."GSALL_SPECIES_CODES_USED_VW" ("GIVEN_SPEC_CODE", "GIVEN_COMMON_NAME", "GIVEN_SCIENT_NAME", "FAO_CODE", "FAO_E_COMMON_NAME", "FAO_F_COMMON_NAME")
  ORGANIZATION HEAP PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "MFD_GROUNDFISH" 
  PARALLEL 2 
  BUILD IMMEDIATE
  USING INDEX 
  REFRESH FORCE ON DEMAND START WITH sysdate+0 NEXT NEXT_DAY(trunc(SysDate),'TUESDAY')+4/24
  USING DEFAULT LOCAL ROLLBACK SEGMENT
  DISABLE QUERY REWRITE
  AS (
select s.code given_spec_code, s.comm given_common_name, s.spec given_scient_name,
       f.a3_code fao_code, f.english_name fao_e_common_name, f.french_name fao_f_common_name
from gsspecies s
LEFT OUTER JOIN 
(select f2.scientific_name, a3_code, french_name, english_name
from mflib.fao_spcodes f2
INNER JOIN
  (select scientific_name, count(a3_code) cnt
  from mflib.fao_spcodes  
  group by scientific_name) f1
ON f2.scientific_name = f1.scientific_name and f1.cnt = 1
) f
on upper(f.scientific_name) in (upper(s.spec), upper(s.spec||' spp'))
WHERE s.spec is not null
);
 

   COMMENT ON MATERIALIZED VIEW "GROUNDFISH"."GSALL_SPECIES_CODES_USED_VW"  IS 'snapshot table for snapshot GROUNDFISH.GSALL_SPECIES_CODES_USED_VW';
  GRANT SELECT ON "GROUNDFISH"."GSALL_SPECIES_CODES_USED_VW" TO "MFLIB";
 
  GRANT SELECT ON "GROUNDFISH"."GSALL_SPECIES_CODES_USED_VW" TO "VDC";
 
  GRANT SELECT ON "GROUNDFISH"."GSALL_SPECIES_CODES_USED_VW" TO "HUBLEYB";
 
  GRANT SELECT ON "GROUNDFISH"."GSALL_SPECIES_CODES_USED_VW" TO "GREYSONP";
