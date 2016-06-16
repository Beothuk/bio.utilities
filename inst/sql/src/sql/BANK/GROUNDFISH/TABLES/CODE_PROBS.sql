--------------------------------------------------------
--  DDL for Table CODE_PROBS
--------------------------------------------------------

  CREATE TABLE "GROUNDFISH"."CODE_PROBS" 
   (	"SOURCE" CHAR(4 BYTE), 
	"CODE" NUMBER(4,0), 
	"SPEC" VARCHAR2(49 BYTE), 
	"COMM" VARCHAR2(38 BYTE), 
	"TSN" NUMBER(10,0), 
	"TSN_ACCEPTED" NUMBER(10,0), 
	"ITIS_NAME" VARCHAR2(71 BYTE), 
	"RANK_NAME" VARCHAR2(15 BYTE), 
	"TAXON_AUTHOR" VARCHAR2(100 BYTE), 
	"NTOW" NUMBER, 
	"TOTNO" NUMBER, 
	"TOTWGT" NUMBER
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "MFD_GROUNDFISH" ;
  GRANT SELECT ON "GROUNDFISH"."CODE_PROBS" TO "RICARDD";
 
  GRANT SELECT ON "GROUNDFISH"."CODE_PROBS" TO "HUBLEYB";
 
  GRANT SELECT ON "GROUNDFISH"."CODE_PROBS" TO "GREYSONP";