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

	


	CREATE OR REPLACE PACKAGE pkg805Sample AS

--	Declare all pkgbody cursors for use in creating rowtypes
--	Then declare user types of curser.rowtype


	
--	Declare Cursors

	Cursor curGetKeys IS
	SELECT	to_char(Table1.CompanyID,'999999999') CompanyID, Table1.CompanyName,
			to_char(Table2.ContractID,'999999999') ContractID,  Table2.Table2Name,
			to_char(Table2.StartDate, 'MM/DD/YYYY') CntStart,
			to_char(Table2.EndDate, 'MM/DD/YYYY') CntEnd,
			to_char(Table3.InvoiceTermsID,'999999999') InvoiceTermsID, Table3.description ITDesc,
			to_char(Table3.StartDate, 'MM/DD/YYYY') ITStart,
			to_char(Table3.EndDate, 'MM/DD/YYYY') ITEnd,
			Table4.Description BTDesc,
			Table4.Billtype BTBillType,
			Table4.StartDate BTStart,
			Table4.EndDate BTEnd,
			Table4.TransactionBillable BTTranBill,
			to_char(Table4.BilltypeID,'9999999999') BillTypeID,
			Table5.Description UDDesc,
			to_char(Table6.UnitID,'9999999999') UUnitID, Table6.Unitname,
			to_char(Table7.RateElementID,'9999999999') RateElementID, 
			Table7.Description REDesc,
			Table7.StartDate REStart,
			Table7.EndDate REEnd,
			Table7.TaxCategoryIndicator RETCI
	FROM		Table2, Table1, Table3, Table4,
			Table5, Table6, Table7;

	
--	Declare UserTypes and other "global" variables



	TYPE typGetKeys IS REF CURSOR RETURN curGetKeys%ROWTYPE;
	


	
--	Global declaration for err_num for use in all procedures

	err_num number;


-- 	Define Procedures
 

	PROCEDURE SP_GetKeys	(po_udtKeys IN OUT typGetKeys,
					 pi_UserID IN VARCHAR2,
					 err_cd OUT VARCHAR2,
					 err_txt OUT VARCHAR2);


END pkg805Sample;
/
