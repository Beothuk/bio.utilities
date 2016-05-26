cap = function(s, strict=FALSE) {
    paste( toupper(substring(s,1,1)), 
           { s <- substring(s,2); if(strict) tolower(s) else s},
           sep = "", collapse = " " 
		)
}


