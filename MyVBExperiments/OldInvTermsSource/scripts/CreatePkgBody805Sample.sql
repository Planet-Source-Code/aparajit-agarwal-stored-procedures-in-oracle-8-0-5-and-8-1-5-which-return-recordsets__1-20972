
--	"Body" data for Planet Source Code Sample
--	Prepared by Aparajit H. Agarwal on 05/21/1999



	CREATE OR REPLACE PACKAGE BODY pkg805Sample IS

	PROCEDURE SP_GetKeys	(po_udtKeys IN OUT typGetKeys,
					 pi_UserID IN VARCHAR2,
					 err_cd OUT VARCHAR2,
					 err_txt OUT VARCHAR2)
	IS

/*	
||	DECLARE VARIABLES
*/
	
	BEGIN

/*
||	First set err_cd and err_num to '0' and 0 respectively
*/

	err_cd  := '0';
	err_num := 0;

/*	
||	Obtain count of new accounts appropriate to the operator level
||	where Status is not set to 'Review' or 'Active'. This is done by
||	opening Cursor type to send data back to VB
*/

	OPEN		po_udtKeys for
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
			Table5, Table6, Table7
	WHERE		Table2.companyID (+) = Table1.companyID
	AND		Table3.ContractID (+) = Table2.ContractID
	AND		Table6.UnitDefID (+) = Table5.UnitDefID
	AND		Table4.InvoiceTermsID (+) = Table3.InvoiceTermsID
	AND		Table5.InvoiceTermsID (+) = Table3.InvoiceTermsID
	AND		Table7.BillTypeID (+) = Table4.BillTypeID
	AND		Table2.ContractID 	IN 	(SELECT 	ContractID 
						 		FROM 	User_Table2
						 		WHERE UserID = pi_UserID);

	EXCEPTION


		WHEN NO_DATA_FOUND THEN
		err_cd :='0';

		WHEN OTHERS THEN

			IF err_cd = '0' then
				err_num := SQLCODE;
				err_cd := to_char(err_num);
				err_txt := substr(SQLERRM,1,100);
			END IF;

	END SP_GetKeys;



	END pkg805Sample;
/

