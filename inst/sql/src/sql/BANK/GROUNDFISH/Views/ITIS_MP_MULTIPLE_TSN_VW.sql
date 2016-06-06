--------------------------------------------------------
--  DDL for View ITIS_MP_MULTIPLE_TSN_VW
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."ITIS_MP_MULTIPLE_TSN_VW" ("GIVEN_COMMON_NAME", "GIVEN_SPEC_CODE", "GIVEN_SCIENT_NAME", "GIVEN_TSN", "ACCEPTED_TSN", "UNACCEPT_REASON", "SPECIES_", "GENUS_", "FAMILY_", "ORDER_", "CLASS_", "PHYLUM_", "KINGDOM_", "USAGE", "CREDIBILITY_RTNG") AS 
  (
select
  ost.given_common_name,
  ost.given_spec_code,
  ost.given_scient_name,
  ost.GIVEN_TSN,
  ost.ACCEPTED_TSN,
  ost.unaccept_reason, 
  trim(substr(ITIS.get_taxon_group(ost.accepted_tsn, 220),1,35)) species_,
  trim(substr(ITIS.get_taxon_group(ost.accepted_tsn, 180),1,35)) genus_,
  trim(substr(ITIS.get_taxon_group(ost.accepted_tsn, 140),1,35)) family_,
  trim(substr(ITIS.get_taxon_group(ost.accepted_tsn, 100),1,35)) order_,
  trim(substr(ITIS.get_taxon_group(ost.accepted_tsn, 60),1,35)) class_,
  trim(substr(ITIS.get_taxon_group(ost.accepted_tsn, 30),1,35)) phylum_,
  trim(substr(ITIS.get_taxon_group(ost.accepted_tsn, 10),1,35)) kingdom_,
   tu.usage,
   tu.CREDIBILITY_RTNG
from 
-- ---- get the species and associated attributes for those not
-- ---- automatically assigned accepted_TSN
(select a.*, b.given_common_name
from itis_MP_taxon_tsn_vw a 
INNER JOIN
itis_MP_taxon_accepted_vw b
on a.given_spec_code = b.given_spec_code
where b.accepted_tsn is null) ost
INNER JOIN
ITIS.taxonomic_units tu
on ost.accepted_tsn = tu.tsn
);
