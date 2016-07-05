#' @export
#' @title connect.ptran
#' @description This function is supposed to be a user-friendly means for adding a connection to ptran.  The user is prompted for the credentials 5 times before it 
#' @param \code{user} 
#' @param \code{password} 
#' @param \code{i} 
#' @return \code{channel} 
#' @author  Mike McMahon, \email{Mike.McMahon@@dfo-mpo.gc.ca}
#' @family GUI functions
#' @export
connect.ptran = function(user="x", password="x", i=0){
  require(RODBC)
  if (i<5){
    channel = tryCatch( 
      { 
        odbcConnect(uid = user, pw= password, dsn='PTRAN', case='nochange', rows_at_time=1)
        connected=T
        odbcConnect(uid = user, pw= password, dsn='PTRAN', case='nochange', rows_at_time=1);
      },
      warning=function(e) {
        message("Please enter your credentials below")
        user <- readline(prompt="Enter Username: ")
        password <- readline(prompt="Enter Password: ")
        i=i+1
        connect.ptran(user,password, i)
      }
    )
  }else{
    writeLines("Please check your credentials - you don't seem to be able to connect")
    channel = NULL
  }
  return(channel)
}