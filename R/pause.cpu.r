#' @title pause.cpu
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  pause.cpu = function(variable="cpu.total", threshold=99) {
          # print ("CPU usage ..." )
          cpu = get.cpu.usage()[variable]
          while( cpu >= threshold ) {
            cpu.usage = get.cpu.usage()
            cpu = cpu.usage[variable]
            print ( paste("Waiting for CPU usage to drop:", variable, cpu) )
          }
  }


