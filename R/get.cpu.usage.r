#' @title get.cpu.usage
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  get.cpu.usage = function() {
      sys.usage = system ("vmstat -n 2 5", intern=T)  # a unix command: get 3 snapshots of 1 sec intervals
      sys.usage = gsub ( "^[[:space:]]", "", sys.usage ) # remove starting blanks
      cpu.usage = as.numeric( unlist(strsplit(sys.usage[5], "[[:space:]]+")) ) # get the next-to-last data
      cpu.user  = cpu.usage[13]
      cpu.system = cpu.usage[14]
      cpu.idle =  cpu.usage[15]
      cpu.total =  cpu.user +  cpu.system
    res = list(vmstat = sys.usage, cpu.user=cpu.user, cpu.system=cpu.system, cpu.idle=cpu.idle, cpu.total=cpu.total)
    return(res)
  }
   

