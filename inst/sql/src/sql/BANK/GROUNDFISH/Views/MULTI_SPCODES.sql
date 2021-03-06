--------------------------------------------------------
--  DDL for View MULTI_SPCODES
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."MULTI_SPCODES" ("RESEARCH", "ICNAF", "FAO", "FAO_2002", "COMMON", "SCIENTIF", "COMMER", "NMFS", "ENTR", "DESCRIPTION", "IML", "NFLD", "IML_ENGLISHCOMMONNAME", "IML_FRENCHCOMMONNAME", "IML_SCIENTIFICNAME", "FAO_SCIENTIFIC_NAME", "FAO_FRENCH_NAME", "FAO_SPANISH_NAME", "FAO_ENGLISH_NAME", "TSN1", "TSN2", "TSN3") AS 
  select "RESEARCH","ICNAF","FAO","FAO_2002","COMMON","SCIENTIF","COMMER","NMFS","ENTR","DESCRIPTION","IML","NFLD","IML_ENGLISHCOMMONNAME","IML_FRENCHCOMMONNAME","IML_SCIENTIFICNAME","FAO_SCIENTIFIC_NAME","FAO_FRENCH_NAME","FAO_SPANISH_NAME","FAO_ENGLISH_NAME","TSN1","TSN2","TSN3" from itis.multi_spcodes
;
