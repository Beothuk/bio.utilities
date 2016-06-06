--------------------------------------------------------
--  DDL for View CFERRREPORT
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."CFERRREPORT" ("ID", "SAMPLE", "SOURCE", "SETNO", "FISHNUMBER", "FSRS_SAMPLED", "MESS_ID", "TIMESTAMP_ID", "MESSAGE", "TECH", "TIMESTAMP") AS 
  SELECT a."ID",a."SAMPLE",a."SOURCE",a."SETNO",a."FISHNUMBER",a."FSRS_SAMPLED",a."MESS_ID",a."TIMESTAMP_ID", b.message, c.fsrs_sampled tech, d.timestamp
	FROM cferrlog a, cferrmess b, cffsrs_sampled c, cftimestamps d
	WHERE a.mess_id = b.mess_id
	AND NVL(a.fsrs_sampled,999) = c.fsrs_sampleid
	AND a.timestamp_id = d.id 
;
 

   COMMENT ON COLUMN "GROUNDFISH"."CFERRREPORT"."ID" IS 'Error Report ID';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFERRREPORT"."SAMPLE" IS 'Serial Number';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFERRREPORT"."SOURCE" IS 'Code for data sources';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFERRREPORT"."SETNO" IS 'Setno - 999 for no setno';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFERRREPORT"."FISHNUMBER" IS 'Unique fish number';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFERRREPORT"."FSRS_SAMPLED" IS 'Code for FSRS sampler';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFERRREPORT"."MESS_ID" IS 'Error message ID';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFERRREPORT"."TIMESTAMP_ID" IS 'Timestamp ID';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFERRREPORT"."MESSAGE" IS 'Error message';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFERRREPORT"."TECH" IS 'FSRS Technician';
 
   COMMENT ON COLUMN "GROUNDFISH"."CFERRREPORT"."TIMESTAMP" IS 'Timestamp of last execution';
 
   COMMENT ON TABLE "GROUNDFISH"."CFERRREPORT"  IS 'View to query error identification information';
