<div align="center">

## Stored Procedures in Oracle 8\.0\.5 and 8\.1\.5 which return recordsets


</div>

### Description

I have received a lot of responses to my code posted earlier ( a generic object that assisted in returning recordsets from Oracle). Most of these questions have been in the domain of the stored procedures themselves. Hopefully this article and example stored procedures will help clarify.
 
### More Info
 


<span>             |<span>
---                |---
**Submitted On**   |2001-02-13 09:54:02
**By**             |[Aparajit Agarwal](https://github.com/Planet-Source-Code/PSCIndex/blob/master/ByAuthor/aparajit-agarwal.md)
**Level**          |Advanced
**User Rating**    |4.7 (14 globes from 3 users)
**Compatibility**  |VB 6\.0
**Category**       |[Databases/ Data Access/ DAO/ ADO](https://github.com/Planet-Source-Code/PSCIndex/blob/master/ByCategory/databases-data-access-dao-ado__1-6.md)
**World**          |[Visual Basic](https://github.com/Planet-Source-Code/PSCIndex/blob/master/ByWorld/visual-basic.md)
**Archive File**   |[CODE\_UPLOAD149142132001\.zip](https://github.com/Planet-Source-Code/aparajit-agarwal-stored-procedures-in-oracle-8-0-5-and-8-1-5-which-return-recordsets__1-20972/archive/master.zip)





### Source Code

```
AAAAAAAAArrrrrrrrggggggggggghhhhhhhhhhhhh!!!!!!!!!!!!
So you want to write stored procedures in Oracle that return recordsets. Actually no big deal. The problem comes in when you have the wrong ODBC driver (mostly) or a version of Oracle that does not support what you are doing. The actual mechanism of obtaining the recordset itself is quite simple. If this article seems too technical or convoluted, accept my apologies in advance. The zipped sample code files should be fairly easy to follow. I recommend looking at them as you read this article. It will make a lot more sense.
The first and foremost question is &#8220;What version of Oracle DB Server do you have?&#8221;
If the answer is 8.0.5 or higher&#8230;&#8230;read on. Lower versions of Oracle do not return recordsets from within stored procedures (SP for the remainder of this article). The way you retreive recordsets in 8.0.5 is also more cumbersome, less flexible and has lesser features than 8.1.5.
The basic premise is that the first (absolute must) parameter of your stored procedure is an IN OUT and is a ref cursor type variable. Within Oracle you have something known as typing. Your cursor variable may be weak typed meaning that it can contain the contents of any SQL query and thus the number and type of columns/returned fields need not be known (Oh my God&#8230;just like a VB recordset&#8230;Yeeeehaaahh)&#8230;&#8230;or your cursor may be strong typed meaning that it is pre-defined as being based on a query. The first type is used in 8.1.5 and is great and eliminates some trouble. In 8.1.5, you can have a weak cursor based user-defined type as an IN OUT parameter. This way, when you open the cursor using the following syntax:
	Open 	po_udtXYZ for
	Select 	field1, field2, field3
	From	table1, table 2
	Where	condition1
	And 	condition 2
	And 	field 3 = passed in parameter;
the cursor is returned back to VB as and ADO recordset and contains fields 1, 2 and 3.
In 8.0.5 it is not so simple and requires that you write the same query shown above (minus the where clause) and declare it as a cursor within your package header. Then you create a user defined type using the %Rowtype of that cursor. Then your parameter is an IN OUT based on this &#8220;strong&#8221; user-defined type. This is fairly cumbersome and requires maintenance of the query in two locations.
Dynamic SQL: This can be done only in 8.1.5. The syntax is as follows:
	Open 	po_udtXYZ for
	&#8216;Select 	field1, field2, field3
	From	table1, table 2
	Where	condition1
	and 	condition 2 &#8217;||&#8217; dynamic clause passed in as parameter goes here&#8217;;
Note that the Select clause is enclosed in single quotes and the last statement (after the pipe concatenator used in Oracle) is a dynamic clause constructed outside, somewhere in VB or maybe another stored procedure and passed in as a parameter.
I have tested it and found not much of a lag in time for dynamic vs. non dynamic SQL&#8230;The thing to remember is that the dynamic SQL query is compiled at run-time and therefore you lose some of the speed benefits of having your query in a Stored Procedure. This may become more obvious if the passed parameter is a fairly complex set of clauses.
Compatibility issues: If you are using Oracle 8.0.5, make sure you are using the 8.0.5 driver. If you are using 8.1.5, the 8.1.56 ODBC driver should be used. The 8.1.5 driver had 2 updates to it&#8230; the 8.1.55 and then 8.1.56. The 8.1.56 is what you want. It fixes several problems, including the ability to run autonomous transactions (phased commits) and the ability to call a stored procedure from VB that is not in your schema but declared as a public synonym (This one had me in the loop for 3 days before I called Oracle).
On a separate note: I have recently used autonomous transactions as a way to report back to the user, what is going on in the database. The primary concern when running a stored procedure that is time intensive is the loss of control on the user&#8217;s machine and the need to give feedback (other than an hourglass) to the user. To do this, we made a status bar that pings the database and runs an inline SQL query to read the results of a Load Control table for a loadID passed to the status bar. The main stored procedure is also passed the same load ID and updates the load control table at various points within its code by calling another stored procedure. Here is the kink. Unless you commit, how do you see the results elsewhere and if you commit, you cannot rollback your main line stored procedure. This is where autonomous transactions are extremely useful. There are some quirks with distributed transactions and autonomous transactions (They do not like each other). These quirks and how to construct an autonomous transaction will be written in the next article. Until then, hopefully the enclosed examples should be helpful. If there are any questions feel free to email me.
```

