<%

dim form : set form=aspl.form
form.target="sampleform18"

dim feedback : set feedback=form.field("element")
feedback.add "tag","div"
feedback.add "html","Replaced"
feedback.add "class","alert alert-primary"	
	
form.build()

%>