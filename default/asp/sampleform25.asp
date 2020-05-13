<%
'turn a text file into a PDF file!
dim form : set form=aspl.form

if form.postback then
	
	dim script : set script = form.field("script")	
	script.add "text", textFileTojsPDF("default/html/jsPDF.resx")
	
end if

dim button : set button=form.field("submit")
button.add "value","click to generate pdf"
button.add "class","btn btn-danger"	

form.build()

'this function turns any text-file (only) into a PDF using the jsPDF library
function textFileTojsPDF (filepath)

	'load textfile
	text=aspl.loadText(filepath)

	text=replace(text,vblf,"\n",1,-1,1)
	text=replace(text,vbcr,"",1,-1,1)
	text=replace(text,vbcrlf,"\n",1,-1,1)

	'split on the linebreaks
	arr=split(text,"\n")
	
	'keep track of the number of lines, we will stick to 45 lines max/page
	counter=0
	
	'loop through the lines
	for i=lbound(arr) to ubound(arr)
		
		line=arr(i)	
		
		'split line on whitespaces
		word=split(line," ")
		
		line=""
		
		for j=lbound(word) to ubound(word)
		
			'replace tabs with 5 white spaces
			text=replace(word(j),vbtab,"     ",1,-1,1)
			
			'we rebuild the line with the words, but...
			line=line & text & " "
			
			'...if the line gets longer than 75 characters, we migrate the current word to the next line!
			if len(line)>75 then
			
				line=left(line,(len(line)-len(word(j)))-1)
								
				'...we add a new linebreak and...
				file=file & line & "\n"
				
				'...add the last word to the new line
				line=word(j) & " "
				
				'as we added a linebreak, the line-counter goes up
				counter=counter+1
				
				'if we reach 45 lines, let's add a pagebreak
				if counter>45 then
					file=file & "\addPage"
					counter=0
				end if
				
			end if
			
		next		
	
		file=file & line & "\n"	'final line of each paragraph, here the initial linebreak gets inserted again
		
		counter=counter+1

		if counter>45 then
			file=file & "\addPage"
			counter=0
		end if

	next			
	
	dim pages : pages = split(file,"\addPage")
	
	'compile JavaScript 
	dim js : js=""
	for i=lbound(pages) to ubound(pages)	
	
		js=js & "doc.text('" & aspl.sanitizeJS(pages(i)) & "', 20, 20);"
		
		if i<ubound(pages) then js=js & "doc.addPage();"
		
	next	
	
	textFileTojsPDF = "var doc = new jsPDF();doc.setFontSize(14);" & js & "; doc.save('aspLite-jsPDF.pdf')"

end function

%>