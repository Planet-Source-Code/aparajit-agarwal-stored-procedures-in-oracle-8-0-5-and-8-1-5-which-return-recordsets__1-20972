--
--
--	PROCEDURE:		Not a procedure.  This is just a script file that creates
--				the package specification without the body.
--	PURPOSE: 		Make life easy.  Anytime a procedure is to be submitted,
--				First create all Cursors, UserDefined types, procedures here
--				and then create a separate procedure file.  Also, make sure
--				to add the file to the list of procedures in the
--				CreatePkgBodyInvoiceTerms.sql file
--	INPUT PARAMETERS:	NONE
--	OUTPUT PARAMETERS:	NONE
--	AUTHOR:			Aparajit H. Agarwal
--	DATE:			05/21/1999
--	HISTORY:		
--	Change		Date		Author
--
--  	Date    	By				Comment
--  	------  	---				-----------------
--	05/21/99	Aparajit H. Agarwal	Initial shell preparation
--	05/21/99	Aparajit H. Agarwal	Wrote package header spec

	


	CREATE OR REPLACE PACKAGE pkg815Sample AS

--	Declare all pkgbody cursors for use in creating rowtypes
--	Then declare user types of curser.rowtype


	
--	Declare Cursors (No need to do that in 815

	
--	Declare UserTypes and other "global" variables


--	The line below is commented but left in place so you can see the difference between the strong type (805) and weak type (815)
--	TYPE typGetKeys IS REF CURSOR RETURN curGetKeys%ROWTYPE;
	
      TYPE CurType IS REF CURSOR;

	
--	Global declaration for err_num for use in all procedures

	err_num number;


-- 	Define Procedures
 

	PROCEDURE SP_GetKeys	(po_udtKeys IN OUT CurType,
					 pi_UserID IN VARCHAR2,
					 err_cd OUT VARCHAR2,
					 err_txt OUT VARCHAR2);


END pkg815Sample;
/
