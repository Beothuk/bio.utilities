--------------------------------------------------------
--  DDL for View ITIS_MP_MISSING_TSN_VW
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."ITIS_MP_MISSING_TSN_VW" ("GIVEN_SPEC_CODE", "GIVEN_COMMON_NAME", "GIVEN_SCIENT_NAME", "FAO_CODE", "FAO_E_COMMON_NAME", "FAO_F_COMMON_NAME") AS 
  (
select u.* 
from MP_SPECIES_CODES_USED_VW u
INNER JOIN
(
select given_scient_name, given_spec_code from MP_SPECIES_CODES_USED_VW
minus
select distinct given_scient_name, given_spec_code from itis_MP_taxon_tsn_vw
) m
on u.given_spec_code = m.given_spec_code and u.given_scient_name = m.given_scient_name
);
