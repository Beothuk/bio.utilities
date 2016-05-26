#remove rows where specific columns have NA
completeFun <- function(data, desiredCols) {
	#usage completeFun(dd,'y')
  completeVec <- complete.cases(data[, desiredCols])
  return(data[completeVec, ])
}