#' @title export.to.clipboard
#' @description function to send results to Excel clipboard so they can be pasted easily
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
# 
export.to.clipboard = function (results) {
  write.table(results, "clipboard", sep="\t")
  return ("Now you can paste the table into excel, or word, etc")
}


