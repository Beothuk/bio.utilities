--------------------------------------------------------
--  DDL for View TEST_ITIS_GS_TAXON_TSN_VW
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."TEST_ITIS_GS_TAXON_TSN_VW" ("GIVEN_SCIENT_NAME", "GIVEN_SPEC_CODE", "GIVEN_TSN", "ACCEPTED_TSN", "UNACCEPT_REASON") AS 
  (
-- ---- ITIS supplies accepted TSN via SYNONYM_LINKS, but if there isn't a different accepted TSN it
-- ---- may not be in the synonym_links table, so NVL call.  Prefix unaccept reason with ITIS unaccept_reason
-- ---- as this is from where it is being extracted, later on there may be manual fix unaccept reasons added
select o.given_scient_name, o.given_spec_code, i.tsn given_tsn, NVL(s.tsn_accepted, i.tsn) accepted_tsn, 
CASE
  WHEN i.unaccept_reason is not null
  THEN 'ITIS unaccept_reason: '||i.unaccept_reason
  ELSE null
END unaccept_reason
from
-- ---- for each given_spec_code, parse the given_scient_name into two parts
-- ---- second part will only be populated (i.e. Not Null) when given_scient_name
-- ---- is Genus and species (and possibly more)
-- ---- This is necessary as ITIS splits Genus species into two parts as well 
-- ---- (unit_name1 and unit_name2)
(select distinct given_scient_name, given_spec_code,
CASE
  WHEN instr(given_scient_name, ' ') > 0
  THEN substr(
              given_scient_name, 
              1, 
              instr(given_scient_name, ' ')-1
              )
  ELSE trim(given_scient_name)
END givenname1,
CASE
  WHEN instr(given_scient_name, ' ') > 0 and instr(given_scient_name, ' ', instr(given_scient_name, ' ')+1) > 0 
  THEN trim( substr( 
                    given_scient_name, 
                    instr(given_scient_name, ' ')+1,
                    instr(given_scient_name, ' ', instr(given_scient_name, ' ')+1)-(instr(given_scient_name, ' ')+1)
                    ) 
            )
  WHEN instr(given_scient_name, ' ') > 0
  THEN trim( substr( 
                    given_scient_name, 
                    instr(given_scient_name, ' ')+1,
                    length(given_scient_name)
                    ) 
            )
  ELSE null
END givenname2,
CASE
  WHEN instr(given_scient_name, ' ', instr(given_scient_name, ' ')+1) > 0 
  THEN trim( substr(
                    given_scient_name, 
                    instr(given_scient_name, ' ', instr(given_scient_name, ' ')+1)+1,
                    length(given_scient_name)
                    )
           )
  ELSE null
END givenname3 
from GS_SPECIES_CODES_USED_VW) o
INNER JOIN
ITIS.TAXONOMIC_UNITS i 
-- ---- The first part of the given name is either Genus or higher, so must match unit_name1
-- ---- in itis.taxonomic_units and nothing we/fisheries do would use unit_name3 or unit_name4 
-- ---- so these must be Null in taxonomic_units table
ON upper(o.givenname1) = upper(i.unit_name1) and i.unit_name4 is null 
-- ---- either the second part was Null (only Genus or higher) or second part species or second part
-- ---- commonly used abbrev. for identified taxonomic rank (....)
-- ***** THINK I AM GOING TO MAKE A TABLE FOR THESE FREQUENTLY USED ABBREV WITH ASSOCIATED DESCRIPTIONS ******* --
and(upper(o.givenname2) = upper(i.unit_name2) or (i.unit_name2 is null and (o.givenname2 is null or 
upper(o.givenname2) IN(select abbrev from itis.taxon_suffix )   )))
and ( (upper(o.givenname3) = upper(i.unit_name3)) or (i.unit_name3 is null and (o.givenname3 is null or 
upper(o.givenname3) IN (select abbrev from itis.taxon_suffix) )
) )
LEFT OUTER JOIN
ITIS.SYNONYM_LINKS s
ON i.tsn = s.tsn
)
;
