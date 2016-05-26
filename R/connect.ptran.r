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