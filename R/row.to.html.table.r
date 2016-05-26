row.to.html.table <- function(therow,main='',center='F',tableSummary='')
{
  #//MMM - 2016 - there are times where I want to be able to pull all of the attributes for a particular
  #//row of data into a single html table, where the first column corresponds with the fields,
  #//and the second row are the values.
  #//This might assist people using the kmlbuilder package who want to populate the kml balloon
  #//with all of the attributes
  #//Calling via apply(x,1, row.to.html.table) might be helpful
  tabhead=paste0('<![CDATA[
              <table style="border: 1px solid #1C1C1C; border-collapse: collapse;" summary=',tableSummary,'>
              <caption><em>',main,'</em></caption>
              <tr style="border: 1px solid #1C1C1C; border-collapse: collapse;">
              <th style="border: 1px solid #1C1C1C; border-collapse: collapse;">Field</th>
              <th style="border: 1px solid #1C1C1C; border-collapse: collapse;">Value</th></tr>')
  tabbody=''
  nvar=length(therow)
  for (i in 1:nvar) {
    tabbody=paste0(tabbody, '<tr>
                   <td style="border: 1px solid #1C1C1C; border-collapse: collapse;">',names(therow[i]),'</td>
                   <td style="border: 1px solid #1C1C1C; border-collapse: collapse;">',therow[i],'</td></tr>')
  }
  tabtail=paste0('</table>]]>')
  the.table=paste0(tabhead,tabbody,tabtail)
  return(the.table)
}