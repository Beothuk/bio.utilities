--------------------------------------------------------
--  DDL for View GSBOTTOMHYD
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."GSBOTTOMHYD" ("MISSION", "SETNO", "SDEPTH", "TEMP", "SAL") AS 
  SELECT i.mission, i.setno,   
       ROUND(decode(nvl(b.temp,-99),-99,decode(nvl(c.temp,-99),-99,NULL,c.sdepth),b.sdepth),2) sdepth,   
	   decode(nvl(c.temp,-99),-99,b.temp,c.temp) temp,   
	   decode(nvl(c.sal,-99),-99,b.sal,c.sal) sal   
  FROM (select i.mission, i.setno, h.sdepth, h.temp, h.sal   
          FROM gsinf i,   
		     (select mission, setno, sdepth, temp, sal from gshyd where gear=1 and bid='B') h   
		 WHERE i.mission=h.mission(+) and i.setno=h.setno(+)) b,   
	   (select i.mission, i.setno, h.sdepth, h.temp, h.sal   
	      from gsinf i,   
	   (select mission, setno, sdepth, temp, sal from gshyd where gear=2 and bid='B') h   
		WHERE i.mission=h.mission(+) and i.setno=h.setno(+)) c, gsinf i, mflib.gs_survey_list l   
 WHERE i.mission=b.mission and i.setno=b.setno   
   and i.mission=c.mission and i.setno=c.setno   
   and i.mission=l.mission
;
