<%
class cls_asp_jpg

	public maxsize,path,effect,fsr

	private sub class_initialize
	
		maxsize=1920 'max= 2560
		
		'fsr=0/1 - crop image to rectangle: 0:no / 1:yes
		'effect=1/2/3 - 1:bw / 2:grayscale / 3:sepia
		
	end sub
	
	public function src
	
		src=asp_path & "/plugins/jpg/jpg.aspx?img=" & server.urlencode(path) & "&maxsize="& maxsize & "&se=" & effect & "&fsr=" & fsr
	
	end function

end class 
%>