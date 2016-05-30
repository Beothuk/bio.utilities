
  convert.graphics.format = function (file0, file1, options="" ) {
		# this uses imagemagick's functionality ... does not work in Windows
		#    cmd("convert", options, file0, file1, "&")
    cmd( "convert", options, file0, file1 )
  }


