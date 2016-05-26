

      decibar2depth = function( P, lat, Del=0, method="default" ) {
        
        if (method %in% c("default", "seabird", "unesco" ) ) {
          # http://www.code10.info/index.php?option=com_content&view=article&id=67:calculating-the-depth-from-pressure&catid=54:cat_coding_algorithms_seawater&Itemid=79
          # DEPTH IN METERS FROM PRESSURE IN DECIBARS USING SAUNDERS AND FOFONOFF'S METHOD.
          # DEEP-SEA RES., 1976, 23, 109-111.
          # / UNITS:
          # //   PRESSURE     P      DECIBARS
          # //   LATITUDE     LAT    DEGREES
          # //   DEPTH        DEPTH  METERS
          # //   DTN. HEIGHT  DEL    DYN. METERS (geopotenial anomaly in J/kg:: assume 0) 
          # // CHECKVALUE:
          # //   1.) DEPTH = 9712.653 M for P=10000 DECIBARS, LAT=30 DEG, DEL=0
          # //   ABOVE FOR STANDARD OCEAN: T=0 DEG CELSIUS; S=35 (PSS-78)
          # // ----------------------------------------------------------
          # // Original fortran code is found in:
          # //   UNESCO technical papers in marine science 44 (1983) -
          # //   'Algorithms for computation of fundamental properties of seawater'
          
          X = (sin( lat * pi / 180 ))^2 # convert degree decimal to RADs

          # GR=GRAVITY VARIATION WITH LATITUDE: ANON (1970) BULLETIN GEODESIQUE
          GR = 9.780318 * (1.0 + (5.2788E-3 + 2.36E-5 * X) * X) + 1.092E-6 * P
          DepthTerm = (((-1.82E-15 * P + 2.279E-10) * P - 2.2512E-5) * P + 9.72659) * P ## assuming (35 psu, 0 C, and P=pressure in decibars )
          DEPTH = DepthTerm / GR + Del / 9.8
          return (DEPTH)
        }

        if (method %in% c("seabird", "unesco") ){

          ## NOTE this method is the same as the above ...
          
          # http://www.seabird.com/application_notes/AN69.htm
          # 
          # Sea-Bird uses the formula in UNESCO Technical Papers in Marine Science No. 44. 
          # This is an empirical formula that takes compressibility (that is, density) into account. 
          # An ocean water column at 0 °C (t = 0) and 35 PSU (s = 35) is assumed.
          # 
          # The gravity variation with latitude and pressure is computed as:
          # 
          # g (m/sec2) = 9.780318 * [ 1.0 + ( 5.2788x10 -3  + 2.36x10 -5  * x) * x ] + 1.092x10 -6  * p
          # 
          # where 
          # x = [sin (latitude / 57.29578) ] ^2 
          # p = pressure (decibars)
          # 
          # Then, depth is calculated from pressure:
          # 
          # depth (meters) = [(((-1.82x10 -15  * p + 2.279x10 -10 ) * p - 2.2512x10 -5 ) * p + 9.72659) * p] / g
          # 
          # where 
          # p = pressure (decibars) 
          # g = gravity (m/sec2)
          
          # x = (sin (latitude / 57.29578) )^2
          # g = 9.780318 * [ 1.0 + ( 5.2788E-3  + 2.36E-5  * x) * x ] + 1.092E-6  * p
          # depth = ((((-1.82E-15  * p + 2.279E-10 ) * p - 2.2512E-5 ) * p + 9.72659) * p) / g


        }


      }


