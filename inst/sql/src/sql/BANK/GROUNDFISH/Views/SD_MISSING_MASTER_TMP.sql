--------------------------------------------------------
--  DDL for View SD_MISSING_MASTER_TMP
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."SD_MISSING_MASTER_TMP" ("PREYSPECCD") AS 
  SELECT m.preyspeccd FROM SDItem_Master m
MINUS
SELECT i.preyspeccd FROM SDItem i
;
