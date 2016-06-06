--------------------------------------------------------
--  DDL for Table CFSAMPLES
--------------------------------------------------------

  CREATE TABLE "GROUNDFISH"."CFSAMPLES" 
   (	"SAMPLEID" NUMBER(6,0), 
	"SOURCE" VARCHAR2(3 BYTE), 
	"SAMPLE" VARCHAR2(15 BYTE), 
	"SETNO" NUMBER(4,0), 
	"DATESAMPLED" DATE, 
	"AREA" VARCHAR2(3 BYTE), 
	"DEPTH" NUMBER(3,0), 
	"FISHING" VARCHAR2(1 BYTE), 
	"DFO_SAMPLED" VARCHAR2(2 BYTE), 
	"FSRS_SAMPLED" NUMBER(4,0), 
	"CFV" VARCHAR2(8 BYTE), 
	"FG_CODE" NUMBER(4,0), 
	"FG_NORTH_LAT" NUMBER(6,2), 
	"FG_SOUTH_LAT" NUMBER(6,2), 
	"FG_EAST_LONG" NUMBER(6,2), 
	"FG_WEST_LONG" NUMBER(6,2), 
	"FG_REMARKS" VARCHAR2(500 BYTE), 
	"FSRS_REMARKS" VARCHAR2(255 BYTE)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 106496 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "MFD_GROUNDFISH" ;
 

   COMMENT ON COLUMN "GROUNDFISH"."CFSAMPLES"."SAMPLEID" IS '(PK) Sequence - (cfsamples_sampleid_seq)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFSAMPLES"."SOURCE" IS 'Code for data source - (groundfish.sdsource.datasource, groundfish.sddet.datasource)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFSAMPLES"."SAMPLE" IS 'Serial Number - (mfd_port_samples.gpsamples.sample, groundfish.sddet.mission)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFSAMPLES"."SETNO" IS 'Set Number - (groundfish.sddet.setno)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFSAMPLES"."DATESAMPLED" IS 'Date sample was taken - (mfd_port_samples.gpsamples.datesampled)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFSAMPLES"."AREA" IS 'Code for stat unit area - (mfd_port_samples.gpuniq_area.areacode)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFSAMPLES"."DEPTH" IS 'Average fishing depth in fathoms - (mfd_port_samples.gpsamples.depth)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFSAMPLES"."FISHING" IS 'Code for type of fishing gear - (mfd_port_samples.gpuniq_gear.gearcode)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFSAMPLES"."DFO_SAMPLED" IS 'Code for name of port sampler - (mfd_port_samples.gpuniq_sampled.sampledcode)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFSAMPLES"."FSRS_SAMPLED" IS 'Code for FSRS sampler - (cftmpfsrs_sampled.technician_codes)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFSAMPLES"."CFV" IS 'Commercial fishing vessel number - (mfd_port_samples.gpsamples.cfv)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFSAMPLES"."FG_CODE" IS 'Code for name of fishing ground - (mfg_port_samples.gpsamples.fg_code)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFSAMPLES"."FG_NORTH_LAT" IS 'North boundary of area actually fished - (mfd_port_samples.gpsamples.fg_north_lat)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFSAMPLES"."FG_SOUTH_LAT" IS 'South boundary of area actually fished - (mfd_port_samples.gpsamples.fg_south_lat)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFSAMPLES"."FG_EAST_LONG" IS 'East boundary of area actually fished - (mfd_port_samples.gpsamples.fg_east_long)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFSAMPLES"."FG_WEST_LONG" IS 'West boundary of area actually fished - (mdf_port_samples.gpsamples.fg_west_long)';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFSAMPLES"."FG_REMARKS" IS 'DFO port technician remarks';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFSAMPLES"."FSRS_REMARKS" IS 'FSRS sampling technician remarks';
 
   COMMENT ON TABLE "GROUNDFISH"."CFSAMPLES"  IS 'Table to store sample positional information';
  GRANT SELECT ON "GROUNDFISH"."CFSAMPLES" TO "FOWLER";
 
  GRANT SELECT ON "GROUNDFISH"."CFSAMPLES" TO "MFLIB";
 
  GRANT SELECT ON "GROUNDFISH"."CFSAMPLES" TO "HURLEYP" WITH GRANT OPTION;
 
  GRANT SELECT ON "GROUNDFISH"."CFSAMPLES" TO "VDC";
 
  GRANT SELECT ON "GROUNDFISH"."CFSAMPLES" TO "VDC_DEV";
 
  GRANT SELECT ON "GROUNDFISH"."CFSAMPLES" TO "RICARDD";
 
  GRANT SELECT ON "GROUNDFISH"."CFSAMPLES" TO "HUBLEYB";
 
  GRANT SELECT ON "GROUNDFISH"."CFSAMPLES" TO "CAPECHIDLEY" WITH GRANT OPTION;
 
  GRANT SELECT ON "GROUNDFISH"."CFSAMPLES" TO "GREYSONP";
