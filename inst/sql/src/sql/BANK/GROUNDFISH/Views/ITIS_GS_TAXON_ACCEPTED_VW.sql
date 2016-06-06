--------------------------------------------------------
--  DDL for View ITIS_GS_TAXON_ACCEPTED_VW
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."ITIS_GS_TAXON_ACCEPTED_VW" ("GIVEN_SPEC_CODE", "GIVEN_COMMON_NAME", "GIVEN_SCIENT_NAME", "FAO_CODE", "FAO_E_COMMON_NAME", "FAO_F_COMMON_NAME", "GIVEN_TSN", "ACCEPTED_TSN", "UNACCEPT_REASON") AS 
  (
select u.*, f.given_tsn, f.accepted_tsn, f.unaccept_reason
from GS_SPECIES_CODES_USED_VW u
-- ---- All original used species will be in the accepted table, but only those automatically
-- ---- assigned an accepted_TSN will have associated TSN attributes
LEFT OUTER JOIN
(
select ost.* from
itis_gs_taxon_tsn_vw ost
INNER JOIN
-- ---- Current design forces scientificnames with multiple species codes to be "marked" for
-- ---- manual review ... thus cnt_scient
(
select given_scient_name, count(distinct given_spec_code) cnt_scient, count(given_tsn) cnt_gvn, count(distinct accepted_tsn) cnt_accpt 
from itis_gs_taxon_tsn_vw
group by given_scient_name
) o 
on ost.given_scient_name = o.given_scient_name
-- ---- So if not duplicate scientific name and 
-- ---- (either single given_tsn or (single accepted_tsn and one of the multiple given_TSN = accepted_tsn)
-- ---- then valid accepted_TSN, otherwise, do not include TSN attributes for this species/scientific_name
-- ---- thus "marked" for manual review/intervention
where o.cnt_scient = 1 and (o.cnt_gvn = 1 or (o.cnt_accpt = 1 and ost.given_tsn = ost.accepted_tsn))
) f
ON u.given_spec_code = f.given_spec_code
)
;
