--------------------------------------------------------
--  DDL for Materialized View GSDET_LENS
--------------------------------------------------------

  CREATE MATERIALIZED VIEW "GROUNDFISH"."GSDET_LENS" ("MISSION", "SETNO", "SPEC", "MINIMUMSIZE", "MAXIMUMSIZE", "AVERAGESIZE")
  ORGANIZATION HEAP PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "MFD_GROUNDFISH" 
  PARALLEL 2 
  BUILD IMMEDIATE
  USING INDEX 
  REFRESH COMPLETE ON DEMAND START WITH sysdate+0 NEXT (trunc(sysdate+1)+20/24)
  USING DEFAULT LOCAL ROLLBACK SEGMENT
  ENABLE QUERY REWRITE
  AS select	mission, setno, spec,
		min(flen) MinimumSize, 
		max(flen) MaximumSize, 
		ROUND(sum(flen*num_at_length)/sum(num_at_length),0) averagesize
	from ( 
		 select mission, setno, spec, flen, count(*) num_at_length
		 from groundfish.gsdet
		 group by mission, setno, spec, flen
		 )
	 group by mission, setno, spec

;
 

   COMMENT ON MATERIALIZED VIEW "GROUNDFISH"."GSDET_LENS"  IS 'snapshot table for snapshot GROUNDFISH.GSDET_LENS';
  GRANT SELECT ON "GROUNDFISH"."GSDET_LENS" TO "MFLIB";
 
  GRANT SELECT ON "GROUNDFISH"."GSDET_LENS" TO "VDC";
 
  GRANT SELECT ON "GROUNDFISH"."GSDET_LENS" TO "HUBLEYB";
 
  GRANT SELECT ON "GROUNDFISH"."GSDET_LENS" TO "GREYSONP";
