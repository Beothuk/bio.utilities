  remove.files = function (clean) {
    if (is.null(clean) || length(clean)==0 ) return()
    cf = file.info(clean)
    cfi = which( !is.na(cf$isdir) & !cf$isdir) 
    file.remove (clean[cfi]) 
    return ("done")
  }


