lettersToNumbers <- function(x) {
  #replaces all letters with digits - there must be a better way!
  res=gsub("A",01,gsub("B",02,gsub("C",03,gsub("D",04,gsub("E",05,gsub(
    "F",06,gsub("G",07,gsub("H",08,gsub("I",09,gsub("J",10,gsub("K",11,gsub(
    "L",12,gsub("M",13,gsub("N",14,gsub("O",15,gsub("P",16,gsub("Q",17,gsub(
    "R",18,gsub("S",19,gsub("T",20,gsub("U",21,gsub("V",22,gsub("W",23,gsub(
    "X",24,gsub("Y",25,gsub("Z",26,x))))))))))))))))))))))))))
  return(res)
}