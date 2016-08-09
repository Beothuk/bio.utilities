#' @title recode
#' @description recode a column of variables easily
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
#
recode <- function (var, recodes) 
{
		#useage dat$species <- recode(dat$species,  "10=2; 60=6; 15=3;400=7;11=5;16=8;14=10;200=11; 220=12;12=13;50=14;40=4")       
		#useage recode(out$ID,"'ESS'='4VW';'WSS'='4X'")
    recodes <- gsub("\n|\t", " ", recodes)
    recode.list <- rev(strsplit(recodes, ";")[[1]])
    is.fac <- is.factor(var)
    as.factor.result <- is.fac
    if (is.fac) var <- as.character(var)
    result <- var
    if (is.numeric(var)) {
        lo <- min(var, na.rm = TRUE)
        hi <- max(var, na.rm = TRUE)
    }
    for (term in recode.list) {
        if (0 < length(grep(":", term))) {
            range <- strsplit(strsplit(term, "=")[[1]][1], ":")
            low <- eval(parse(text = range[[1]][1]))
            high <- eval(parse(text = range[[1]][2]))
            target <- eval(parse(text = strsplit(term, "=")[[1]][2]))
            result[(var >= low) & (var <= high)] <- target
        }
        else if (0 < length(grep("^else=", squeezeBlanks(term)))) {
            target <- eval(parse(text = strsplit(term, "=")[[1]][2]))
            result[1:length(var)] <- target
        }
        else {
            set <- eval(parse(text = strsplit(term, "=")[[1]][1]))
            target <- eval(parse(text = strsplit(term, "=")[[1]][2]))
            for (val in set) {
                if (is.na(val)) 
                  result[is.na(var)] <- target
                else result[var == val] <- target
            }
        }
    }
        result.valid <- na.omit(result)
        opt <- options(warn = -1)
        result.valid <- as.numeric(result.valid)
        options(opt)
        if (!any(is.na(result.valid)))  result <- as.numeric(result)
    
    result
}
