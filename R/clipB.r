#' @title clipB
#' @description Writes table into clipboard in unix environment. Requires xclip be installed (pacman xclip).
#' @author Stackoverflow 
#' @export 

clipB <- function(x, sep="\t", row.names=FALSE, col.names=TRUE){
     con <- pipe("xclip -selection clipboard -i", open="w")
     write.table(x, con, sep=sep, row.names=row.names, col.names=col.names)
     close(con)
}
