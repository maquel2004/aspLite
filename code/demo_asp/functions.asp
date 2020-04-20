<%

'the functions below are not part of aspLite. But they are used in code/demo_asp/jqueryui.asp (jQuery IO Datepicker)
'they are rather specific to use with the jQuery Datepicker. You can extend this list of functions as you wish.

'select a date-format
dim dateformat
dateformat="dd/mm/yy" 'or mm/dd/yy see function dateFromPicker - you can add more - see https://jqueryui.com/datepicker/

function dateFromPicker(theDate)
	
	if not aspL.isEmp(theDate) then
	
		dim arrDate
		arrDate=split(theDate,"/")
		
		select case dateformat
		
			case "dd/mm/yy" : dateFromPicker=dateserial(arrDate(2),arrDate(1),arrDate(0))
				
			case "mm/dd/yy" : dateFromPicker=dateserial(arrDate(2),arrDate(0),arrDate(1))
				
		end select
	
	else
	
		dateFromPicker=""
		
	end if
	
end function

function dateToPicker(theDate)

	if not aspL.isEmp(theDate) then
	
		select case dateformat
		
			case "dd/mm/yy" : dateToPicker=aspl.convert2(day(theDate)) & "/" & aspl.convert2(month(theDate)) & "/" & year(theDate)
				
			case "mm/dd/yy" : dateToPicker=aspl.convert2(month(theDate)) & "/" & aspl.convert2(day(theDate)) & "/" & year(theDate)
				
		end select
		
	else
		dateToPicker=""
	end if
	
end function


%>