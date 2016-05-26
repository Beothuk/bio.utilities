


  variable.list.expand = function(component="all.data") {
    
    V = switch( EXPR=component,
      
    sp.list = c( 
      "forage.fish", "all", "allfish", "elasmobranchs", "gadoid", "flatfish",
      "demersal", "large.demersal", "small.demersal",
      "pelagic", "large.pelagic", "small.pelagic",
      "commercial", "noncommercial", 
      "cod", "haddock", "american.plaice", "silver.hake", "white.hake", 
      "capelin", "herring", "mackerel", "sandlance", "redfish", "wolffish",
      "winter.flounder", 
      "spiny.dogfish",  "thornyskate",
      "crabs", "snowcrab", "northernshrimp", "squid" 
    ), 
    multispecies = c( "all", "elasmobranchs", "demersal", "large.demersal", "small.demersal",
      "pelagic", "large.pelagic", "small.pelagic", "flatfish", "commercial", "noncommercial"
    ),
    days = c("all.1km.10day", "all.50km.10day", "all.1km.50day", "all.50km.50day" 
    ),

    all = c(
      paste( "totno", variable.list.expand("sp.list"), sep="." ),
      paste( "totwgt", variable.list.expand("sp.list"),  sep="." ),
      paste( "ntaxa", variable.list.expand("multispecies"),  sep="." ),
      paste( "rmean", variable.list.expand("sp.list"),  sep="." ),
      paste( "pmean", variable.list.expand("sp.list"),  sep="." ),
      paste( "mmean", variable.list.expand("sp.list"),  sep="." ),
#      paste( "lmean", variable.list.expand("sp.list"),  sep="." ),
      paste( "nss.rsquared", variable.list.expand("days"), sep="."),
      paste( "nss.df", variable.list.expand("days"), sep="."),
      paste( "nss.b0", variable.list.expand("days"), sep="."),
      paste( "nss.b1", variable.list.expand("days"), sep="."),
      paste( "nss.shannon", variable.list.expand("days"), sep="."),
      paste( "nss.evenness", variable.list.expand("days"), sep="."),
      paste( "nss.Hmax", variable.list.expand("days"), sep="."),
      paste( "ntaxa", "annual",c(1,seq(20,200,20)), sep="."),
      "C", "Z", "sar.rsq", "Npred", 
      "mr", "mrT", "smr", "smrT", "mrPvalue", "mrPvalueT",
      "ca1", "ca2", "shannon", "evenness", "Hmax",
      "sdepth", "temp", "sal", "oxyml", "julian"
    ),

      catch.summary = variable.list.expand("sp.list") ,
  
               
       physical = c("z", "t", "julian"),
       
       males.general = c(
        "totmass.male.com", "totno.male.com", "totno.male.mat", "totno.male.imm", "totno.male", 
        "R0.mass", "R0.no","R1.no", "R2.no", "R3.no", "R4.no", "R5p.no",
        "male.large.mass", "male.small.mass", "male.large.no", "male.small.no", "dwarf.no", "totno.male.skip.moulter"
      ),
      males.CC = c( 
        "totno.male.com.CC1", "totno.male.com.CC2", "totno.male.com.CC3", "totno.male.com.CC4", "totno.male.com.CC5",
        "totno.male.com.CC1to2", "totno.male.com.CC3to4",
        "totmass.male.com.CC1", "totmass.male.com.CC2", "totmass.male.com.CC3", "totmass.male.com.CC4", "totmass.male.com.CC5",
        "totmass.male.com.CC1to2", "totmass.male.com.CC3to4"
      ),
      males.instar = c( 
        "mi123.no", "mi4.no", "mi5.no", "mi6.no", "mi7.no", "mi8.no","mi9.no", "mi10.no", "mi11.no", "mi12.no",
        "mi9.skip.moulter.no", "mi10.skip.moulter.no","mi11.skip.moulter.no","mi12.skip.moulter.no",
        "ma9.no","ma10.no","ma11.no","ma12.no","ma13.no",
        "ma9.CC1to2.no","ma10.CC1to2.no","ma11.CC1to2.no","ma12.CC1to2.no","ma13.CC1to2.no",
        "ma9.CC3to4.no","ma10.CC3to4.no","ma11.CC3to4.no","ma12.CC3to4.no","ma13.CC3to4.no",
        "ma9.CC5.no","ma10.CC5.no","ma11.CC5.no","ma12.CC5.no","ma13.CC5.no" 
      ),
      females.instar = c(
        "fi1234.no", "fi5.no", "fi6.no", "fi7.no", "fi8.no", "fi9.no", "fi10.no",
        "fi6.adolescent.no","fi7.adolescent.no","fi8.adolescent.no","fi9.adolescent.no","fi10.adolescent.no",
        "fi6.preprimiparous.no","fi7.preprimiparous.no", "fi8.preprimiparous.no", "fi9.preprimiparous.no","fi10.preprimiparous.no",
        "fa7.no","fa8.no","fa9.no","fa10.no",
        "fa7.berried.no","fa8.berried.no","fa9.berried.no","fa10.berried.no",
        "fa7.primiparous.no","fa8.primiparous.no","fa9.primiparous.no","fa10.primiparous.no",
        "fa7.multiparous.no","fa8.multiparous.no","fa9.multiparous.no","fa10.multiparous.no",
        "fa7.senile.no","fa8.senile.no","fa9.senile.no","fa10.senile.no" 
      ),
      females.general = c(
        "totno.female.berried","totno.female.imm", "totno.female.mat", "totno.female.primiparous","totno.female.multiparous", "fecundity", 
        "female.large.mass", "female.small.mass", "female.large.no", "female.small.no", "totno.female"
      ),
      snowcrab.general = c(
        "totno.all", "totmass.all"
      ),
      snowcrab.unused = c(
        "totmass.male", "totmass.female",
        "totmass.male.imm", "totmass.female.imm",
        "totmass.male.mat", "totmass.female.mat",
        "totmass.female.berried", 
        "totmass.female.primiparous", "totmass.female.multiparous",
        "totno.male.ncom",
        "totmass.male.ncom",
        "totmass.male.skip.moulter",
        "pre.recruit.no", "pre.recruit.mass",
        "mi123.mass", "mi4.mass", "mi5.mass", "mi6.mass", "mi7.mass", "mi8.mass", "mi9.mass", "mi10.mass", "mi11.mass", "mi12.mass", 
        "fi1234.mass", "fi5.mass", "fi6.mass", "fi7.mass", "fi8.mass", "fi9.mass", "fi10.mass",
        "m7.no", "f7.no",
        "m8.no", "f8.no",
        "m9.no", "f9.no",
        "m10.no", "f10.no",
        "totmass.female.CC3", "totmass.female.CC4",
        "totno.female.CC3", "totno.female.CC4", 
        "totno.female.CC1to2", "totno.female.CC3to4", "totno.female.CC5", 
        "totmass.female.CC1to2", "totmass.female.CC3to4", "totmass.female.CC5", 
        "R1.mass", "R2.mass", "R3.mass", "R4.mass", "R5p.mass", "dwarf.mass" 
      ),
      snowcrab.bycatch = c(
        "grd", "pel", "shark", "pred1", "pred2", "prey", "invert",
        "amPlaice", "atSpinyLumpsucker", "loScuplin", "noSandlance", "spDogfish", 
        "thSkate", "wiFlounder", "yeFlounder", "cod"
      ),
      snowcrab.indicators = c(      
        "sexratio.all", "sexratio.mat", "sexratio.imm" 
      ),
      snowcrab.cw = c(
        "cw.mean", "cw.comm.mean", "cw.notcomm.mean", "cw.fem.mat.mean", "cw.fem.imm.mean",
        "cw.comm.var", "cw.notcomm.var", "cw.fem.mat.var", "cw.fem.imm.var", "cw.var",
        "cw.male.mat.mean", "cw.male.imm.mean", "cw.male.mat.var", "cw.male.imm.var", "cw", "ch", "aw"
      ),
      
      all.data = c(
        variable.list.expand("physical"),
        variable.list.expand("males.general"),
        variable.list.expand("males.CC"),
        variable.list.expand("males.instar"),
        variable.list.expand("females.instar"),
        variable.list.expand("females.general"),
        variable.list.expand("snowcrab.general"),
        variable.list.expand("snowcrab.unused"),
        variable.list.expand("snowcrab.bycatch"),
        variable.list.expand("snowcrab.indicators"),
        variable.list.expand("snowcrab.cw"),
         "landings", "cpue",  "effort"
      ),
     
      all.to.model = c( 
        variable.list.expand("males.general"),
        variable.list.expand("males.CC"),
        variable.list.expand("males.instar"),
        variable.list.expand("females.instar"),
        variable.list.expand("females.general")
      ),

      scaled.centered =c ("dummyvariable"), # swtich does not like a null vector

      log.transform = c(
        paste( "totno", variable.list.expand("sp.list"), sep="." ),
        paste( "totwgt", variable.list.expand("sp.list"),  sep="." ),
        "Npred", "mr", "mrT",
        variable.list.expand("males.general"),
        variable.list.expand("males.CC"),
        variable.list.expand("males.instar"),
        variable.list.expand("females.instar"),
        variable.list.expand("females.general"),
        variable.list.expand("snowcrab.general"),
        variable.list.expand("snowcrab.unused"),
        variable.list.expand("snowcrab.bycatch"),
        "landings", "dZ", "ddZ"
      )
    ) # end switch
    
    V = sort( unique(  V ) )
    return (V)
  }


