#removes leading blanks
squeezeBlanks <- function (text) 
{
    gsub(" *", "", text)
}