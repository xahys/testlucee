Request
<cfdump var=#request#/>
This
<cfdump var=#this#/>
System Env
<cfdump var=#createObject("java", "java.lang.System").getEnv()#/>
<a name="q">Query</a>
<cfquery name="test" result="res">
	select * from check_point;
</cfquery>
Result
<cfdump var=#test#/>
