--------------------------------------------------------
--  DDL for Table CFFISH
--------------------------------------------------------

  CREATE TABLE "GROUNDFISH"."CFFISH" 
   (	"FISHID" NUMBER(6,0), 
	"SAMPLEID" NUMBER(6,0), 
	"SPECIES" NUMBER(3,0), 
	"FISHNUMBER" NUMBER(6,0), 
	"OTOLITHNUMBER" NUMBER(6,0), 
	"STOMACHNUMBER" NUMBER(6,0), 
	"LENGTH" NUMBER(3,0), 
	"SEX" NUMBER(1,0), 
	"AGE" NUMBER(2,0), 
	"ROUNDWGT" NUMBER(6,0), 
	"GUTTEDWGT" NUMBER(6,0), 
	"LIVERWGT" NUMBER(5,0), 
	"GONADWGT" NUMBER(5,0), 
	"MATURITY" NUMBER(1,0), 
	"GUTFULLNESS" NUMBER(1,0), 
	"FSRS_COMMENTS" VARCHAR2(50 BYTE), 
	"STOMACHWGT" NUMBER(5,0)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 106496 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "MFD_GROUNDFISH"  ENABLE ROW MOVEMENT ;
 

   COMMENT ON COLUMN "GROUNDFISH"."CFFISH"."FISHID" IS '(PK) Sequence - (cffish_fishid_seq) ';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFFISH"."SAMPLEID" IS '(FK) References cfsamples.sampleid';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFFISH"."SPECIES" IS 'Code for species common name - (groundfish.sddet.spec, mfd_port_samples.gpspecies_edit.speciescode)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFFISH"."FISHNUMBER" IS 'Unique fish number - (groundfish.sddet.fishno)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFFISH"."OTOLITHNUMBER" IS 'Otolith identification number - (mfd_port_samples.gpages.otolith)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFFISH"."STOMACHNUMBER" IS 'Stomach identification number - (groundfish.sddet.fshno)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFFISH"."LENGTH" IS 'Length of fish(cm) - (mfd_port_samples.gpages.length)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFFISH"."SEX" IS 'Code for sex - (mfd_port_samples.gpages.sex)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFFISH"."AGE" IS 'Age in years - (mfd_port_samples.gpages.age)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFFISH"."ROUNDWGT" IS 'Round weight(gr) - (mfd_port_samples.gpages.weight)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFFISH"."GUTTEDWGT" IS 'Gutted weight(gr)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFFISH"."LIVERWGT" IS 'Liver weight(gr)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFFISH"."GONADWGT" IS 'Gonad weight(gr)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFFISH"."MATURITY" IS 'Code for maturity - (groundfish.gsmaturity.code)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFFISH"."GUTFULLNESS" IS 'Code for gut condition - (groundfish.sdfullness.fullness)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFFISH"."FSRS_COMMENTS" IS 'FSRS comments';
 
   COMMENT ON TABLE "GROUNDFISH"."CFFISH"  IS 'Table to store detail sample information';
  GRANT SELECT ON "GROUNDFISH"."CFFISH" TO "FOWLER";
 
  GRANT SELECT ON "GROUNDFISH"."CFFISH" TO "MFLIB";
 
  GRANT SELECT ON "GROUNDFISH"."CFFISH" TO "HURLEYP" WITH GRANT OPTION;
 
  GRANT SELECT ON "GROUNDFISH"."CFFISH" TO "VDC";
 
  GRANT SELECT ON "GROUNDFISH"."CFFISH" TO "VDC_DEV";
 
  GRANT SELECT ON "GROUNDFISH"."CFFISH" TO "RICARDD";
 
  GRANT SELECT ON "GROUNDFISH"."CFFISH" TO "HUBLEYB";
 
  GRANT SELECT ON "GROUNDFISH"."CFFISH" TO "CAPECHIDLEY" WITH GRANT OPTION;
 
  GRANT SELECT ON "GROUNDFISH"."CFFISH" TO "GREYSONP";
