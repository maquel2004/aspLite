<%
'load template
body=aspL.loadText("html/demo_asp/jqueryui.resx")

'load some variables and functions (dateformat, dateFromPicker, dateToPicker)
aspL.exec("code/demo_asp/functions.asp")

body=replace(body,"[dateformat]",dateformat,1,-1,1)

dim today,vbDate

if not aspl.isEmp(aspL.getRequest("today")) then	
	
	'form was submitted. 
	
	today=aspL.getRequest("today")
	
	'be careful... the selected date is not necessarely a valid VBScript date. 
	'It's a string actually. It has to be converted to a VBScript date!
	
	vbDate=dateFromPicker(today)
	
	body=replace(body,"[feedback]","<p>You selected <strong>" & FormatDateTime(vbDate,1) & "</strong> (vbLongDate)</p>",1,-1,1)
	
else

	today=dateToPicker(date())
	body=replace(body,"[feedback]","",1,-1,1)
	
end if

body=replace(body,"[today]",today,1,-1,1)

%>