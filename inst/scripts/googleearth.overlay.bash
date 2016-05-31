#!/bin/bash
# to create background bathymetry for googlearth etc.

region=" -R-72/-52/40/50"    
# projection="-JL-62/44/42/46/8i"  # Lambert Conical
# projection="-JM-62/45/8i"  # Mercator
# projection="-JU-20/8i"  # Universal Transverse Mercator Cylindrical (conformal)
projection="-JQ-62/8i"  # Cylindrical equidistant (Plate Carre)
resolution="-I0.25m"
out="/home/jae/bio/bathymetry/ss.highres.ps"
in="/home/jae/bio/bathymetry/data/bathymetry.canada.east.xyz"

d1="/tmp/isobaths.bin"
d2="/tmp/isobaths_clipped.bin"
grd="/tmp/isobaths.grd"

psappend="-O -K"

gmtconvert -bo $in > $d1
blockmedian $region $resolution $d1 -bi3 -bo > $d2
surface $region $resolution $d2 -T0.35 -G$grd -bi3
makecpt -Cjet -T-350/350/50 -Z -D > bathy.cpt

psmask $region $projection $resolution $d1 -bi3 $psappend > $out
grdclip $grd -Sa-10/NaN -Sb-10000/NaN -G$grd
grdimage $grd $projection -Cbathy.cpt -Q $psappend  >> $out
# grdcontour $grd $projection -Cbathy.cpt -A- -S0.2m -W+faint -L-350/-1  $psappend >> $out
psmask -C $psappend >> $out

psbasemap $region $projection -Bnesw -K > test.ps
# psbasemap $region $projection -B2neSW -K > test.ps
cat $out >> test.ps
pscoast $region $projection -Dh -W0.1p -O >> test.ps
# pscoast $region $projection -Df -Gc -O >> test.ps

gv test.ps


gmip test.ps 
save as *.tif

geotifcp -4 "+proj=lcc +lat_1=45 +lon_0=-62 +ellps=WGS84" -c lzw ss.bathy.colour.tif ss.bathy.colour.geo.tif 


For UTM:
geotifcp -4 "+proj=utm +zone=20 +ellps=WGS84" -c lzw ss.bathy.colour.tif ss.bathy.colour.geo.tif 


finally using Plate Carre which is the default for Googleearth
geotifcp -4 "+proj=eqc +lat_ts=0 +lat_0=0 +lon_0=-62 +ellps=WGS84" -c lzw ss.bathy.colour.tif ss.bathy.colour.geo.tif 
# the above does not work .. not sure why

   
# rm $d1 $d2 $grd 



