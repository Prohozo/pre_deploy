-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.38-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for fcrm20
CREATE DATABASE IF NOT EXISTS `fcrm20` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `fcrm20`;

-- Dumping structure for procedure fcrm20.dsa_account
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account`(
	IN `id_proc` VARCHAR(50),
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `leadsource` VARCHAR(50),
	IN `industry` VARCHAR(50),
	IN `account_id` INT,
	IN `user_assign` VARCHAR(50),
	IN `user_marketing` VARCHAR(50),
	IN `user_service` VARCHAR(50),
	IN `dept_id` INT,
	IN `start_revenue` DECIMAL(25,8),
	IN `end_revenue` DECIMAL(25,8),
	IN `start_employee` INT,
	IN `end_employee` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)

)
BEGIN
   /*Overview*/
	IF id_proc = 'ov_account' THEN
		CALL dsa_account_total_account(timetype,start_date,end_date,leadsource,industry,account_id,user_assign,user_marketing,user_service,dept_id,col,val);
	END IF;
	
	IF id_proc = 'ov_contact' THEN
		CALL dsa_account_total_contact(timetype,start_date,end_date,leadsource,industry,account_id,user_assign,user_marketing,user_service,dept_id,col,val);
	END IF;
	
	IF id_proc = 'ov_potential' THEN
		CALL dsa_account_total_potential(timetype,start_date,end_date,leadsource,industry,account_id,user_assign,user_marketing,user_service,dept_id,col,val);
	END IF;
	
	IF id_proc = 'ov_salesorder' THEN
		CALL dsa_account_total_salesorder(timetype,start_date,end_date,leadsource,industry,account_id,user_assign,user_marketing,user_service,dept_id,col,val);
	END IF;
	
	/*Bar chart*/
	
		/*Users*/
	IF id_proc = 'user_assign' THEN
		CALL dsa_account_user_assign(timetype,start_date,end_date,leadsource,industry,account_id,user_assign,user_marketing,user_service,dept_id,col,val);
	END IF;
	
	IF id_proc = 'user_marketing' THEN
		CALL dsa_account_user_marketing(timetype,start_date,end_date,leadsource,industry,account_id,user_assign,user_marketing,user_service,dept_id,col,val);
	END IF;
	
	IF id_proc = 'user_service' THEN
		CALL dsa_account_user_service(timetype,start_date,end_date,leadsource,industry,account_id,user_assign,user_marketing,user_service,dept_id,col,val);
	END IF;
	
		/*Status*/
	IF id_proc = 'bar_status' THEN
		CALL dsa_account_status(timetype,start_date,end_date,leadsource,industry,account_id,user_assign,user_marketing,user_service,dept_id,col,val);
	END IF;
		
		/*Industry*/
	IF id_proc = 'industry' THEN
		CALL dsa_account_industry(timetype,start_date,end_date,leadsource,industry,account_id,user_assign,user_marketing,user_service,dept_id,col,val);
	END IF;
	
	
	/*Table*/
	
		/*Bảng chi tiết user*/
	IF id_proc = 'user_detail' THEN
		CALL dsa_account_user_detail(timetype,start_date,end_date,leadsource,industry,account_id,user_assign,user_marketing,user_service,dept_id,col,val);
	END IF;
	
		/*Contact*/
	IF id_proc = 'contact' THEN
		CALL dsa_account_contact(timetype,start_date,end_date,leadsource,industry,account_id,user_assign,user_marketing,user_service,dept_id,col,val);
	END IF;
		
		/*Potential-Salesorder*/	
	IF id_proc = 'potential_salesorder' THEN
		CALL dsa_account_potential_salesorder(timetype,start_date,end_date,leadsource,industry,account_id,user_assign,user_marketing,user_service,dept_id,col,val);
	END IF;
	
		/*Revenue-Employee*/
	IF id_proc = 'revenue_employee' THEN
		CALL dsa_account_revenue_employee(start_date,end_date,leadsource,industry,account_id,user_assign,user_marketing,user_service,dept_id,start_revenue,end_revenue,start_employee,end_employee,col,val);
	END IF;
		
		/*Contact-Leadsource*/
	IF id_proc = 'contact_leadsource' THEN
		CALL dsa_account_contact_leadsource(timetype,start_date,end_date,leadsource,industry,account_id,user_assign,user_marketing,user_service,dept_id,col,val);
	END IF;
	
	IF id_proc = 'account_detail' THEN
		CALL dsa_account_detail(timetype,start_date,end_date,leadsource,industry,account_id,user_assign,user_marketing,user_service,dept_id,start_revenue,end_revenue,start_employee,end_employee,col,val);
	END IF;
	
		/*City*/
	IF id_proc = 'city' THEN
		CALL dsa_account_city(timetype,start_date,end_date,leadsource,industry,account_id,user_assign,user_marketing,user_service,dept_id,col,val);
	END IF;
	
	/*Line chart*/
	IF id_proc = 'account_day' THEN
		CALL dsa_account_day(timetype,start_date,end_date,leadsource,industry,account_id,user_assign,user_marketing,user_service,dept_id,col,val);
	END IF;
	
	IF id_proc = 'account_month' THEN
		CALL dsa_account_month(timetype,start_date,end_date,leadsource,industry,account_id,user_assign,user_marketing,user_service,dept_id,col,val);
	END IF;
	
	IF id_proc = 'account_quarter' THEN
		CALL dsa_account_quarter(timetype,start_date,end_date,leadsource,industry,account_id,user_assign,user_marketing,user_service,dept_id,col,val);
	END IF;
	
	IF id_proc = 'account_year' THEN
		CALL dsa_account_year(timetype,start_date,end_date,leadsource,industry,account_id,user_assign,user_marketing,user_service,dept_id,col,val);
	END IF;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_account_city
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account_city`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `leadsource` VARCHAR(50),
	IN `industry` VARCHAR(50),
	IN `account_id` INT,
	IN `user_assign` VARCHAR(50),
	IN `user_marketing` VARCHAR(50),
	IN `user_service` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)

)
BEGIN

	DECLARE myquery nvarchar(2000);
	SET myquery = CONCAT('SELECT ad.ship_city, COUNT(DISTINCT c.crmid) AS ''num_account''
								
								FROM (SELECT accountid,account_no,accountname,
												CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
												annualrevenue,employees,isconvertedfromlead
										FROM vtiger_account) a
								
								JOIN vtiger_crmentity c
								ON a.accountid = c.crmid
								
								LEFT JOIN vtiger_contactdetails ctd
								ON a.accountid = ctd.accountid
								
								JOIN (SELECT accountid, 
												CASE WHEN cf_773 = '''' THEN ''Không có'' ELSE cf_773 END AS ''user_marketing'',
												CASE WHEN cf_775 = '''' THEN ''Không có'' ELSE cf_775 END AS ''user_service'',
												CASE WHEN cf_891 = '''' THEN ''Unknown'' ELSE cf_891 END AS ''status''
										FROM vtiger_accountscf ) acf
								ON acf.accountid = c.crmid
								
								LEFT JOIN (SELECT contactsubscriptionid,
														CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
												FROM vtiger_contactsubdetails) cts
								ON cts.contactsubscriptionid = ctd.contactid
								
								LEFT JOIN vtiger_users2group ug1
								ON ug1.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g1
								ON g1.groupid = ug1.groupid
								
								LEFT JOIN vtiger_users2group ug2
								ON ug2.groupid = c.smownerid
							
								LEFT JOIN vtiger_groups g2
								ON g2.groupid = ug2.groupid
								
								LEFT JOIN (SELECT accountaddressid,
												CASE WHEN ship_city='''' OR ship_city IS NULL THEN ''Unknown'' ELSE ship_city END AS ''ship_city''
												FROM vtiger_accountshipads) ad
								ON ad.accountaddressid = c.crmid
								
								WHERE 1=1');
	SET myquery = CONCAT(myquery,' AND c.deleted = ''0''');
	
	/*Chọn theo khoảng thời gian*/
	IF (timetype = 0 OR timetype IS NULL) AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	ELSEIF timetype = 1  AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		  SET myquery = CONCAT(myquery,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' ');
	END IF;
	
	/*Chọn theo nguồn*/
	IF (leadsource IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND cts.leadsource = ''',leadsource,'''');
	END IF;
	
	/*Chọn theo lĩnh vực*/
	IF (industry IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.industry = ''',industry,'''');
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.accountid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo user marketing*/
	IF(user_marketing IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND acf.user_marketing = ''',user_marketing,'''');
	END IF;	

	/*Chọn theo user giới thiệu*/
	IF(user_service IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND acf.user_service = ''',user_service,'''');
	END IF;
	
	/*Chọn theo bộ phận*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ( g1.groupid = ''',dept_id,''' OR g2.groupid = ''',dept_id,''')');
	END IF;
	
	/*Lọc theo col,val*/
	
	IF (col IS NOT NULL) AND (col = 'NV_assign') THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'NV_assign' AND col != 'c.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	
	SET myquery = CONCAT (myquery,' GROUP BY 1 ORDER BY 1');
	
	-- In và khởi chạy query
	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_account_day
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account_day`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `leadsource` VARCHAR(50),
	IN `industry` VARCHAR(50),
	IN `account_id` INT,
	IN `user_assign` VARCHAR(50),
	IN `user_marketing` VARCHAR(50),
	IN `user_service` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN

	DECLARE myquery_1 nvarchar(4000);
	DECLARE myquery_2 nvarchar(4000);
	
	
	SET myquery_1 = CONCAT('SELECT CONCAT(Day(c.createdtime),''/'',Month(c.createdtime),''/'', Year(c.createdtime)), COUNT(DISTINCT c.crmid)
								
								FROM (SELECT accountid,account_no,accountname,
												CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
												annualrevenue,employees,isconvertedfromlead
										FROM vtiger_account) a
								
								JOIN vtiger_crmentity c
								ON a.accountid = c.crmid
								
								LEFT JOIN vtiger_contactdetails ctd
								ON a.accountid = ctd.accountid
								
								JOIN (SELECT accountid, 
												CASE WHEN cf_773 = '''' THEN ''Không có'' ELSE cf_773 END AS ''user_marketing'',
												CASE WHEN cf_775 = '''' THEN ''Không có'' ELSE cf_775 END AS ''user_service'',
												CASE WHEN cf_891 = '''' THEN ''Unknown'' ELSE cf_891 END AS ''status''
										FROM vtiger_accountscf ) acf
								ON acf.accountid = c.crmid
								
								LEFT JOIN (SELECT contactsubscriptionid,
														CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
												FROM vtiger_contactsubdetails) cts
								ON cts.contactsubscriptionid = ctd.contactid
								
								LEFT JOIN vtiger_users2group ug1
								ON ug1.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g1
								ON g1.groupid = ug1.groupid
								
								LEFT JOIN vtiger_users2group ug2
								ON ug2.groupid = c.smownerid
							
								LEFT JOIN vtiger_groups g2
								ON g2.groupid = ug2.groupid
								
								LEFT JOIN (SELECT accountaddressid,
												CASE WHEN ship_city='''' OR ship_city IS NULL THEN ''Unknown'' ELSE ship_city END AS ''ship_city''
												FROM vtiger_accountshipads) ad
								ON ad.accountaddressid = c.crmid
								
								WHERE 1=1');
	
	
	SET myquery_2 = CONCAT('SELECT CONCAT(Day(c.modifiedtime),''/'',Month(c.modifiedtime),''/'', Year(c.modifiedtime)), COUNT(DISTINCT c.crmid)
								
								FROM (SELECT accountid,account_no,accountname,
												CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
												annualrevenue,employees,isconvertedfromlead
										FROM vtiger_account) a
								
								JOIN vtiger_crmentity c
								ON a.accountid = c.crmid
								
								LEFT JOIN vtiger_contactdetails ctd
								ON a.accountid = ctd.accountid
								
								JOIN (SELECT accountid, 
												CASE WHEN cf_773 = '''' THEN ''Không có'' ELSE cf_773 END AS ''user_marketing'',
												CASE WHEN cf_775 = '''' THEN ''Không có'' ELSE cf_775 END AS ''user_service'',
												CASE WHEN cf_891 = '''' THEN ''Unknown'' ELSE cf_891 END AS ''status''
										FROM vtiger_accountscf ) acf
								ON acf.accountid = c.crmid
								
								LEFT JOIN (SELECT contactsubscriptionid,
														CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
												FROM vtiger_contactsubdetails) cts
								ON cts.contactsubscriptionid = ctd.contactid
								
								LEFT JOIN vtiger_users2group ug1
								ON ug1.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g1
								ON g1.groupid = ug1.groupid
								
								LEFT JOIN vtiger_users2group ug2
								ON ug2.groupid = c.smownerid
							
								LEFT JOIN vtiger_groups g2
								ON g2.groupid = ug2.groupid
								
								LEFT JOIN (SELECT accountaddressid,
												CASE WHEN ship_city='''' OR ship_city IS NULL THEN ''Unknown'' ELSE ship_city END AS ''ship_city''
												FROM vtiger_accountshipads) ad
								ON ad.accountaddressid = c.crmid
								
								WHERE 1=1');						
								
	
	SET myquery_1 = CONCAT(myquery_1,' AND c.deleted = ''0''');
	SET myquery_2 = CONCAT(myquery_2,' AND c.deleted = ''0''');	
	
	/*Chọn theo khoảng thời gian*/
	IF (start_date IS NOT NULL AND end_date IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
		SET myquery_2 = CONCAT(myquery_2,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;
	
	/*Chọn theo nguồn*/
	IF (leadsource IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND cts.leadsource = ''',leadsource,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND cts.leadsource = ''',leadsource,'''');
	END IF;
	
	/*Chọn theo lĩnh vực*/
	IF (industry IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND a.industry = ''',industry,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND a.industry = ''',industry,'''');
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND a.accountid = ''',account_id,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND a.accountid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.smownerid = ''',user_assign,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo user marketing*/
	IF(user_marketing IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND acf.user_marketing = ''',user_marketing,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND acf.user_marketing = ''',user_marketing,'''');
	END IF;	

	/*Chọn theo user giới thiệu*/
	IF(user_service IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND acf.user_service = ''',user_service,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND acf.user_service = ''',user_service,'''');
	END IF;
	
	/*Chọn theo bộ phận*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND ( g1.groupid = ''',dept_id,''' OR g2.groupid = ''',dept_id,''')');
		SET myquery_2 = CONCAT(myquery_2,' AND ( g1.groupid = ''',dept_id,''' OR g2.groupid = ''',dept_id,''')');
	END IF;
	
	/*Lọc theo col,val*/
	
	IF (col IS NOT NULL) AND (col = 'NV_assign') THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.smownerid = ''', val,''' ');
		SET myquery_2 = CONCAT(myquery_2,' AND c.smownerid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.crmid = ''', val,''' ');
		SET myquery_2 = CONCAT(myquery_2,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'NV_assign' AND col != 'c.label')  THEN
		SET myquery_1 = CONCAT(myquery_1,' AND ',col, ' = ''', val,''' ');
		SET myquery_2 = CONCAT(myquery_2,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	
	SET myquery_1 = CONCAT (myquery_1,' GROUP BY 1 ORDER BY YEAR(c.createdtime), MONTH(c.createdtime), DAY(c.createdtime)');
	SET myquery_2 = CONCAT (myquery_2,' GROUP BY 1 ORDER BY YEAR(c.modifiedtime), MONTH(c.modifiedtime), DAY(c.modifiedtime)');
	
	
	IF (timetype = 0 OR timetype IS NULL) THEN
		SELECT myquery_1;
		SET @SQL := myquery_1;
	 	PREPARE my_query1 FROM @SQL;
		EXECUTE my_query1;
	ELSEIF (timetype = 1 OR timetype IS NULL) THEN
		SELECT myquery_2;
		SET @SQL := myquery_2;
	 	PREPARE my_query2 FROM @SQL;
		EXECUTE my_query2;
	END IF;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_account_ddl
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account_ddl`(
	IN `id_ddl` VARCHAR(50)
)
BEGIN
	IF id_ddl = 'ddl_account' THEN
		CALL dsa_account_ddl_account();
	END IF;
	
	IF id_ddl = 'ddl_dept' THEN
		CALL dsa_account_ddl_dept();
	END IF;
	
	IF id_ddl = 'ddl_industry' THEN
		CALL dsa_account_ddl_industry();
	END IF;
	
	IF id_ddl = 'ddl_leadsource' THEN
		CALL dsa_account_ddl_leadsource();
	END IF;
	
	IF id_ddl = 'ddl_user_assign' THEN
		CALL dsa_account_ddl_user_assign();
	END IF;
	
	IF id_ddl = 'ddl_user_marketing' THEN
		CALL dsa_account_ddl_user_marketing();
	END IF;
	
	IF id_ddl = 'ddl_user_service' THEN
		CALL dsa_account_ddl_user_service();
	END IF;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_account_ddl_account
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account_ddl_account`()
BEGIN
	DECLARE myquery nvarchar(2000);
	
	SET myquery = CONCAT('SELECT c.crmid, CONCAT(c.label,'' ('', a.account_no, '')'')
								FROM (SELECT accountid,account_no,accountname,
												CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
												annualrevenue,employees,isconvertedfromlead
										FROM vtiger_account) a
								
								JOIN vtiger_crmentity c
								ON c.crmid = a.accountid
								
								WHERE c.deleted = ''0''		
								ORDER BY c.label');
								
	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_account_ddl_dept
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account_ddl_dept`()
BEGIN
	DECLARE myquery nvarchar(2000);

	SET myquery = CONCAT('SELECT g.groupid, g.groupname 
								FROM vtiger_groups g
								ORDER BY g.groupname');
	

	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_account_ddl_industry
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account_ddl_industry`()
BEGIN
	DECLARE myquery nvarchar(2000);
	
	SET myquery = CONCAT('SELECT DISTINCT a.industry
								FROM (SELECT accountid,account_no,accountname,
												CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
												annualrevenue,employees,isconvertedfromlead
										FROM vtiger_account) a
										
								ORDER BY 1');
								
	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_account_ddl_leadsource
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account_ddl_leadsource`()
BEGIN
	DECLARE myquery nvarchar(2000);
	
	SET myquery = CONCAT('SELECT DISTINCT cts.leadsource
								FROM (SELECT contactsubscriptionid,
												CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
										FROM vtiger_contactsubdetails) cts
								ORDER BY 1');

	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_account_ddl_user_assign
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account_ddl_user_assign`()
BEGIN
	DECLARE myquery nvarchar(2000);
	DECLARE myquery_1 nvarchar(2000);
	DECLARE myquery_2 nvarchar(2000);
	SET myquery_1 = CONCAT('(SELECT u.id, CONCAT(u.last_name,'' '', u.first_name, '' ('', u.user_name, '')'') AS ''NV_assign''
								FROM vtiger_users u
								WHERE u.deleted = ''0''
								ORDER BY u.user_name)');
	
	SET myquery_2 = CONCAT('(SELECT g.groupid, g.groupname AS ''NV_assign''
								FROM vtiger_groups g
								ORDER BY g.groupname)');
	
	SET myquery = CONCAT(myquery_1,' UNION ALL ', myquery_2);
	

	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_account_ddl_user_marketing
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account_ddl_user_marketing`()
BEGIN
	DECLARE myquery nvarchar(2000);
	
	SET myquery = CONCAT('SELECT u.user_name, CONCAT(u.last_name,'' '', u.first_name, '' ('', u.user_name, '')'') AS ''u.name''
								FROM vtiger_users u
								JOIN vtiger_cf_773
								ON u.user_name = vtiger_cf_773.cf_773
								WHERE u.deleted = ''0''
								ORDER BY u.user_name');
	

	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_account_ddl_user_service
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account_ddl_user_service`()
BEGIN
	DECLARE myquery nvarchar(2000);
	
	SET myquery = CONCAT('SELECT u.user_name, CONCAT(u.last_name,'' '', u.first_name, '' ('', u.user_name, '')'') AS ''u.name''
								FROM vtiger_users u
								WHERE u.deleted = ''0''
								ORDER BY u.user_name');
	

	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_account_detail
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account_detail`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `leadsource` VARCHAR(50),
	IN `industry` VARCHAR(50),
	IN `account_id` INT,
	IN `user_assign` VARCHAR(50),
	IN `user_marketing` VARCHAR(50),
	IN `user_service` VARCHAR(50),
	IN `dept_id` INT,
	IN `start_revenue` DECIMAL(25,8),
	IN `end_revenue` DECIMAL(25,8),
	IN `start_employee` INT,
	IN `end_employee` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)

)
BEGIN
	DECLARE myquery nvarchar(4000);
	
	SET myquery = CONCAT('SELECT DISTINCT c.crmid, 
										CONCAT(''['',c.label, '' ('',a.account_no, '')'', '' ]'',''(http://crm.fastdn.com.vn/index.php?module=Accounts&view=Detail&record='',c.crmid,''&app=SUPPORT)'') AS ''c.label'',
										a.industry, 
										acf.status,		
										ad.ship_city,
										COUNT(DISTINCT (CASE WHEN (c2.deleted = ''0'' AND ctd.contactid IS NOT NULL) THEN ctd.contactid ELSE NULL END)) AS SL_contact,										
										COUNT(DISTINCT (CASE WHEN (c3.deleted = ''0'' OR p.potentialid IS NOT NULL) THEN p.potentialid ELSE NULL END)) AS SL_potential,
										COUNT(DISTINCT (CASE WHEN (c4.deleted = ''0'' OR so.salesorderid IS NOT NULL) THEN so.salesorderid ELSE NULL END)) AS SL_salesorder,
										a.annualrevenue,a.employees, 
										CONCAT(Day(c.createdtime),''/'',Month(c.createdtime),''/'', Year(c.createdtime)) AS ''c.createdtime'',
										CONCAT(Day(c.modifiedtime),''/'',Month(c.modifiedtime),''/'', Year(c.modifiedtime)) AS ''c.modifiedtime''
								FROM (SELECT accountid,account_no,accountname,
												CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
												annualrevenue,employees,isconvertedfromlead
										FROM vtiger_account) a
								
								JOIN vtiger_crmentity c
								ON a.accountid = c.crmid
								
								LEFT JOIN vtiger_contactdetails ctd
								ON a.accountid = ctd.accountid
								
								JOIN (SELECT accountid, 
												CASE WHEN cf_773 = '''' THEN ''Không có'' ELSE cf_773 END AS ''user_marketing'',
												CASE WHEN cf_775 = '''' THEN ''Không có'' ELSE cf_775 END AS ''user_service'',
												CASE WHEN cf_891 = '''' THEN ''Unknown'' ELSE cf_891 END AS ''status''
										FROM vtiger_accountscf ) acf
								ON acf.accountid = c.crmid
								
								LEFT JOIN (SELECT contactsubscriptionid,
														CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
												FROM vtiger_contactsubdetails) cts
								ON cts.contactsubscriptionid = ctd.contactid								
								
								LEFT JOIN vtiger_potential p 
								ON a.accountid = p.related_to
								
								LEFT JOIN vtiger_salesorder so
								ON a.accountid = so.accountid
								
								LEFT JOIN vtiger_crmentity c2
								ON ctd.contactid = c2.crmid
								
								LEFT JOIN vtiger_crmentity c3
								ON p.potentialid = c3.crmid
								
								LEFT JOIN vtiger_crmentity c4
								ON so.salesorderid = c4.crmid
								
								LEFT JOIN vtiger_users2group ug1
								ON ug1.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g1
								ON g1.groupid = ug1.groupid
								
								LEFT JOIN vtiger_users2group ug2
								ON ug2.groupid = c.smownerid
							
								LEFT JOIN vtiger_groups g2
								ON g2.groupid = ug2.groupid
								
								LEFT JOIN (SELECT accountaddressid,
												CASE WHEN ship_city='''' OR ship_city IS NULL THEN ''Unknown'' ELSE ship_city END AS ''ship_city''
												FROM vtiger_accountshipads) ad
								ON ad.accountaddressid = c.crmid

								
								WHERE 1=1');
	
	SET myquery = CONCAT(myquery,' AND c.deleted = ''0''');
		
	/*Chọn theo khoảng thời gian*/
	IF (timetype = 0 OR timetype IS NULL) AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	ELSEIF timetype = 1  AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		  SET myquery = CONCAT(myquery,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' ');
	END IF;
	
	/*Chọn theo nguồn*/
	IF (leadsource IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND cts.leadsource = ''',leadsource,'''');
	END IF;
	
	/*Chọn theo lĩnh vực*/
	IF (industry IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.industry = ''',industry,'''');
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.accountid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo user marketing*/
	IF(user_marketing IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND acf.user_marketing = ''',user_marketing,'''');
	END IF;	

	/*Chọn theo user giới thiệu*/
	IF(user_service IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND acf.user_service = ''',user_service,'''');
	END IF;
	
	/*Chọn theo bộ phận*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ( g1.groupid = ''',dept_id,''' OR g2.groupid = ''',dept_id,''')');
	END IF;
	
	/*Chọn theo doanh thu và số lượng NV*/
	IF (start_revenue IS NOT NULL) AND (end_revenue IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND (a.annualrevenue BETWEEN ',start_revenue,' AND ', end_revenue,' ) ' );
	END IF;
	
	IF (start_employee IS NOT NULL) AND (end_employee IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND (a.employees BETWEEN ',start_employee,' AND ', end_employee,' ) ' );
	END IF;
	
	/*Lọc theo col,val*/
	
	IF (col IS NOT NULL) AND (col = 'NV_assign') THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'NV_assign' AND col != 'c.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	SET myquery = CONCAT (myquery,' GROUP BY c.crmid ORDER BY c.label');
						
	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_account_industry
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account_industry`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `leadsource` VARCHAR(50),
	IN `industry` VARCHAR(50),
	IN `account_id` INT,
	IN `user_assign` INT,
	IN `user_marketing` VARCHAR(50),
	IN `user_service` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(2000);
	SET myquery = CONCAT('SELECT a.industry, COUNT(DISTINCT c.crmid)
								
								FROM (SELECT accountid,account_no,accountname,
												CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
												annualrevenue,employees,isconvertedfromlead
										FROM vtiger_account) a
								
								JOIN vtiger_crmentity c
								ON a.accountid = c.crmid
								
								LEFT JOIN vtiger_contactdetails ctd
								ON a.accountid = ctd.accountid
								
								JOIN (SELECT accountid, 
												CASE WHEN cf_773 = '''' THEN ''Không có'' ELSE cf_773 END AS ''user_marketing'',
												CASE WHEN cf_775 = '''' THEN ''Không có'' ELSE cf_775 END AS ''user_service'',
												CASE WHEN cf_891 = '''' THEN ''Unknown'' ELSE cf_891 END AS ''status''
										FROM vtiger_accountscf ) acf
								ON acf.accountid = c.crmid
								
								LEFT JOIN (SELECT contactsubscriptionid,
														CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
												FROM vtiger_contactsubdetails) cts
								ON cts.contactsubscriptionid = ctd.contactid
								
								LEFT JOIN vtiger_users2group ug1
								ON ug1.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g1
								ON g1.groupid = ug1.groupid
								
								LEFT JOIN vtiger_users2group ug2
								ON ug2.groupid = c.smownerid
							
								LEFT JOIN vtiger_groups g2
								ON g2.groupid = ug2.groupid
								
								LEFT JOIN (SELECT accountaddressid,
												CASE WHEN ship_city='''' OR ship_city IS NULL THEN ''Unknown'' ELSE ship_city END AS ''ship_city''
												FROM vtiger_accountshipads) ad
								ON ad.accountaddressid = c.crmid
								
								WHERE 1=1');
	SET myquery = CONCAT(myquery,' AND c.deleted = ''0''');
	
	/*Chọn theo khoảng thời gian*/
	IF (timetype = 0 OR timetype IS NULL) AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	ELSEIF timetype = 1  AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		  SET myquery = CONCAT(myquery,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' ');
	END IF;
	
	/*Chọn theo nguồn*/
	IF (leadsource IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND cts.leadsource = ''',leadsource,'''');
	END IF;
	
	/*Chọn theo lĩnh vực*/
	IF (industry IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.industry = ''',industry,'''');
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.accountid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo user marketing*/
	IF(user_marketing IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND acf.user_marketing = ''',user_marketing,'''');
	END IF;	

	/*Chọn theo user giới thiệu*/
	IF(user_service IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND acf.user_service = ''',user_service,'''');
	END IF;
	
	/*Chọn theo bộ phận*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ( g1.groupid = ''',dept_id,''' OR g2.groupid = ''',dept_id,''')');
	END IF;
	
	/*Lọc theo col,val*/
	
	IF (col IS NOT NULL) AND (col = 'NV_assign') THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'NV_assign' AND col != 'c.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	SET myquery = CONCAT (myquery,' GROUP BY 1 ORDER BY 2 DESC, 1');

	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_account_month
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account_month`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `leadsource` VARCHAR(50),
	IN `industry` VARCHAR(50),
	IN `account_id` INT,
	IN `user_assign` VARCHAR(50),
	IN `user_marketing` VARCHAR(50),
	IN `user_service` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN

	DECLARE myquery_1 nvarchar(4000);
	DECLARE myquery_2 nvarchar(4000);
	
	
	SET myquery_1 = CONCAT('SELECT CONCAT(Month(c.createdtime),''/'', Year(c.createdtime)) , COUNT(DISTINCT c.crmid)
								
								FROM (SELECT accountid,account_no,accountname,
												CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
												annualrevenue,employees,isconvertedfromlead
										FROM vtiger_account) a
								
								JOIN vtiger_crmentity c
								ON a.accountid = c.crmid
								
								LEFT JOIN vtiger_contactdetails ctd
								ON a.accountid = ctd.accountid
								
								JOIN (SELECT accountid, 
												CASE WHEN cf_773 = '''' THEN ''Không có'' ELSE cf_773 END AS ''user_marketing'',
												CASE WHEN cf_775 = '''' THEN ''Không có'' ELSE cf_775 END AS ''user_service'',
												CASE WHEN cf_891 = '''' THEN ''Unknown'' ELSE cf_891 END AS ''status''
										FROM vtiger_accountscf ) acf
								ON acf.accountid = c.crmid
								
								LEFT JOIN (SELECT contactsubscriptionid,
														CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
												FROM vtiger_contactsubdetails) cts
								ON cts.contactsubscriptionid = ctd.contactid
								
								LEFT JOIN vtiger_users2group ug1
								ON ug1.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g1
								ON g1.groupid = ug1.groupid
								
								LEFT JOIN vtiger_users2group ug2
								ON ug2.groupid = c.smownerid
							
								LEFT JOIN vtiger_groups g2
								ON g2.groupid = ug2.groupid
								
								LEFT JOIN (SELECT accountaddressid,
												CASE WHEN ship_city='''' OR ship_city IS NULL THEN ''Unknown'' ELSE ship_city END AS ''ship_city''
												FROM vtiger_accountshipads) ad
								ON ad.accountaddressid = c.crmid
								
								WHERE 1=1');
	
	
	SET myquery_2 = CONCAT('SELECT CONCAT(Month(c.modifiedtime),''/'', Year(c.modifiedtime)), COUNT(DISTINCT c.crmid)
								
								FROM (SELECT accountid,account_no,accountname,
												CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
												annualrevenue,employees,isconvertedfromlead
										FROM vtiger_account) a
								
								JOIN vtiger_crmentity c
								ON a.accountid = c.crmid
								
								LEFT JOIN vtiger_contactdetails ctd
								ON a.accountid = ctd.accountid
								
								JOIN (SELECT accountid, 
												CASE WHEN cf_773 = '''' THEN ''Không có'' ELSE cf_773 END AS ''user_marketing'',
												CASE WHEN cf_775 = '''' THEN ''Không có'' ELSE cf_775 END AS ''user_service'',
												CASE WHEN cf_891 = '''' THEN ''Unknown'' ELSE cf_891 END AS ''status''
										FROM vtiger_accountscf ) acf
								ON acf.accountid = c.crmid
								
								LEFT JOIN (SELECT contactsubscriptionid,
														CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
												FROM vtiger_contactsubdetails) cts
								ON cts.contactsubscriptionid = ctd.contactid
								
								LEFT JOIN vtiger_users2group ug1
								ON ug1.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g1
								ON g1.groupid = ug1.groupid
								
								LEFT JOIN vtiger_users2group ug2
								ON ug2.groupid = c.smownerid
							
								LEFT JOIN vtiger_groups g2
								ON g2.groupid = ug2.groupid
								
								LEFT JOIN (SELECT accountaddressid,
												CASE WHEN ship_city='''' OR ship_city IS NULL THEN ''Unknown'' ELSE ship_city END AS ''ship_city''
												FROM vtiger_accountshipads) ad
								ON ad.accountaddressid = c.crmid
								
								WHERE 1=1');						
								
	
	SET myquery_1 = CONCAT(myquery_1,' AND c.deleted = ''0''');
	SET myquery_2 = CONCAT(myquery_2,' AND c.deleted = ''0''');	
	
	/*Chọn theo khoảng thời gian*/
	IF (start_date IS NOT NULL AND end_date IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
		SET myquery_2 = CONCAT(myquery_2,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;
	
	/*Chọn theo nguồn*/
	IF (leadsource IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND cts.leadsource = ''',leadsource,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND cts.leadsource = ''',leadsource,'''');
	END IF;
	
	/*Chọn theo lĩnh vực*/
	IF (industry IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND a.industry = ''',industry,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND a.industry = ''',industry,'''');
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND a.accountid = ''',account_id,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND a.accountid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.smownerid = ''',user_assign,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo user marketing*/
	IF(user_marketing IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND acf.user_marketing = ''',user_marketing,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND acf.user_marketing = ''',user_marketing,'''');
	END IF;	

	/*Chọn theo user giới thiệu*/
	IF(user_service IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND acf.user_service = ''',user_service,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND acf.user_service = ''',user_service,'''');
	END IF;
	
	/*Chọn theo bộ phận*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND ( g1.groupid = ''',dept_id,''' OR g2.groupid = ''',dept_id,''')');
		SET myquery_2 = CONCAT(myquery_2,' AND ( g1.groupid = ''',dept_id,''' OR g2.groupid = ''',dept_id,''')');
	END IF;
	
	/*Lọc theo col,val*/
	
	IF (col IS NOT NULL) AND (col = 'NV_assign') THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.smownerid = ''', val,''' ');
		SET myquery_2 = CONCAT(myquery_2,' AND c.smownerid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.crmid = ''', val,''' ');
		SET myquery_2 = CONCAT(myquery_2,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'NV_assign' AND col != 'c.label')  THEN
		SET myquery_1 = CONCAT(myquery_1,' AND ',col, ' = ''', val,''' ');
		SET myquery_2 = CONCAT(myquery_2,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	
	SET myquery_1 = CONCAT (myquery_1,' GROUP BY 1 ORDER BY YEAR(c.createdtime), MONTH(c.createdtime)');
	SET myquery_2 = CONCAT (myquery_2,' GROUP BY 1 ORDER BY YEAR(c.modifiedtime), MONTH(c.modifiedtime)');
	
	
	IF (timetype = 0 OR timetype IS NULL) THEN
		SELECT myquery_1;
		SET @SQL := myquery_1;
	 	PREPARE my_query1 FROM @SQL;
		EXECUTE my_query1;
	ELSEIF (timetype = 1 OR timetype IS NULL) THEN
		SELECT myquery_2;
		SET @SQL := myquery_2;
	 	PREPARE my_query2 FROM @SQL;
		EXECUTE my_query2;
	END IF;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_account_quarter
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account_quarter`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `leadsource` VARCHAR(50),
	IN `industry` VARCHAR(50),
	IN `account_id` INT,
	IN `user_assign` VARCHAR(50),
	IN `user_marketing` VARCHAR(50),
	IN `user_service` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN

	DECLARE myquery_1 nvarchar(4000);
	DECLARE myquery_2 nvarchar(4000);
	
	
	SET myquery_1 = CONCAT('SELECT CONCAT(YEAR(c.createdtime),'' - Q'', QUARTER(c.createdtime)) , COUNT(DISTINCT c.crmid)
								
								FROM (SELECT accountid,account_no,accountname,
												CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
												annualrevenue,employees,isconvertedfromlead
										FROM vtiger_account) a
								
								JOIN vtiger_crmentity c
								ON a.accountid = c.crmid
								
								LEFT JOIN vtiger_contactdetails ctd
								ON a.accountid = ctd.accountid
								
								JOIN (SELECT accountid, 
												CASE WHEN cf_773 = '''' THEN ''Không có'' ELSE cf_773 END AS ''user_marketing'',
												CASE WHEN cf_775 = '''' THEN ''Không có'' ELSE cf_775 END AS ''user_service'',
												CASE WHEN cf_891 = '''' THEN ''Unknown'' ELSE cf_891 END AS ''status''
										FROM vtiger_accountscf ) acf
								ON acf.accountid = c.crmid
								
								LEFT JOIN (SELECT contactsubscriptionid,
														CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
												FROM vtiger_contactsubdetails) cts
								ON cts.contactsubscriptionid = ctd.contactid
								
								LEFT JOIN vtiger_users2group ug1
								ON ug1.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g1
								ON g1.groupid = ug1.groupid
								
								LEFT JOIN vtiger_users2group ug2
								ON ug2.groupid = c.smownerid
							
								LEFT JOIN vtiger_groups g2
								ON g2.groupid = ug2.groupid
								
								LEFT JOIN (SELECT accountaddressid,
												CASE WHEN ship_city='''' OR ship_city IS NULL THEN ''Unknown'' ELSE ship_city END AS ''ship_city''
												FROM vtiger_accountshipads) ad
								ON ad.accountaddressid = c.crmid
								
								WHERE 1=1');
	
	
	SET myquery_2 = CONCAT('SELECT CONCAT(YEAR(c.modifiedtime),'' - Q'', QUARTER(c.modifiedtime)), COUNT(DISTINCT c.crmid)
								
								FROM (SELECT accountid,account_no,accountname,
												CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
												annualrevenue,employees,isconvertedfromlead
										FROM vtiger_account) a
								
								JOIN vtiger_crmentity c
								ON a.accountid = c.crmid
								
								LEFT JOIN vtiger_contactdetails ctd
								ON a.accountid = ctd.accountid
								
								JOIN (SELECT accountid, 
												CASE WHEN cf_773 = '''' THEN ''Không có'' ELSE cf_773 END AS ''user_marketing'',
												CASE WHEN cf_775 = '''' THEN ''Không có'' ELSE cf_775 END AS ''user_service'',
												CASE WHEN cf_891 = '''' THEN ''Unknown'' ELSE cf_891 END AS ''status''
										FROM vtiger_accountscf ) acf
								ON acf.accountid = c.crmid
								
								LEFT JOIN (SELECT contactsubscriptionid,
														CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
												FROM vtiger_contactsubdetails) cts
								ON cts.contactsubscriptionid = ctd.contactid
								
								LEFT JOIN vtiger_users2group ug1
								ON ug1.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g1
								ON g1.groupid = ug1.groupid
								
								LEFT JOIN vtiger_users2group ug2
								ON ug2.groupid = c.smownerid
							
								LEFT JOIN vtiger_groups g2
								ON g2.groupid = ug2.groupid
								
								LEFT JOIN (SELECT accountaddressid,
												CASE WHEN ship_city='''' OR ship_city IS NULL THEN ''Unknown'' ELSE ship_city END AS ''ship_city''
												FROM vtiger_accountshipads) ad
								ON ad.accountaddressid = c.crmid
								
								WHERE 1=1');						
								
	
	SET myquery_1 = CONCAT(myquery_1,' AND c.deleted = ''0''');
	SET myquery_2 = CONCAT(myquery_2,' AND c.deleted = ''0''');	
	
	/*Chọn theo khoảng thời gian*/
	IF (start_date IS NOT NULL AND end_date IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
		SET myquery_2 = CONCAT(myquery_2,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;
	
	/*Chọn theo nguồn*/
	IF (leadsource IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND cts.leadsource = ''',leadsource,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND cts.leadsource = ''',leadsource,'''');
	END IF;
	
	/*Chọn theo lĩnh vực*/
	IF (industry IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND a.industry = ''',industry,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND a.industry = ''',industry,'''');
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND a.accountid = ''',account_id,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND a.accountid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.smownerid = ''',user_assign,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo user marketing*/
	IF(user_marketing IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND acf.user_marketing = ''',user_marketing,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND acf.user_marketing = ''',user_marketing,'''');
	END IF;	

	/*Chọn theo user giới thiệu*/
	IF(user_service IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND acf.user_service = ''',user_service,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND acf.user_service = ''',user_service,'''');
	END IF;
	
	/*Chọn theo bộ phận*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND ( g1.groupid = ''',dept_id,''' OR g2.groupid = ''',dept_id,''')');
		SET myquery_2 = CONCAT(myquery_2,' AND ( g1.groupid = ''',dept_id,''' OR g2.groupid = ''',dept_id,''')');
	END IF;
	
	/*Lọc theo col,val*/
	
	IF (col IS NOT NULL) AND (col = 'NV_assign') THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.smownerid = ''', val,''' ');
		SET myquery_2 = CONCAT(myquery_2,' AND c.smownerid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.crmid = ''', val,''' ');
		SET myquery_2 = CONCAT(myquery_2,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'NV_assign' AND col != 'c.label')  THEN
		SET myquery_1 = CONCAT(myquery_1,' AND ',col, ' = ''', val,''' ');
		SET myquery_2 = CONCAT(myquery_2,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	
	SET myquery_1 = CONCAT (myquery_1,' GROUP BY 1 ORDER BY YEAR(c.createdtime),QUARTER(c.createdtime) ');
	SET myquery_2 = CONCAT (myquery_2,' GROUP BY 1 ORDER BY YEAR(c.modifiedtime),QUARTER(c.modifiedtime)');
	
	
	IF (timetype = 0 OR timetype IS NULL) THEN
		SELECT myquery_1;
		SET @SQL := myquery_1;
	 	PREPARE my_query1 FROM @SQL;
		EXECUTE my_query1;
	ELSEIF (timetype = 1 OR timetype IS NULL) THEN
		SELECT myquery_2;
		SET @SQL := myquery_2;
	 	PREPARE my_query2 FROM @SQL;
		EXECUTE my_query2;
	END IF;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_account_status
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account_status`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `leadsource` VARCHAR(50),
	IN `industry` VARCHAR(50),
	IN `account_id` INT,
	IN `user_assign` VARCHAR(50),
	IN `user_marketing` VARCHAR(50),
	IN `user_service` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(2000);
	SET myquery = CONCAT('SELECT acf.status, COUNT(DISTINCT c.crmid)
								
								FROM (SELECT accountid,account_no,accountname,
												CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
												annualrevenue,employees,isconvertedfromlead
										FROM vtiger_account) a
								
								JOIN vtiger_crmentity c
								ON a.accountid = c.crmid
								
								LEFT JOIN vtiger_contactdetails ctd
								ON a.accountid = ctd.accountid
								
								JOIN (SELECT accountid, 
												CASE WHEN cf_773 = '''' THEN ''Không có'' ELSE cf_773 END AS ''user_marketing'',
												CASE WHEN cf_775 = '''' THEN ''Không có'' ELSE cf_775 END AS ''user_service'',
												CASE WHEN cf_891 = '''' THEN ''Unknown'' ELSE cf_891 END AS ''status''
										FROM vtiger_accountscf ) acf
								ON acf.accountid = c.crmid
								
								LEFT JOIN (SELECT contactsubscriptionid,
														CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
												FROM vtiger_contactsubdetails) cts
								ON cts.contactsubscriptionid = ctd.contactid		
								
								LEFT JOIN vtiger_users2group ug1
								ON ug1.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g1
								ON g1.groupid = ug1.groupid
								
								LEFT JOIN vtiger_users2group ug2
								ON ug2.groupid = c.smownerid
							
								LEFT JOIN vtiger_groups g2
								ON g2.groupid = ug2.groupid
								
								LEFT JOIN (SELECT accountaddressid,
												CASE WHEN ship_city='''' OR ship_city IS NULL THEN ''Unknown'' ELSE ship_city END AS ''ship_city''
												FROM vtiger_accountshipads) ad
								ON ad.accountaddressid = c.crmid
								
								WHERE 1=1');
	SET myquery = CONCAT(myquery,' AND c.deleted = ''0''');
	
	/*Chọn theo khoảng thời gian*/
	IF (timetype = 0 OR timetype IS NULL) AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	ELSEIF timetype = 1  AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		  SET myquery = CONCAT(myquery,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' ');
	END IF;
	
	/*Chọn theo nguồn*/
	IF (leadsource IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND cts.leadsource = ''',leadsource,'''');
	END IF;
	
	/*Chọn theo lĩnh vực*/
	IF (industry IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.industry = ''',industry,'''');
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.accountid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo user marketing*/
	IF(user_marketing IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND acf.user_marketing = ''',user_marketing,'''');
	END IF;	

	/*Chọn theo user giới thiệu*/
	IF(user_service IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND acf.user_service = ''',user_service,'''');
	END IF;
	
	/*Chọn theo bộ phận*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ( g1.groupid = ''',dept_id,''' OR g2.groupid = ''',dept_id,''')');
	END IF;
	
	/*Lọc theo col,val*/
	
	IF (col IS NOT NULL) AND (col = 'NV_assign') THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'NV_assign' AND col != 'c.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	
	SET myquery = CONCAT (myquery,' GROUP BY 1 ORDER BY 2 DESC, 1');
	
	

	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_account_total_account
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account_total_account`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `leadsource` VARCHAR(50),
	IN `industry` VARCHAR(50),
	IN `account_id` INT,
	IN `user_assign` VARCHAR(50),
	IN `user_marketing` VARCHAR(50),
	IN `user_service` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(4000);
	SET myquery = CONCAT('SELECT COUNT(DISTINCT c.crmid)
								
								FROM (SELECT accountid,account_no,accountname,
												CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
												annualrevenue,employees,isconvertedfromlead
										FROM vtiger_account) a
								
								JOIN vtiger_crmentity c
								ON a.accountid = c.crmid
								
								LEFT JOIN vtiger_contactdetails ctd
								ON a.accountid = ctd.accountid
																
								JOIN (SELECT accountid, 
												CASE WHEN cf_773 = '''' THEN ''Không có'' ELSE cf_773 END AS ''user_marketing'',
												CASE WHEN cf_775 = '''' THEN ''Không có'' ELSE cf_775 END AS ''user_service'',
												CASE WHEN cf_891 = '''' THEN ''Unknown'' ELSE cf_891 END AS ''status''
										FROM vtiger_accountscf ) acf
								ON acf.accountid = c.crmid
								
								LEFT JOIN (SELECT contactsubscriptionid,
														CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
												FROM vtiger_contactsubdetails) cts
								ON cts.contactsubscriptionid = ctd.contactid
								
								LEFT JOIN vtiger_users2group ug1
								ON ug1.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g1
								ON g1.groupid = ug1.groupid
								
								LEFT JOIN vtiger_users2group ug2
								ON ug2.groupid = c.smownerid
							
								LEFT JOIN vtiger_groups g2
								ON g2.groupid = ug2.groupid
								
								LEFT JOIN (SELECT accountaddressid,
												CASE WHEN ship_city='''' OR ship_city IS NULL THEN ''Unknown'' ELSE ship_city END AS ''ship_city''
												FROM vtiger_accountshipads) ad
								ON ad.accountaddressid = c.crmid
																
								WHERE 1=1');
	
	SET myquery = CONCAT(myquery,' AND c.deleted = ''0''');
	
	/*Chọn theo khoảng thời gian*/
	IF (timetype = 0 OR timetype IS NULL) AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	ELSEIF timetype = 1  AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		  SET myquery = CONCAT(myquery,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' ');
	END IF;
	
	/*Chọn theo nguồn*/
	IF (leadsource IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND cts.leadsource = ''',leadsource,'''');
	END IF;
	
	/*Chọn theo lĩnh vực*/
	IF (industry IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.industry = ''',industry,'''');
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.accountid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo user marketing*/
	IF(user_marketing IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND acf.user_marketing = ''',user_marketing,'''');
	END IF;	

	/*Chọn theo user giới thiệu*/
	IF(user_service IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND acf.user_service = ''',user_service,'''');
	END IF;
	
	/*Chọn theo bộ phận*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ( g1.groupid = ''',dept_id,''' OR g2.groupid = ''',dept_id,''')');
	END IF;
	
	/*Lọc theo col,val*/
	
	IF (col IS NOT NULL) AND (col = 'NV_assign') THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'NV_assign' AND col != 'c.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_account_total_contact
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account_total_contact`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `leadsource` VARCHAR(50),
	IN `industry` VARCHAR(50),
	IN `account_id` INT,
	IN `user_assign` VARCHAR(50),
	IN `user_marketing` VARCHAR(50),
	IN `user_service` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(4000);
	SET myquery = CONCAT('SELECT COUNT(DISTINCT c2.crmid)
								
								FROM (SELECT accountid,account_no,accountname,
												CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
												annualrevenue,employees,isconvertedfromlead
										FROM vtiger_account) a
								
								JOIN vtiger_crmentity c
								ON a.accountid = c.crmid
								
								LEFT JOIN vtiger_contactdetails ctd
								ON a.accountid = ctd.accountid
																
								JOIN (SELECT accountid, 
												CASE WHEN cf_773 = '''' THEN ''Không có'' ELSE cf_773 END AS ''user_marketing'',
												CASE WHEN cf_775 = '''' THEN ''Không có'' ELSE cf_775 END AS ''user_service'',
												CASE WHEN cf_891 = '''' THEN ''Unknown'' ELSE cf_891 END AS ''status''
										FROM vtiger_accountscf ) acf
								ON acf.accountid = c.crmid
								
								LEFT JOIN (SELECT contactsubscriptionid,
														CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
												FROM vtiger_contactsubdetails) cts
								ON cts.contactsubscriptionid = ctd.contactid
								
								LEFT JOIN vtiger_crmentity c2
								ON ctd.contactid = c2.crmid
								
								LEFT JOIN vtiger_users2group ug1
								ON ug1.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g1
								ON g1.groupid = ug1.groupid
								
								LEFT JOIN vtiger_users2group ug2
								ON ug2.groupid = c.smownerid
							
								LEFT JOIN vtiger_groups g2
								ON g2.groupid = ug2.groupid
								
								LEFT JOIN (SELECT accountaddressid,
												CASE WHEN ship_city='''' OR ship_city IS NULL THEN ''Unknown'' ELSE ship_city END AS ''ship_city''
												FROM vtiger_accountshipads) ad
								ON ad.accountaddressid = c.crmid
								
								WHERE 1=1');
	SET myquery = CONCAT(myquery,' AND c.deleted = ''0''');
	SET myquery = CONCAT(myquery,' AND c2.deleted = ''0''');
		
	/*Chọn theo khoảng thời gian*/
	IF (timetype = 0 OR timetype IS NULL) AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	ELSEIF timetype = 1  AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		  SET myquery = CONCAT(myquery,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' ');
	END IF;
	
	/*Chọn theo nguồn*/
	IF (leadsource IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND cts.leadsource = ''',leadsource,'''');
	END IF;
	
	/*Chọn theo lĩnh vực*/
	IF (industry IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.industry = ''',industry,'''');
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.accountid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo user marketing*/
	IF(user_marketing IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND acf.user_marketing = ''',user_marketing,'''');
	END IF;	

	/*Chọn theo user giới thiệu*/
	IF(user_service IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND acf.user_service = ''',user_service,'''');
	END IF;
	
	/*Chọn theo bộ phận*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ( g1.groupid = ''',dept_id,''' OR g2.groupid = ''',dept_id,''')');
	END IF;
	
	/*Lọc theo col,val*/
	
	IF (col IS NOT NULL) AND (col = 'NV_assign') THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'NV_assign' AND col != 'c.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_account_total_potential
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account_total_potential`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `leadsource` VARCHAR(50),
	IN `industry` VARCHAR(50),
	IN `account_id` INT,
	IN `user_assign` VARCHAR(50),
	IN `user_marketing` VARCHAR(50),
	IN `user_service` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(4000);
	SET myquery = CONCAT('SELECT COUNT(DISTINCT c2.crmid)
								
								FROM (SELECT accountid,account_no,accountname,
												CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
												annualrevenue,employees,isconvertedfromlead
										FROM vtiger_account) a
								
								JOIN vtiger_crmentity c
								ON a.accountid = c.crmid
								
								LEFT JOIN vtiger_contactdetails ctd
								ON a.accountid = ctd.accountid
																
								JOIN (SELECT accountid, 
												CASE WHEN cf_773 = '''' THEN ''Không có'' ELSE cf_773 END AS ''user_marketing'',
												CASE WHEN cf_775 = '''' THEN ''Không có'' ELSE cf_775 END AS ''user_service'',
												CASE WHEN cf_891 = '''' THEN ''Unknown'' ELSE cf_891 END AS ''status''
										FROM vtiger_accountscf ) acf
								ON acf.accountid = c.crmid
								
								LEFT JOIN (SELECT contactsubscriptionid,
														CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
												FROM vtiger_contactsubdetails) cts
								ON cts.contactsubscriptionid = ctd.contactid
								
								LEFT JOIN vtiger_potential p 
								ON a.accountid = p.related_to
								
								LEFT JOIN vtiger_crmentity c2
								ON p.potentialid = c2.crmid
								
								LEFT JOIN vtiger_users2group ug1
								ON ug1.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g1
								ON g1.groupid = ug1.groupid
								
								LEFT JOIN vtiger_users2group ug2
								ON ug2.groupid = c.smownerid
							
								LEFT JOIN vtiger_groups g2
								ON g2.groupid = ug2.groupid
								
								LEFT JOIN (SELECT accountaddressid,
												CASE WHEN ship_city='''' OR ship_city IS NULL THEN ''Unknown'' ELSE ship_city END AS ''ship_city''
												FROM vtiger_accountshipads) ad
								ON ad.accountaddressid = c.crmid
								
								WHERE 1=1');
	SET myquery = CONCAT(myquery,' AND c.deleted = ''0''');
	SET myquery = CONCAT(myquery,' AND c2.deleted = ''0''');
		
	/*Chọn theo khoảng thời gian*/
	IF (timetype = 0 OR timetype IS NULL) AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	ELSEIF timetype = 1  AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		  SET myquery = CONCAT(myquery,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' ');
	END IF;
	
	/*Chọn theo nguồn*/
	IF (leadsource IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND cts.leadsource = ''',leadsource,'''');
	END IF;
	
	/*Chọn theo lĩnh vực*/
	IF (industry IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.industry = ''',industry,'''');
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.accountid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo user marketing*/
	IF(user_marketing IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND acf.user_marketing = ''',user_marketing,'''');
	END IF;	

	/*Chọn theo user giới thiệu*/
	IF(user_service IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND acf.user_service = ''',user_service,'''');
	END IF;
	
	/*Chọn theo bộ phận*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ( g1.groupid = ''',dept_id,''' OR g2.groupid = ''',dept_id,''')');
	END IF;
	
	/*Lọc theo col,val*/
	
	IF (col IS NOT NULL) AND (col = 'NV_assign') THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'NV_assign' AND col != 'c.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;

	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_account_total_salesorder
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account_total_salesorder`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `leadsource` VARCHAR(50),
	IN `industry` VARCHAR(50),
	IN `account_id` INT,
	IN `user_assign` VARCHAR(50),
	IN `user_marketing` VARCHAR(50),
	IN `user_service` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(4000);
	SET myquery = CONCAT('SELECT COUNT(DISTINCT c2.crmid)
								
								FROM (SELECT accountid,account_no,accountname,
												CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
												annualrevenue,employees,isconvertedfromlead
										FROM vtiger_account) a
								
								JOIN vtiger_crmentity c
								ON a.accountid = c.crmid
								
								LEFT JOIN vtiger_contactdetails ctd
								ON a.accountid = ctd.accountid
																
								JOIN (SELECT accountid, 
												CASE WHEN cf_773 = '''' THEN ''Không có'' ELSE cf_773 END AS ''user_marketing'',
												CASE WHEN cf_775 = '''' THEN ''Không có'' ELSE cf_775 END AS ''user_service'',
												CASE WHEN cf_891 = '''' THEN ''Unknown'' ELSE cf_891 END AS ''status''
										FROM vtiger_accountscf ) acf
								ON acf.accountid = c.crmid
								
								LEFT JOIN (SELECT contactsubscriptionid,
														CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
												FROM vtiger_contactsubdetails) cts
								ON cts.contactsubscriptionid = ctd.contactid
								
								LEFT JOIN vtiger_salesorder so
								ON a.accountid = so.accountid
								
								LEFT JOIN vtiger_crmentity c2
								ON so.salesorderid = c2.crmid
								
								LEFT JOIN vtiger_users2group ug1
								ON ug1.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g1
								ON g1.groupid = ug1.groupid
								
								LEFT JOIN vtiger_users2group ug2
								ON ug2.groupid = c.smownerid
							
								LEFT JOIN vtiger_groups g2
								ON g2.groupid = ug2.groupid
								
								LEFT JOIN (SELECT accountaddressid,
												CASE WHEN ship_city='''' OR ship_city IS NULL THEN ''Unknown'' ELSE ship_city END AS ''ship_city''
												FROM vtiger_accountshipads) ad
								ON ad.accountaddressid = c.crmid
								
								WHERE 1=1');
	SET myquery = CONCAT(myquery,' AND c.deleted = ''0''');
	SET myquery = CONCAT(myquery,' AND c2.deleted = ''0''');
	
		
	/*Chọn theo khoảng thời gian*/
	IF (timetype = 0 OR timetype IS NULL) AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	ELSEIF timetype = 1  AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		  SET myquery = CONCAT(myquery,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' ');
	END IF;
	
	
	/*Chọn theo nguồn*/
	IF (leadsource IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND cts.leadsource = ''',leadsource,'''');
	END IF;
	
	/*Chọn theo lĩnh vực*/
	IF (industry IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.industry = ''',industry,'''');
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.accountid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo user marketing*/
	IF(user_marketing IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND acf.user_marketing = ''',user_marketing,'''');
	END IF;	

	/*Chọn theo user giới thiệu*/
	IF(user_service IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND acf.user_service = ''',user_service,'''');
	END IF;
	
	/*Chọn theo bộ phận*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ( g1.groupid = ''',dept_id,''' OR g2.groupid = ''',dept_id,''')');
	END IF;
	
	/*Lọc theo col,val*/
	
	IF (col IS NOT NULL) AND (col = 'NV_assign') THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'NV_assign' AND col != 'c.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;

	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_account_user_assign
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account_user_assign`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `leadsource` VARCHAR(50),
	IN `industry` VARCHAR(50),
	IN `account_id` INT,
	IN `user_assign` INT,
	IN `user_marketing` VARCHAR(50),
	IN `user_service` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(4000);
	DECLARE myquery_1 nvarchar(2000);
	DECLARE myquery_2 nvarchar(2000);

	SET myquery_1 = CONCAT('(SELECT c.smownerid,u.user_name AS ''NV_assign'', COUNT(DISTINCT c.crmid) as SL
	
									FROM (SELECT accountid,account_no,accountname,
													CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
													annualrevenue,employees,isconvertedfromlead
											FROM vtiger_account) a
									
									JOIN vtiger_crmentity c
									ON a.accountid = c.crmid
									
									LEFT JOIN vtiger_contactdetails ctd
									ON a.accountid = ctd.accountid
									
									JOIN (SELECT accountid, 
													CASE WHEN cf_773 = '''' THEN ''Không có'' ELSE cf_773 END AS ''user_marketing'',
													CASE WHEN cf_775 = '''' THEN ''Không có'' ELSE cf_775 END AS ''user_service'',
													CASE WHEN cf_891 = '''' THEN ''Unknown'' ELSE cf_891 END AS ''status''
											FROM vtiger_accountscf ) acf
									ON acf.accountid = c.crmid
									
									LEFT JOIN (SELECT contactsubscriptionid,
															CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
													FROM vtiger_contactsubdetails) cts
									ON cts.contactsubscriptionid = ctd.contactid		
									
									JOIN vtiger_users u
									ON c.smownerid = u.id
									
									LEFT JOIN vtiger_users2group ug1
									ON ug1.userid = c.smownerid
									
									LEFT JOIN vtiger_groups g1
									ON g1.groupid = ug1.groupid
									
									LEFT JOIN (SELECT accountaddressid,
												CASE WHEN ship_city='''' OR ship_city IS NULL THEN ''Unknown'' ELSE ship_city END AS ''ship_city''
												FROM vtiger_accountshipads) ad
									ON ad.accountaddressid = c.crmid
									
									
									WHERE 1=1 ');
	SET myquery_1 = CONCAT(myquery_1, ' AND c.deleted = ''0''');	
	SET myquery_1 = CONCAT(myquery_1, ' AND u.deleted = ''0''');
	
		
	/*Chọn theo khoảng thời gian*/
	IF (timetype = 0 OR timetype IS NULL) AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET myquery_1 = CONCAT(myquery_1,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	ELSEIF timetype = 1  AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		  SET myquery_1 = CONCAT(myquery_1,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' ');
	END IF;
	
	/*Chọn theo nguồn*/
	IF (leadsource IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND cts.leadsource = ''',leadsource,'''');
	END IF;
	
	/*Chọn theo lĩnh vực*/
	IF (industry IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND a.industry = ''',industry,'''');
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND a.accountid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo user marketing*/
	IF(user_marketing IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND acf.user_marketing = ''',user_marketing,'''');
	END IF;	

	/*Chọn theo user giới thiệu*/
	IF(user_service IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND acf.user_service = ''',user_service,'''');
	END IF;
	
	/*Chọn theo bộ phận*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND g1.groupid = ''',dept_id,'''');
	END IF;
	
	/*Lọc theo col,val*/
	
	IF (col IS NOT NULL) AND (col = 'NV_assign') THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.smownerid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'NV_assign' AND col != 'c.label')  THEN
		SET myquery_1 = CONCAT(myquery_1,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	SET myquery_1 = CONCAT(myquery_1,' GROUP BY 1');
	
	SET myquery_1 = CONCAT(myquery_1,' )');
	
	
	
	SET myquery_2 = CONCAT('(SELECT c.smownerid,g.groupname AS ''NV_assign'', COUNT(DISTINCT c.crmid) as SL
	
									FROM (SELECT accountid,account_no,accountname,
													CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
													annualrevenue,employees,isconvertedfromlead
											FROM vtiger_account) a
									
									JOIN vtiger_crmentity c
									ON a.accountid = c.crmid
									
									LEFT JOIN vtiger_contactdetails ctd
									ON a.accountid = ctd.accountid
									
									JOIN (SELECT accountid, 
													CASE WHEN cf_773 = '''' THEN ''Không có'' ELSE cf_773 END AS ''user_marketing'',
													CASE WHEN cf_775 = '''' THEN ''Không có'' ELSE cf_775 END AS ''user_service'',
													CASE WHEN cf_891 = '''' THEN ''Unknown'' ELSE cf_891 END AS ''status''
											FROM vtiger_accountscf ) acf
									ON acf.accountid = c.crmid
									
									LEFT JOIN (SELECT contactsubscriptionid,
															CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
													FROM vtiger_contactsubdetails) cts
									ON cts.contactsubscriptionid = ctd.contactid		
									
									JOIN vtiger_groups g
									ON c.smownerid = g.groupid
									
								
									LEFT JOIN vtiger_users2group ug1
									ON ug1.groupid = c.smownerid
							
									LEFT JOIN vtiger_groups g1
									ON g1.groupid = ug1.groupid
									
									LEFT JOIN (SELECT accountaddressid,
												CASE WHEN ship_city='''' OR ship_city IS NULL THEN ''Unknown'' ELSE ship_city END AS ''ship_city''
												FROM vtiger_accountshipads) ad
									ON ad.accountaddressid = c.crmid
									
									WHERE 1=1 ');
	
	SET myquery_2 = CONCAT(myquery_2, ' AND c.deleted = ''0''');
	
	/*Chọn theo khoảng thời gian*/
	IF (timetype = 0 OR timetype IS NULL) AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET myquery_2 = CONCAT(myquery_2,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	ELSEIF timetype = 1  AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		  SET myquery_2 = CONCAT(myquery_2,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' ');
	END IF;
	
	/*Chọn theo nguồn*/
	IF (leadsource IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND cts.leadsource = ''',leadsource,'''');
	END IF;
	
	/*Chọn theo lĩnh vực*/
	IF (industry IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND a.industry = ''',industry,'''');
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND a.accountid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo user marketing*/
	IF(user_marketing IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND acf.user_marketing = ''',user_marketing,'''');
	END IF;	

	/*Chọn theo user giới thiệu*/
	IF(user_service IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND acf.user_service = ''',user_service,'''');
	END IF;
	
	/*Chọn theo bộ phận*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND g1.groupid = ''',dept_id,'''');
	END IF;
	
	/*Lọc theo col,val*/
	
	IF (col IS NOT NULL) AND (col = 'NV_assign') THEN
		SET myquery_2 = CONCAT(myquery_2,' AND c.smownerid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery_2 = CONCAT(myquery_2,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'NV_assign' AND col != 'c.label')  THEN
		SET myquery_2 = CONCAT(myquery_2,' AND ',col, ' = ''', val,''' ');
	END IF;
			
	SET myquery_2 = CONCAT(myquery_2,' GROUP BY 1 ');
	SET myquery_2 = CONCAT(myquery_2,' )');
	
	SET myquery = CONCAT(myquery_1,' UNION ALL ',myquery_2);
	SET myquery = CONCAT(myquery,' ORDER BY 3 DESC, 2');

	SELECT myquery;
	SET @SQL := myquery;
	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_account_user_detail
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account_user_detail`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `leadsource` VARCHAR(50),
	IN `industry` VARCHAR(50),
	IN `account_id` INT,
	IN `user_assign` INT,
	IN `user_marketing` VARCHAR(50),
	IN `user_service` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)

)
BEGIN
	
	DECLARE myquery nvarchar(6000);
	DECLARE myquery_1 nvarchar(3000);
	DECLARE myquery_2 nvarchar(3000);

	SET myquery_1 = CONCAT('(SELECT DISTINCT c.crmid, 
										CONCAT(''['',c.label, '' ('',a.account_no, '')'', '' ]'',''(http://crm.fastdn.com.vn/index.php?module=Accounts&view=Detail&record='',c.crmid,''&app=SUPPORT)'') AS ''c.label'',c.smownerid, u.user_name AS NV_assigned,
											acf.user_marketing AS NV_marketing,
											acf.user_service AS NV_gioithieu
											
									FROM (SELECT accountid,account_no,accountname,
																CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
																annualrevenue,employees,isconvertedfromlead
														FROM vtiger_account) a
												
									JOIN vtiger_crmentity c
									ON a.accountid = c.crmid
									
									LEFT JOIN vtiger_contactdetails ctd
									ON a.accountid = ctd.accountid
									
									JOIN (SELECT accountid, 
													CASE WHEN cf_773 = '''' THEN ''Không có'' ELSE cf_773 END AS ''user_marketing'',
													CASE WHEN cf_775 = '''' THEN ''Không có'' ELSE cf_775 END AS ''user_service'',
													CASE WHEN cf_891 = '''' THEN ''Unknown'' ELSE cf_891 END AS ''status''
											FROM vtiger_accountscf ) acf
									ON acf.accountid = c.crmid
									
									LEFT JOIN (SELECT contactsubscriptionid,
															CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
													FROM vtiger_contactsubdetails) cts
									ON cts.contactsubscriptionid = ctd.contactid
						
									JOIN vtiger_users u
									ON c.smownerid = u.id
									
									LEFT JOIN vtiger_users2group ug1
									ON ug1.userid = c.smownerid
									
									LEFT JOIN vtiger_groups g1
									ON g1.groupid = ug1.groupid
									
									LEFT JOIN (SELECT accountaddressid,
												CASE WHEN ship_city='''' OR ship_city IS NULL THEN ''Unknown'' ELSE ship_city END AS ''ship_city''
												FROM vtiger_accountshipads) ad
									ON ad.accountaddressid = c.crmid
									
									WHERE 1=1 ');
	SET myquery_2 = CONCAT('(SELECT DISTINCT c.crmid, 
										CONCAT(''['',c.label, '' ('',a.account_no, '')'', '' ]'',''(http://crm.fastdn.com.vn/index.php?module=Accounts&view=Detail&record='',c.crmid,''&app=SALES)'') AS ''c.label'',
											c.smownerid, g.groupname AS NV_assigned,
											acf.user_marketing AS NV_marketing,
											acf.user_service AS NV_gioithieu
											
									FROM (SELECT accountid,account_no,accountname,
																				CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
																				annualrevenue,employees,isconvertedfromlead
																		FROM vtiger_account) a
																
									JOIN vtiger_crmentity c
									ON a.accountid = c.crmid
									
									LEFT JOIN vtiger_contactdetails ctd
									ON a.accountid = ctd.accountid
									
									JOIN (SELECT accountid, 
													CASE WHEN cf_773 = '''' THEN ''Không có'' ELSE cf_773 END AS ''user_marketing'',
													CASE WHEN cf_775 = '''' THEN ''Không có'' ELSE cf_775 END AS ''user_service'',
													CASE WHEN cf_891 = '''' THEN ''Unknown'' ELSE cf_891 END AS ''status''
											FROM vtiger_accountscf ) acf
									ON acf.accountid = c.crmid
									
									LEFT JOIN (SELECT contactsubscriptionid,
															CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
													FROM vtiger_contactsubdetails) cts
									ON cts.contactsubscriptionid = ctd.contactid
									
									JOIN vtiger_groups g
									ON c.smownerid = g.groupid
									
									LEFT JOIN vtiger_users2group ug1
									ON ug1.userid = c.smownerid
									
									LEFT JOIN vtiger_groups g1
									ON g1.groupid = ug1.groupid
									
									LEFT JOIN (SELECT accountaddressid,
												CASE WHEN ship_city='''' OR ship_city IS NULL THEN ''Unknown'' ELSE ship_city END AS ''ship_city''
												FROM vtiger_accountshipads) ad
									ON ad.accountaddressid = c.crmid
									
									WHERE 1=1 ');

	SET myquery_1 = CONCAT(myquery_1, ' AND c.deleted = ''0''');	
	SET myquery_1 = CONCAT(myquery_1, ' AND u.deleted = ''0''');
		
	/*Chọn theo khoảng thời gian*/
	IF (timetype = 0 OR timetype IS NULL) AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET myquery_1 = CONCAT(myquery_1,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	ELSEIF timetype = 1  AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		  SET myquery_1 = CONCAT(myquery_1,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' ');
	END IF;
	
	/*Chọn theo nguồn*/
	IF (leadsource IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND cts.leadsource = ''',leadsource,'''');
	END IF;
	
	/*Chọn theo lĩnh vực*/
	IF (industry IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND a.industry = ''',industry,'''');
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND a.accountid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo user marketing*/
	IF(user_marketing IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND acf.user_marketing = ''',user_marketing,'''');
	END IF;	

	/*Chọn theo user giới thiệu*/
	IF(user_service IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND acf.user_service = ''',user_service,'''');
	END IF;
	
	/*Chọn theo bộ phận*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND g1.groupid = ''',dept_id,'''');
	END IF;
	
	/*Lọc theo col,val*/
	IF (col IS NOT NULL) AND (col = 'NV_assign') THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.smownerid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'NV_assign' AND col != 'c.label')  THEN
		SET myquery_1 = CONCAT(myquery_1,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	SET myquery_1 = CONCAT(myquery_1, ' )');

	
	SET myquery_2 = CONCAT(myquery_2, ' AND c.deleted = ''0''');
		
	/*Chọn theo khoảng thời gian*/
	IF (timetype = 0 OR timetype IS NULL) AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET myquery_2 = CONCAT(myquery_2,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	ELSEIF timetype = 1  AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		  SET myquery_2 = CONCAT(myquery_2,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' ');
	END IF;
	
	/*Chọn theo nguồn*/
	IF (leadsource IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND cts.leadsource = ''',leadsource,'''');
	END IF;
	
	/*Chọn theo lĩnh vực*/
	IF (industry IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND a.industry = ''',industry,'''');
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND a.accountid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo user marketing*/
	IF(user_marketing IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND acf.user_marketing = ''',user_marketing,'''');
	END IF;	

	/*Chọn theo user giới thiệu*/
	IF(user_service IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND acf.user_service = ''',user_service,'''');
	END IF;
	
	/*Chọn theo bộ phận*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND g1.groupid = ''',dept_id,'''');
	END IF;
	
	/*Lọc theo col,val*/
	IF (col IS NOT NULL) AND (col = 'NV_assign') THEN
		SET myquery_2 = CONCAT(myquery_2,' AND c.smownerid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery_2 = CONCAT(myquery_2,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'NV_assign' AND col != 'c.label')  THEN
		SET myquery_2 = CONCAT(myquery_2,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	SET myquery_2 = CONCAT(myquery_2, ' )');
	
	SET myquery = CONCAT(myquery_1,' UNION ALL ',myquery_2);
	SET myquery = CONCAT(myquery,' ORDER BY 2');

	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_account_user_marketing
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account_user_marketing`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `leadsource` VARCHAR(50),
	IN `industry` VARCHAR(50),
	IN `account_id` INT,
	IN `user_assign` INT,
	IN `user_marketing` VARCHAR(50),
	IN `user_service` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(4000);
	DECLARE myquery_1 nvarchar(2000);
	DECLARE myquery_2 nvarchar(2000);


	SET myquery_1 = CONCAT('(SELECT acf.user_marketing AS NV_marketing, 
											COUNT(DISTINCT c.crmid) AS SL
											
									FROM (SELECT accountid,account_no,accountname,
													CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
													annualrevenue,employees,isconvertedfromlead
											FROM vtiger_account) a
												
									JOIN vtiger_crmentity c
									ON a.accountid = c.crmid
									
									LEFT JOIN vtiger_contactdetails ctd
									ON a.accountid = ctd.accountid
									
									JOIN (SELECT accountid, 
													CASE WHEN cf_773 = '''' THEN ''Không có'' ELSE cf_773 END AS ''user_marketing'',
													CASE WHEN cf_775 = '''' THEN ''Không có'' ELSE cf_775 END AS ''user_service'',
													CASE WHEN cf_891 = '''' THEN ''Unknown'' ELSE cf_891 END AS ''status''
											FROM vtiger_accountscf ) acf
									ON acf.accountid = c.crmid
									
									LEFT JOIN (SELECT contactsubscriptionid,
															CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
													FROM vtiger_contactsubdetails) cts
									ON cts.contactsubscriptionid = ctd.contactid
						
									JOIN vtiger_users u
									ON c.smownerid = u.id
									
									LEFT JOIN vtiger_users2group ug1
									ON ug1.userid = c.smownerid
									
									LEFT JOIN vtiger_groups g1
									ON g1.groupid = ug1.groupid
									
									LEFT JOIN (SELECT accountaddressid,
												CASE WHEN ship_city='''' OR ship_city IS NULL THEN ''Unknown'' ELSE ship_city END AS ''ship_city''
												FROM vtiger_accountshipads) ad
									ON ad.accountaddressid = c.crmid
									
									
									WHERE 1=1 ');
	SET myquery_2 = CONCAT('(SELECT acf.user_marketing AS NV_marketing, 
											COUNT(DISTINCT c.crmid) AS SL
											
									FROM (SELECT accountid,account_no,accountname,
													CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
													annualrevenue,employees,isconvertedfromlead
											FROM vtiger_account) a
												
									JOIN vtiger_crmentity c
									ON a.accountid = c.crmid
									
									LEFT JOIN vtiger_contactdetails ctd
									ON a.accountid = ctd.accountid
									
									JOIN (SELECT accountid, 
													CASE WHEN cf_773 = '''' THEN ''Không có'' ELSE cf_773 END AS ''user_marketing'',
													CASE WHEN cf_775 = '''' THEN ''Không có'' ELSE cf_775 END AS ''user_service'',
													CASE WHEN cf_891 = '''' THEN ''Unknown'' ELSE cf_891 END AS ''status''
											FROM vtiger_accountscf ) acf
									ON acf.accountid = c.crmid
									
									LEFT JOIN (SELECT contactsubscriptionid,
															CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
													FROM vtiger_contactsubdetails) cts
									ON cts.contactsubscriptionid = ctd.contactid
						
									JOIN vtiger_groups g
									ON c.smownerid = g.groupid
									
									LEFT JOIN vtiger_users2group ug1
									ON ug1.groupid = c.smownerid
							
									LEFT JOIN vtiger_groups g1
									ON g1.groupid = ug1.groupid
									
									LEFT JOIN (SELECT accountaddressid,
												CASE WHEN ship_city='''' OR ship_city IS NULL THEN ''Unknown'' ELSE ship_city END AS ''ship_city''
												FROM vtiger_accountshipads) ad
									ON ad.accountaddressid = c.crmid
									WHERE 1=1 ');

	SET myquery_1 = CONCAT(myquery_1, ' AND c.deleted = ''0''');	
	SET myquery_1 = CONCAT(myquery_1, ' AND u.deleted = ''0''');
			
	/*Chọn theo khoảng thời gian*/
	IF (timetype = 0 OR timetype IS NULL) AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET myquery_1 = CONCAT(myquery_1,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	ELSEIF timetype = 1  AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		  SET myquery_1 = CONCAT(myquery_1,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' ');
	END IF;
	
	/*Chọn theo nguồn*/
	IF (leadsource IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND cts.leadsource = ''',leadsource,'''');
	END IF;
	
	/*Chọn theo lĩnh vực*/
	IF (industry IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND a.industry = ''',industry,'''');
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND a.accountid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo user marketing*/
	IF(user_marketing IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND acf.user_marketing = ''',user_marketing,'''');
	END IF;	

	/*Chọn theo user giới thiệu*/
	IF(user_service IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND acf.user_service = ''',user_service,'''');
	END IF;
	
	/*Chọn theo bộ phận*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND g1.groupid = ''',dept_id,'''');
	END IF;
	
	/*Lọc theo col,val*/
	IF (col IS NOT NULL) AND (col = 'NV_assign') THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.smownerid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'NV_assign' AND col != 'c.label')  THEN
		SET myquery_1 = CONCAT(myquery_1,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	SET myquery_1 = CONCAT(myquery_1,' GROUP BY 1)');
	
	
	SET myquery_2 = CONCAT(myquery_2, ' AND c.deleted = ''0''');	
			
	/*Chọn theo khoảng thời gian*/
	IF (timetype = 0 OR timetype IS NULL) AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET myquery_2 = CONCAT(myquery_2,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	ELSEIF timetype = 1  AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		  SET myquery_2 = CONCAT(myquery_2,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' ');
	END IF;
	
	/*Chọn theo nguồn*/
	IF (leadsource IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND cts.leadsource = ''',leadsource,'''');
	END IF;
	
	/*Chọn theo lĩnh vực*/
	IF (industry IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND a.industry = ''',industry,'''');
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND a.accountid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo user marketing*/
	IF(user_marketing IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND acf.user_marketing = ''',user_marketing,'''');
	END IF;	

	/*Chọn theo user giới thiệu*/
	IF(user_service IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND acf.user_service = ''',user_service,'''');
	END IF;
	
	/*Chọn theo bộ phận*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND g1.groupid = ''',dept_id,'''');
	END IF;
	
	/*Lọc theo col,val*/
	IF (col IS NOT NULL) AND (col = 'NV_assign') THEN
		SET myquery_2 = CONCAT(myquery_2,' AND c.smownerid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery_2 = CONCAT(myquery_2,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'NV_assign' AND col != 'c.label')  THEN
		SET myquery_2 = CONCAT(myquery_2,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	SET myquery_2 = CONCAT(myquery_2,' GROUP BY 1)');
	
	SET myquery = CONCAT('SELECT NV_marketing,SUM(SL) AS SL
								FROM (',myquery_1,' UNION ALL ',myquery_2,') user');
	SET myquery = CONCAT(myquery,' GROUP BY 1 ORDER BY 2 DESC, 1');

	SELECT myquery;
	SET @SQL := myquery;
	PREPARE my_query FROM @SQL;
	EXECUTE my_query;

	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_account_user_service
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account_user_service`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `leadsource` VARCHAR(50),
	IN `industry` VARCHAR(50),
	IN `account_id` INT,
	IN `user_assign` INT,
	IN `user_marketing` VARCHAR(50),
	IN `user_service` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(4000);
	DECLARE myquery_1 nvarchar(2000);
	DECLARE myquery_2 nvarchar(2000);


	SET myquery_1 = CONCAT('(SELECT acf.user_service AS NV_gioithieu, 
											COUNT(DISTINCT c.crmid) AS SL
											
									FROM (SELECT accountid,account_no,accountname,
													CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
													annualrevenue,employees,isconvertedfromlead
											FROM vtiger_account) a
												
									JOIN vtiger_crmentity c
									ON a.accountid = c.crmid
									
									LEFT JOIN vtiger_contactdetails ctd
									ON a.accountid = ctd.accountid
									
									JOIN (SELECT accountid, 
													CASE WHEN cf_773 = '''' THEN ''Không có'' ELSE cf_773 END AS ''user_marketing'',
													CASE WHEN cf_775 = '''' THEN ''Không có'' ELSE cf_775 END AS ''user_service'',
													CASE WHEN cf_891 = '''' THEN ''Unknown'' ELSE cf_891 END AS ''status''
											FROM vtiger_accountscf ) acf
									ON acf.accountid = c.crmid
									
									LEFT JOIN (SELECT contactsubscriptionid,
															CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
													FROM vtiger_contactsubdetails) cts
									ON cts.contactsubscriptionid = ctd.contactid
									
									JOIN vtiger_users u
									ON c.smownerid = u.id
									
									LEFT JOIN vtiger_users2group ug1
									ON ug1.userid = c.smownerid
									
									LEFT JOIN vtiger_groups g1
									ON g1.groupid = ug1.groupid
									
									LEFT JOIN (SELECT accountaddressid,
												CASE WHEN ship_city='''' OR ship_city IS NULL THEN ''Unknown'' ELSE ship_city END AS ''ship_city''
												FROM vtiger_accountshipads) ad
									ON ad.accountaddressid = c.crmid
									
									WHERE 1=1 ');
	SET myquery_2 = CONCAT('(SELECT acf.user_service AS NV_gioithieu, 
											COUNT(DISTINCT c.crmid) AS SL
									FROM (SELECT accountid,account_no,accountname,
													CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
													annualrevenue,employees,isconvertedfromlead
											FROM vtiger_account) a
												
									JOIN vtiger_crmentity c
									ON a.accountid = c.crmid
									
									LEFT JOIN vtiger_contactdetails ctd
									ON a.accountid = ctd.accountid
									
									JOIN (SELECT accountid, 
													CASE WHEN cf_773 = '''' THEN ''Không có'' ELSE cf_773 END AS ''user_marketing'',
													CASE WHEN cf_775 = '''' THEN ''Không có'' ELSE cf_775 END AS ''user_service'',
													CASE WHEN cf_891 = '''' THEN ''Unknown'' ELSE cf_891 END AS ''status''
											FROM vtiger_accountscf ) acf
									ON acf.accountid = c.crmid
									
									LEFT JOIN (SELECT contactsubscriptionid,
															CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
													FROM vtiger_contactsubdetails) cts
									ON cts.contactsubscriptionid = ctd.contactid
									
									JOIN vtiger_groups g
									ON c.smownerid = g.groupid
									
									LEFT JOIN vtiger_users2group ug1
									ON ug1.groupid = c.smownerid
							
									LEFT JOIN vtiger_groups g1
									ON g1.groupid = ug1.groupid
									
									LEFT JOIN (SELECT accountaddressid,
												CASE WHEN ship_city='''' OR ship_city IS NULL THEN ''Unknown'' ELSE ship_city END AS ''ship_city''
												FROM vtiger_accountshipads) ad
									ON ad.accountaddressid = c.crmid
									
									WHERE 1=1 ');

	SET myquery_1 = CONCAT(myquery_1, ' AND c.deleted = ''0''');	
	SET myquery_1 = CONCAT(myquery_1, ' AND u.deleted = ''0''');
			
	/*Chọn theo khoảng thời gian*/
	IF (timetype = 0 OR timetype IS NULL) AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET myquery_1 = CONCAT(myquery_1,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	ELSEIF timetype = 1  AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		  SET myquery_1 = CONCAT(myquery_1,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' ');
	END IF;
	
	/*Chọn theo nguồn*/
	IF (leadsource IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND cts.leadsource = ''',leadsource,'''');
	END IF;
	
	/*Chọn theo lĩnh vực*/
	IF (industry IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND a.industry = ''',industry,'''');
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND a.accountid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo user marketing*/
	IF(user_marketing IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND acf.user_marketing = ''',user_marketing,'''');
	END IF;	

	/*Chọn theo user giới thiệu*/
	IF(user_service IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND acf.user_service = ''',user_service,'''');
	END IF;
	
	/*Chọn theo bộ phận*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND g1.groupid = ''',dept_id,'''');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'NV_assign') THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.smownerid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'NV_assign' AND col != 'c.label')  THEN
		SET myquery_1 = CONCAT(myquery_1,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	SET myquery_1 = CONCAT(myquery_1,' GROUP BY 1)');
	
	SET myquery_2 = CONCAT(myquery_2, ' AND c.deleted = ''0''');	
			
	/*Chọn theo khoảng thời gian*/
	IF (timetype = 0 OR timetype IS NULL) AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET myquery_2 = CONCAT(myquery_2,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	ELSEIF timetype = 1  AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		  SET myquery_2 = CONCAT(myquery_2,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' ');
	END IF;
	
	/*Chọn theo nguồn*/
	IF (leadsource IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND cts.leadsource = ''',leadsource,'''');
	END IF;
	
	/*Chọn theo lĩnh vực*/
	IF (industry IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND a.industry = ''',industry,'''');
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND a.accountid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo user marketing*/
	IF(user_marketing IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND acf.user_marketing = ''',user_marketing,'''');
	END IF;	

	/*Chọn theo user giới thiệu*/
	IF(user_service IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND acf.user_service = ''',user_service,'''');
	END IF;
	
	/*Chọn theo bộ phận*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery_2 = CONCAT(myquery_2,' AND g1.groupid = ''',dept_id,'''');
	END IF;
	
	/*Lọc theo col,val*/
	IF (col IS NOT NULL) AND (col = 'NV_assign') THEN
		SET myquery_2 = CONCAT(myquery_2,' AND c.smownerid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery_2 = CONCAT(myquery_2,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'NV_assign' AND col != 'c.label')  THEN
		SET myquery_2 = CONCAT(myquery_2,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	SET myquery_2 = CONCAT(myquery_2,' GROUP BY 1)');
	
	SET myquery = CONCAT('SELECT NV_gioithieu,SUM(SL) AS SL
								FROM (',myquery_1,' UNION ALL ',myquery_2,') user');
	SET myquery = CONCAT(myquery,' GROUP BY 1 ORDER BY 2 DESC, 1');

	SELECT myquery;
	SET @SQL := myquery;
	PREPARE my_query FROM @SQL;
	EXECUTE my_query;

	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_account_year
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_account_year`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `leadsource` VARCHAR(50),
	IN `industry` VARCHAR(50),
	IN `account_id` INT,
	IN `user_assign` VARCHAR(50),
	IN `user_marketing` VARCHAR(50),
	IN `user_service` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN

	DECLARE myquery_1 nvarchar(4000);
	DECLARE myquery_2 nvarchar(4000);
	
	
	SET myquery_1 = CONCAT('SELECT CAST(Year(c.createdtime) AS CHAR) , COUNT(DISTINCT c.crmid)
								
								FROM (SELECT accountid,account_no,accountname,
												CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
												annualrevenue,employees,isconvertedfromlead
										FROM vtiger_account) a
								
								JOIN vtiger_crmentity c
								ON a.accountid = c.crmid
								
								LEFT JOIN vtiger_contactdetails ctd
								ON a.accountid = ctd.accountid
								
								JOIN (SELECT accountid, 
												CASE WHEN cf_773 = '''' THEN ''Không có'' ELSE cf_773 END AS ''user_marketing'',
												CASE WHEN cf_775 = '''' THEN ''Không có'' ELSE cf_775 END AS ''user_service'',
												CASE WHEN cf_891 = '''' THEN ''Unknown'' ELSE cf_891 END AS ''status''
										FROM vtiger_accountscf ) acf
								ON acf.accountid = c.crmid
								
								LEFT JOIN (SELECT contactsubscriptionid,
														CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
												FROM vtiger_contactsubdetails) cts
								ON cts.contactsubscriptionid = ctd.contactid
								
								LEFT JOIN vtiger_users2group ug1
								ON ug1.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g1
								ON g1.groupid = ug1.groupid
								
								LEFT JOIN vtiger_users2group ug2
								ON ug2.groupid = c.smownerid
							
								LEFT JOIN vtiger_groups g2
								ON g2.groupid = ug2.groupid
								
								LEFT JOIN (SELECT accountaddressid,
												CASE WHEN ship_city='''' OR ship_city IS NULL THEN ''Unknown'' ELSE ship_city END AS ''ship_city''
												FROM vtiger_accountshipads) ad
								ON ad.accountaddressid = c.crmid
								
								WHERE 1=1');
	
	
	SET myquery_2 = CONCAT('SELECT CAST(Year(c.modifiedtime) AS CHAR), COUNT(DISTINCT c.crmid)
								
								FROM (SELECT accountid,account_no,accountname,
												CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
												annualrevenue,employees,isconvertedfromlead
										FROM vtiger_account) a
								
								JOIN vtiger_crmentity c
								ON a.accountid = c.crmid
								
								LEFT JOIN vtiger_contactdetails ctd
								ON a.accountid = ctd.accountid
								
								JOIN (SELECT accountid, 
												CASE WHEN cf_773 = '''' THEN ''Không có'' ELSE cf_773 END AS ''user_marketing'',
												CASE WHEN cf_775 = '''' THEN ''Không có'' ELSE cf_775 END AS ''user_service'',
												CASE WHEN cf_891 = '''' THEN ''Unknown'' ELSE cf_891 END AS ''status''
										FROM vtiger_accountscf ) acf
								ON acf.accountid = c.crmid
								
								LEFT JOIN (SELECT contactsubscriptionid,
														CASE WHEN leadsource='''' OR leadsource IS NULL THEN ''Unknown'' ELSE leadsource END AS ''leadsource''
												FROM vtiger_contactsubdetails) cts
								ON cts.contactsubscriptionid = ctd.contactid
								
								LEFT JOIN vtiger_users2group ug1
								ON ug1.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g1
								ON g1.groupid = ug1.groupid
								
								LEFT JOIN vtiger_users2group ug2
								ON ug2.groupid = c.smownerid
							
								LEFT JOIN vtiger_groups g2
								ON g2.groupid = ug2.groupid
								
								LEFT JOIN (SELECT accountaddressid,
												CASE WHEN ship_city='''' OR ship_city IS NULL THEN ''Unknown'' ELSE ship_city END AS ''ship_city''
												FROM vtiger_accountshipads) ad
								ON ad.accountaddressid = c.crmid
								
								WHERE 1=1');						
								
	
	SET myquery_1 = CONCAT(myquery_1,' AND c.deleted = ''0''');
	SET myquery_2 = CONCAT(myquery_2,' AND c.deleted = ''0''');	
	
	/*Chọn theo khoảng thời gian*/
	IF (start_date IS NOT NULL AND end_date IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
		SET myquery_2 = CONCAT(myquery_2,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;
	
	/*Chọn theo nguồn*/
	IF (leadsource IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND cts.leadsource = ''',leadsource,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND cts.leadsource = ''',leadsource,'''');
	END IF;
	
	/*Chọn theo lĩnh vực*/
	IF (industry IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND a.industry = ''',industry,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND a.industry = ''',industry,'''');
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND a.accountid = ''',account_id,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND a.accountid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.smownerid = ''',user_assign,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo user marketing*/
	IF(user_marketing IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND acf.user_marketing = ''',user_marketing,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND acf.user_marketing = ''',user_marketing,'''');
	END IF;	

	/*Chọn theo user giới thiệu*/
	IF(user_service IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND acf.user_service = ''',user_service,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND acf.user_service = ''',user_service,'''');
	END IF;
	
	/*Chọn theo bộ phận*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND ( g1.groupid = ''',dept_id,''' OR g2.groupid = ''',dept_id,''')');
		SET myquery_2 = CONCAT(myquery_2,' AND ( g1.groupid = ''',dept_id,''' OR g2.groupid = ''',dept_id,''')');
	END IF;
	
	/*Lọc theo col,val*/
	
	IF (col IS NOT NULL) AND (col = 'NV_assign') THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.smownerid = ''', val,''' ');
		SET myquery_2 = CONCAT(myquery_2,' AND c.smownerid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.crmid = ''', val,''' ');
		SET myquery_2 = CONCAT(myquery_2,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'NV_assign' AND col != 'c.label')  THEN
		SET myquery_1 = CONCAT(myquery_1,' AND ',col, ' = ''', val,''' ');
		SET myquery_2 = CONCAT(myquery_2,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	
	SET myquery_1 = CONCAT (myquery_1,' GROUP BY 1 ORDER BY 1');
	SET myquery_2 = CONCAT (myquery_2,' GROUP BY 1 ORDER BY 1');
	
	
	IF (timetype = 0 OR timetype IS NULL) THEN
		SELECT myquery_1;
		SET @SQL := myquery_1;
	 	PREPARE my_query1 FROM @SQL;
		EXECUTE my_query1;
	ELSEIF (timetype = 1 OR timetype IS NULL) THEN
		SELECT myquery_2;
		SET @SQL := myquery_2;
	 	PREPARE my_query2 FROM @SQL;
		EXECUTE my_query2;
	END IF;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_lead_all
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_lead_all`(
	IN `id_proc` VARCHAR(35),
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `start_revenue` DOUBLE,
	IN `end_revenue` DOUBLE,
	IN `start_emp` INT,
	IN `end_emp` INT,
	IN `user_assign_id` INT,
	IN `status` VARCHAR(50),
	IN `source` VARCHAR(50),
	IN `lead` VARCHAR(100),
	IN `dept` INT,
	IN `city` VARCHAR(50),
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300),
	IN `year_` ENUM('Y','N'),
	IN `month_` ENUM('Y','N'),
	IN `quarter_` ENUM('Y','N'),
	IN `day_` ENUM('Y','N')


)
BEGIN

	IF id_proc = 'total_lead' THEN
		CALL `dsa_lead_total_lead` (date_type,start_date, end_date, user_assign_id, status, SOURCE, lead, dept, city, col, val);
	END IF;
	
	IF id_proc = 'total_lead' THEN
		CALL `dsa_lead_total_lead` (date_type,start_date, end_date, user_assign_id, status, SOURCE, lead, dept, city, col, val);
	END IF;
	
	IF id_proc = 'total_industry' THEN
		CALL `dsa_lead_total_industry` (date_type,start_date, end_date, user_assign_id, status, source, lead, dept, city, col, val);
	END IF;
	
	IF id_proc = 'total_city' THEN
		CALL `dsa_lead_total_city` (date_type,start_date, end_date, user_assign_id, status, source, lead, dept, city, col, val);
	END IF;
	
	IF id_proc = 'num_lead_bystatus' THEN
		CALL `dsa_lead_num_lead_bystatus` (date_type,start_date, end_date, user_assign_id, status, source, lead, dept, city, col, val);
	END IF;
	
	IF id_proc = 'num_lead_byuser' THEN
		CALL `dsa_lead_num_lead_byuser` (date_type,start_date, end_date, user_assign_id, status, source, lead, dept, city, col, val);
	END IF;
	
	IF id_proc = 'num_lead_bysource_status' THEN
		CALL `dsa_lead_num_lead_bysource_status` (date_type,start_date, end_date, user_assign_id, status, source, lead, dept, city, col, val);
	END IF;
	
	IF id_proc = 'num_lead_bysource' THEN
		CALL `dsa_lead_num_lead_bysource` (date_type,start_date, end_date, user_assign_id, status, source, lead, dept, city, col, val);
	END IF;
	
	IF id_proc = 'lead_detail' THEN
		CALL `dsa_lead_detail` (date_type,start_date, end_date, start_revenue, end_revenue, start_emp, end_emp, user_assign_id, status, source, lead, dept, city, col, val);
	END IF;
	
	IF id_proc = 'comment_detail' THEN
		CALL `dsa_lead_comment_detail` (date_type,start_date, end_date, user_assign_id, status, source, lead, dept, city, col, val);
	END IF;

	IF id_proc = 'num_lead_byindustry' THEN
		CALL `dsa_lead_num_lead_byindustry` (date_type,start_date, end_date, user_assign_id, status, source, lead, dept, city, col, val);
	END IF;	

	IF id_proc = 'num_lead_bycity' THEN
		CALL `dsa_lead_num_lead_bycity` (date_type,start_date, end_date, user_assign_id, status, source, lead, dept, city, col, val);
	END IF;	
	
	IF id_proc = 'num_lead_bytime' THEN
		CALL `dsa_lead_num_lead_bytime` (date_type,start_date, end_date, user_assign_id, status, source, lead, dept, city, col, val, year_, month_,quarter_, day_);
	END IF;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_lead_comment_detail
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_lead_comment_detail`(
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `user_assign_id` INT,
	IN `status` VARCHAR(50),
	IN `source` VARCHAR(50),
	IN `lead` VARCHAR(100),
	IN `dept` INT,
	IN `city` VARCHAR(50),
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300)


)
BEGIN
	DECLARE QUERY NVARCHAR(4000);
	DECLARE QUERY1 NVARCHAR(4000);
	DECLARE QUERY2 NVARCHAR(4000);
	
	SET QUERY1 = 
	'(SELECT  
		CONCAT(''['',ld.company, '' ('',ld.lead_no, '')'', '']'',''(http://crm.fastdn.com.vn/index.php?module=Leads&relatedModule=ModComments&view=Detail&record='',ld.leadid,''&mode=showRelatedList&relationId=156&tab_label=ModComments&app=MARKETING)'')  as ''company'',
		m.modcommentsid id,
		CONCAT(u.last_name, '' '', u.first_name) name,
		m.commentcontent content,
		c.createdtime time
	FROM 
		((((vtiger_modcomments m
	INNER JOIN
		vtiger_leaddetails ld
	ON
		ld.leadid = m.related_to)
	INNER JOIN
		vtiger_crmentity c
	ON
		c.crmid = m.modcommentsid)
	LEFT JOIN
		vtiger_users u
	ON
		u.id = m.userid)
	LEFT JOIN
		vtiger_leadaddress la
	ON
		la.leadaddressid = ld.leadid)
	WHERE 
		m.parent_comments = 0 AND c.deleted = 0 AND 1=1 ';

	SET QUERY2 = 
	'(
	SELECT
	   CONCAT(''['',ld.company, '' ('',ld.lead_no, '')'', '']'',''(http://uatcrm.fastdn.com.vn/index.php?module=Leads&relatedModule=ModComments&view=Detail&record='',ld.leadid,''&mode=showRelatedList&relationId=156&tab_label=ModComments&app=MARKETING)'')  as ''company'',
		m.parent_comments id,
		CONCAT(u.last_name, '' '', u.first_name) name,
		m.commentcontent content,
		c.createdtime time
	FROM
		((((vtiger_modcomments m
	INNER JOIN
		vtiger_leaddetails ld
	ON
		ld.leadid = m.related_to)
	LEFT JOIN
		vtiger_users u
	ON
		u.id = m.userid)
	INNER JOIN
		vtiger_crmentity c
	ON
		c.crmid = m.modcommentsid)
	LEFT JOIN
		vtiger_leadaddress la
	ON
		la.leadaddressid = ld.leadid)
	WHERE
		m.parent_comments <> 0 AND c.deleted = 0';
   
   CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY2 = CONCAT(QUERY2,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
				SET QUERY2 = CONCAT(QUERY2,' ');
			END IF;
			
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY2 = CONCAT(QUERY1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
				SET QUERY2 = CONCAT(QUERY2,' ');
			END IF;
			
	END CASE;
	
	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = ', user_assign_id ,' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (c.smownerid = ', user_assign_id ,' )');
	END IF;

	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.leadstatus = \'', status ,'\' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (ld.leadstatus = \'', status ,'\' )');
	END IF;
	
	IF source IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.leadsource = \'', source ,'\' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (ld.leadsource = \'', source ,'\' )');
	END IF;
	
	IF lead IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.company = \'', lead ,'\' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (ld.company = \'', lead ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', dept ,'\' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (c.smownerid = \'', dept ,'\' )');
	END IF;

	IF city IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (la.city = \'', city ,'\' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (la.city = \'', city ,'\' )');
	END IF;

	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
		SET QUERY2 = CONCAT(QUERY2,' AND (', col, ' = N\'', val ,'\')');
	END IF;
	
	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
		SET QUERY2 = CONCAT(QUERY2,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'la.city' OR col = 'ld.industry' OR col = 'ld.leadstatus' OR col = 'ld.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
		SET QUERY1 = CONCAT(QUERY2,' AND (',col,' = '''' )');
	END IF;

	SET QUERY1 = CONCAT(QUERY1,')');
	SET QUERY2 = CONCAT(QUERY2,')');

	SET QUERY = CONCAT('
	SELECT 
		t1.company,
		CONCAT(t1.name,'': '',t1.content) comment,
		GROUP_CONCAT(t2.name, '': '', t2.content SEPARATOR ''\n'') answer
	FROM ', QUERY1, 'as t1 LEFT JOIN ', QUERY2,' as t2 ON t1.id = t2.id GROUP BY 1, 2 ORDER BY t1.time, t2.time');
	
	-- In và khởi chạy query
	SELECT QUERY;
	-- SELECT QUERYZ;
	SET @SQL := QUERY;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_lead_ddl_all
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_lead_ddl_all`(
	IN `id_ddl` VARCHAR(50)
)
BEGIN
	IF id_ddl = 'ddl_lead_company' THEN
		CALL `dsa_lead_ddl_company`;
	END IF;
	
	IF id_ddl = 'ddl_lead_dept' THEN
		CALL `dsa_lead_ddl_dept`;
	END IF;
	
	IF id_ddl = 'ddl_lead_source' THEN
		CALL `dsa_lead_ddl_source`;
	END IF;
	
	IF id_ddl = 'ddl_lead_status' THEN
		CALL `dsa_lead_ddl_status`;
	END IF;
	
	IF id_ddl = 'ddl_lead_assign' THEN
		CALL `dsa_lead_ddl_user_assign`;
	END IF;
	
	IF id_ddl = 'ddl_lead_city' THEN
		CALL `dsa_lead_ddl_city`;
	END IF;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_lead_ddl_city
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_lead_ddl_city`()
BEGIN

	SELECT
		DISTINCT la.city
	FROM
		((vtiger_leaddetails ld
	INNER JOIN
		vtiger_crmentity c
	ON
		c.crmid = ld.leadid)
	LEFT JOIN
		vtiger_leadaddress la
	ON
		la.leadaddressid = ld.leadid)
	WHERE
		c.deleted = '0';
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_lead_ddl_company
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_lead_ddl_company`()
BEGIN

	SELECT
		ld.company
	FROM
		vtiger_leaddetails ld
	INNER JOIN
		vtiger_crmentity c
	ON
		c.crmid = ld.leadid
	WHERE
		c.deleted = '0';
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_lead_ddl_dept
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_lead_ddl_dept`()
BEGIN
	SELECT
		g.groupid,
		CONCAT(g.groupname,' (', g.groupid,')')
	FROM
		vtiger_groups g;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_lead_ddl_source
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_lead_ddl_source`()
BEGIN

	SELECT
		ls.leadsource
	FROM
		vtiger_leadsource ls;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_lead_ddl_status
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_lead_ddl_status`()
BEGIN
	SELECT
		ls.leadstatus
	FROM
		vtiger_leadstatus ls;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_lead_ddl_user_assign
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_lead_ddl_user_assign`()
BEGIN
	SELECT
		u.id,
		CONCAT(u.last_name,' ', u.first_name, ' (', u.user_name, ')') 'u.name'
	FROM
		vtiger_users u
	WHERE
		u.deleted = '0';
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_lead_detail
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_lead_detail`(
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `start_revenue` DOUBLE,
	IN `end_revenue` DOUBLE,
	IN `start_emp` INT,
	IN `end_emp` INT,
	IN `user_assign_id` INT,
	IN `status` VARCHAR(50),
	IN `source` VARCHAR(50),
	IN `lead` VARCHAR(100),
	IN `dept` INT,
	IN `city` VARCHAR(50),
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300)
)
BEGIN

	DECLARE QUERY1 NVARCHAR(4000);
	
   CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			SET QUERY1 = 
				'SELECT
					CONCAT(''['',ld.company, '' ('',ld.lead_no, '')'', '']'',''(http://crm.fastdn.com.vn/index.php?module=Leads&view=Detail&record='',ld.leadid,''&app=MARKETING)'')  as ''ld.company'',
					CONCAT(ld.lastname, ld.firstname) ''ld.name'',
					u.user_name ''u.user_name'',
					ld.leadsource ''ld.leadsource'',
					ld.leadstatus ''ld.leadstatus'',
					ld.noofemployees ''ld.noofemployees'',
					ld.annualrevenue ''ld.annualrevenue'',
					ld.industry ''ld.industry'',
					la.city ''la.city'',
					c.createdtime ''c.createdtime''
					
				FROM
					((((vtiger_leaddetails ld
				INNER JOIN
					vtiger_crmentity c
				ON
					c.crmid = ld.leadid)
				LEFT JOIN
					vtiger_leadscf lcf
				ON
					ld.leadid = lcf.leadid)
				LEFT JOIN
					vtiger_leadaddress la
				ON
					la.leadaddressid = ld.leadid)
				LEFT JOIN
					vtiger_users u
				ON
					c.smownerid = u.id)
			   WHERE 
					c.deleted <> 1 AND 1=1 ';
			
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			SET QUERY1 = 
				'SELECT
					CONCAT(''['',ld.company, '' ('',ld.lead_no, '')'', '']'',''(http://crm.fastdn.com.vn/index.php?module=Leads&view=Detail&record='',ld.leadid,''&app=MARKETING)'')  as ''ld.company'',
					CONCAT(ld.lastname, ld.firstname) ''ld.name'',
					u.user_name ''u.user_name'',
					ld.leadsource ''ld.leadsource'',
					ld.leadstatus ''ld.leadstatus'',
					ld.noofemployees ''ld.noofemployees'',
					ld.annualrevenue ''ld.annualrevenue'',
					ld.industry ''ld.industry'',
					la.city ''la.city'',
					c.modifiedtime ''c.createdtime''
					
				FROM
					((((vtiger_leaddetails ld
				INNER JOIN
					vtiger_crmentity c
				ON
					c.crmid = ld.leadid)
				LEFT JOIN
					vtiger_leadscf lcf
				ON
					ld.leadid = lcf.leadid)
				LEFT JOIN
					vtiger_leadaddress la
				ON
					la.leadaddressid = ld.leadid)
				LEFT JOIN
					vtiger_users u
				ON
					c.smownerid = u.id)
			   WHERE 
					c.deleted <> 1 AND 1=1 ';
			
	END CASE;
	
   CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
			
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
			
	END CASE;
	
	-- Revenue
	IF start_revenue IS NOT NULL AND end_revenue IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.annualrevenue BETWEEN ',start_revenue,' AND ', end_revenue,' ) ' );
	END IF;
	
	-- Employees
	IF start_emp IS NOT NULL AND end_emp IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.noofemployees BETWEEN ',start_emp,' AND ', end_emp,' ) ' );
	END IF;

	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = ', user_assign_id ,' )');
	END IF;

	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.leadstatus = \'', status ,'\' )');
	END IF;
	
	IF source IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.leadsource = \'', source ,'\' )');
	END IF;
	
	IF lead IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.company = \'', lead ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', dept ,'\' )');
	END IF;

	IF city IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (la.city = \'', city ,'\' )');
	END IF;

	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
	END IF;
	
	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'la.city' OR col = 'ld.industry' OR col = 'ld.leadstatus' OR col = 'ld.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
	END IF;
	
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_lead_num_lead_bycity
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_lead_num_lead_bycity`(
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `user_assign_id` INT,
	IN `status` VARCHAR(50),
	IN `source` VARCHAR(50),
	IN `lead` VARCHAR(100),
	IN `dept` INT,
	IN `city` VARCHAR(50),
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300)

)
BEGIN

	DECLARE QUERY1 NVARCHAR(4000);

	
	SET QUERY1 = 
	'
	SELECT
		CASE 
			WHEN la.city = '''' THEN ''Không xác định''
			ELSE la.city
		END ''la.city'',
		
		COUNT(ld.leadid) as num
	FROM
		((((vtiger_leaddetails ld
	INNER JOIN
		vtiger_crmentity c
	ON
		c.crmid = ld.leadid)
	INNER JOIN
		vtiger_leadaddress la
	ON
		la.leadaddressid = ld.leadid)
	LEFT JOIN
		vtiger_leadscf lcf
	ON
		lcf.leadid = ld.leadid)
	LEFT JOIN
		vtiger_users u
	ON
		c.smownerid = u.id)
   WHERE 
		c.deleted <> 1 AND 1=1 ';
   
   CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
			
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
			
	END CASE;
	
	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = ', user_assign_id ,' )');
	END IF;
	
	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.leadstatus = \'', status ,'\' )');
	END IF;
	
	IF source IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.leadsource = \'', source ,'\' )');
	END IF;
	
	IF lead IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.company = \'', lead ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', dept ,'\' )');
	END IF;

	IF city IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (la.city = \'', city ,'\' )');
	END IF;

	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
	END IF;
	
	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'la.city' OR col = 'ld.industry' OR col = 'ld.leadstatus' OR col = 'ld.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
	END IF;
	
	SET QUERY1 = CONCAT(QUERY1, 'GROUP BY la.city ORDER BY la.city DESC');
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_lead_num_lead_byindustry
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_lead_num_lead_byindustry`(
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `user_assign_id` INT,
	IN `status` VARCHAR(50),
	IN `source` VARCHAR(50),
	IN `lead` VARCHAR(100),
	IN `dept` INT,
	IN `city` VARCHAR(50),
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300)
)
BEGIN

	DECLARE QUERY1 NVARCHAR(4000);
	-- SET @ROW_NUMBER = 0; 
	-- (@row_number:=@row_number + 1) AS num1,
	
	SET QUERY1 = 
	'SELECT
		
		CASE 
			WHEN ld.industry = '''' THEN ''Không xác định''
			ELSE ld.industry
		END ''ld.industry'',
		
		COUNT(ld.leadid) as num
	FROM
		((((vtiger_leaddetails ld
	INNER JOIN
		vtiger_crmentity c
	ON
		c.crmid = ld.leadid)
	LEFT JOIN
		vtiger_leadscf lcf
	ON
		ld.leadid = lcf.leadid)
	LEFT JOIN
		vtiger_leadaddress la
	ON
		la.leadaddressid = ld.leadid)
	LEFT JOIN
		vtiger_users u
	ON
		c.smownerid = u.id)
   WHERE 
		c.deleted <> 1 AND 1=1 ';
   
   CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
			
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
			
	END CASE;
	
	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = ', user_assign_id ,' )');
	END IF;
	
	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.leadstatus = \'', status ,'\' )');
	END IF;
	
	IF source IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.leadsource = \'', source ,'\' )');
	END IF;
	
	IF lead IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.company = \'', lead ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', dept ,'\' )');
	END IF;

	IF city IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (la.city = \'', city ,'\' )');
	END IF;

	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
	END IF;
	
	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'la.city' OR col = 'ld.industry' OR col = 'ld.leadstatus' OR col = 'ld.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
	END IF;
	
	SET QUERY1 = CONCAT(QUERY1, 'GROUP BY ld.industry ORDER BY num DESC');
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_lead_num_lead_bysource
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_lead_num_lead_bysource`(
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `user_assign_id` INT,
	IN `status` VARCHAR(50),
	IN `source` VARCHAR(50),
	IN `lead` VARCHAR(100),
	IN `dept` INT,
	IN `city` VARCHAR(50),
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(50)
)
BEGIN

	DECLARE QUERY1 NVARCHAR(4000);
	
	SET QUERY1 = 
	'SELECT
		CASE 
			WHEN ld.leadsource = '''' THEN ''Không xác định''
			ELSE ld.leadsource
		END as ''ld.leadsource'',
	
		COUNT(ld.leadid) as num
	FROM
		((((vtiger_leaddetails ld
	INNER JOIN
		vtiger_crmentity c
	ON
		c.crmid = ld.leadid)
	LEFT JOIN
		vtiger_leadscf lcf
	ON
		ld.leadid = lcf.leadid)
	LEFT JOIN
		vtiger_leadaddress la
	ON
		la.leadaddressid = ld.leadid)
	LEFT JOIN
		vtiger_users u
	ON
		c.smownerid = u.id)
   WHERE 
		c.deleted <> 1 AND 1=1 ';
   
   CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
			
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
			
	END CASE;

	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = ', user_assign_id ,' )');
	END IF;
	
	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.leadstatus = \'', status ,'\' )');
	END IF;
	
	IF source IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.leadsource = \'', source ,'\' )');
	END IF;
	
	IF lead IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.company = \'', lead ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', dept ,'\' )');
	END IF;

	IF city IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (la.city = \'', city ,'\' )');
	END IF;
	
	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
	END IF;
	
	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'la.city' OR col = 'ld.industry' OR col = 'ld.leadstatus' OR col = 'ld.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
	END IF;
	
	SET QUERY1 = CONCAT(QUERY1, ' GROUP BY ld.leadsource ORDER BY 2 DESC');
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_lead_num_lead_bysource_status
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_lead_num_lead_bysource_status`(
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `user_assign_id` INT,
	IN `status` VARCHAR(50),
	IN `source` VARCHAR(50),
	IN `lead` VARCHAR(100),
	IN `dept` INT,
	IN `city` VARCHAR(50),
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300)
)
BEGIN

	DECLARE QUERY1 NVARCHAR(4000);
	
	SET QUERY1 = 
	'SELECT
		CASE 
			WHEN ld.leadsource = '''' THEN ''Không xác định''
			ELSE ld.leadsource
		END as ''ld.leadsource'',
		
		CASE 
			WHEN ld.leadstatus = '''' THEN ''Không xác định''
			ELSE ld.leadstatus
		END as ''ld.leadstatus'',
	
		COUNT(ld.leadid) as num
	FROM
		((((vtiger_leaddetails ld
	INNER JOIN
		vtiger_crmentity c
	ON
		c.crmid = ld.leadid)
	LEFT JOIN
		vtiger_leadscf lcf
	ON
		ld.leadid = lcf.leadid)
	LEFT JOIN
		vtiger_leadaddress la
	ON
		la.leadaddressid = ld.leadid)
	LEFT JOIN
		vtiger_users u
	ON
		c.smownerid = u.id)
   WHERE 
		c.deleted <> 1 AND 1=1 ';
   
   CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
			
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
			
	END CASE;

	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = ', user_assign_id ,' )');
	END IF;
	
	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.leadstatus = \'', status ,'\' )');
	END IF;
	
	IF source IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.leadsource = \'', source ,'\' )');
	END IF;
	
	IF lead IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.company = \'', lead ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', dept ,'\' )');
	END IF;

	IF city IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (la.city = \'', city ,'\' )');
	END IF;
	
	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
	END IF;
	
	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'la.city' OR col = 'ld.industry' OR col = 'ld.leadstatus' OR col = 'ld.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
	END IF;
	
	SET QUERY1 = CONCAT(QUERY1, ' GROUP BY ld.leadsource, ld.leadstatus ORDER BY 3 DESC');
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_lead_num_lead_bystatus
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_lead_num_lead_bystatus`(
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `user_assign_id` INT,
	IN `status` VARCHAR(50),
	IN `source` VARCHAR(50),
	IN `lead` VARCHAR(100),
	IN `dept` INT,
	IN `city` VARCHAR(50),
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300)
)
BEGIN

	DECLARE QUERY1 NVARCHAR(4000);
	
	SET QUERY1 = 
	'SELECT
		CASE 
			WHEN ld.leadstatus = '''' THEN ''Không xác định''
			ELSE ld.leadstatus
		END ''ld.leadstatus'',
		
		COUNT(ld.leadid) as num
	FROM
		((((vtiger_leaddetails ld
	INNER JOIN
		vtiger_crmentity c
	ON
		c.crmid = ld.leadid)
	LEFT JOIN
		vtiger_leadscf lcf
	ON
		ld.leadid = lcf.leadid)
	LEFT JOIN
		vtiger_leadaddress la
	ON
		la.leadaddressid = ld.leadid)
	LEFT JOIN
		vtiger_users u
	ON
		c.smownerid = u.id)
   WHERE 
		c.deleted <> 1 AND 1=1 ';
   
   CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
			
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
			
	END CASE;

	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = ', user_assign_id ,' )');
	END IF;

	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.leadstatus = \'', status ,'\' )');
	END IF;
	
	IF source IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.leadsource = \'', source ,'\' )');
	END IF;
	
	IF lead IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.company = \'', lead ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', dept ,'\' )');
	END IF;
	
	IF city IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (la.city = \'', city ,'\' )');
	END IF;
	
	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
	END IF;
	
	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'la.city' OR col = 'ld.industry' OR col = 'ld.leadstatus' OR col = 'ld.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
	END IF;
	
	SET QUERY1 = CONCAT(QUERY1, 'GROUP BY ld.leadstatus ORDER BY num DESC');
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_lead_num_lead_bytime
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_lead_num_lead_bytime`(
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `user_assign_id` INT,
	IN `status` VARCHAR(50),
	IN `source` VARCHAR(50),
	IN `lead` VARCHAR(100),
	IN `dept` INT,
	IN `city` VARCHAR(50),
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300),
	IN `year_` ENUM('Y','N'),
	IN `month_` ENUM('Y','N'),
	IN `quarter_` ENUM('Y','N'),
	IN `day_` ENUM('Y','N')


)
BEGIN
	DECLARE QUERY1 NVARCHAR(4000);
	DECLARE QUERY2 NVARCHAR(4000);
	DECLARE QUERY3 NVARCHAR(4000);
	DECLARE QUERY4 NVARCHAR(4000);
	
	CASE
	WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
		
		-- Đếm các task đã mở theo ngày
		SET QUERY1 = 
			'SELECT
				CONCAT(Year(c.createdtime), '' - Q'', Quarter(c.createdtime)) AS ''c.createdtime'',
				COUNT(ld.leadid) num
			FROM
				((((vtiger_leaddetails ld
			INNER JOIN
				vtiger_crmentity c
			ON
				c.crmid = ld.leadid)
			LEFT JOIN
				vtiger_leadscf lcf
			ON
				ld.leadid = lcf.leadid)
			LEFT JOIN
				vtiger_leadaddress la
			ON
				la.leadaddressid = ld.leadid)
			LEFT JOIN
				vtiger_users u
			ON
				c.smownerid = u.id)
		   WHERE 
				c.deleted <> 1 AND 1=1 ';
		
		SET QUERY2 = 
			'SELECT
				CAST(Year(c.createdtime) AS CHAR) AS ''c.createdtime'',
				COUNT(ld.leadid) num
			FROM
				((((vtiger_leaddetails ld
			INNER JOIN
				vtiger_crmentity c
			ON
				c.crmid = ld.leadid)
			LEFT JOIN
				vtiger_leadscf lcf
			ON
				ld.leadid = lcf.leadid)
			LEFT JOIN
				vtiger_leadaddress la
			ON
				la.leadaddressid = ld.leadid)
			LEFT JOIN
				vtiger_users u
			ON
				c.smownerid = u.id)
		   WHERE 
				c.deleted <> 1 AND 1=1 ';
		
		SET QUERY3 = 
			'SELECT
				CONCAT(Month(c.createdtime),''/'', Year(c.createdtime)) AS ''c.createdtime'',
				COUNT(ld.leadid) num
			FROM
				((((vtiger_leaddetails ld
			INNER JOIN
				vtiger_crmentity c
			ON
				c.crmid = ld.leadid)
			LEFT JOIN
				vtiger_leadscf lcf
			ON
				ld.leadid = lcf.leadid)
			LEFT JOIN
				vtiger_leadaddress la
			ON
				la.leadaddressid = ld.leadid)
			LEFT JOIN
				vtiger_users u
			ON
				c.smownerid = u.id)
		   WHERE 
				c.deleted <> 1 AND 1=1 ';
		
		SET QUERY4 = 
			'SELECT
				CONCAT(Day(c.createdtime),''/'',Month(c.createdtime),''/'', Year(c.createdtime)) AS ''c.createdtime'',
				COUNT(ld.leadid) num
			FROM
				((((vtiger_leaddetails ld
			INNER JOIN
				vtiger_crmentity c
			ON
				c.crmid = ld.leadid)
			LEFT JOIN
				vtiger_leadscf lcf
			ON
				ld.leadid = lcf.leadid)
			LEFT JOIN
				vtiger_leadaddress la
			ON
				la.leadaddressid = ld.leadid)
			LEFT JOIN
				vtiger_users u
			ON
				c.smownerid = u.id)
		   WHERE 
				c.deleted <> 1 AND 1=1 ';
				
	WHEN date_type = 'Ngày chính sửa' THEN
		-- Đếm các task đã mở theo ngày
		SET QUERY1 = 
			'SELECT
				CONCAT(Year(c.modifiedtime), '' - Q'', Quarter(c.modifiedtime)) AS ''c.modifiedtime'',
				COUNT(ld.leadid) num
			FROM
				((((vtiger_leaddetails ld
			INNER JOIN
				vtiger_crmentity c
			ON
				c.crmid = ld.leadid)
			LEFT JOIN
				vtiger_leadscf lcf
			ON
				ld.leadid = lcf.leadid)
			LEFT JOIN
				vtiger_leadaddress la
			ON
				la.leadaddressid = ld.leadid)
			LEFT JOIN
				vtiger_users u
			ON
				c.smownerid = u.id)
		   WHERE 
				c.deleted <> 1 AND 1=1 ';
		
		SET QUERY2 = 
			'SELECT
				CAST(Year(c.modifiedtime) AS CHAR) AS ''c.modifiedtime'',
				COUNT(ld.leadid) num
			FROM
				((((vtiger_leaddetails ld
			INNER JOIN
				vtiger_crmentity c
			ON
				c.crmid = ld.leadid)
			LEFT JOIN
				vtiger_leadscf lcf
			ON
				ld.leadid = lcf.leadid)
			LEFT JOIN
				vtiger_leadaddress la
			ON
				la.leadaddressid = ld.leadid)
			LEFT JOIN
				vtiger_users u
			ON
				c.smownerid = u.id)
		   WHERE 
				c.deleted <> 1 AND 1=1 ';
		
		SET QUERY3 = 
			'SELECT
				CONCAT(Month(c.modifiedtime),''/'', Year(c.modifiedtime)) AS ''c.modifiedtime'',
				COUNT(ld.leadid) num
			FROM
				((((vtiger_leaddetails ld
			INNER JOIN
				vtiger_crmentity c
			ON
				c.crmid = ld.leadid)
			LEFT JOIN
				vtiger_leadscf lcf
			ON
				ld.leadid = lcf.leadid)
			LEFT JOIN
				vtiger_leadaddress la
			ON
				la.leadaddressid = ld.leadid)
			LEFT JOIN
				vtiger_users u
			ON
				c.smownerid = u.id)
		   WHERE 
				c.deleted <> 1 AND 1=1 ';
		
		SET QUERY4 = 
			'SELECT
				CONCAT(Day(c.modifiedtime),''/'',Month(c.modifiedtime),''/'', Year(c.modifiedtime)) AS ''c.modifiedtime'',
				COUNT(ld.leadid) num
			FROM
				((((vtiger_leaddetails ld
			INNER JOIN
				vtiger_crmentity c
			ON
				c.crmid = ld.leadid)
			LEFT JOIN
				vtiger_leadscf lcf
			ON
				ld.leadid = lcf.leadid)
			LEFT JOIN
				vtiger_leadaddress la
			ON
				la.leadaddressid = ld.leadid)
			LEFT JOIN
				vtiger_users u
			ON
				c.smownerid = u.id)
		   WHERE 
				c.deleted <> 1 AND 1=1 ';
	END CASE;

	-- Lọc các task có thời gian hoàn thành nằm trong khoảng đã cho
	CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY2 = CONCAT(QUERY2,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY3 = CONCAT(QUERY3,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY4 = CONCAT(QUERY4,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
				SET QUERY2 = CONCAT(QUERY2,' ');
				SET QUERY3 = CONCAT(QUERY3,' ');
				SET QUERY4 = CONCAT(QUERY4,' ');
			END IF;
			
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY2 = CONCAT(QUERY2,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY3 = CONCAT(QUERY3,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY4 = CONCAT(QUERY4,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
				SET QUERY2 = CONCAT(QUERY2,' ');
				SET QUERY3 = CONCAT(QUERY3,' ');
				SET QUERY4 = CONCAT(QUERY4,' ');
			END IF;
			
	END CASE;
	
	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = ', user_assign_id ,' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (c.smownerid = ', user_assign_id ,' )');
		SET QUERY3 = CONCAT(QUERY3,' AND (c.smownerid = ', user_assign_id ,' )');
		SET QUERY4 = CONCAT(QUERY4,' AND (c.smownerid = ', user_assign_id ,' )');
		
	END IF;

	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.leadstatus = \'', status ,'\' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (ld.leadstatus = \'', status ,'\' )');
		SET QUERY3 = CONCAT(QUERY3,' AND (ld.leadstatus = \'', status ,'\' )');
		SET QUERY4 = CONCAT(QUERY4,' AND (ld.leadstatus = \'', status ,'\' )');
	END IF;
	
	IF source IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.leadsource = \'', source ,'\' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (ld.leadsource = \'', source ,'\' )');
		SET QUERY3 = CONCAT(QUERY3,' AND (ld.leadsource = \'', source ,'\' )');
		SET QUERY4 = CONCAT(QUERY4,' AND (ld.leadsource = \'', source ,'\' )');
	END IF;
	
	IF lead IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.company = \'', lead ,'\' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (ld.company = \'', lead ,'\' )');
		SET QUERY3 = CONCAT(QUERY3,' AND (ld.company = \'', lead ,'\' )');
		SET QUERY4 = CONCAT(QUERY4,' AND (ld.company = \'', lead ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', dept ,'\' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (c.smownerid = \'', dept ,'\' )');
		SET QUERY3 = CONCAT(QUERY3,' AND (c.smownerid = \'', dept ,'\' )');
		SET QUERY4 = CONCAT(QUERY4,' AND (c.smownerid = \'', dept ,'\' )');
	END IF;

	IF city IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (la.city = \'', city ,'\' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (la.city = \'', city ,'\' )');
		SET QUERY3 = CONCAT(QUERY3,' AND (la.city = \'', city ,'\' )');
		SET QUERY4 = CONCAT(QUERY4,' AND (la.city = \'', city ,'\' )');
	END IF;

	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
		SET QUERY2 = CONCAT(QUERY2,' AND (', col, ' = N\'', val ,'\')');
		SET QUERY3 = CONCAT(QUERY3,' AND (', col, ' = N\'', val ,'\')');
		SET QUERY4 = CONCAT(QUERY4,' AND (', col, ' = N\'', val ,'\')');
	END IF;
	
	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
		SET QUERY2 = CONCAT(QUERY2,' AND (u.user_name IS NULL)');
		SET QUERY3 = CONCAT(QUERY3,' AND (u.user_name IS NULL)');
		SET QUERY4 = CONCAT(QUERY4,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'la.city' OR col = 'ld.industry' OR col = 'ld.leadstatus' OR col = 'ld.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (',col,' = '''' )');
		SET QUERY3 = CONCAT(QUERY3,' AND (',col,' = '''' )');
		SET QUERY4 = CONCAT(QUERY4,' AND (',col,' = '''' )');
	END IF;
	
	-- Gộp theo ngày và sắp xếp theo ngày từ h về trước
	-- SET QUERY1 = CONCAT(QUERY1,'GROUP BY 1 ORDER BY 1');
	SET QUERY2 = CONCAT(QUERY2,'GROUP BY 1 ORDER BY 1');
	
	CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			SET QUERY1 = CONCAT(QUERY1,'GROUP BY 1 ORDER BY Year(c.createdtime), Quarter(c.createdtime)');
			SET QUERY3 = CONCAT(QUERY3,'GROUP BY 1 ORDER BY Year(c.createdtime), Month(c.createdtime)');
			SET QUERY4 = CONCAT(QUERY4,'GROUP BY 1 ORDER BY Year(c.createdtime), Month(c.createdtime), Day(c.createdtime)');
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			SET QUERY1 = CONCAT(QUERY1,'GROUP BY 1 ORDER BY Year(c.modifiedtime), Quarter(c.modifiedtime)');
			SET QUERY3 = CONCAT(QUERY3,'GROUP BY 1 ORDER BY Year(c.modifiedtime), Month(c.modifiedtime)');
			SET QUERY4 = CONCAT(QUERY4,'GROUP BY 1 ORDER BY Year(c.modifiedtime), Month(c.modifiedtime), Day(c.modifiedtime)');
	END CASE;
	
	IF day_ IS NOT NULL OR (day_ IS NULL AND month_ IS NULL AND quarter_ IS NULL AND year_ IS NULL) THEN
		-- In và khởi chạy query
		-- SELECT QUERY4;
		SET @SQL := QUERY4;
		PREPARE stmt4 FROM @SQL;
		EXECUTE stmt4;
		DEALLOCATE PREPARE stmt4;
	END IF;
	
	IF month_ IS NOT NULL THEN
		-- In và khởi chạy query
		 SELECT QUERY3;
		SET @SQL := QUERY3;
		PREPARE stmt3 FROM @SQL;
		EXECUTE stmt3;
		DEALLOCATE PREPARE stmt3;
	END IF;
	
	IF quarter_ IS NOT NULL THEN
		-- In và khởi chạy query
		-- SELECT QUERY1;
		SET @SQL := QUERY1;
		PREPARE stmt FROM @SQL;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
	END IF;	
	
	IF year_ IS NOT NULL THEN
		-- In và khởi chạy query
		-- SELECT QUERY2;
		SET @SQL := QUERY2;
		PREPARE stmt2 FROM @SQL;
		EXECUTE stmt2;
		DEALLOCATE PREPARE stmt2;
	END IF;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_lead_num_lead_byuser
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_lead_num_lead_byuser`(
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `user_assign_id` INT,
	IN `status` VARCHAR(50),
	IN `source` VARCHAR(50),
	IN `lead` VARCHAR(100),
	IN `dept` INT,
	IN `city` VARCHAR(50),
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300)
)
BEGIN

	DECLARE QUERY1 NVARCHAR(4000);
	
	SET QUERY1 = 
	'SELECT
		CASE 
			WHEN u.user_name IS NULL THEN ''Không xác định''
			ELSE u.user_name
		END ''u.user_name'',
		
		COUNT(ld.leadid) as num
	FROM
		((((vtiger_leaddetails ld
	INNER JOIN
		vtiger_crmentity c
	ON
		c.crmid = ld.leadid)
	LEFT JOIN
		vtiger_leadscf lcf
	ON
		ld.leadid = lcf.leadid)
	LEFT JOIN
		vtiger_leadaddress la
	ON
		la.leadaddressid = ld.leadid)
	LEFT JOIN
		vtiger_users u
	ON
		c.smownerid = u.id)
   WHERE 
		c.deleted <> 1 AND 1=1 ';
   
   CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
			
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
			
	END CASE;

	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = ', user_assign_id ,' )');
	END IF;

	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.leadstatus = \'', status ,'\' )');
	END IF;
	
	IF source IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.leadsource = \'', source ,'\' )');
	END IF;
	
	IF lead IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.company = \'', lead ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', dept ,'\' )');
	END IF;
	
	IF city IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (la.city = \'', city ,'\' )');
	END IF;
	
	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
	END IF;
	
	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'la.city' OR col = 'ld.industry' OR col = 'ld.leadstatus' OR col = 'ld.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
	END IF;
	
	SET QUERY1 = CONCAT(QUERY1, 'GROUP BY 1 ORDER BY 2 DESC');
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_lead_total_city
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_lead_total_city`(
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `user_assign_id` INT,
	IN `status` VARCHAR(50),
	IN `source` VARCHAR(50),
	IN `lead` VARCHAR(100),
	IN `dept` INT,
	IN `city` VARCHAR(50),
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300)
)
BEGIN
	
	DECLARE QUERY1 NVARCHAR(4000);
	
	SET QUERY1 = 
	'SELECT
		COUNT(DISTINCT la.city) as total_city
	FROM
		((((vtiger_leaddetails ld
	INNER JOIN
		vtiger_crmentity c
	ON
		c.crmid = ld.leadid)
	LEFT JOIN
		vtiger_leadscf lcf
	ON
		ld.leadid = lcf.leadid)
	LEFT JOIN
		vtiger_leadaddress la
	ON
		la.leadaddressid = ld.leadid)
	LEFT JOIN
		vtiger_users u
	ON
		c.smownerid = u.id)
   WHERE 
		c.deleted <> 1 AND 1=1 AND la.city <> ''''';
   
   CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
			
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
			
	END CASE;
	
	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', user_assign_id ,'\' )');
	END IF;
	
	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.leadstatus = \'', status ,'\' )');
	END IF;
	
	IF source IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.leadsource = \'', source ,'\' )');
	END IF;
	
	IF lead IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.company = \'', lead ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', dept ,'\' )');
	END IF;
	
	IF city IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (la.city = \'', city ,'\' )');
	END IF;
	
	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
	END IF;
	
	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'la.city' OR col = 'ld.industry' OR col = 'ld.leadstatus' OR col = 'ld.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
	END IF;
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_lead_total_industry
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_lead_total_industry`(
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `user_assign_id` INT,
	IN `status` VARCHAR(50),
	IN `source` VARCHAR(50),
	IN `lead` VARCHAR(100),
	IN `dept` INT,
	IN `city` VARCHAR(50),
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300)
)
BEGIN

	DECLARE QUERY1 NVARCHAR(4000);
	
	SET QUERY1 = 
	'SELECT
		COUNT(DISTINCT ld.industry) as total_industry
	FROM
		((((vtiger_leaddetails ld
	INNER JOIN
		vtiger_crmentity c
	ON
		c.crmid = ld.leadid)
	LEFT JOIN
		vtiger_leadscf lcf
	ON
		ld.leadid = lcf.leadid)
	LEFT JOIN
		vtiger_leadaddress la
	ON
		la.leadaddressid = ld.leadid)
	LEFT JOIN
		vtiger_users u
	ON
		c.smownerid = u.id)
   WHERE 
		c.deleted <> 1 AND ld.industry <> '''' AND 1=1 ';
   
   CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
			
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
			
	END CASE;
	
	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = ', user_assign_id ,' )');
	END IF;
	
	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.leadstatus = \'', status ,'\' )');
	END IF;
	
	IF source IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.leadsource = \'', source ,'\' )');
	END IF;
	
	IF lead IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.company = \'', lead ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', dept ,'\' )');
	END IF;
	
	IF city IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (la.city = \'', city ,'\' )');
	END IF;
	
	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
	END IF;
	
	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'la.city' OR col = 'ld.industry' OR col = 'ld.leadstatus' OR col = 'ld.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
	END IF;
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_lead_total_lead
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_lead_total_lead`(
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `user_assign_id` INT,
	IN `status` VARCHAR(50),
	IN `source` VARCHAR(50),
	IN `lead` VARCHAR(100),
	IN `dept` INT,
	IN `city` VARCHAR(50),
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300)
)
BEGIN
	
	DECLARE QUERY1 NVARCHAR(4000);
	
	SET QUERY1 = 
		'SELECT
			COUNT(ld.leadid) as total_lead
		FROM
			((((vtiger_leaddetails ld
		INNER JOIN
			vtiger_crmentity c
		ON
			c.crmid = ld.leadid)
		LEFT JOIN
			vtiger_leadscf lcf
		ON
			ld.leadid = lcf.leadid)
		LEFT JOIN
			vtiger_leadaddress la
		ON
			la.leadaddressid = ld.leadid)
		LEFT JOIN
			vtiger_users u
		ON
			c.smownerid = u.id)
	   WHERE 
			c.deleted <> 1 AND 1=1 ';
		
   CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
			
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
			
	END CASE;
	
	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', user_assign_id ,'\' )');
	END IF;
	
	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.leadstatus = \'', status ,'\' )');
	END IF;
	
	IF source IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.leadsource = \'', source ,'\' )');
	END IF;
	
	IF lead IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (ld.company = \'', lead ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', dept ,'\' )');
	END IF;
	
	IF city IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (la.city = \'', city ,'\' )');
	END IF;
	
	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
	END IF;
	
	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'la.city' OR col = 'ld.industry' OR col = 'ld.leadstatus' OR col = 'ld.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
	END IF;
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_potential_activity_detail
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_potential_activity_detail`(
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `user_assign_id` INT,
	IN `user_service` VARCHAR(50),
	IN `user_mkt` VARCHAR(50),
	IN `status` VARCHAR(50),
	IN `sales_stage` VARCHAR(50),
	IN `potential` VARCHAR(100),
	IN `dept` INT,
	IN `product` INT,
	IN `start_day_type` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300)





)
BEGIN
	
	DECLARE QUERY1 NVARCHAR(4000);
	
	SET QUERY1 = 
	'SELECT
		CONCAT(''['',a.subject, '' ('',a.activityid, '')'', '']'',''(http://uatcrm.fastdn.com.vn/index.php?module=Calendar&view=Detail&record='',p.potentialid,''&&mode=showDetailViewByMode&requestMode=full&tab_label=Sự%20kiện%20Chi%20tiết&app=MARKETING)'') ''a.subject'',
		a.activitytype,
		CASE 
			WHEN u.user_name IS NULL THEN ''Không xác định''
			WHEN u.user_name = '''' THEN ''Trống''
			ELSE u.user_name
		END ''u.user_name'', 
		a.date_start,
		LEFT(a.time_start, 5) ''time_start'',
		a.due_date,
		LEFT(a.time_end, 5) ''time_end'',
		CASE 
			WHEN a.status=''In Progress'' THEN ''Đang xử lý''
			WHEN a.status=''Completed'' OR a.status=''Hoàn thành'' THEN ''Đã hoàn thành''
			WHEN a.status=''Pending Input'' THEN ''Đang chờ xử lý''
			WHEN a.status=''Deferred'' THEN ''Trì hoãn''
			WHEN a.status=''Planned'' THEN ''Đã lên kế hoạch''
			WHEN a.eventstatus=''Planned''THEN ''Lên kế hoạch''
			WHEN a.eventstatus=''Held'' OR a.eventstatus=''Đã tổ chức'' THEN ''Đã tổ chức''
			WHEN a.eventstatus=''Not Held'' THEN ''Không tổ chức''
			ELSE ''Không xác định'' END AS ''a.status''
		FROM
			(((((((vtiger_potential p
		INNER JOIN
			vtiger_crmentity c
		ON
			c.crmid = p.potentialid)
		LEFT JOIN
			vtiger_potentialscf pcf
		ON
			p.potentialid = pcf.potentialid)
		LEFT JOIN
			vtiger_users u
		ON
			c.smownerid = u.id)
		LEFT JOIN
			vtiger_seproductsrel pse
		ON
			pse.crmid = c.crmid)
		LEFT JOIN
			vtiger_products pr
		ON
			pr.productid = pse.productid)
		INNER JOIN
			vtiger_seactivityrel s
		ON
			s.crmid = c.crmid)
		INNER JOIN
			vtiger_activity a
		ON
			a.activityid = s.activityid)
		WHERE 
			c.deleted <> 1 AND a.due_date <> ''4031-02-23 00:00:00'' AND 1=1';
	
   CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (a.date_start BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
		
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (a.date_start BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
		
		WHEN date_type = 'Ngày đóng' THEN 
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (a.date_start BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )');
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
	END CASE;
	
	CASE
		WHEN start_day_type = 0 OR start_day_type IS NULL THEN
			SET QUERY1 = CONCAT(QUERY1,' ');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (a.date_start = CURDATE() )');
	END CASE;
	
	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', user_assign_id ,'\' )');
	END IF;
	
	IF user_service IS NOT NULL THEN 
		IF user_service = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = \'', user_service ,'\' )');
		END IF;
	END IF;
	
	IF user_mkt IS NOT NULL THEN 
		IF user_mkt = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
		END IF;
	END IF;
	
	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_987 = \'', status ,'\' )');
	END IF;
	
	IF sales_stage IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.sales_stage = \'', sales_stage ,'\' )');
	END IF;
	
	IF potential IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.potentialname = \'', potential ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = ', dept ,' )');
	END IF;
	
	IF product IS NOT NULL THEN 
		IF product = 0 THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid IS NULL )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid = ', product ,' )');
		END IF;
	END IF;
	
	-- col, val
	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
	END IF;	

	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'pcf.cf_987' OR col = 'p.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
	END IF;
	
	SET QUERY1 = CONCAT(QUERY1,' ORDER BY c.createdtime DESC');
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_potential_all
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_potential_all`(
	IN `id_proc` VARCHAR(35),
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `start_prob` DOUBLE,
	IN `end_prob` DOUBLE,
	IN `start_prob2` INT,
	IN `end_prob2` INT,
	IN `user_assign_id` INT,
	IN `user_service` VARCHAR(50),
	IN `user_mkt` VARCHAR(50),
	IN `status` VARCHAR(50),
	IN `sales_stage` VARCHAR(50),
	IN `potential` VARCHAR(100),
	IN `dept` INT,
	IN `product` INT,
	IN `days_delay` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300),
	IN `year_` ENUM('Y','N'),
	IN `month_` ENUM('Y','N'),
	IN `day_` ENUM('Y','N'),
	IN `quarter_` ENUM('Y','N')


)
BEGIN
	IF user_mkt = 'Không xác định' THEN SET user_mkt = ''; END IF;
	IF user_service = 'Không xác định' THEN  SET user_service = ''; END IF;
	IF status = 'Không xác định' THEN  SET status = ''; END IF;
	IF status = 'Trống' THEN  SET status = NULL; END IF;
	
	IF id_proc = 'total_potential' THEN
		CALL `dsa_potential_total_potential` (date_type,start_date, end_date, user_assign_id, user_service, user_mkt, status, sales_stage, potential, dept, product, col, val);
	END IF;
	
	IF id_proc = 'total_potential_won' THEN
		CALL `dsa_potential_total_potential_won` (date_type,start_date, end_date, user_assign_id, user_service, user_mkt, status, sales_stage, potential, dept, product, col, val);
	END IF;
	
	IF id_proc = 'total_potential_lost' THEN
		CALL `dsa_potential_total_potential_lost` (date_type,start_date, end_date, user_assign_id, user_service, user_mkt, status, sales_stage, potential, dept, product, col, val);
	END IF;
	
	IF id_proc = 'total_potential_sale' THEN
		CALL `dsa_potential_total_potential_sale` (date_type,start_date, end_date, user_assign_id, user_service, user_mkt, status, sales_stage, potential, dept, product, col, val);
	END IF;
	
	IF id_proc = 'num_potential_bytime' THEN
		CALL `dsa_potential_bytime` (date_type,start_date, end_date, user_assign_id, user_service, user_mkt, status, sales_stage, potential, dept, product, col, val, year_, month_, day_, quarter_);
	END IF;
	
	IF id_proc = 'potential_delay' THEN
		CALL `dsa_potential_delay` (user_assign_id, user_service, user_mkt, status, sales_stage, potential, dept, product, days_delay, col, val);
	END IF;
	
	IF id_proc = 'potential_delay_2' THEN
		CALL `dsa_potential_delay_2` (user_assign_id, user_service, user_mkt, status, sales_stage, potential, dept, product, start_prob, end_prob, start_prob2, end_prob2, col, val);
	END IF;
	
	IF id_proc = 'num_potential_bysalestage' THEN
		CALL `dsa_potential_bysalestage` (date_type,start_date, end_date, user_assign_id, user_service, user_mkt, status, sales_stage, potential, dept, product, col, val);
	END IF;
	
	IF id_proc = 'num_potential_byproduct' THEN
		CALL `dsa_potential_byproduct` (date_type,start_date, end_date, user_assign_id, user_service, user_mkt, status, sales_stage, potential, dept, product, col, val);
	END IF;
	
	IF id_proc = 'num_potential_byuser' THEN
		CALL `dsa_potential_byuser` (date_type,start_date, end_date, user_assign_id, user_service, user_mkt, status, sales_stage, potential, dept, product, col, val, year_, month_, day_);
	END IF;
	
	IF id_proc = 'num_potential_byuser_status' THEN
		CALL `dsa_potential_by_user_status` (date_type,start_date, end_date, user_assign_id, user_service, user_mkt, status, sales_stage, potential, dept, product, col, val, year_, month_, day_);
	END IF;
	
	IF id_proc = 'potential_detail' THEN
		CALL `dsa_potential_detail` (date_type,start_date, end_date, user_assign_id, user_service, user_mkt, status, sales_stage, potential, dept, product, start_prob, end_prob, col, val);
	END IF;
	
	IF id_proc = 'comment_detail' THEN
		CALL `dsa_potential_comment_detail` (date_type,start_date, end_date, user_assign_id, user_service, user_mkt, status, sales_stage, potential, dept, product, col, val);
	END IF;
	
	IF id_proc = 'activity_detail' THEN
		CALL `dsa_potential_activity_detail` (date_type,start_date, end_date, user_assign_id, user_service, user_mkt, status, sales_stage, potential, dept, product, days_delay, col, val);
	END IF;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_potential_byproduct
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_potential_byproduct`(
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `user_assign_id` INT,
	IN `user_service` VARCHAR(50),
	IN `user_mkt` VARCHAR(50),
	IN `status` VARCHAR(50),
	IN `sales_stage` VARCHAR(50),
	IN `potential` VARCHAR(100),
	IN `dept` INT,
	IN `product` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300)
)
BEGIN
	
	DECLARE QUERY1 NVARCHAR(4000);
	
	SET QUERY1 = 
	'SELECT
		CASE 
			WHEN pr.productname IS NULL THEN ''Không xác định ()''
			ELSE pr.productname
		END ''pr.productname'',
		
		COUNT(DISTINCT p.potentialid) ''num''
	FROM
		((((vtiger_potential p
	INNER JOIN
		vtiger_crmentity c
	ON
		c.crmid = p.potentialid)
	LEFT JOIN
		vtiger_potentialscf pcf
	ON
		p.potentialid = pcf.potentialid)
	LEFT JOIN
		vtiger_seproductsrel pse
	ON
		pse.crmid = c.crmid)
	LEFT JOIN
		vtiger_products pr
	ON
		pr.productid = pse.productid)
	WHERE 
		c.deleted <> 1 AND 1=1 ';
	
	CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
			
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;	
		
		WHEN date_type = 'Ngày đóng' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (p.closingdate BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
			
	END CASE;
	
	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', user_assign_id ,'\' )');
	END IF;
	
	IF user_service IS NOT NULL THEN 
		IF user_service = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = \'', user_service ,'\' )');
		END IF;
	END IF;
	
	IF user_mkt IS NOT NULL THEN 
		IF user_mkt = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
		END IF;
	END IF;
	
	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_987 = \'', status ,'\' )');
	END IF;
	
	IF sales_stage IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.sales_stage = \'', sales_stage ,'\' )');
	END IF;
	
	IF potential IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.potentialname = \'', potential ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = ', dept ,' )');
	END IF;
	
	IF product IS NOT NULL THEN 
		IF product = 0 THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid IS NULL )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid = ', product ,' )');
		END IF;
	END IF;
	
	-- col, val
	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
	END IF;	

	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'pcf.cf_987' OR col = 'p.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
	END IF;
	
	SET QUERY1 = CONCAT(QUERY1,' 	GROUP BY 1 ORDER BY 2 DESC');
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_potential_bysalestage
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_potential_bysalestage`(
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `user_assign_id` INT,
	IN `user_service` VARCHAR(50),
	IN `user_mkt` VARCHAR(50),
	IN `status` VARCHAR(50),
	IN `sales_stage` VARCHAR(50),
	IN `potential` VARCHAR(100),
	IN `dept` INT,
	IN `product` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300)
)
BEGIN
	
	DECLARE QUERY1 NVARCHAR(4000);
	
	SET QUERY1 = 
	'SELECT
		CASE 
			WHEN p.sales_stage IS NULL THEN ''Không xác định''
			ELSE p.sales_stage
		END ''p.sales_stage'',
		
		COUNT(DISTINCT p.potentialid) ''num''
	FROM
		(((((vtiger_potential p
	INNER JOIN
		vtiger_crmentity c
	ON
		c.crmid = p.potentialid)
	LEFT JOIN
		vtiger_potentialscf pcf
	ON
		p.potentialid = pcf.potentialid)
	LEFT JOIN
		vtiger_users u
	ON
		c.smownerid = u.id)
	LEFT JOIN
		vtiger_seproductsrel pse
	ON
		pse.crmid = c.crmid)
	LEFT JOIN
		vtiger_products pr
	ON
		pr.productid = pse.productid)
	WHERE 
		c.deleted <> 1 AND 1=1 ';
		
	CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
		
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
		
		WHEN date_type = 'Ngày đóng' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (p.closingdate BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
			
	END CASE;
	
	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', user_assign_id ,'\' )');
	END IF;
	
	IF user_service IS NOT NULL THEN 
		IF user_service = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = \'', user_service ,'\' )');
		END IF;
	END IF;
	
	IF user_mkt IS NOT NULL THEN 
		IF user_mkt = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
		END IF;
	END IF;
	
	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_987 = \'', status ,'\' )');
	END IF;
	
	IF sales_stage IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.sales_stage = \'', sales_stage ,'\' )');
	END IF;
	
	IF potential IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.potentialname = \'', potential ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = ', dept ,' )');
	END IF;
	
	IF product IS NOT NULL THEN 
		IF product = 0 THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid IS NULL )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid = ', product ,' )');
		END IF;
	END IF;
	
	-- col, val
	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
	END IF;	

	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'pcf.cf_987' OR col = 'p.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
	END IF;
	
	SET QUERY1 = CONCAT(QUERY1,' 	GROUP BY 1 ORDER BY 2 DESC');
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_potential_bytime
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_potential_bytime`(
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `user_assign_id` INT,
	IN `user_service` VARCHAR(50),
	IN `user_mkt` VARCHAR(50),
	IN `status` VARCHAR(50),
	IN `sales_stage` VARCHAR(50),
	IN `potential` VARCHAR(100),
	IN `dept` INT,
	IN `product` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300),
	IN `year_` ENUM('Y','N'),
	IN `month_` ENUM('Y','N'),
	IN `day_` ENUM('Y','N'),
	IN `quarter_` ENUM('Y','N')
)
BEGIN
	DECLARE QUERY1 NVARCHAR(4000);
	DECLARE QUERY2 NVARCHAR(4000);
	DECLARE QUERY3 NVARCHAR(4000);
	DECLARE QUERY4 NVARCHAR(4000);
	
	CASE
	WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
		
		-- Đếm các task đã mở theo ngày
		SET QUERY1 = 
			'SELECT
				CONCAT(Year(c.createdtime), '' - Q'', Quarter(c.createdtime)) AS ''c.createdtime'',
				COUNT(DISTINCT p.potentialid) num
			FROM
				(((((vtiger_potential p
			INNER JOIN
				vtiger_crmentity c
			ON
				c.crmid = p.potentialid)
			LEFT JOIN
				vtiger_potentialscf pcf
			ON
				p.potentialid = pcf.potentialid)
			LEFT JOIN
				vtiger_users u
			ON
				c.smownerid = u.id)
			LEFT JOIN
				vtiger_seproductsrel pse
			ON
				pse.crmid = c.crmid)
			LEFT JOIN
				vtiger_products pr
			ON
				pr.productid = pse.productid)
		   WHERE 
				c.deleted <> 1 AND 1=1 ';
		
		SET QUERY2 = 
			'SELECT
				CAST(Year(c.createdtime) AS CHAR) AS ''c.createdtime'',
				COUNT(DISTINCT p.potentialid) num
			FROM
				(((((vtiger_potential p
			INNER JOIN
				vtiger_crmentity c
			ON
				c.crmid = p.potentialid)
			LEFT JOIN
				vtiger_potentialscf pcf
			ON
				p.potentialid = pcf.potentialid)
			LEFT JOIN
				vtiger_users u
			ON
				c.smownerid = u.id)
			LEFT JOIN
				vtiger_seproductsrel pse
			ON
				pse.crmid = c.crmid)
			LEFT JOIN
				vtiger_products pr
			ON
				pr.productid = pse.productid)
		   WHERE 
				c.deleted <> 1 AND 1=1 ';
		
		SET QUERY3 = 
			'SELECT
				CONCAT(Month(c.createdtime),''/'', Year(c.createdtime)) AS ''c.createdtime'',
				COUNT(DISTINCT p.potentialid) num
			FROM
				(((((vtiger_potential p
			INNER JOIN
				vtiger_crmentity c
			ON
				c.crmid = p.potentialid)
			LEFT JOIN
				vtiger_potentialscf pcf
			ON
				p.potentialid = pcf.potentialid)
			LEFT JOIN
				vtiger_users u
			ON
				c.smownerid = u.id)
			LEFT JOIN
				vtiger_seproductsrel pse
			ON
				pse.crmid = c.crmid)
			LEFT JOIN
				vtiger_products pr
			ON
				pr.productid = pse.productid)
		   WHERE 
				c.deleted <> 1 AND 1=1 ';
		
		SET QUERY4 = 
			'SELECT
				CONCAT(Day(c.createdtime),''/'',Month(c.createdtime),''/'', Year(c.createdtime)) AS ''c.createdtime'',
				COUNT(DISTINCT p.potentialid) num
			FROM
				(((((vtiger_potential p
			INNER JOIN
				vtiger_crmentity c
			ON
				c.crmid = p.potentialid)
			LEFT JOIN
				vtiger_potentialscf pcf
			ON
				p.potentialid = pcf.potentialid)
			LEFT JOIN
				vtiger_users u
			ON
				c.smownerid = u.id)
			LEFT JOIN
				vtiger_seproductsrel pse
			ON
				pse.crmid = c.crmid)
			LEFT JOIN
				vtiger_products pr
			ON
				pr.productid = pse.productid)
		   WHERE 
				c.deleted <> 1 AND 1=1 ';

	WHEN date_type = 'Ngày chỉnh sửa' THEN
		-- Đếm các task đã mở theo ngày
		SET QUERY1 = 
			'SELECT
				CONCAT(Year(c.modifiedtime), '' - Q'', Quarter(c.modifiedtime)) AS ''c.modifiedtime'',
				COUNT(DISTINCT p.potentialid) num
			FROM
				(((((vtiger_potential p
			INNER JOIN
				vtiger_crmentity c
			ON
				c.crmid = p.potentialid)
			LEFT JOIN
				vtiger_potentialscf pcf
			ON
				p.potentialid = pcf.potentialid)
			LEFT JOIN
				vtiger_users u
			ON
				c.smownerid = u.id)
			LEFT JOIN
				vtiger_seproductsrel pse
			ON
				pse.crmid = c.crmid)
			LEFT JOIN
				vtiger_products pr
			ON
				pr.productid = pse.productid)
		   WHERE 
				c.deleted <> 1 AND 1=1 ';
		
		SET QUERY2 = 
			'SELECT
				CAST(Year(c.modifiedtime) AS CHAR) AS ''c.modifiedtime'',
				COUNT(DISTINCT p.potentialid) num
			FROM
				(((((vtiger_potential p
			INNER JOIN
				vtiger_crmentity c
			ON
				c.crmid = p.potentialid)
			LEFT JOIN
				vtiger_potentialscf pcf
			ON
				p.potentialid = pcf.potentialid)
			LEFT JOIN
				vtiger_users u
			ON
				c.smownerid = u.id)
			LEFT JOIN
				vtiger_seproductsrel pse
			ON
				pse.crmid = c.crmid)
			LEFT JOIN
				vtiger_products pr
			ON
				pr.productid = pse.productid)
		   WHERE 
				c.deleted <> 1 AND 1=1 ';
		
		SET QUERY3 = 
			'SELECT
				CONCAT(Month(c.modifiedtime),''/'', Year(c.modifiedtime)) AS ''c.modifiedtime'',
				COUNT(DISTINCT p.potentialid) num
			FROM
				(((((vtiger_potential p
			INNER JOIN
				vtiger_crmentity c
			ON
				c.crmid = p.potentialid)
			LEFT JOIN
				vtiger_potentialscf pcf
			ON
				p.potentialid = pcf.potentialid)
			LEFT JOIN
				vtiger_users u
			ON
				c.smownerid = u.id)
			LEFT JOIN
				vtiger_seproductsrel pse
			ON
				pse.crmid = c.crmid)
			LEFT JOIN
				vtiger_products pr
			ON
				pr.productid = pse.productid)
		   WHERE 
				c.deleted <> 1 AND 1=1 ';
		
		SET QUERY4 = 
			'SELECT
				CONCAT(Day(c.modifiedtime),''/'',Month(c.modifiedtime),''/'', Year(c.modifiedtime)) AS ''c.modifiedtime'',
				COUNT(DISTINCT p.potentialid) num
			FROM
				(((((vtiger_potential p
			INNER JOIN
				vtiger_crmentity c
			ON
				c.crmid = p.potentialid)
			LEFT JOIN
				vtiger_potentialscf pcf
			ON
				p.potentialid = pcf.potentialid)
			LEFT JOIN
				vtiger_users u
			ON
				c.smownerid = u.id)
			LEFT JOIN
				vtiger_seproductsrel pse
			ON
				pse.crmid = c.crmid)
			LEFT JOIN
				vtiger_products pr
			ON
				pr.productid = pse.productid)
		   WHERE 
				c.deleted <> 1 AND 1=1 ';
				
	WHEN date_type = 'Ngày đóng' THEN
		-- Đếm các task đã mở theo ngày
		SET QUERY1 = 
			'SELECT
				CONCAT(Year(p.closingdate), '' - Q'', Quarter(p.closingdate)) AS ''p.closingdate'',
				COUNT(DISTINCT p.potentialid) num
			FROM
				(((((vtiger_potential p
			INNER JOIN
				vtiger_crmentity c
			ON
				c.crmid = p.potentialid)
			LEFT JOIN
				vtiger_potentialscf pcf
			ON
				p.potentialid = pcf.potentialid)
			LEFT JOIN
				vtiger_users u
			ON
				c.smownerid = u.id)
			LEFT JOIN
				vtiger_seproductsrel pse
			ON
				pse.crmid = c.crmid)
			LEFT JOIN
				vtiger_products pr
			ON
				pr.productid = pse.productid)
		   WHERE 
				c.deleted <> 1 AND 1=1 ';
		
		SET QUERY2 = 
			'SELECT
				CAST(Year(p.closingdate) AS CHAR) AS ''p.closingdate'',
				COUNT(DISTINCT p.potentialid) num
			FROM
				(((((vtiger_potential p
			INNER JOIN
				vtiger_crmentity c
			ON
				c.crmid = p.potentialid)
			LEFT JOIN
				vtiger_potentialscf pcf
			ON
				p.potentialid = pcf.potentialid)
			LEFT JOIN
				vtiger_users u
			ON
				c.smownerid = u.id)
			LEFT JOIN
				vtiger_seproductsrel pse
			ON
				pse.crmid = c.crmid)
			LEFT JOIN
				vtiger_products pr
			ON
				pr.productid = pse.productid)
		   WHERE 
				c.deleted <> 1 AND 1=1 ';
		
		SET QUERY3 = 
			'SELECT
				CONCAT(Month(p.closingdate),''/'', Year(p.closingdate)) AS ''p.closingdate'',
				COUNT(DISTINCT p.potentialid) num
			FROM
				(((((vtiger_potential p
			INNER JOIN
				vtiger_crmentity c
			ON
				c.crmid = p.potentialid)
			LEFT JOIN
				vtiger_potentialscf pcf
			ON
				p.potentialid = pcf.potentialid)
			LEFT JOIN
				vtiger_users u
			ON
				c.smownerid = u.id)
			LEFT JOIN
				vtiger_seproductsrel pse
			ON
				pse.crmid = c.crmid)
			LEFT JOIN
				vtiger_products pr
			ON
				pr.productid = pse.productid)
		   WHERE 
				c.deleted <> 1 AND 1=1 ';
		
		SET QUERY4 = 
			'SELECT
				CONCAT(Day(p.closingdate),''/'',Month(p.closingdate),''/'', Year(p.closingdate)) AS ''p.closingdate'',
				COUNT(DISTINCT p.potentialid) num
			FROM
				(((((vtiger_potential p
			INNER JOIN
				vtiger_crmentity c
			ON
				c.crmid = p.potentialid)
			LEFT JOIN
				vtiger_potentialscf pcf
			ON
				p.potentialid = pcf.potentialid)
			LEFT JOIN
				vtiger_users u
			ON
				c.smownerid = u.id)
			LEFT JOIN
				vtiger_seproductsrel pse
			ON
				pse.crmid = c.crmid)
			LEFT JOIN
				vtiger_products pr
			ON
				pr.productid = pse.productid)
		   WHERE 
				c.deleted <> 1 AND 1=1 ';
	END CASE;

	-- Lọc các task có thời gian hoàn thành nằm trong khoảng đã cho
	CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY2 = CONCAT(QUERY2,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY3 = CONCAT(QUERY3,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY4 = CONCAT(QUERY4,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
				SET QUERY2 = CONCAT(QUERY2,' ');
				SET QUERY3 = CONCAT(QUERY3,' ');
				SET QUERY4 = CONCAT(QUERY4,' ');
			END IF;
		
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.modifiedtime BETWEEN \'',start_date,'\'  ',' AND  \'', end_date,'\'  )' );
				SET QUERY2 = CONCAT(QUERY2,' AND (c.modifiedtime BETWEEN \'',start_date,'\'  ',' AND  \'', end_date,'\'  )' );
				SET QUERY3 = CONCAT(QUERY3,' AND (c.modifiedtime BETWEEN \'',start_date,'\'  ',' AND  \'', end_date,'\'  )' );
				SET QUERY4 = CONCAT(QUERY4,' AND (c.modifiedtime BETWEEN \'',start_date,'\'  ',' AND  \'', end_date,'\'  )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
				SET QUERY2 = CONCAT(QUERY2,' ');
				SET QUERY3 = CONCAT(QUERY3,' ');
				SET QUERY4 = CONCAT(QUERY4,' ');
			END IF;
		
		WHEN date_type = 'Ngày đóng' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (p.closingdate BETWEEN \'',start_date,'\'  ',' AND  \'', end_date,'\'  )' );
				SET QUERY2 = CONCAT(QUERY2,' AND (p.closingdate BETWEEN \'',start_date,'\'  ',' AND  \'', end_date,'\'  )' );
				SET QUERY3 = CONCAT(QUERY3,' AND (p.closingdate BETWEEN \'',start_date,'\'  ',' AND  \'', end_date,'\'  )' );
				SET QUERY4 = CONCAT(QUERY4,' AND (p.closingdate BETWEEN \'',start_date,'\'  ',' AND  \'', end_date,'\'  )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
				SET QUERY2 = CONCAT(QUERY2,' ');
				SET QUERY3 = CONCAT(QUERY3,' ');
				SET QUERY4 = CONCAT(QUERY4,' ');
			END IF;
			
	END CASE;
	
	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = ', user_assign_id ,' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (c.smownerid = ', user_assign_id ,' )');
		SET QUERY3 = CONCAT(QUERY3,' AND (c.smownerid = ', user_assign_id ,' )');
		SET QUERY4 = CONCAT(QUERY4,' AND (c.smownerid = ', user_assign_id ,' )');
		
	END IF;
	
	IF user_service IS NOT NULL THEN 
		IF user_service = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = '''' )');
			SET QUERY2 = CONCAT(QUERY2,' AND (pcf.cf_901 = '''' )');
			SET QUERY3 = CONCAT(QUERY3,' AND (pcf.cf_901 = '''' )');
			SET QUERY4 = CONCAT(QUERY4,' AND (pcf.cf_901 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = \'', user_service ,'\' )');
			SET QUERY2 = CONCAT(QUERY2,' AND (pcf.cf_901 = \'', user_service ,'\' )');
			SET QUERY3 = CONCAT(QUERY3,' AND (pcf.cf_901 = \'', user_service ,'\' )');
			SET QUERY4 = CONCAT(QUERY4,' AND (pcf.cf_901 = \'', user_service ,'\' )');
		END IF;
	END IF;
	
	IF user_mkt IS NOT NULL THEN 
		IF user_mkt = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = '''' )');
			SET QUERY2 = CONCAT(QUERY2,' AND (pcf.cf_985 = '''' )');
			SET QUERY3 = CONCAT(QUERY3,' AND (pcf.cf_985 = '''' )');
			SET QUERY4 = CONCAT(QUERY4,' AND (pcf.cf_985 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
			SET QUERY2 = CONCAT(QUERY2,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
			SET QUERY3 = CONCAT(QUERY3,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
			SET QUERY4 = CONCAT(QUERY4,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
		END IF;
	END IF;
	
	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_987 = \'', status ,'\' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (pcf.cf_987 = \'', status ,'\' )');
		SET QUERY3 = CONCAT(QUERY3,' AND (pcf.cf_987 = \'', status ,'\' )');
		SET QUERY4 = CONCAT(QUERY4,' AND (pcf.cf_987 = \'', status ,'\' )');
	END IF;
	
	IF sales_stage IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.sales_stage = \'', sales_stage ,'\' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (p.sales_stage = \'', sales_stage ,'\' )');
		SET QUERY3 = CONCAT(QUERY3,' AND (p.sales_stage = \'', sales_stage ,'\' )');
		SET QUERY4 = CONCAT(QUERY4,' AND (p.sales_stage = \'', sales_stage ,'\' )');
	END IF;
	
	IF potential IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.potentialname = \'', potential ,'\' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (p.potentialname = \'', potential ,'\' )');
		SET QUERY3 = CONCAT(QUERY3,' AND (p.potentialname = \'', potential ,'\' )');
		SET QUERY4 = CONCAT(QUERY4,' AND (p.potentialname = \'', potential ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', dept ,'\' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (c.smownerid = \'', dept ,'\' )');
		SET QUERY3 = CONCAT(QUERY3,' AND (c.smownerid = \'', dept ,'\' )');
		SET QUERY4 = CONCAT(QUERY4,' AND (c.smownerid = \'', dept ,'\' )');
	END IF;

	IF product IS NOT NULL THEN 
		IF product = 0 THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid IS NULL )');
			SET QUERY2 = CONCAT(QUERY2,' AND (pr.productid IS NULL )');
			SET QUERY3 = CONCAT(QUERY3,' AND (pr.productid IS NULL )');
			SET QUERY4 = CONCAT(QUERY4,' AND (pr.productid IS NULL )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid = ', product ,' )');
			SET QUERY2 = CONCAT(QUERY2,' AND (pr.productid = ', product ,' )');
			SET QUERY3 = CONCAT(QUERY3,' AND (pr.productid = ', product ,' )');
			SET QUERY4 = CONCAT(QUERY4,' AND (pr.productid = ', product ,' )');
		END IF;
	END IF;

	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
		SET QUERY2 = CONCAT(QUERY2,' AND (', col, ' = N\'', val ,'\')');
		SET QUERY3 = CONCAT(QUERY3,' AND (', col, ' = N\'', val ,'\')');
		SET QUERY4 = CONCAT(QUERY4,' AND (', col, ' = N\'', val ,'\')');
	END IF;
	
	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
		SET QUERY2 = CONCAT(QUERY2,' AND (u.user_name IS NULL)');
		SET QUERY3 = CONCAT(QUERY3,' AND (u.user_name IS NULL)');
		SET QUERY4 = CONCAT(QUERY4,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'pcf.cf_987' OR col = 'p.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (',col,' = '''' )');
		SET QUERY3 = CONCAT(QUERY3,' AND (',col,' = '''' )');
		SET QUERY4 = CONCAT(QUERY4,' AND (',col,' = '''' )');
	END IF;
	
	-- Gộp theo ngày và sắp xếp theo ngày từ h về trước
	
	SET QUERY2 = CONCAT(QUERY2,'GROUP BY 1 ORDER BY 1');
	
	CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			SET QUERY1 = CONCAT(QUERY1,'GROUP BY 1 ORDER BY Year(c.createdtime), QUARTER(c.createdtime)');
			SET QUERY3 = CONCAT(QUERY3,'GROUP BY 1 ORDER BY Year(c.createdtime), Month(c.createdtime)');
			SET QUERY4 = CONCAT(QUERY4,'GROUP BY 1 ORDER BY Year(c.createdtime), Month(c.createdtime), Day(c.createdtime)');
		
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			SET QUERY1 = CONCAT(QUERY1,'GROUP BY 1 ORDER BY Year(c.modifiedtime), QUARTER(c.modifiedtime)');
			SET QUERY3 = CONCAT(QUERY3,'GROUP BY 1 ORDER BY Year(c.modifiedtime), Month(c.modifiedtime)');
			SET QUERY4 = CONCAT(QUERY4,'GROUP BY 1 ORDER BY Year(c.modifiedtime), Month(c.modifiedtime), Day(c.modifiedtime)');
		
		WHEN date_type = 'Ngày đóng' THEN
			SET QUERY1 = CONCAT(QUERY1,'GROUP BY 1 ORDER BY Year(p.closingdate), QUARTER(p.closingdate)');
			SET QUERY3 = CONCAT(QUERY3,'GROUP BY 1 ORDER BY Year(p.closingdate), Month(p.closingdate)');
			SET QUERY4 = CONCAT(QUERY4,'GROUP BY 1 ORDER BY Year(p.closingdate), Month(p.closingdate), Day(p.closingdate)');
	END CASE;
	
	IF quarter_ IS NOT NULL THEN
		-- In và khởi chạy query
		SELECT QUERY1;
		SET @SQL := QUERY1;
		PREPARE stmt FROM @SQL;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
	END IF;
	
	IF year_ IS NOT NULL THEN
		-- In và khởi chạy query
		SELECT QUERY2;
		SET @SQL := QUERY2;
		PREPARE stmt2 FROM @SQL;
		EXECUTE stmt2;
		DEALLOCATE PREPARE stmt2;
	END IF;
	
	IF month_ IS NOT NULL THEN
		-- In và khởi chạy query
		SELECT QUERY3;
		SET @SQL := QUERY3;
		PREPARE stmt3 FROM @SQL;
		EXECUTE stmt3;
		DEALLOCATE PREPARE stmt3;
	END IF;
	
	IF day_ IS NOT NULL THEN
		-- In và khởi chạy query
		SELECT QUERY4;
		SET @SQL := QUERY4;
		PREPARE stmt4 FROM @SQL;
		EXECUTE stmt4;
		DEALLOCATE PREPARE stmt4;
	END IF;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_potential_byuser
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_potential_byuser`(
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `user_assign_id` INT,
	IN `user_service` VARCHAR(50),
	IN `user_mkt` VARCHAR(50),
	IN `status` VARCHAR(50),
	IN `sales_stage` VARCHAR(50),
	IN `potential` VARCHAR(100),
	IN `dept` INT,
	IN `product` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300),
	IN `assign` ENUM('Y','N'),
	IN `mkt` ENUM('Y','N'),
	IN `service` ENUM('Y','N')
)
BEGIN
	DECLARE QUERY1 NVARCHAR(4000);
	DECLARE QUERY1_1 NVARCHAR(4000);
	DECLARE QUERY1_2 NVARCHAR(4000);
	DECLARE QUERY2 NVARCHAR(4000);
	DECLARE QUERY2_1 NVARCHAR(4000);
	DECLARE QUERY2_2 NVARCHAR(4000);
	DECLARE QUERY3 NVARCHAR(4000);
	DECLARE QUERY3_1 NVARCHAR(4000);
	DECLARE QUERY3_2 NVARCHAR(4000);
	
	SET QUERY1_1 = 
		'(SELECT
			CASE 
				WHEN u.user_name IS NULL THEN ''Không xác định''
				WHEN u.user_name = '''' THEN ''Trống''
				ELSE u.user_name
			END ''user_name'',
				
			COUNT(DISTINCT p.potentialid) ''num''
		FROM
			(((((vtiger_potential p
		INNER JOIN
			vtiger_crmentity c
		ON
			c.crmid = p.potentialid)
		LEFT JOIN
			vtiger_potentialscf pcf
		ON
			p.potentialid = pcf.potentialid)
		LEFT JOIN
			vtiger_users u
		ON
			c.smownerid = u.id)
		LEFT JOIN
			vtiger_seproductsrel pse
		ON
			pse.crmid = c.crmid)
		LEFT JOIN
			vtiger_products pr
		ON
			pr.productid = pse.productid)
		WHERE 
			c.deleted <> 1 AND 1=1 ';
	
	SET QUERY1_2 = 
		'(SELECT
			CASE 
				WHEN u.user_name IS NULL THEN ''Không xác định''
				WHEN u.user_name = '''' THEN ''Trống''
				ELSE u.user_name
			END ''user_name'',
				
			COUNT(DISTINCT p.potentialid) ''num''
		FROM
			(((((vtiger_potential p
		INNER JOIN
			vtiger_crmentity c
		ON
			c.crmid = p.potentialid)
		LEFT JOIN
			vtiger_potentialscf pcf
		ON
			p.potentialid = pcf.potentialid)
		LEFT JOIN
			vtiger_users u
		ON
			c.smownerid = u.id)
		LEFT JOIN
			vtiger_seproductsrel pse
		ON
			pse.crmid = c.crmid)
		LEFT JOIN
			vtiger_products pr
		ON
			pr.productid = pse.productid)
		WHERE 
			c.deleted <> 1 AND p.sales_stage=''Closed Won'' AND 1=1 ';
	
	SET QUERY2_1 = 
		'(SELECT
			CASE 
				WHEN pcf.cf_985 IS NULL THEN ''Không xác định''
				WHEN pcf.cf_985 = '''' THEN ''Trống''
				ELSE pcf.cf_985
			END ''user_name'',
				
			COUNT(DISTINCT p.potentialid) ''num''
		FROM
			(((((vtiger_potential p
		INNER JOIN
			vtiger_crmentity c
		ON
			c.crmid = p.potentialid)
		LEFT JOIN
			vtiger_potentialscf pcf
		ON
			p.potentialid = pcf.potentialid)
		LEFT JOIN
			vtiger_users u
		ON
			c.smownerid = u.id)
		LEFT JOIN
			vtiger_seproductsrel pse
		ON
			pse.crmid = c.crmid)
		LEFT JOIN
			vtiger_products pr
		ON
			pr.productid = pse.productid)
		WHERE 
			c.deleted <> 1 AND 1=1 ';
			
	SET QUERY2_2 = 
		'(SELECT
			CASE 
				WHEN pcf.cf_985 IS NULL THEN ''Không xác định''
				WHEN pcf.cf_985 = '''' THEN ''Trống''
				ELSE pcf.cf_985
			END ''user_name'',
				
			COUNT(DISTINCT p.potentialid) ''num''
		FROM
			(((((vtiger_potential p
		INNER JOIN
			vtiger_crmentity c
		ON
			c.crmid = p.potentialid)
		LEFT JOIN
			vtiger_potentialscf pcf
		ON
			p.potentialid = pcf.potentialid)
		LEFT JOIN
			vtiger_users u
		ON
			c.smownerid = u.id)
		LEFT JOIN
			vtiger_seproductsrel pse
		ON
			pse.crmid = c.crmid)
		LEFT JOIN
			vtiger_products pr
		ON
			pr.productid = pse.productid)
		WHERE 
			c.deleted <> 1 AND p.sales_stage=''Closed Won'' AND 1=1 ';
	
	SET QUERY3_1 = 
		'(SELECT
			CASE 
				WHEN pcf.cf_901 IS NULL THEN ''Không xác định''
				WHEN pcf.cf_901 = '''' THEN ''Trống''
				ELSE pcf.cf_901
			END ''user_name'',
				
			COUNT(DISTINCT p.potentialid) ''num''
		FROM
			(((((vtiger_potential p
		INNER JOIN
			vtiger_crmentity c
		ON
			c.crmid = p.potentialid)
		LEFT JOIN
			vtiger_potentialscf pcf
		ON
			p.potentialid = pcf.potentialid)
		LEFT JOIN
			vtiger_users u
		ON
			c.smownerid = u.id)
		LEFT JOIN
			vtiger_seproductsrel pse
		ON
			pse.crmid = c.crmid)
		LEFT JOIN
			vtiger_products pr
		ON
			pr.productid = pse.productid)
		WHERE 
			c.deleted <> 1 AND 1=1 ';
			
	SET QUERY3_2 = 
		'(SELECT
			CASE 
				WHEN pcf.cf_901 IS NULL THEN ''Không xác định''
				WHEN pcf.cf_901 = '''' THEN ''Trống''
				ELSE pcf.cf_901
			END ''user_name'',
				
			COUNT(DISTINCT p.potentialid) ''num''
		FROM
			(((((vtiger_potential p
		INNER JOIN
			vtiger_crmentity c
		ON
			c.crmid = p.potentialid)
		LEFT JOIN
			vtiger_potentialscf pcf
		ON
			p.potentialid = pcf.potentialid)
		LEFT JOIN
			vtiger_users u
		ON
			c.smownerid = u.id)
		LEFT JOIN
			vtiger_seproductsrel pse
		ON
			pse.crmid = c.crmid)
		LEFT JOIN
			vtiger_products pr
		ON
			pr.productid = pse.productid)
		WHERE 
			c.deleted <> 1 AND p.sales_stage=''Closed Won'' AND 1=1 ';

	-- 
	CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1_1 = CONCAT(QUERY1_1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY1_2 = CONCAT(QUERY1_2,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY2_1 = CONCAT(QUERY2_1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY2_2 = CONCAT(QUERY2_2,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY3_1 = CONCAT(QUERY3_1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY3_2 = CONCAT(QUERY3_2,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1_1 = CONCAT(QUERY1_1,' ');
				SET QUERY1_2 = CONCAT(QUERY1_2,' ');
				SET QUERY2_1 = CONCAT(QUERY2_1,' ');
				SET QUERY2_2 = CONCAT(QUERY2_2,' ');
				SET QUERY3_1 = CONCAT(QUERY3_1,' ');
				SET QUERY3_2 = CONCAT(QUERY3_2,' ');
			END IF;
		
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1_1 = CONCAT(QUERY1_1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY1_2 = CONCAT(QUERY1_2,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY2_1 = CONCAT(QUERY2_1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY2_2 = CONCAT(QUERY2_2,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY3_1 = CONCAT(QUERY3_1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY3_2 = CONCAT(QUERY3_2,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1_1 = CONCAT(QUERY1_1,' ');
				SET QUERY1_2 = CONCAT(QUERY1_2,' ');
				SET QUERY2_1 = CONCAT(QUERY2_1,' ');
				SET QUERY2_2 = CONCAT(QUERY2_2,' ');
				SET QUERY3_1 = CONCAT(QUERY3_1,' ');
				SET QUERY3_2 = CONCAT(QUERY3_2,' ');
			END IF;
		
		WHEN date_type = 'Ngày đóng' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1_1 = CONCAT(QUERY1_1,' AND (p.closingdate BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY1_2 = CONCAT(QUERY1_2,' AND (p.closingdate BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY2_1 = CONCAT(QUERY2_1,' AND (p.closingdate BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY2_2 = CONCAT(QUERY2_2,' AND (p.closingdate BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY3_1 = CONCAT(QUERY3_1,' AND (p.closingdate BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY3_2 = CONCAT(QUERY3_2,' AND (p.closingdate BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1_1 = CONCAT(QUERY1_1,' ');
				SET QUERY1_2 = CONCAT(QUERY1_2,' ');
				SET QUERY2_1 = CONCAT(QUERY2_1,' ');
				SET QUERY2_2 = CONCAT(QUERY2_2,' ');
				SET QUERY3_1 = CONCAT(QUERY3_1,' ');
				SET QUERY3_2 = CONCAT(QUERY3_2,' ');
			END IF;
			
	END CASE;
	
	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1_1 = CONCAT(QUERY1_1,' AND (c.smownerid = ', user_assign_id ,' )');
		SET QUERY1_2 = CONCAT(QUERY1_2,' AND (c.smownerid = ', user_assign_id ,' )');
		SET QUERY2_1 = CONCAT(QUERY2_1,' AND (c.smownerid = ', user_assign_id ,' )');
		SET QUERY2_2 = CONCAT(QUERY2_2,' AND (c.smownerid = ', user_assign_id ,' )');
		SET QUERY3_1 = CONCAT(QUERY3_1,' AND (c.smownerid = ', user_assign_id ,' )');
		SET QUERY3_2 = CONCAT(QUERY3_2,' AND (c.smownerid = ', user_assign_id ,' )');
	END IF;
	
	IF user_service IS NOT NULL THEN 
		IF user_service = '' THEN
			SET QUERY1_1 = CONCAT(QUERY1_1,' AND (pcf.cf_901 = '''' )');
			SET QUERY1_2 = CONCAT(QUERY1_2,' AND (pcf.cf_901 = '''' )');
			SET QUERY2_1 = CONCAT(QUERY2_1,' AND (pcf.cf_901 = '''' )');
			SET QUERY2_2 = CONCAT(QUERY2_2,' AND (pcf.cf_901 = '''' )');
			SET QUERY3_1 = CONCAT(QUERY3_1,' AND (pcf.cf_901 = '''' )');
			SET QUERY3_2 = CONCAT(QUERY3_2,' AND (pcf.cf_901 = '''' )');
		ELSE
			SET QUERY1_1 = CONCAT(QUERY1_1,' AND (pcf.cf_901 = \'', user_service ,'\' )');
			SET QUERY1_2 = CONCAT(QUERY1_2,' AND (pcf.cf_901 = \'', user_service ,'\' )');
			SET QUERY2_1 = CONCAT(QUERY2_1,' AND (pcf.cf_901 = \'', user_service ,'\' )');
			SET QUERY2_2 = CONCAT(QUERY2_2,' AND (pcf.cf_901 = \'', user_service ,'\' )');
			SET QUERY3_1 = CONCAT(QUERY3_1,' AND (pcf.cf_901 = \'', user_service ,'\' )');
			SET QUERY3_2 = CONCAT(QUERY3_2,' AND (pcf.cf_901 = \'', user_service ,'\' )');
		END IF;
	END IF;
	
	IF user_mkt IS NOT NULL THEN 
		IF user_mkt = '' THEN
			SET QUERY1_1 = CONCAT(QUERY1_1,' AND (pcf.cf_985 = '''' )');
			SET QUERY1_2 = CONCAT(QUERY1_2,' AND (pcf.cf_985 = '''' )');
			SET QUERY2_1 = CONCAT(QUERY2_1,' AND (pcf.cf_985 = '''' )');
			SET QUERY2_2 = CONCAT(QUERY2_2,' AND (pcf.cf_985 = '''' )');
			SET QUERY3_1 = CONCAT(QUERY3_1,' AND (pcf.cf_985 = '''' )');
			SET QUERY3_2 = CONCAT(QUERY3_2,' AND (pcf.cf_985 = '''' )');
		ELSE
			SET QUERY1_1 = CONCAT(QUERY1_1,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
			SET QUERY1_2 = CONCAT(QUERY1_2,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
			SET QUERY2_1 = CONCAT(QUERY2_1,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
			SET QUERY2_2 = CONCAT(QUERY2_2,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
			SET QUERY3_1 = CONCAT(QUERY3_1,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
			SET QUERY3_2 = CONCAT(QUERY3_2,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
		END IF;
	END IF;
	
	IF status IS NOT NULL THEN 
		SET QUERY1_1 = CONCAT(QUERY1_1,' AND (pcf.cf_987 = \'', status ,'\' )');
		SET QUERY1_2 = CONCAT(QUERY1_2,' AND (pcf.cf_987 = \'', status ,'\' )');
		SET QUERY2_1 = CONCAT(QUERY2_1,' AND (pcf.cf_987 = \'', status ,'\' )');
		SET QUERY2_2 = CONCAT(QUERY2_2,' AND (pcf.cf_987 = \'', status ,'\' )');
		SET QUERY3_1 = CONCAT(QUERY3_1,' AND (pcf.cf_987 = \'', status ,'\' )');
		SET QUERY3_2 = CONCAT(QUERY3_2,' AND (pcf.cf_987 = \'', status ,'\' )');
	END IF;
	
	IF sales_stage IS NOT NULL THEN 
		SET QUERY1_1 = CONCAT(QUERY1_1,' AND (p.sales_stage = \'', sales_stage ,'\' )');
		SET QUERY1_2 = CONCAT(QUERY1_2,' AND (p.sales_stage = \'', sales_stage ,'\' )');
		SET QUERY2_1 = CONCAT(QUERY2_1,' AND (p.sales_stage = \'', sales_stage ,'\' )');
		SET QUERY2_2 = CONCAT(QUERY2_2,' AND (p.sales_stage = \'', sales_stage ,'\' )');
		SET QUERY3_1 = CONCAT(QUERY3_1,' AND (p.sales_stage = \'', sales_stage ,'\' )');
		SET QUERY3_2 = CONCAT(QUERY3_2,' AND (p.sales_stage = \'', sales_stage ,'\' )');
	END IF;
	
	IF potential IS NOT NULL THEN 
		SET QUERY1_1 = CONCAT(QUERY1_1,' AND (p.potentialname = \'', potential ,'\' )');
		SET QUERY1_2 = CONCAT(QUERY1_2,' AND (p.potentialname = \'', potential ,'\' )');
		SET QUERY2_1 = CONCAT(QUERY2_1,' AND (p.potentialname = \'', potential ,'\' )');
		SET QUERY2_2 = CONCAT(QUERY2_2,' AND (p.potentialname = \'', potential ,'\' )');
		SET QUERY3_1 = CONCAT(QUERY3_1,' AND (p.potentialname = \'', potential ,'\' )');
		SET QUERY3_2 = CONCAT(QUERY3_2,' AND (p.potentialname = \'', potential ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1_1 = CONCAT(QUERY1_1,' AND (c.smownerid = \'', dept ,'\' )');
		SET QUERY1_2 = CONCAT(QUERY1_2,' AND (c.smownerid = \'', dept ,'\' )');
		SET QUERY2_1 = CONCAT(QUERY2_1,' AND (c.smownerid = \'', dept ,'\' )');
		SET QUERY2_2 = CONCAT(QUERY2_2,' AND (c.smownerid = \'', dept ,'\' )');
		SET QUERY3_1 = CONCAT(QUERY3_1,' AND (c.smownerid = \'', dept ,'\' )');
		SET QUERY3_2 = CONCAT(QUERY3_2,' AND (c.smownerid = \'', dept ,'\' )');
	END IF;

	IF product IS NOT NULL THEN 
		IF product = 0 THEN
			SET QUERY1_1 = CONCAT(QUERY1_1,' AND (pr.productid IS NULL )');
			SET QUERY1_2 = CONCAT(QUERY1_2,' AND (pr.productid IS NULL )');
			SET QUERY2_1 = CONCAT(QUERY2_1,' AND (pr.productid IS NULL )');
			SET QUERY2_2 = CONCAT(QUERY2_2,' AND (pr.productid IS NULL )');
			SET QUERY3_1 = CONCAT(QUERY2_1,' AND (pr.productid IS NULL )');
			SET QUERY3_2 = CONCAT(QUERY2_2,' AND (pr.productid IS NULL )');
		ELSE
			SET QUERY1_1 = CONCAT(QUERY1_1,' AND (pr.productid = ', product ,' )');
			SET QUERY1_2 = CONCAT(QUERY1_2,' AND (pr.productid = ', product ,' )');
			SET QUERY2_1 = CONCAT(QUERY2_1,' AND (pr.productid = ', product ,' )');
			SET QUERY2_2 = CONCAT(QUERY2_2,' AND (pr.productid = ', product ,' )');
			SET QUERY3_1 = CONCAT(QUERY3_1,' AND (pr.productid = ', product ,' )');
			SET QUERY3_2 = CONCAT(QUERY3_2,' AND (pr.productid = ', product ,' )');
		END IF;
	END IF;

	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1_1 = CONCAT(QUERY1_1,' AND (', col, ' = N\'', val ,'\')');
		SET QUERY1_2 = CONCAT(QUERY1_2,' AND (', col, ' = N\'', val ,'\')');
		SET QUERY2_1 = CONCAT(QUERY2_1,' AND (', col, ' = N\'', val ,'\')');
		SET QUERY2_2 = CONCAT(QUERY2_2,' AND (', col, ' = N\'', val ,'\')');
		SET QUERY3_1 = CONCAT(QUERY3_1,' AND (', col, ' = N\'', val ,'\')');
		SET QUERY3_2 = CONCAT(QUERY3_2,' AND (', col, ' = N\'', val ,'\')');
	END IF;
	
	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1_1 = CONCAT(QUERY1_1,' AND (u.user_name IS NULL)');
		SET QUERY1_2 = CONCAT(QUERY1_2,' AND (u.user_name IS NULL)');
		SET QUERY2_1 = CONCAT(QUERY2_1,' AND (u.user_name IS NULL)');
		SET QUERY2_2 = CONCAT(QUERY2_2,' AND (u.user_name IS NULL)');
		SET QUERY3_1 = CONCAT(QUERY3_1,' AND (u.user_name IS NULL)');
		SET QUERY3_2 = CONCAT(QUERY3_2,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'pcf.cf_987' OR col = 'p.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1_1 = CONCAT(QUERY1_1,' AND (',col,' = '''' )');
		SET QUERY1_2 = CONCAT(QUERY1_2,' AND (',col,' = '''' )');
		SET QUERY2_1 = CONCAT(QUERY2_1,' AND (',col,' = '''' )');
		SET QUERY2_2 = CONCAT(QUERY2_2,' AND (',col,' = '''' )');
		SET QUERY3_1 = CONCAT(QUERY3_1,' AND (',col,' = '''' )');
		SET QUERY3_2 = CONCAT(QUERY3_2,' AND (',col,' = '''' )');
	END IF;
	
	-- Gộp theo ngày và sắp xếp theo ngày từ h về trước
	SET QUERY1_1 = CONCAT(QUERY1_1,'GROUP BY 1 ORDER BY 2 DESC)');
	SET QUERY1_2 = CONCAT(QUERY1_2,'GROUP BY 1 ORDER BY 2 DESC)');
	SET QUERY2_1 = CONCAT(QUERY2_1,'GROUP BY 1 ORDER BY 2 DESC)');
	SET QUERY2_2 = CONCAT(QUERY2_2,'GROUP BY 1 ORDER BY 2 DESC)');
	SET QUERY3_1 = CONCAT(QUERY3_1,'GROUP BY 1 ORDER BY 2 DESC)');
	SET QUERY3_2 = CONCAT(QUERY3_2,'GROUP BY 1 ORDER BY 2 DESC)');

	SET QUERY1 = CONCAT('SELECT t1.`user_name` as ''u.user_name'', CONCAT(ROUND(t2.num/t1.num * 100, 2), ''%'') num, t1.num total FROM ',QUERY1_1,' t1 LEFT JOIN ',QUERY1_2,' t2 ON t1.`user_name` = t2.`user_name` WHERE ROUND(t2.num/t1.num * 100, 2) IS NOT NULL ORDER BY t1.num DESC');
	SET QUERY2 = CONCAT('SELECT t1.`user_name` as ''pcf.cf_985'', CONCAT(ROUND(t2.num/t1.num * 100, 2), ''%'') num, t1.num total FROM ',QUERY2_1,' t1 LEFT JOIN ',QUERY2_2,' t2 ON t1.`user_name` = t2.`user_name` WHERE ROUND(t2.num/t1.num * 100, 2) IS NOT NULL ORDER BY t1.num DESC');
	SET QUERY3 = CONCAT('SELECT t1.`user_name` as ''pcf.cf_901'', CONCAT(ROUND(t2.num/t1.num * 100, 2), ''%'') num, t1.num total FROM ',QUERY3_1,' t1 LEFT JOIN ',QUERY3_2,' t2 ON t1.`user_name` = t2.`user_name` WHERE ROUND(t2.num/t1.num * 100, 2) IS NOT NULL ORDER BY t1.num DESC');
	
	IF assign IS NOT NULL THEN
		-- In và khởi chạy query
		SELECT QUERY1;
		SET @SQL := QUERY1;
		PREPARE stmt1 FROM @SQL;
		EXECUTE stmt1;
		DEALLOCATE PREPARE stmt1;
	END IF;
	
	IF mkt IS NOT NULL THEN
		-- In và khởi chạy query
		-- SELECT QUERY2;
		SET @SQL := QUERY2;
		PREPARE stmt2 FROM @SQL;
		EXECUTE stmt2;
		DEALLOCATE PREPARE stmt2;
	END IF;
	
	IF service IS NOT NULL THEN
		-- In và khởi chạy query
		SELECT QUERY3;
		SET @SQL := QUERY3;
		PREPARE stmt3 FROM @SQL;
		EXECUTE stmt3;
		DEALLOCATE PREPARE stmt3;
	END IF;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_potential_by_user_status
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_potential_by_user_status`(
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `user_assign_id` INT,
	IN `user_service` VARCHAR(50),
	IN `user_mkt` VARCHAR(50),
	IN `status` VARCHAR(50),
	IN `sales_stage` VARCHAR(50),
	IN `potential` VARCHAR(100),
	IN `dept` INT,
	IN `product` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300),
	IN `assign` ENUM('Y','N'),
	IN `mkt` ENUM('Y','N'),
	IN `service` ENUM('Y','N')
)
BEGIN
	DECLARE QUERY1 NVARCHAR(4000);
	DECLARE QUERY2 NVARCHAR(4000);
	DECLARE QUERY3 NVARCHAR(4000);
	
	SET QUERY1 = 
		'SELECT
			CASE 
				WHEN u.user_name IS NULL THEN ''Không xác định''
				WHEN u.user_name = '''' THEN ''Trống''
				ELSE u.user_name
			END ''u.user_name'',
			
			CASE 
				WHEN p.sales_stage IS NULL THEN ''Không xác định''
				WHEN p.sales_stage = '''' THEN ''Trống''
				ELSE p.sales_stage
			END ''p.sales_stage'',
				
			COUNT(DISTINCT p.potentialid) ''num''
		FROM
			(((((vtiger_potential p
		INNER JOIN
			vtiger_crmentity c
		ON
			c.crmid = p.potentialid)
		LEFT JOIN
			vtiger_potentialscf pcf
		ON
			p.potentialid = pcf.potentialid)
		LEFT JOIN
			vtiger_users u
		ON
			c.smownerid = u.id)
		LEFT JOIN
			vtiger_seproductsrel pse
		ON
			pse.crmid = c.crmid)
		LEFT JOIN
			vtiger_products pr
		ON
			pr.productid = pse.productid)
		WHERE 
			c.deleted <> 1 AND 1=1 ';
	
	SET QUERY2 = 
		'SELECT
			CASE 
				WHEN pcf.cf_985 = '''' THEN ''Không xác định''
				WHEN pcf.cf_985 = '''' THEN ''Trống''
				ELSE pcf.cf_985
			END ''pcf.cf_985'',
			
			CASE 
				WHEN p.sales_stage IS NULL THEN ''Không xác định''
				WHEN p.sales_stage = '''' THEN ''Trống''
				ELSE p.sales_stage
			END ''p.sales_stage'',
			
			COUNT(DISTINCT p.potentialid) ''num''
		FROM
			(((((vtiger_potential p
		INNER JOIN
			vtiger_crmentity c
		ON
			c.crmid = p.potentialid)
		LEFT JOIN
			vtiger_potentialscf pcf
		ON
			p.potentialid = pcf.potentialid)
		LEFT JOIN
			vtiger_users u
		ON
			c.smownerid = u.id)
		LEFT JOIN
			vtiger_seproductsrel pse
		ON
			pse.crmid = c.crmid)
		LEFT JOIN
			vtiger_products pr
		ON
			pr.productid = pse.productid)
		WHERE 
			c.deleted <> 1 AND 1=1 ';
	
	SET QUERY3 = 
		'SELECT
			CASE 
				WHEN pcf.cf_901 = '''' THEN ''Không xác định''
				WHEN pcf.cf_901 = '''' THEN ''Trống''
				ELSE pcf.cf_901
			END ''pcf.cf_901'',
			
			CASE 
				WHEN p.sales_stage IS NULL THEN ''Không xác định''
				WHEN p.sales_stage = '''' THEN ''Trống''
				ELSE p.sales_stage
			END ''p.sales_stage'',
			
			COUNT(DISTINCT p.potentialid) ''num''
		FROM
			(((((vtiger_potential p
		INNER JOIN
			vtiger_crmentity c
		ON
			c.crmid = p.potentialid)
		LEFT JOIN
			vtiger_potentialscf pcf
		ON
			p.potentialid = pcf.potentialid)
		LEFT JOIN
			vtiger_users u
		ON
			c.smownerid = u.id)
		LEFT JOIN
			vtiger_seproductsrel pse
		ON
			pse.crmid = c.crmid)
		LEFT JOIN
			vtiger_products pr
		ON
			pr.productid = pse.productid)
		WHERE 
			c.deleted <> 1 AND 1=1 ';

	-- 
	CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY2 = CONCAT(QUERY2,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY3 = CONCAT(QUERY3,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
				SET QUERY2 = CONCAT(QUERY2,' ');
				SET QUERY3 = CONCAT(QUERY3,' ');
			END IF;
		
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY2 = CONCAT(QUERY2,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY3 = CONCAT(QUERY3,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
				SET QUERY2 = CONCAT(QUERY2,' ');
				SET QUERY3 = CONCAT(QUERY3,' ');
			END IF;
		
		WHEN date_type = 'Ngày đóng' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (p.closingdate BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY2 = CONCAT(QUERY2,' AND (p.closingdate BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY3 = CONCAT(QUERY3,' AND (p.closingdate BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
				SET QUERY2 = CONCAT(QUERY2,' ');
				SET QUERY3 = CONCAT(QUERY3,' ');
			END IF;
			
	END CASE;
	
	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = ', user_assign_id ,' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (c.smownerid = ', user_assign_id ,' )');
		SET QUERY3 = CONCAT(QUERY3,' AND (c.smownerid = ', user_assign_id ,' )');
		
	END IF;
	
	IF user_service IS NOT NULL THEN 
		IF user_service = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = '''' )');
			SET QUERY2 = CONCAT(QUERY2,' AND (pcf.cf_901 = '''' )');
			SET QUERY3 = CONCAT(QUERY3,' AND (pcf.cf_901 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = \'', user_service ,'\' )');
			SET QUERY2 = CONCAT(QUERY2,' AND (pcf.cf_901 = \'', user_service ,'\' )');
			SET QUERY3 = CONCAT(QUERY3,' AND (pcf.cf_901 = \'', user_service ,'\' )');
		END IF;
	END IF;
	
	IF user_mkt IS NOT NULL THEN 
		IF user_mkt = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = '''' )');
			SET QUERY2 = CONCAT(QUERY2,' AND (pcf.cf_985 = '''' )');
			SET QUERY3 = CONCAT(QUERY3,' AND (pcf.cf_985 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
			SET QUERY2 = CONCAT(QUERY2,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
			SET QUERY3 = CONCAT(QUERY3,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
		END IF;
	END IF;
	
	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_987 = \'', status ,'\' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (pcf.cf_987 = \'', status ,'\' )');
		SET QUERY3 = CONCAT(QUERY3,' AND (pcf.cf_987 = \'', status ,'\' )');
	END IF;
	
	IF sales_stage IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.sales_stage = \'', sales_stage ,'\' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (p.sales_stage = \'', sales_stage ,'\' )');
		SET QUERY3 = CONCAT(QUERY3,' AND (p.sales_stage = \'', sales_stage ,'\' )');
	END IF;
	
	IF potential IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.potentialname = \'', potential ,'\' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (p.potentialname = \'', potential ,'\' )');
		SET QUERY3 = CONCAT(QUERY3,' AND (p.potentialname = \'', potential ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', dept ,'\' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (c.smownerid = \'', dept ,'\' )');
		SET QUERY3 = CONCAT(QUERY3,' AND (c.smownerid = \'', dept ,'\' )');
	END IF;

	IF product IS NOT NULL THEN 
		IF product = 0 THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid IS NULL )');
			SET QUERY2 = CONCAT(QUERY2,' AND (pr.productid IS NULL )');
			SET QUERY3 = CONCAT(QUERY3,' AND (pr.productid IS NULL )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid = ', product ,' )');
			SET QUERY2 = CONCAT(QUERY2,' AND (pr.productid = ', product ,' )');
			SET QUERY3 = CONCAT(QUERY3,' AND (pr.productid = ', product ,' )');
		END IF;
	END IF;

	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
		SET QUERY2 = CONCAT(QUERY2,' AND (', col, ' = N\'', val ,'\')');
		SET QUERY3 = CONCAT(QUERY3,' AND (', col, ' = N\'', val ,'\')');
	END IF;
	
	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
		SET QUERY2 = CONCAT(QUERY2,' AND (u.user_name IS NULL)');
		SET QUERY3 = CONCAT(QUERY3,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'pcf.cf_987' OR col = 'p.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (',col,' = '''' )');
		SET QUERY3 = CONCAT(QUERY3,' AND (',col,' = '''' )');
	END IF;
	
	-- Gộp theo ngày và sắp xếp theo ngày từ h về trước
	SET QUERY1 = CONCAT(QUERY1,'GROUP BY 1,2 ORDER BY 3 DESC');
	SET QUERY2 = CONCAT(QUERY2,'GROUP BY 1,2 ORDER BY 3 DESC');
	SET QUERY3 = CONCAT(QUERY3,'GROUP BY 1,2 ORDER BY 3 DESC');

	
	IF assign IS NOT NULL THEN
		-- In và khởi chạy query
		-- SELECT QUERY1;
		SET @SQL := QUERY1;
		PREPARE stmt1 FROM @SQL;
		EXECUTE stmt1;
		DEALLOCATE PREPARE stmt1;
	END IF;
	
	IF mkt IS NOT NULL THEN
		-- In và khởi chạy query
		-- SELECT QUERY2;
		SET @SQL := QUERY2;
		PREPARE stmt2 FROM @SQL;
		EXECUTE stmt2;
		DEALLOCATE PREPARE stmt2;
	END IF;
	
	IF service IS NOT NULL THEN
		-- In và khởi chạy query
		SELECT QUERY3;
		SET @SQL := QUERY3;
		PREPARE stmt3 FROM @SQL;
		EXECUTE stmt3;
		DEALLOCATE PREPARE stmt3;
	END IF;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_potential_comment_detail
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_potential_comment_detail`(
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `user_assign_id` INT,
	IN `user_service` VARCHAR(50),
	IN `user_mkt` VARCHAR(50),
	IN `status` VARCHAR(50),
	IN `sales_stage` VARCHAR(50),
	IN `potential` VARCHAR(100),
	IN `dept` INT,
	IN `product` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300)



)
BEGIN
	
	DECLARE QUERY1 NVARCHAR(4000);
	DECLARE QUERY2 NVARCHAR(4000);
	DECLARE QUERY NVARCHAR(4000);
	
	SET QUERY1 = 
	'(SELECT
		CONCAT(''['',p.potentialname , '' ('',p.potential_no, '')'', '']'',''(http://crm.fastdn.com.vn/index.php?module=Potentials&view=Detail&record='',p.potentialid,''&app=SALES)'') ''company'',
		CASE 
			WHEN u.user_name IS NULL THEN ''Không xác định''
			WHEN u.user_name = '''' THEN ''Trống''
			ELSE u.user_name
		END ''u.user_name'', 
		m.modcommentsid id,
		CONCAT(u.last_name, '' '', u.first_name) name,
		m.commentcontent content,
		c.createdtime time
	FROM
		((((((vtiger_potential p
	INNER JOIN
		vtiger_crmentity c
	ON
		c.crmid = p.potentialid)
	INNER JOIN
		vtiger_modcomments m
	ON
		m.related_to = p.potentialid)
	LEFT JOIN
		vtiger_potentialscf pcf
	ON
		p.potentialid = pcf.potentialid)
	LEFT JOIN
		vtiger_users u
	ON
		c.smownerid = u.id)
	LEFT JOIN
		vtiger_seproductsrel pse
	ON
		pse.crmid = c.crmid)
	LEFT JOIN
		vtiger_products pr
	ON
		pr.productid = pse.productid)
	WHERE 
		m.parent_comments = 0 AND c.deleted = 0 AND 1=1 ';
	
	SET QUERY2 = 
	'(SELECT
		CONCAT(''['',p.potentialname , '' ('',p.potential_no, '')'', '']'',''(http://uatcrm.fastdn.com.vn/index.php?module=Potentials&view=Detail&record='',p.potentialid,''&app=SALES)'') ''company'',
		CASE 
			WHEN u.user_name IS NULL THEN ''Không xác định''
			WHEN u.user_name = '''' THEN ''Trống''
			ELSE u.user_name
		END ''u.user_name'', 
		m.modcommentsid id,
		CONCAT(u.last_name, '' '', u.first_name) name,
		m.commentcontent content,
		c.createdtime time
	FROM
		((((((vtiger_potential p
	INNER JOIN
		vtiger_crmentity c
	ON
		c.crmid = p.potentialid)
	INNER JOIN
		vtiger_modcomments m
	ON
		m.related_to = p.potentialid)
	LEFT JOIN
		vtiger_potentialscf pcf
	ON
		p.potentialid = pcf.potentialid)
	LEFT JOIN
		vtiger_users u
	ON
		c.smownerid = u.id)
	LEFT JOIN
		vtiger_seproductsrel pse
	ON
		pse.crmid = c.crmid)
	LEFT JOIN
		vtiger_products pr
	ON
		pr.productid = pse.productid)
	WHERE 
		m.parent_comments <> 0 AND c.deleted = 0 AND 1=1 ';
	
	CASE 
	
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY2 = CONCAT(QUERY2,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
				SET QUERY2 = CONCAT(QUERY2,' ');
			END IF;
			
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY2 = CONCAT(QUERY2,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
				SET QUERY2 = CONCAT(QUERY2,' ');
			END IF;	
		
		WHEN date_type = 'Ngày đóng' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (p.closingdate BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
				SET QUERY2 = CONCAT(QUERY2,' AND (p.closingdate BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
				SET QUERY2 = CONCAT(QUERY2,' ');
			END IF;
			
	END CASE;
	
	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', user_assign_id ,'\' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (c.smownerid = \'', user_assign_id ,'\' )');
	END IF;
	
	IF user_service IS NOT NULL THEN 
		IF user_service = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = '''' )');
			SET QUERY2 = CONCAT(QUERY2,' AND (pcf.cf_901 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = \'', user_service ,'\' )');
			SET QUERY2 = CONCAT(QUERY2,' AND (pcf.cf_901 = \'', user_service ,'\' )');
		END IF;
	END IF;
	
	IF user_mkt IS NOT NULL THEN 
		IF user_mkt = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = '''' )');
			SET QUERY2 = CONCAT(QUERY2,' AND (pcf.cf_985 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
			SET QUERY2 = CONCAT(QUERY2,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
		END IF;
	END IF;
	
	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_987 = \'', status ,'\' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (pcf.cf_987 = \'', status ,'\' )');
	END IF;
	
	IF sales_stage IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.sales_stage = \'', sales_stage ,'\' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (p.sales_stage = \'', sales_stage ,'\' )');
	END IF;
	
	IF potential IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.potentialname = \'', potential ,'\' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (p.potentialname = \'', potential ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = ', dept ,' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (c.smownerid = ', dept ,' )');
	END IF;
	
	IF product IS NOT NULL THEN 
		IF product = 0 THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid IS NULL )');
			SET QUERY2 = CONCAT(QUERY2,' AND (pr.productid IS NULL )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid = ', product ,' )');
			SET QUERY2 = CONCAT(QUERY2,' AND (pr.productid = ', product ,' )');
		END IF;
	END IF;
	
	-- col, val
	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
		SET QUERY2 = CONCAT(QUERY2,' AND (', col, ' = N\'', val ,'\')');
	END IF;	

	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
		SET QUERY2 = CONCAT(QUERY2,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'pcf.cf_987' OR col = 'p.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (',col,' = '''' )');
	END IF;
	
	SET QUERY1 = CONCAT(QUERY1,')');
	SET QUERY2 = CONCAT(QUERY2,')');
	
	SET QUERY = CONCAT('
	SELECT 
		t1.company,
		t1.`u.user_name`,
		CONCAT(t1.name,'': '',t1.content) comment,
		GROUP_CONCAT(t2.name, '': '', t2.content SEPARATOR ''\n'') answer
	FROM ', QUERY1, 'as t1 LEFT JOIN ', QUERY2,' as t2 ON t1.id = t2.id GROUP BY 1, 2 ORDER BY t1.time, t2.time');
	
	-- In và khởi chạy query
	SELECT QUERY;
	SET @SQL := QUERY;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_potential_ddl_all
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_potential_ddl_all`(
	IN `id_ddl` VARCHAR(50)
)
BEGIN
	IF id_ddl = 'ddl_potential_company' THEN
		CALL `dsa_potential_ddl_company`;
	END IF;
	
	IF id_ddl = 'ddl_potential_dept' THEN
		CALL `dsa_potential_ddl_dept`;
	END IF;
	
	IF id_ddl = 'ddl_potential_product' THEN
		CALL `dsa_potential_ddl_product`;
	END IF;
	
	IF id_ddl = 'ddl_potential_status' THEN
		CALL `dsa_potential_ddl_status`;
	END IF;
	
	IF id_ddl = 'ddl_potential_assign' THEN
		CALL `dsa_potential_ddl_user_assign`;
	END IF;
	
	IF id_ddl = 'ddl_potential_mkt' THEN
		CALL `dsa_potential_ddl_user_mkt`;
	END IF;
	
	IF id_ddl = 'ddl_potential_service' THEN
		CALL `dsa_potential_ddl_user_service`;
	END IF;
	
	IF id_ddl = 'ddl_potential_sales_stage' THEN
		CALL `dsa_potential_ddl_sales_stage`;
	END IF;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_potential_ddl_company
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_potential_ddl_company`()
BEGIN

	SELECT 
		p.potentialname 
	FROM
		vtiger_potential p 
	INNER JOIN
		vtiger_crmentity c 
	ON
		c.crmid = p.potentialid
	WHERE
		c.deleted = 0;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_potential_ddl_dept
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_potential_ddl_dept`()
BEGIN
	SELECT
		g.groupid,
		CONCAT(g.groupname,' (', g.groupid,')')
	FROM
		vtiger_groups g;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_potential_ddl_product
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_potential_ddl_product`()
BEGIN

	SELECT 
		pr.productid,
		pr.productname
	FROM
		vtiger_products pr
	INNER JOIN
		vtiger_crmentity c 
	ON
		c.crmid = pr.productid
	WHERE
		c.deleted = 0;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_potential_ddl_sales_stage
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_potential_ddl_sales_stage`()
BEGIN

	SELECT 
		DISTINCT p.sales_stage
	FROM
		vtiger_potential p 
	INNER JOIN
		vtiger_crmentity c 
	ON
		c.crmid = p.potentialid
	WHERE
		c.deleted = 0;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_potential_ddl_status
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_potential_ddl_status`()
BEGIN

	SELECT 
		DISTINCT CASE 
			WHEN pcf.cf_987 = '' THEN 'Không xác định' 
			WHEN pcf.cf_987 IS NULL THEN 'Trống'
			ELSE pcf.cf_987 END
	FROM
		((vtiger_potential p 
	INNER JOIN
		vtiger_crmentity c 
	ON
		c.crmid = p.potentialid)
	LEFT JOIN
		vtiger_potentialscf pcf
	ON
		pcf.potentialid = p.potentialid) 
	WHERE
		c.deleted = 0;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_potential_ddl_user_assign
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_potential_ddl_user_assign`()
BEGIN

	SELECT
		u.id,
		CONCAT(u.last_name,' ', u.first_name, ' (', u.user_name, ')') 'u.name'
	FROM
		vtiger_users u
	WHERE
		u.deleted = '0';
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_potential_ddl_user_mkt
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_potential_ddl_user_mkt`()
BEGIN
		
	SELECT
		DISTINCT CASE 
			WHEN pcf.cf_985 = '' THEN 'Không xác định'
			WHEN pcf.cf_985 IS NULL THEN 'Trống'
			ELSE pcf.cf_985 END
	FROM
		vtiger_potentialscf pcf;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_potential_ddl_user_service
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_potential_ddl_user_service`()
BEGIN

	SELECT
		DISTINCT CASE 
			WHEN pcf.cf_901 = '' THEN 'Không xác định' 
			WHEN pcf.cf_901 IS NULL THEN 'Trống'
			ELSE pcf.cf_901 END
	FROM
		vtiger_potentialscf pcf;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_potential_delay
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_potential_delay`(
	IN `user_assign_id` INT,
	IN `user_service` VARCHAR(50),
	IN `user_mkt` VARCHAR(50),
	IN `status` VARCHAR(50),
	IN `sales_stage` VARCHAR(50),
	IN `potential` VARCHAR(100),
	IN `dept` INT,
	IN `product` INT,
	IN `days_delay` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300)

)
BEGIN
	
	DECLARE QUERY1 NVARCHAR(4000);
	
	SET QUERY1 = 
	'SELECT
		CONCAT(''['',p.potentialname , '' ('',p.potential_no, '')'', '']'',''(http://crm.fastdn.com.vn/index.php?module=Potentials&view=Detail&record='',p.potentialid,''&app=SALES)'') ''p.potentialname'',
		u.user_name ''u.user_name'',
		p.sales_stage ''p.sales_stage'',
		DATEDIFF(DATE(NOW()), DATE(c.modifiedtime)) ''delay_days''
	FROM
		(((((vtiger_potential p
	INNER JOIN
		vtiger_crmentity c
	ON
		c.crmid = p.potentialid)
	LEFT JOIN
		vtiger_potentialscf pcf
	ON
		p.potentialid = pcf.potentialid)
	LEFT JOIN
		vtiger_users u
	ON
		c.smownerid = u.id)
	LEFT JOIN
		vtiger_seproductsrel pse
	ON
		pse.crmid = c.crmid)
	LEFT JOIN
		vtiger_products pr
	ON
		pr.productid = pse.productid)
	WHERE 
		c.deleted <> 1 AND 1=1 AND p.sales_stage NOT IN (''Closed Won'', ''Closed Lost'') ';
	   
	IF days_delay IS NOT NULL AND days_delay = 7 THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND DATEDIFF(DATE(NOW()), DATE(c.modifiedtime)) BETWEEN 7 AND 15');
	ELSE
		SET QUERY1 = CONCAT(QUERY1,' AND DATEDIFF(DATE(NOW()), DATE(c.modifiedtime)) >= 16');
	END IF;
	
	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', user_assign_id ,'\' )');
	END IF;
	
	IF user_service IS NOT NULL THEN 
		IF user_service = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = \'', user_service ,'\' )');
		END IF;
	END IF;
	
	IF user_mkt IS NOT NULL THEN 
		IF user_mkt = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
		END IF;
	END IF;
	
	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_987 = \'', status ,'\' )');
	END IF;
	
	IF sales_stage IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.sales_stage = \'', sales_stage ,'\' )');
	END IF;
	
	IF potential IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.potentialname = \'', potential ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = ', dept ,' )');
	END IF;
	
	IF product IS NOT NULL THEN 
		IF product = 0 THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid IS NULL )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid = ', product ,' )');
		END IF;
	END IF;
	
	-- col, val
	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
	END IF;	

	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'pcf.cf_987' OR col = 'p.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
	END IF;
	
	SET QUERY1 = CONCAT(QUERY1,' ORDER BY 4 DESC');
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_potential_delay_2
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_potential_delay_2`(
	IN `user_assign_id` INT,
	IN `user_service` VARCHAR(50),
	IN `user_mkt` VARCHAR(50),
	IN `status` VARCHAR(50),
	IN `sales_stage` VARCHAR(50),
	IN `potential` VARCHAR(100),
	IN `dept` INT,
	IN `product` INT,
	IN `start_prob` INT,
	IN `end_prob` INT,
	IN `start_prob2` INT,
	IN `end_prob2` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300)


)
BEGIN
	
	DECLARE QUERY1 NVARCHAR(4000);
	
	SET QUERY1 = 
	'SELECT
		CONCAT(''['',p.potentialname , '' ('',p.potential_no, '')'', '']'',''(http://crm.fastdn.com.vn/index.php?module=Potentials&view=Detail&record='',p.potentialid,''&app=SALES)'') ''p.potentialname'',
		u.user_name ''u.user_name'',
		p.sales_stage ''p.sales_stage'',
		TIMESTAMPDIFF(MONTH, DATE(c.createdtime),NOW()) ''delay_days'',
		TIMESTAMPDIFF(MONTH, DATE(p.closingdate),NOW()) ''delay_days_2''
	FROM
		(((((vtiger_potential p
	INNER JOIN
		vtiger_crmentity c
	ON
		c.crmid = p.potentialid)
	LEFT JOIN
		vtiger_potentialscf pcf
	ON
		p.potentialid = pcf.potentialid)
	LEFT JOIN
		vtiger_users u
	ON
		c.smownerid = u.id)
	LEFT JOIN
		vtiger_seproductsrel pse
	ON
		pse.crmid = c.crmid)
	LEFT JOIN
		vtiger_products pr
	ON
		pr.productid = pse.productid)
	WHERE 
		c.deleted <> 1 AND 1=1 AND p.sales_stage NOT IN (''Closed Won'', ''Closed Lost'') ';
	
	IF start_prob IS NOT NULL AND end_prob IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (TIMESTAMPDIFF(MONTH, DATE(c.createdtime),NOW()) BETWEEN ',start_prob,' AND ', end_prob,' ) ' );
	END IF;

	IF start_prob2 IS NOT NULL AND end_prob2 IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (TIMESTAMPDIFF(MONTH, DATE(p.closingdate),NOW()) BETWEEN ',start_prob2,' AND ', end_prob2,' ) ' );
	END IF;
	
	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', user_assign_id ,'\' )');
	END IF;
	
	IF user_service IS NOT NULL THEN 
		IF user_service = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = \'', user_service ,'\' )');
		END IF;
	END IF;
	
	IF user_mkt IS NOT NULL THEN 
		IF user_mkt = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
		END IF;
	END IF;
	
	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_987 = \'', status ,'\' )');
	END IF;
	
	IF sales_stage IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.sales_stage = \'', sales_stage ,'\' )');
	END IF;
	
	IF potential IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.potentialname = \'', potential ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = ', dept ,' )');
	END IF;
	
	IF product IS NOT NULL THEN 
		IF product = 0 THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid IS NULL )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid = ', product ,' )');
		END IF;
	END IF;
	
	-- col, val
	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
	END IF;	

	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'pcf.cf_987' OR col = 'p.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
	END IF;
	
	SET QUERY1 = CONCAT(QUERY1,' ORDER BY 4 DESC');
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_potential_detail
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_potential_detail`(
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `user_assign_id` INT,
	IN `user_service` VARCHAR(50),
	IN `user_mkt` VARCHAR(50),
	IN `status` VARCHAR(50),
	IN `sales_stage` VARCHAR(50),
	IN `potential` VARCHAR(100),
	IN `dept` INT,
	IN `product` INT,
	IN `start_prob` INT,
	IN `end_prob` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300)


)
BEGIN
	
	DECLARE QUERY1 NVARCHAR(4000);
	
	SET QUERY1 = 
	'SELECT
		CONCAT(''['',p.potentialname , '' ('',p.potential_no, '')'', '']'',''(http://crm.fastdn.com.vn/index.php?module=Potentials&view=Detail&record='',p.potentialid,''&app=SALES)'') ''p.potentialname'',
		
		COUNT(DISTINCT s.activityid) ''num_ac'',
		
		p.sales_stage ''p.sales_stage'',	
		
		CASE 
			WHEN u.user_name IS NULL THEN ''Không xác định''
			WHEN u.user_name = '''' THEN ''Trống''
			ELSE u.user_name
		END ''u.user_name'', 
		
		pcf.cf_901 ''pcf.cf_901'',
		
		pcf.cf_985 ''pcf.cf_985'',
		
		p.probability ''p.probability'',
		
		CASE 
			WHEN pcf.cf_987 IS NULL THEN ''Trống''
			WHEN pcf.cf_987 = '''' THEN ''Không xác định''
			ELSE pcf.cf_987
		END ''pcf.cf_987'', 
		
		c.createdtime ''c.createdtime'',
		
		c.modifiedtime ''c.modifiedtime'',
		
		p.closingdate ''p.closingdate''
		
	FROM
		((((((vtiger_potential p
	INNER JOIN
		vtiger_crmentity c
	ON
		c.crmid = p.potentialid)
	LEFT JOIN
		vtiger_potentialscf pcf
	ON
		p.potentialid = pcf.potentialid)
	LEFT JOIN
		vtiger_users u
	ON
		c.smownerid = u.id)
	LEFT JOIN
		vtiger_seproductsrel pse
	ON
		pse.crmid = c.crmid)
	LEFT JOIN
		vtiger_products pr
	ON
		pr.productid = pse.productid)
	LEFT JOIN
		vtiger_seactivityrel s
	ON
		s.crmid = c.crmid)
	WHERE 
		c.deleted <> 1 AND 1=1 ';
	
   CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
		
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
		
		WHEN date_type = 'Ngày đóng' THEN 
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (p.closingdate BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )');
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
	END CASE;
	
	IF start_prob IS NOT NULL AND end_prob IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (p.probability BETWEEN ',start_prob,' AND ', end_prob,' ) ' );
	END IF;
	
	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', user_assign_id ,'\' )');
	END IF;
	
	IF user_service IS NOT NULL THEN 
		IF user_service = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = \'', user_service ,'\' )');
		END IF;
	END IF;
	
	IF user_mkt IS NOT NULL THEN 
		IF user_mkt = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
		END IF;
	END IF;
	
	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_987 = \'', status ,'\' )');
	END IF;
	
	IF sales_stage IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.sales_stage = \'', sales_stage ,'\' )');
	END IF;
	
	IF potential IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.potentialname = \'', potential ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = ', dept ,' )');
	END IF;
	
	IF product IS NOT NULL THEN 
		IF product = 0 THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid IS NULL )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid = ', product ,' )');
		END IF;
	END IF;
	
	-- col, val
	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
	END IF;	

	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'pcf.cf_987' OR col = 'p.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
	END IF;
	
	SET QUERY1 = CONCAT(QUERY1,'GROUP BY 1,3,4,5,6,7,8,9,10 ORDER BY c.createdtime DESC');
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_potential_total_potential
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_potential_total_potential`(
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `user_assign_id` INT,
	IN `user_service` VARCHAR(50),
	IN `user_mkt` VARCHAR(50),
	IN `status` VARCHAR(50),
	IN `sales_stage` VARCHAR(50),
	IN `potential` VARCHAR(100),
	IN `dept` INT,
	IN `product` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300)
)
BEGIN
	
	DECLARE QUERY1 NVARCHAR(4000);
	
	SET QUERY1 = 
	'SELECT
		COUNT(DISTINCT p.potentialid) as total_potential
	FROM
		(((((vtiger_potential p
	INNER JOIN
		vtiger_crmentity c
	ON
		c.crmid = p.potentialid)
	LEFT JOIN
		vtiger_potentialscf pcf
	ON
		p.potentialid = pcf.potentialid)
	LEFT JOIN
		vtiger_users u
	ON
		c.smownerid = u.id)
	LEFT JOIN
		vtiger_seproductsrel pse
	ON
		pse.crmid = c.crmid)
	LEFT JOIN
		vtiger_products pr
	ON
		pr.productid = pse.productid)
	WHERE 
		c.deleted <> 1 AND 1=1 ';
	   
   CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
		
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
		
		WHEN date_type = 'Ngày đóng' THEN 
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (p.closingdate BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )');
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
	END CASE;
	
	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', user_assign_id ,'\' )');
	END IF;
	
	IF user_service IS NOT NULL THEN 
		IF user_service = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = \'', user_service ,'\' )');
		END IF;
	END IF;
	
	IF user_mkt IS NOT NULL THEN 
		IF user_mkt = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
		END IF;
	END IF;
	
	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_987 = \'', status ,'\' )');
	END IF;
	
	IF sales_stage IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.sales_stage = \'', sales_stage ,'\' )');
	END IF;
	
	IF potential IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.potentialname = \'', potential ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = ', dept ,' )');
	END IF;
	
	IF product IS NOT NULL THEN 
		IF product = 0 THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid IS NULL )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid = ', product ,' )');
		END IF;
	END IF;
	
	-- col, val
	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
	END IF;	

	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'pcf.cf_987' OR col = 'p.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
	END IF;
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_potential_total_potential_lost
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_potential_total_potential_lost`(
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `user_assign_id` INT,
	IN `user_service` VARCHAR(50),
	IN `user_mkt` VARCHAR(50),
	IN `status` VARCHAR(50),
	IN `sales_stage` VARCHAR(50),
	IN `potential` VARCHAR(100),
	IN `dept` INT,
	IN `product` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300)
)
BEGIN
	
	DECLARE QUERY1 NVARCHAR(4000);
	
	SET QUERY1 = 
	'SELECT
		COUNT(DISTINCT p.potentialid) as total_potential_lost
	FROM
		(((((vtiger_potential p
	INNER JOIN
		vtiger_crmentity c
	ON
		c.crmid = p.potentialid)
	LEFT JOIN
		vtiger_potentialscf pcf
	ON
		p.potentialid = pcf.potentialid)
	LEFT JOIN
		vtiger_users u
	ON
		c.smownerid = u.id)
	LEFT JOIN
		vtiger_seproductsrel pse
	ON
		pse.crmid = c.crmid)
	LEFT JOIN
		vtiger_products pr
	ON
		pr.productid = pse.productid)
	WHERE 
		c.deleted <> 1 AND p.sales_stage = ''Closed Lost'' AND 1=1 ';
	   
   CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
		
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
		
		WHEN date_type = 'Ngày đóng' THEN 
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (p.closingdate BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )');
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
	END CASE;
	
	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', user_assign_id ,'\' )');
	END IF;
	
	IF user_service IS NOT NULL THEN 
		IF user_service = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = \'', user_service ,'\' )');
		END IF;
	END IF;
	
	IF user_mkt IS NOT NULL THEN 
		IF user_mkt = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
		END IF;
	END IF;
	
	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_987 = \'', status ,'\' )');
	END IF;
	
	IF sales_stage IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.sales_stage = \'', sales_stage ,'\' )');
	END IF;
	
	IF potential IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.potentialname = \'', potential ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = ', dept ,' )');
	END IF;
	
	IF product IS NOT NULL THEN 
		IF product = 0 THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid IS NULL )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid = ', product ,' )');
		END IF;
	END IF;
	
	-- col, val
	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
	END IF;	

	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'pcf.cf_987' OR col = 'p.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
	END IF;
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_potential_total_potential_sale
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_potential_total_potential_sale`(
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `user_assign_id` INT,
	IN `user_service` VARCHAR(50),
	IN `user_mkt` VARCHAR(50),
	IN `status` VARCHAR(50),
	IN `sales_stage` VARCHAR(50),
	IN `potential` VARCHAR(100),
	IN `dept` INT,
	IN `product` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300)
)
BEGIN
	
	DECLARE QUERY1 NVARCHAR(4000);
	
	SET QUERY1 = 
	'SELECT
		COUNT(DISTINCT p.potentialid) as total_potential_sale
	FROM
		(((((vtiger_potential p
	INNER JOIN
		vtiger_crmentity c
	ON
		c.crmid = p.potentialid)
	LEFT JOIN
		vtiger_potentialscf pcf
	ON
		p.potentialid = pcf.potentialid)
	LEFT JOIN
		vtiger_users u
	ON
		c.smownerid = u.id)
	LEFT JOIN
		vtiger_seproductsrel pse
	ON
		pse.crmid = c.crmid)
	LEFT JOIN
		vtiger_products pr
	ON
		pr.productid = pse.productid)
	WHERE 
		c.deleted <> 1 AND p.sales_stage NOT IN (''Closed Lost'', ''Closed Won'') AND 1=1 ';
	   
   CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
		
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
		
		WHEN date_type = 'Ngày đóng' THEN 
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (p.closingdate BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )');
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
	END CASE;
	
	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', user_assign_id ,'\' )');
	END IF;
	
	IF user_service IS NOT NULL THEN 
		IF user_service = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = \'', user_service ,'\' )');
		END IF;
	END IF;
	
	IF user_mkt IS NOT NULL THEN 
		IF user_mkt = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
		END IF;
	END IF;
	
	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_987 = \'', status ,'\' )');
	END IF;
	
	IF sales_stage IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.sales_stage = \'', sales_stage ,'\' )');
	END IF;
	
	IF potential IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.potentialname = \'', potential ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = ', dept ,' )');
	END IF;
	
	IF product IS NOT NULL THEN 
		IF product = 0 THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid IS NULL )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid = ', product ,' )');
		END IF;
	END IF;
	
	-- col, val
	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
	END IF;	

	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'pcf.cf_987' OR col = 'p.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
	END IF;
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_potential_total_potential_won
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_potential_total_potential_won`(
	IN `date_type` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `user_assign_id` INT,
	IN `user_service` VARCHAR(50),
	IN `user_mkt` VARCHAR(50),
	IN `status` VARCHAR(50),
	IN `sales_stage` VARCHAR(50),
	IN `potential` VARCHAR(100),
	IN `dept` INT,
	IN `product` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300)
)
BEGIN
	
	DECLARE QUERY1 NVARCHAR(4000);
	
	SET QUERY1 = 
	'SELECT
		COUNT(DISTINCT p.potentialid) as total_potential_won
	FROM
		(((((vtiger_potential p
	INNER JOIN
		vtiger_crmentity c
	ON
		c.crmid = p.potentialid)
	LEFT JOIN
		vtiger_potentialscf pcf
	ON
		p.potentialid = pcf.potentialid)
	LEFT JOIN
		vtiger_users u
	ON
		c.smownerid = u.id)
	LEFT JOIN
		vtiger_seproductsrel pse
	ON
		pse.crmid = c.crmid)
	LEFT JOIN
		vtiger_products pr
	ON
		pr.productid = pse.productid)
	WHERE 
		c.deleted <> 1 AND p.sales_stage = ''Closed Won'' AND 1=1 ';
	   
   CASE 
		WHEN date_type = 'Ngày tạo' OR date_type IS NULL THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.createdtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
		
		WHEN date_type = 'Ngày chỉnh sửa' THEN
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (c.modifiedtime BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
		
		WHEN date_type = 'Ngày đóng' THEN 
			IF start_date IS NOT NULL AND end_date IS NOT NULL THEN 
				SET QUERY1 = CONCAT(QUERY1,' AND (p.closingdate BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )');
			ELSE
				SET QUERY1 = CONCAT(QUERY1,' ');
			END IF;
	END CASE;
	
	IF user_assign_id IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = \'', user_assign_id ,'\' )');
	END IF;
	
	IF user_service IS NOT NULL THEN 
		IF user_service = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_901 = \'', user_service ,'\' )');
		END IF;
	END IF;
	
	IF user_mkt IS NOT NULL THEN 
		IF user_mkt = '' THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = '''' )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_985 = \'', user_mkt ,'\' )');
		END IF;
	END IF;
	
	IF status IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (pcf.cf_987 = \'', status ,'\' )');
	END IF;
	
	IF sales_stage IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.sales_stage = \'', sales_stage ,'\' )');
	END IF;
	
	IF potential IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (p.potentialname = \'', potential ,'\' )');
	END IF;
	
	IF dept IS NOT NULL THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (c.smownerid = ', dept ,' )');
	END IF;
	
	IF product IS NOT NULL THEN 
		IF product = 0 THEN
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid IS NULL )');
		ELSE
			SET QUERY1 = CONCAT(QUERY1,' AND (pr.productid = ', product ,' )');
		END IF;
	END IF;
	
	-- col, val
	IF col IS NOT NULL AND val <> 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' = N\'', val ,'\')');
	END IF;	

	IF col ='u.user_name' AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (u.user_name IS NULL)');
	END IF;
	
	IF (col = 'pcf.cf_987' OR col = 'p.leadsource') AND val = 'Không xác định' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (',col,' = '''' )');
	END IF;
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_support_all
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_support_all`(
	IN `id_proc` VARCHAR(50),
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `account_status` VARCHAR(50),
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `status` VARCHAR(50),
	IN `delay_day` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
   /*Overview*/
	IF id_proc = 'ov_support' THEN
		CALL dsa_support_total_support(timetype,start_date,end_date,account_id,account_status,user_assign,dept_id,status,col,val);
	END IF;
	
	IF id_proc = 'ov_support_open' THEN
		CALL dsa_support_total_support_open(timetype,start_date,end_date,account_id,account_status,user_assign,dept_id,status,col,val);
	END IF;
	
	IF id_proc = 'ov_support_closed' THEN
		CALL dsa_support_total_support_closed(timetype,start_date,end_date,account_id,account_status,user_assign,dept_id,status,col,val);
	END IF;
	
	/*Bar chart*/
	
		/*Users*/
	IF id_proc = 'user_assign' THEN
		CALL dsa_support_user(timetype,start_date,end_date,account_id,account_status,user_assign,dept_id,status,col,val);
	END IF;
	
		/*Status*/
	IF id_proc = 'status' THEN
		CALL dsa_support_status(timetype,start_date,end_date,account_id,account_status,user_assign,dept_id,status,col,val);
	END IF;
		
	
	
	/*Table*/
		/*Delay*/
	IF id_proc = 'detail_delay' THEN
		CALL dsa_support_detail_delay(account_id,account_status,user_assign,dept_id,status,delay_day,col,val);
	END IF;
	
	IF id_proc = 'detail' THEN
		CALL dsa_support_detail(timetype,start_date,end_date,account_id,account_status,user_assign,dept_id,status,col,val);
	END IF;
	
	/*Line chart*/
	IF id_proc = 'support_day' THEN
		CALL dsa_support_day(timetype,start_date,end_date,account_id,account_status,user_assign,dept_id,status,col,val);
	END IF;
	
	IF id_proc = 'support_month' THEN
		CALL dsa_support_month(timetype,start_date,end_date,account_id,account_status,user_assign,dept_id,status,col,val);
	END IF;
	
	IF id_proc = 'support_quarter' THEN
		CALL dsa_support_quarter(timetype,start_date,end_date,account_id,account_status,user_assign,dept_id,status,col,val);
	END IF;
	
	IF id_proc = 'support_year' THEN
		CALL dsa_support_year(timetype,start_date,end_date,account_id,account_status,user_assign,dept_id,status,col,val);
	END IF;
	
	/*Pie chart*/
	IF id_proc = 'location' THEN
		CALL dsa_support_location(timetype,start_date,end_date,account_id,account_status,user_assign,dept_id,status,col,val);
	END IF;
	
	IF id_proc = 'priority' THEN
		CALL dsa_support_priority(timetype,start_date,end_date,account_id,account_status,user_assign,dept_id,status,col,val);
	END IF;
	
		
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_support_day
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_support_day`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `account_status` VARCHAR(50),
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `status` VARCHAR(50),
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery_1 nvarchar(4000);
	DECLARE myquery_2 nvarchar(4000);
	
	
	SET myquery_1 = CONCAT('SELECT CONCAT(Day(c.createdtime),''/'',Month(c.createdtime),''/'', Year(c.createdtime)) day, COUNT(DISTINCT t.ticketid) num
								FROM vtiger_crmentity c 
	
								JOIN (SELECT ticketid,ticket_no,parent_id,
												(CASE WHEN priority= ''High'' THEN ''Cao''
													WHEN priority != '''' THEN priority
													ELSE ''Không xác định'' END) AS ''priority'',
													
												(CASE WHEN status = ''Closed'' THEN ''Đã hoàn thành''
													WHEN status = ''In Progress'' THEN ''Đang xử lý''
													WHEN status = ''Open'' OR status = ''Mở'' THEN ''Đang mở''
													WHEN status = ''Wait For Response'' THEN ''Chờ phản hồi''
													WHEN status IS NOT NULL THEN status
													ELSE ''Không xác định'' END) AS ''status'',
												category,title
										FROM vtiger_troubletickets) t
								ON t.ticketid = c.crmid
								
								JOIN (SELECT ticketid, 
												(CASE WHEN cf_893 IS NULL OR cf_893 = '''' THEN ''Không xác định''
														ELSE cf_893 END) AS ''cf_893''
										FROM vtiger_ticketcf) tcf
								ON tcf.ticketid = t.ticketid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = t.parent_id
								
								LEFT JOIN vtiger_users u
								ON u.id = c.smownerid
								
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = u.id
								
								LEFT JOIN (SELECT accountid, 
												(CASE WHEN cf_891 IS NULL OR cf_891 = '''' THEN ''Không xác định'' 
														ELSE cf_891 END) AS ''cf_891''
										FROM vtiger_accountscf ) a
								ON a.accountid = t.parent_id 
																 
								WHERE 1=1');
								
								
	SET myquery_2 = CONCAT('SELECT CONCAT(Day(c.modifiedtime),''/'',Month(c.modifiedtime),''/'', Year(c.modifiedtime)) day, COUNT(DISTINCT t.ticketid) num
								FROM vtiger_crmentity c 
	
								JOIN (SELECT ticketid,ticket_no,parent_id,priority,
												(CASE WHEN status = ''Closed'' THEN ''Đã đóng''
													WHEN status = ''In Progress'' THEN ''Đang xử lý''
													WHEN status = ''Open'' THEN ''Mở''
													WHEN status = ''Wait For Response'' THEN ''Đợi phản hồi''
													WHEN status IS NOT NULL THEN status
													ELSE ''Không xác định'' END) AS ''status'',
												category,title
								FROM vtiger_troubletickets) t
								ON t.ticketid = c.crmid
								
								JOIN (SELECT ticketid, 
												(CASE WHEN cf_893 IS NULL OR cf_893 = '''' THEN ''Không xác định''
														ELSE cf_893 END) AS ''cf_893''
										FROM vtiger_ticketcf) tcf
								ON tcf.ticketid = t.ticketid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = t.parent_id
								
								LEFT JOIN vtiger_users u
								ON u.id = c.smownerid
								
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = u.id
								
								LEFT JOIN (SELECT accountid, 
												(CASE WHEN cf_891 IS NULL OR cf_891 = '''' THEN ''Không xác định'' 
														ELSE cf_891 END) AS ''cf_891''
										FROM vtiger_accountscf ) a
								ON a.accountid = t.parent_id 
																		 
								WHERE 1=1');
							

	SET myquery_1 = CONCAT(myquery_1, ' AND c.deleted = ''0''');
	SET myquery_1 = CONCAT(myquery_1, ' AND c2.deleted = ''0''');
	SET myquery_2 = CONCAT(myquery_2, ' AND c.deleted = ''0''');
	SET myquery_2 = CONCAT(myquery_2, ' AND c2.deleted = ''0''');
	
	/*Chọn theo khoảng thời gian*/
	IF (start_date IS NOT NULL AND end_date IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
		SET myquery_2 = CONCAT(myquery_2,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;
	
	/*Chọn theo KH*/
	IF(account_id IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND t.parent_id = ''',account_id,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND t.parent_id = ''',account_id,'''');
	END IF;
	
	/*Chọn theo status KH*/
	IF(account_status IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND a.cf_891 = ''',account_status,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND a.cf_891 = ''',account_status,'''');
	END IF;
	
	/*Chọn theo NV*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.smownerid = ''',user_assign,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo col-val*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery_1 = CONCAT(myquery_1,' AND t.ticketid = ''', val,''' ');
		SET myquery_2 = CONCAT(myquery_2,' AND t.ticketid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c2.label') THEN
		SET myquery_1 = CONCAT(myquery_1,' AND t.parent_id = ''', val,''' ');
		SET myquery_2 = CONCAT(myquery_2,' AND t.parent_id = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label' AND col != 'c2.label')  THEN
		SET myquery_1 = CONCAT(myquery_1,' AND ',col, ' = ''', val,''' ');
		SET myquery_2 = CONCAT(myquery_2,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	
	SET myquery_1 = CONCAT(myquery_1, ' GROUP BY 1 ORDER BY YEAR(c.createdtime), MONTH(c.createdtime), DAY(c.createdtime)');
	SET myquery_2 = CONCAT(myquery_2, ' GROUP BY 1 ORDER BY YEAR(c.modifiedtime), MONTH(c.modifiedtime), DAY(c.modifiedtime)');
	
	
	IF (timetype = 0 OR timetype IS NULL) THEN
		SELECT myquery_1;
		SET @SQL := myquery_1;
	 	PREPARE my_query1 FROM @SQL;
		EXECUTE my_query1;
	ELSEIF (timetype = 1) THEN
		SELECT myquery_2;
		SET @SQL := myquery_2;
	 	PREPARE my_query2 FROM @SQL;
		EXECUTE my_query2;
	END IF;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_support_ddl_account
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_support_ddl_account`()
BEGIN
	DECLARE myquery nvarchar(2000);
	
	SET myquery = CONCAT('SELECT c.crmid, CONCAT(c.label,'' ('', a.account_no, '')'')
								FROM (SELECT accountid,account_no,accountname,
												CASE WHEN industry='''' OR industry IS NULL THEN ''Unknown'' ELSE industry END AS ''industry'',
												annualrevenue,employees,isconvertedfromlead
										FROM vtiger_account) a
								
								JOIN vtiger_crmentity c
								ON c.crmid = a.accountid
								
								WHERE c.deleted = ''0''		
								ORDER BY c.label');
								
	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_support_ddl_account_status
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_support_ddl_account_status`()
BEGIN
	DECLARE myquery nvarchar(2000);
	
	SET myquery = CONCAT('SELECT DISTINCT a.cf_891
								FROM (SELECT accountid, 
												(CASE WHEN cf_891 IS NULL OR cf_891 = '''' THEN ''Không xác định'' 
														ELSE cf_891 END) AS ''cf_891''
										FROM vtiger_accountscf ) a
								
								JOIN vtiger_crmentity c
								ON c.crmid = a.accountid
								
								WHERE c.deleted = ''0''		
								ORDER BY c.label');
								
	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_support_ddl_all
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_support_ddl_all`(
	IN `id_ddl` VARCHAR(50)
)
BEGIN
	IF id_ddl = 'ddl_account' THEN
		CALL dsa_support_ddl_account();
	END IF;
	
	IF id_ddl = 'ddl_dept' THEN
		CALL dsa_support_ddl_dept();
	END IF;

	IF id_ddl = 'ddl_user_assign' THEN
		CALL dsa_support_ddl_user_assign();
	END IF;
	
	IF id_ddl = 'ddl_status' THEN
		CALL dsa_support_ddl_status();
	END IF;
	
	IF id_ddl = 'ddl_account_status' THEN
		CALL dsa_support_ddl_account_status();
	END IF;
	

END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_support_ddl_dept
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_support_ddl_dept`()
BEGIN
	DECLARE myquery nvarchar(2000);

	SET myquery = CONCAT('SELECT g.groupid, g.groupname 
								FROM vtiger_groups g
								ORDER BY g.groupname');
	

	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_support_ddl_status
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_support_ddl_status`()
BEGIN
	DECLARE myquery nvarchar(2000);
	SET myquery = CONCAT('SELECT DISTINCT t.status
								FROM (SELECT CASE WHEN status = ''Closed'' THEN ''Đã hoàn thành''
													WHEN status = ''In Progress'' THEN ''Đang xử lý''
													WHEN status = ''Open'' OR status = ''Mở'' THEN ''Đang mở''
													WHEN status = ''Wait For Response'' THEN ''Chờ phản hồi''
													WHEN status IS NOT NULL THEN status
													ELSE ''Không xác định''END AS ''status''
										FROM vtiger_troubletickets) t');
	

	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_support_ddl_user_assign
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_support_ddl_user_assign`()
BEGIN
	DECLARE myquery nvarchar(2000);
	SET myquery = CONCAT('(SELECT u.id, CONCAT(u.last_name,'' '', u.first_name, '' ('', u.user_name, '')'') AS ''NV_assign''
								FROM vtiger_users u
								WHERE u.deleted = ''0''
								ORDER BY u.user_name)');
	

	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_support_detail
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_support_detail`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `account_status` VARCHAR(50),
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `status` VARCHAR(50),
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(4000);

	SET myquery = CONCAT('SELECT DISTINCT t.ticketid ''t.ticketid'', 
										CONCAT(''['',c.label , '' ('',t.ticket_no, '')'', '']'',''(http://crm.fastdn.com.vn/index.php?module=HelpDesk&view=Detail&record='',t.ticketid,''&app=SUPPORT)'') ''c.label'',
										u.user_name ''u.user_name'',
										t.status ''t.status'',
										t.priority ''t.priority'',
										DATE(c.createdtime) AS ''c.createdtime'',
										DATE(c.modifiedtime) AS ''c.modifiedtime'',
										c2.crmid ''c2.crmid'',
										CONCAT(''['',c2.label ,'']'',''(http://crm.fastdn.com.vn/index.php?module=Accounts&view=Detail&record='',c2.crmid,'')'') ''c2.label''
								FROM vtiger_crmentity c 
	
								JOIN (SELECT ticketid,ticket_no,parent_id,
												(CASE WHEN priority= ''High'' THEN ''Cao''
													WHEN priority != '''' THEN priority
													ELSE ''Không xác định'' END) AS ''priority'',
													
												(CASE WHEN status = ''Closed'' THEN ''Đã hoàn thành''
													WHEN status = ''In Progress'' THEN ''Đang xử lý''
													WHEN status = ''Open'' OR status = ''Mở'' THEN ''Đang mở''
													WHEN status = ''Wait For Response'' THEN ''Chờ phản hồi''
													WHEN status IS NOT NULL THEN status
													ELSE ''Không xác định'' END) AS ''status'',
												category,title
										FROM vtiger_troubletickets) t
								ON t.ticketid = c.crmid
								
								JOIN (SELECT ticketid, 
												(CASE WHEN cf_893 IS NULL OR cf_893 = '''' THEN ''Không xác định''
														ELSE cf_893 END) AS ''cf_893''
										FROM vtiger_ticketcf) tcf
								ON tcf.ticketid = t.ticketid
																
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = t.parent_id
								
								LEFT JOIN vtiger_users u
								ON u.id = c.smownerid
								
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = u.id
								
								LEFT JOIN (SELECT accountid, 
												(CASE WHEN cf_891 IS NULL OR cf_891 = '''' THEN ''Không xác định'' 
														ELSE cf_891 END) AS ''cf_891''
										FROM vtiger_accountscf ) a
								ON a.accountid = t.parent_id 
																		 
								WHERE 1=1');
							

	SET myquery = CONCAT(myquery, ' AND c.deleted = ''0''');
	SET myquery = CONCAT(myquery, ' AND c2.deleted = ''0''');

	/*Chọn theo khoảng thời gian*/
	IF (timetype = 0 OR timetype IS NULL) AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	ELSEIF timetype = 1  AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		  SET myquery = CONCAT(myquery,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' ');
	END IF;
	
	/*Chọn theo KH*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.parent_id = ''',account_id,'''');
	END IF;
		
	/*Chọn theo status KH*/
	IF(account_status IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.cf_891 = ''',account_status,'''');	
	END IF;
	
	/*Chọn theo NV*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ug.groupid = ''',dept_id,'''');
	END IF;
	
	/*Chọn theo trạng thái*/
	IF (status IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.status = ''',status,'''');
	END IF;
	
	/*Chọn theo col-val*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND t.ticketid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c2.label') THEN
		SET myquery = CONCAT(myquery,' AND t.parent_id = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label' AND col != 'c2.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	SET myquery = CONCAT(myquery, ' ORDER BY 1 DESC');


	
	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;	
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_support_detail_delay
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_support_detail_delay`(
	IN `account_id` INT,
	IN `account_status` VARCHAR(50),
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `status` VARCHAR(50),
	IN `delay_day` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)

)
BEGIN
	DECLARE myquery nvarchar(4000);

	SET myquery = CONCAT('SELECT DISTINCT c2.crmid ''c2.crmid'',
										CONCAT(''['',c2.label, '' ('',acc.account_no, '')'', '' ]'',''(http://crm.fastdn.com.vn/index.php?module=Accounts&view=Detail&record='',c2.crmid,''&app=SUPPORT)'') AS ''c2.label'',
										a.cf_891 ''a.cf_891'',
										
										CASE WHEN t.ticketid IS NOT NULL AND t.ticketid !='''' AND c.deleted = ''0'' THEN u.user_name		 
												ELSE '''' END ''u.user_name'',
										
										CASE WHEN t.ticketid IS NOT NULL AND t.ticketid !='''' THEN (SELECT COUNT(DISTINCT t.ticketid)
																																	FROM vtiger_crmentity c 
																																	INNER JOIN vtiger_troubletickets t 
																																	ON t.ticketid = c.crmid 
																																	LEFT JOIN vtiger_users u 
																																	ON c.smownerid = u.id 
																																	LEFT JOIN vtiger_account a 
																																	ON a.accountid = t.parent_id 
																																	WHERE c.deleted = 0 AND a.accountid=acc.accountid)
												ELSE 0 END ''num_ticket'',
										
										CASE WHEN t.ticketid IS NOT NULL AND c.deleted = ''0'' THEN DATEDIFF(DATE(NOW()), DATE(c.createdtime))
												ELSE DATEDIFF(DATE(NOW()), DATE(c2.createdtime)) END ''delay_day''
										
								FROM vtiger_crmentity c2
								
								JOIN vtiger_account acc
								ON c2.crmid = acc.accountid
	
								LEFT JOIN (SELECT ticketid,ticket_no,parent_id,
												(CASE WHEN priority= ''High'' THEN ''Cao''
													WHEN priority != '''' THEN priority
													ELSE ''Không xác định'' END) AS ''priority'',
													
												(CASE WHEN status = ''Closed'' THEN ''Đã hoàn thành''
													WHEN status = ''In Progress'' THEN ''Đang xử lý''
													WHEN status = ''Open'' OR status = ''Mở'' THEN ''Đang mở''
													WHEN status = ''Wait For Response'' THEN ''Chờ phản hồi''
													WHEN status IS NOT NULL THEN status
													ELSE ''Không xác định'' END) AS ''status'',
												category,title
											FROM vtiger_troubletickets) t
								ON t.parent_id = c2.crmid
								LEFT JOIN vtiger_crmentity c
								ON t.ticketid = c.crmid
								
								LEFT JOIN (SELECT ticketid, 
												(CASE WHEN cf_893 IS NULL OR cf_893 = '''' THEN ''Không xác định''
														ELSE cf_893 END) AS ''cf_893''
										FROM vtiger_ticketcf) tcf
								ON tcf.ticketid = t.ticketid
								
								LEFT JOIN vtiger_users u
								ON u.id = c.smownerid
								
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = u.id
								
								LEFT JOIN (SELECT accountid, 
												(CASE WHEN cf_891 IS NULL OR cf_891 = '''' THEN ''Không xác định'' 
														ELSE cf_891 END) AS ''cf_891''
										FROM vtiger_accountscf ) a
								ON a.accountid = acc.accountid
												 
								WHERE 1=1');
							

	-- SET myquery = CONCAT(myquery, ' AND c.deleted = ''0'' AND a.cf_891 IN (''Bảo hành'', ''Đang sử dụng(DV)'') ');
	SET myquery = CONCAT(myquery, ' AND c2.deleted = ''0''');
	SET myquery = CONCAT(myquery, ' AND CASE WHEN t.ticketid IS NOT NULL AND c.deleted = ''0'' THEN t.ticketid IN (SELECT MAX(t.ticketid)
																																	FROM vtiger_crmentity c 
																																	INNER JOIN vtiger_troubletickets t 
																																	ON t.ticketid = c.crmid 
																																	LEFT JOIN vtiger_account a 
																																	ON a.accountid = t.parent_id 
																																	JOIN vtiger_crmentity c2
																																	ON c2.crmid = a.accountid
																																	WHERE 
																																		c.deleted = 0 AND c2.deleted = 0
																																	GROUP BY a.accountid)
													ELSE c2.crmid END');
	SET myquery = CONCAT(myquery, ' AND (DATEDIFF(DATE(NOW()), DATE(c2.createdtime)) >=60 OR DATEDIFF(DATE(NOW()), DATE(c.createdtime)) >=60)');

	-- SET myquery = CONCAT(myquery, ' AND t.status != ''Đã đóng''');
	
	/*Chọn theo KH*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.parent_id = ''',account_id,'''');
	END IF;
	
	/*Chọn theo status KH*/
	IF(account_status IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.cf_891 = ''',account_status,'''');	
	END IF;
		
	/*Chọn theo NV*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ug.groupid = ''',dept_id,'''');
	END IF;
	
	/*Chọn theo trạng thái*/
	IF (status IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.status = ''',status,'''');
	END IF;

	
	/*Chọn theo col-val*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND t.ticketid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c2.label') THEN
		SET myquery = CONCAT(myquery,' AND c2.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label' AND col != 'c2.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	SET myquery = CONCAT(myquery, ' GROUP BY 1');
	SET myquery = CONCAT(myquery, ' ORDER BY delay_day DESC');


	
	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;	
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_support_location
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_support_location`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `account_status` VARCHAR(50),
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `status` VARCHAR(50),
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(4000);

	SET myquery = CONCAT('SELECT tcf.cf_893, COUNT(DISTINCT t.ticketid) num
								FROM vtiger_crmentity c 
	
								JOIN (SELECT ticketid,ticket_no,parent_id,
												(CASE WHEN priority= ''High'' THEN ''Cao''
													WHEN priority != '''' THEN priority
													ELSE ''Không xác định'' END) AS ''priority'',
													
												(CASE WHEN status = ''Closed'' THEN ''Đã hoàn thành''
													WHEN status = ''In Progress'' THEN ''Đang xử lý''
													WHEN status = ''Open'' OR status = ''Mở'' THEN ''Đang mở''
													WHEN status = ''Wait For Response'' THEN ''Chờ phản hồi''
													WHEN status IS NOT NULL THEN status
													ELSE ''Không xác định'' END) AS ''status'',
												category,title
											FROM vtiger_troubletickets) t
								ON t.ticketid = c.crmid
								
								JOIN (SELECT ticketid, 
												(CASE WHEN cf_893 IS NULL OR cf_893 = '''' THEN ''Không xác định''
														ELSE cf_893 END) AS ''cf_893''
										FROM vtiger_ticketcf) tcf
								ON tcf.ticketid = t.ticketid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = t.parent_id
								
								LEFT JOIN vtiger_users u
								ON u.id = c.smownerid
								
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = u.id
								
								LEFT JOIN (SELECT accountid, 
												(CASE WHEN cf_891 IS NULL OR cf_891 = '''' THEN ''Không xác định'' 
														ELSE cf_891 END) AS ''cf_891''
										FROM vtiger_accountscf ) a
								ON a.accountid = t.parent_id 
									 
								WHERE 1=1');
							

	SET myquery = CONCAT(myquery, ' AND c.deleted = ''0''');
	SET myquery = CONCAT(myquery, ' AND c2.deleted = ''0''');
	
	/*Chọn theo khoảng thời gian*/
	IF (timetype = 0 OR timetype IS NULL) AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	ELSEIF timetype = 1  AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		  SET myquery = CONCAT(myquery,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' ');
	END IF;
	
	/*Chọn theo KH*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.parent_id = ''',account_id,'''');
	END IF;
		
	/*Chọn theo status KH*/
	IF(account_status IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.cf_891 = ''',account_status,'''');	
	END IF;
		
	/*Chọn theo NV*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ug.groupid = ''',dept_id,'''');
	END IF;
	
	/*Chọn theo trạng thái*/
	IF (status IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.status = ''',status,'''');
	END IF;
	
	/*Chọn theo col-val*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND t.ticketid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c2.label') THEN
		SET myquery = CONCAT(myquery,' AND t.parent_id = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label' AND col != 'c2.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	SET myquery = CONCAT(myquery, ' GROUP BY 1');


	
	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;	
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_support_month
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_support_month`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `account_status` VARCHAR(50),
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `status` VARCHAR(50),
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery_1 nvarchar(4000);
	DECLARE myquery_2 nvarchar(4000);
	
	
	SET myquery_1 = CONCAT('SELECT CONCAT(Month(c.createdtime),''/'', Year(c.createdtime)) month, COUNT(DISTINCT t.ticketid) num
								FROM vtiger_crmentity c 
	
								JOIN (SELECT ticketid,ticket_no,parent_id,
												(CASE WHEN priority= ''High'' THEN ''Cao''
													WHEN priority != '''' THEN priority
													ELSE ''Không xác định'' END) AS ''priority'',
													
												(CASE WHEN status = ''Closed'' THEN ''Đã hoàn thành''
													WHEN status = ''In Progress'' THEN ''Đang xử lý''
													WHEN status = ''Open'' OR status = ''Mở'' THEN ''Đang mở''
													WHEN status = ''Wait For Response'' THEN ''Chờ phản hồi''
													WHEN status IS NOT NULL THEN status
													ELSE ''Không xác định'' END) AS ''status'',
												category,title
											FROM vtiger_troubletickets) t
								ON t.ticketid = c.crmid
								
								JOIN (SELECT ticketid, 
												(CASE WHEN cf_893 IS NULL OR cf_893 = '''' THEN ''Không xác định''
														ELSE cf_893 END) AS ''cf_893''
										FROM vtiger_ticketcf) tcf
								ON tcf.ticketid = t.ticketid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = t.parent_id
								
								LEFT JOIN vtiger_users u
								ON u.id = c.smownerid
								
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = u.id
								
								LEFT JOIN (SELECT accountid, 
												(CASE WHEN cf_891 IS NULL OR cf_891 = '''' THEN ''Không xác định'' 
														ELSE cf_891 END) AS ''cf_891''
										FROM vtiger_accountscf ) a
								ON a.accountid = t.parent_id 
																 
								WHERE 1=1');
								
								
	SET myquery_2 = CONCAT('SELECT CONCAT(Month(c.modifiedtime),''/'', Year(c.modifiedtime)) month, COUNT(DISTINCT t.ticketid) num
								FROM vtiger_crmentity c 
	
								JOIN (SELECT ticketid,ticket_no,parent_id,
												(CASE WHEN priority= ''High'' THEN ''Cao''
													WHEN priority != '''' THEN priority
													ELSE ''Không xác định'' END) AS ''priority'',
													
												(CASE WHEN status = ''Closed'' THEN ''Đã đóng''
													WHEN status = ''In Progress'' THEN ''Đang xử lý''
													WHEN status = ''Open'' THEN ''Mở''
													WHEN status = ''Wait For Response'' THEN ''Đợi phản hồi''
													WHEN status IS NOT NULL THEN status
													ELSE ''Không xác định'' END) AS ''status'',
												category,title
								FROM vtiger_troubletickets) t
								ON t.ticketid = c.crmid
								
								JOIN (SELECT ticketid, 
												(CASE WHEN cf_893 IS NULL OR cf_893 = '''' THEN ''Không xác định''
														ELSE cf_893 END) AS ''cf_893''
										FROM vtiger_ticketcf) tcf
								ON tcf.ticketid = t.ticketid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = t.parent_id
								
								LEFT JOIN vtiger_users u
								ON u.id = c.smownerid
								
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = u.id
								
								LEFT JOIN (SELECT accountid, 
												(CASE WHEN cf_891 IS NULL OR cf_891 = '''' THEN ''Không xác định'' 
														ELSE cf_891 END) AS ''cf_891''
										FROM vtiger_accountscf ) a
								ON a.accountid = t.parent_id 
																		 
								WHERE 1=1');
							

	SET myquery_1 = CONCAT(myquery_1, ' AND c.deleted = ''0''');
	SET myquery_1 = CONCAT(myquery_1, ' AND c2.deleted = ''0''');
	SET myquery_2 = CONCAT(myquery_2, ' AND c.deleted = ''0''');
	SET myquery_2 = CONCAT(myquery_2, ' AND c2.deleted = ''0''');	
		
	/*Chọn theo khoảng thời gian*/
	IF (start_date IS NOT NULL AND end_date IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
		SET myquery_2 = CONCAT(myquery_2,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;
	
	/*Chọn theo KH*/
	IF(account_id IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND t.parent_id = ''',account_id,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND t.parent_id = ''',account_id,'''');
	END IF;
	
	/*Chọn theo status KH*/
	IF(account_status IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND a.cf_891 = ''',account_status,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND a.cf_891 = ''',account_status,'''');
	END IF;
		
	/*Chọn theo NV*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.smownerid = ''',user_assign,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND ug.groupid = ''',dept_id,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND ug.groupid = ''',dept_id,'''');
	END IF;
	
	/*Chọn theo trạng thái*/
	IF (status IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND t.status = ''',status,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND t.status = ''',status,'''');
	END IF;
	
	/*Chọn theo col-val*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery_1 = CONCAT(myquery_1,' AND t.ticketid = ''', val,''' ');
		SET myquery_2 = CONCAT(myquery_2,' AND t.ticketid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c2.label') THEN
		SET myquery_1 = CONCAT(myquery_1,' AND t.parent_id = ''', val,''' ');
		SET myquery_2 = CONCAT(myquery_2,' AND t.parent_id = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label' AND col != 'c2.label')  THEN
		SET myquery_1 = CONCAT(myquery_1,' AND ',col, ' = ''', val,''' ');
		SET myquery_2 = CONCAT(myquery_2,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	SET myquery_1 = CONCAT(myquery_1, ' GROUP BY 1 ORDER BY YEAR(c.createdtime), MONTH(c.createdtime)');
	SET myquery_2 = CONCAT(myquery_2, ' GROUP BY 1 ORDER BY YEAR(c.modifiedtime), MONTH(c.modifiedtime)');
	
	
	
	IF (timetype = 0 OR timetype IS NULL) THEN
		SELECT myquery_1;
		SET @SQL := myquery_1;
	 	PREPARE my_query1 FROM @SQL;
		EXECUTE my_query1;
	ELSEIF (timetype = 1) THEN
		SELECT myquery_2;
		SET @SQL := myquery_2;
	 	PREPARE my_query2 FROM @SQL;
		EXECUTE my_query2;
	END IF;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_support_priority
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_support_priority`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `account_status` VARCHAR(50),
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `status` VARCHAR(50),
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(4000);

	SET myquery = CONCAT('SELECT t.priority, COUNT(DISTINCT t.ticketid) num
								FROM vtiger_crmentity c 
	
								JOIN (SELECT ticketid,ticket_no,parent_id,
												(CASE WHEN priority= ''High'' THEN ''Cao''
													WHEN priority != '''' THEN priority
													ELSE ''Không xác định'' END) AS ''priority'',
													
												(CASE WHEN status = ''Closed'' THEN ''Đã hoàn thành''
													WHEN status = ''In Progress'' THEN ''Đang xử lý''
													WHEN status = ''Open'' OR status = ''Mở'' THEN ''Đang mở''
													WHEN status = ''Wait For Response'' THEN ''Chờ phản hồi''
													WHEN status IS NOT NULL THEN status
													ELSE ''Không xác định'' END) AS ''status'',
												category,title
											FROM vtiger_troubletickets) t
								ON t.ticketid = c.crmid
								
								JOIN (SELECT ticketid, 
												(CASE WHEN cf_893 IS NULL OR cf_893 = '''' THEN ''Không xác định''
														ELSE cf_893 END) AS ''cf_893''
										FROM vtiger_ticketcf) tcf
								ON tcf.ticketid = t.ticketid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = t.parent_id
								
								LEFT JOIN vtiger_users u
								ON u.id = c.smownerid
								
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = u.id
								
								LEFT JOIN (SELECT accountid, 
												(CASE WHEN cf_891 IS NULL OR cf_891 = '''' THEN ''Không xác định'' 
														ELSE cf_891 END) AS ''cf_891''
										FROM vtiger_accountscf ) a
								ON a.accountid = t.parent_id 
															 
								WHERE 1=1');
							

	SET myquery = CONCAT(myquery, ' AND c.deleted = ''0''');
	SET myquery = CONCAT(myquery, ' AND c2.deleted = ''0''');
	
	/*Chọn theo khoảng thời gian*/
	IF (timetype = 0 OR timetype IS NULL) AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	ELSEIF timetype = 1  AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		  SET myquery = CONCAT(myquery,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' ');
	END IF;
	
	/*Chọn theo KH*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.parent_id = ''',account_id,'''');
	END IF;
		
	/*Chọn theo status KH*/
	IF(account_status IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.cf_891 = ''',account_status,'''');	
	END IF;
			
	/*Chọn theo NV*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ug.groupid = ''',dept_id,'''');
	END IF;
	
	/*Chọn theo trạng thái*/
	IF (status IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.status = ''',status,'''');
	END IF;
	
	/*Chọn theo col-val*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND t.ticketid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c2.label') THEN
		SET myquery = CONCAT(myquery,' AND t.parent_id = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label' AND col != 'c2.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	
	SET myquery = CONCAT(myquery, ' GROUP BY 1');


	
	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;	
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_support_quarter
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_support_quarter`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `account_status` VARCHAR(50),
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `status` VARCHAR(50),
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery_1 nvarchar(4000);
	DECLARE myquery_2 nvarchar(4000);
	
	
	SET myquery_1 = CONCAT('SELECT CONCAT(YEAR(c.createdtime),'' - Q'', QUARTER(c.createdtime)) quarter, COUNT(DISTINCT t.ticketid) num
								FROM vtiger_crmentity c 
	
								JOIN (SELECT ticketid,ticket_no,parent_id,
												(CASE WHEN priority= ''High'' THEN ''Cao''
													WHEN priority != '''' THEN priority
													ELSE ''Không xác định'' END) AS ''priority'',
													
												(CASE WHEN status = ''Closed'' THEN ''Đã hoàn thành''
													WHEN status = ''In Progress'' THEN ''Đang xử lý''
													WHEN status = ''Open'' OR status = ''Mở'' THEN ''Đang mở''
													WHEN status = ''Wait For Response'' THEN ''Chờ phản hồi''
													WHEN status IS NOT NULL THEN status
													ELSE ''Không xác định'' END) AS ''status'',
												category,title
											FROM vtiger_troubletickets) t
								ON t.ticketid = c.crmid
								
								JOIN (SELECT ticketid, 
												(CASE WHEN cf_893 IS NULL OR cf_893 = '''' THEN ''Không xác định''
														ELSE cf_893 END) AS ''cf_893''
										FROM vtiger_ticketcf) tcf
								ON tcf.ticketid = t.ticketid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = t.parent_id
								
								LEFT JOIN vtiger_users u
								ON u.id = c.smownerid
								
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = u.id
								
								LEFT JOIN (SELECT accountid, 
												(CASE WHEN cf_891 IS NULL OR cf_891 = '''' THEN ''Không xác định'' 
														ELSE cf_891 END) AS ''cf_891''
										FROM vtiger_accountscf ) a
								ON a.accountid = t.parent_id  
																	 
								WHERE 1=1');
								
								
	SET myquery_2 = CONCAT('SELECT CONCAT(YEAR(c.modifiedtime),'' - Q'', QUARTER(c.modifiedtime)) quarter, COUNT(DISTINCT t.ticketid) num
								FROM vtiger_crmentity c 
	
								JOIN (SELECT ticketid,ticket_no,parent_id,
												(CASE WHEN priority= ''High'' THEN ''Cao''
													WHEN priority != '''' THEN priority
													ELSE ''Không xác định'' END) AS ''priority'',
													
												(CASE WHEN status = ''Closed'' THEN ''Đã đóng''
													WHEN status = ''In Progress'' THEN ''Đang xử lý''
													WHEN status = ''Open'' THEN ''Mở''
													WHEN status = ''Wait For Response'' THEN ''Đợi phản hồi''
													WHEN status IS NOT NULL THEN status
													ELSE ''Không xác định'' END) AS ''status'',
												category,title
								FROM vtiger_troubletickets) t
								ON t.ticketid = c.crmid
								
								JOIN (SELECT ticketid, 
												(CASE WHEN cf_893 IS NULL OR cf_893 = '''' THEN ''Không xác định''
														ELSE cf_893 END) AS ''cf_893''
										FROM vtiger_ticketcf) tcf
								ON tcf.ticketid = t.ticketid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = t.parent_id
								
								LEFT JOIN vtiger_users u
								ON u.id = c.smownerid
								
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = u.id
								
								LEFT JOIN (SELECT accountid, 
												(CASE WHEN cf_891 IS NULL OR cf_891 = '''' THEN ''Không xác định'' 
														ELSE cf_891 END) AS ''cf_891''
										FROM vtiger_accountscf ) a
								ON a.accountid = t.parent_id 
																		 
								WHERE 1=1');
							

	SET myquery_1 = CONCAT(myquery_1, ' AND c.deleted = ''0''');
	SET myquery_1 = CONCAT(myquery_1, ' AND c2.deleted = ''0''');
	SET myquery_2 = CONCAT(myquery_2, ' AND c.deleted = ''0''');
	SET myquery_2 = CONCAT(myquery_2, ' AND c2.deleted = ''0''');

	
	/*Chọn theo khoảng thời gian*/
	IF (start_date IS NOT NULL AND end_date IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
		SET myquery_2 = CONCAT(myquery_2,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;
	
	/*Chọn theo KH*/
	IF(account_id IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND t.parent_id = ''',account_id,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND t.parent_id = ''',account_id,'''');
	END IF;
	
	/*Chọn theo status KH*/
	IF(account_status IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND a.cf_891 = ''',account_status,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND a.cf_891 = ''',account_status,'''');
	END IF;
		
	/*Chọn theo NV*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.smownerid = ''',user_assign,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND ug.groupid = ''',dept_id,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND ug.groupid = ''',dept_id,'''');
	END IF;
	
	/*Chọn theo trạng thái*/
	IF (status IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND t.status = ''',status,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND t.status = ''',status,'''');
	END IF;
	
	/*Chọn theo col-val*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery_1 = CONCAT(myquery_1,' AND t.ticketid = ''', val,''' ');
		SET myquery_2 = CONCAT(myquery_2,' AND t.ticketid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c2.label') THEN
		SET myquery_1 = CONCAT(myquery_1,' AND t.parent_id = ''', val,''' ');
		SET myquery_2 = CONCAT(myquery_2,' AND t.parent_id = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label' AND col != 'c2.label')  THEN
		SET myquery_1 = CONCAT(myquery_1,' AND ',col, ' = ''', val,''' ');
		SET myquery_2 = CONCAT(myquery_2,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	SET myquery_1 = CONCAT(myquery_1, ' GROUP BY 1 ORDER BY YEAR(c.createdtime),QUARTER(c.createdtime)');
	SET myquery_2 = CONCAT(myquery_2, ' GROUP BY 1 ORDER BY YEAR(c.modifiedtime),QUARTER(c.modifiedtime)');
	
	
	
	IF (timetype = 0 OR timetype IS NULL) THEN
		SELECT myquery_1;
		SET @SQL := myquery_1;
	 	PREPARE my_query1 FROM @SQL;
		EXECUTE my_query1;
	ELSEIF (timetype = 1) THEN
		SELECT myquery_2;
		SET @SQL := myquery_2;
	 	PREPARE my_query2 FROM @SQL;
		EXECUTE my_query2;
	END IF;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_support_status
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_support_status`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `account_status` VARCHAR(50),
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `status` VARCHAR(50),
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(4000);

	SET myquery = CONCAT('SELECT t.status, COUNT(DISTINCT t.ticketid) num
								FROM vtiger_crmentity c 
	
								JOIN (SELECT ticketid,ticket_no,parent_id,
												(CASE WHEN priority= ''High'' THEN ''Cao''
													WHEN priority != '''' THEN priority
													ELSE ''Không xác định'' END) AS ''priority'',
													
												(CASE WHEN status = ''Closed'' THEN ''Đã hoàn thành''
													WHEN status = ''In Progress'' THEN ''Đang xử lý''
													WHEN status = ''Open'' OR status = ''Mở'' THEN ''Đang mở''
													WHEN status = ''Wait For Response'' THEN ''Chờ phản hồi''
													WHEN status IS NOT NULL THEN status
													ELSE ''Không xác định'' END) AS ''status'',
												category,title
											FROM vtiger_troubletickets) t
								ON t.ticketid = c.crmid
								
								JOIN (SELECT ticketid, 
												(CASE WHEN cf_893 IS NULL OR cf_893 = '''' THEN ''Không xác định''
														ELSE cf_893 END) AS ''cf_893''
										FROM vtiger_ticketcf) tcf
								ON tcf.ticketid = t.ticketid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = t.parent_id
								
								LEFT JOIN vtiger_users u
								ON u.id = c.smownerid
								
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = u.id
								
								LEFT JOIN (SELECT accountid, 
												(CASE WHEN cf_891 IS NULL OR cf_891 = '''' THEN ''Không xác định'' 
														ELSE cf_891 END) AS ''cf_891''
										FROM vtiger_accountscf ) a
								ON a.accountid = t.parent_id
																	 
								WHERE 1=1');
							

	SET myquery = CONCAT(myquery, ' AND c.deleted = ''0''');
	SET myquery = CONCAT(myquery, ' AND c2.deleted = ''0''');
	
	/*Chọn theo khoảng thời gian*/
	IF (timetype = 0 OR timetype IS NULL) AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	ELSEIF timetype = 1  AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		  SET myquery = CONCAT(myquery,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' ');
	END IF;
	
	/*Chọn theo KH*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.parent_id = ''',account_id,'''');
	END IF;
		
	/*Chọn theo status KH*/
	IF(account_status IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.cf_891 = ''',account_status,'''');	
	END IF;
			
	/*Chọn theo NV*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ug.groupid = ''',dept_id,'''');
	END IF;
	
	/*Chọn theo trạng thái*/
	IF (status IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.status = ''',status,'''');
	END IF;
	
	/*Chọn theo col-val*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND t.ticketid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c2.label') THEN
		SET myquery = CONCAT(myquery,' AND t.parent_id = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label' AND col != 'c2.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	
	SET myquery = CONCAT(myquery, ' GROUP BY 1 ORDER BY 2 DESC,1');


	
	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;	
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_support_total_support
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_support_total_support`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `account_status` VARCHAR(50),
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `status` VARCHAR(50),
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(4000);
	SET myquery = CONCAT('SELECT COUNT(DISTINCT t.ticketid) num
								FROM vtiger_crmentity c 
	
								JOIN (SELECT ticketid,ticket_no,parent_id,
												(CASE WHEN priority= ''High'' THEN ''Cao''
													WHEN priority != '''' THEN priority
													ELSE ''Không xác định'' END) AS ''priority'',
													
												(CASE WHEN status = ''Closed'' THEN ''Đã hoàn thành''
													WHEN status = ''In Progress'' THEN ''Đang xử lý''
													WHEN status = ''Open'' OR status = ''Mở'' THEN ''Đang mở''
													WHEN status = ''Wait For Response'' THEN ''Chờ phản hồi''
													WHEN status IS NOT NULL THEN status
													ELSE ''Không xác định'' END) AS ''status'',
												category,title
											FROM vtiger_troubletickets) t
								ON t.ticketid = c.crmid
								
								JOIN (SELECT ticketid, 
												(CASE WHEN cf_893 IS NULL OR cf_893 = '''' THEN ''Không xác định''
														ELSE cf_893 END) AS ''cf_893''
										FROM vtiger_ticketcf) tcf
								ON tcf.ticketid = t.ticketid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = t.parent_id
								
								LEFT JOIN vtiger_users u
								ON u.id = c.smownerid
								
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = u.id
								
								LEFT JOIN (SELECT accountid, 
												(CASE WHEN cf_891 IS NULL OR cf_891 = '''' THEN ''Không xác định'' 
														ELSE cf_891 END) AS ''cf_891''
										FROM vtiger_accountscf ) a
								ON a.accountid = t.parent_id 
								
								WHERE 1=1');
	
	SET myquery = CONCAT(myquery,' AND c.deleted = ''0''');
	
	/*Chọn theo khoảng thời gian*/
	IF (timetype = 0 OR timetype IS NULL) AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	ELSEIF timetype = 1  AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		  SET myquery = CONCAT(myquery,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' ');
	END IF;
	
	/*Chọn theo KH*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.parent_id = ''',account_id,'''');
	END IF;
		
	/*Chọn theo status KH*/
	IF(account_status IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.cf_891 = ''',account_status,'''');	
	END IF;
		
	/*Chọn theo NV*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ug.groupid = ''',dept_id,'''');
	END IF;
	
	/*Chọn theo trạng thái*/
	IF (status IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.status = ''',status,'''');
	END IF;
	
	/*Chọn theo col-val*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND t.ticketid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c2.label') THEN
		SET myquery = CONCAT(myquery,' AND t.parent_id = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label' AND col != 'c2.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	
	SET myquery = CONCAT(myquery, ' AND c2.deleted = ''0''');
	
	
	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_support_total_support_closed
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_support_total_support_closed`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `account_status` VARCHAR(50),
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `status` VARCHAR(50),
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(4000);
	SET myquery = CONCAT('SELECT COUNT(DISTINCT t.ticketid) num
								FROM vtiger_crmentity c 
	
								JOIN (SELECT ticketid,ticket_no,parent_id,
												(CASE WHEN priority= ''High'' THEN ''Cao''
													WHEN priority != '''' THEN priority
													ELSE ''Không xác định'' END) AS ''priority'',
													
												(CASE WHEN status = ''Closed'' THEN ''Đã hoàn thành''
													WHEN status = ''In Progress'' THEN ''Đang xử lý''
													WHEN status = ''Open'' OR status = ''Mở'' THEN ''Đang mở''
													WHEN status = ''Wait For Response'' THEN ''Chờ phản hồi''
													WHEN status IS NOT NULL THEN status
													ELSE ''Không xác định'' END) AS ''status'',
												category,title
											FROM vtiger_troubletickets) t
								ON t.ticketid = c.crmid
								
								JOIN (SELECT ticketid, 
												(CASE WHEN cf_893 IS NULL OR cf_893 = '''' THEN ''Không xác định''
														ELSE cf_893 END) AS ''cf_893''
										FROM vtiger_ticketcf) tcf
								ON tcf.ticketid = t.ticketid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = t.parent_id
								
								LEFT JOIN vtiger_users u
								ON u.id = c.smownerid
								
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = u.id
								
								LEFT JOIN (SELECT accountid, 
												(CASE WHEN cf_891 IS NULL OR cf_891 = '''' THEN ''Không xác định'' 
														ELSE cf_891 END) AS ''cf_891''
										FROM vtiger_accountscf ) a
								ON a.accountid = t.parent_id
								
								WHERE 1=1 AND t.status=''Đã hoàn thành''');
	
	SET myquery = CONCAT(myquery,' AND c.deleted = ''0''');
	
	/*Chọn theo khoảng thời gian*/
	IF (timetype = 0 OR timetype IS NULL) AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	ELSEIF timetype = 1  AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		  SET myquery = CONCAT(myquery,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' ');
	END IF;
	
	/*Chọn theo KH*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.parent_id = ''',account_id,'''');
	END IF;
		
	/*Chọn theo status KH*/
	IF(account_status IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.cf_891 = ''',account_status,'''');	
	END IF;
		
	/*Chọn theo NV*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ug.groupid = ''',dept_id,'''');
	END IF;
	
	/*Chọn theo trạng thái*/
	IF (status IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.status = ''',status,'''');
	END IF;
	
	/*Chọn theo col-val*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND t.ticketid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c2.label') THEN
		SET myquery = CONCAT(myquery,' AND t.parent_id = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label' AND col != 'c2.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	
	SET myquery = CONCAT(myquery, ' AND c2.deleted = ''0''');
	
	
	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_support_total_support_open
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_support_total_support_open`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `account_status` VARCHAR(50),
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `status` VARCHAR(50),
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(4000);
	SET myquery = CONCAT('SELECT COUNT(DISTINCT t.ticketid) num
								FROM vtiger_crmentity c 
	
								JOIN (SELECT ticketid,ticket_no,parent_id,
												(CASE WHEN priority= ''High'' THEN ''Cao''
													WHEN priority != '''' THEN priority
													ELSE ''Không xác định'' END) AS ''priority'',
													
												(CASE WHEN status = ''Closed'' THEN ''Đã hoàn thành''
													WHEN status = ''In Progress'' THEN ''Đang xử lý''
													WHEN status = ''Open'' OR status = ''Mở'' THEN ''Đang mở''
													WHEN status = ''Wait For Response'' THEN ''Chờ phản hồi''
													WHEN status IS NOT NULL THEN status
													ELSE ''Không xác định'' END) AS ''status'',
												category,title
											FROM vtiger_troubletickets) t
								ON t.ticketid = c.crmid
								
								JOIN (SELECT ticketid, 
												(CASE WHEN cf_893 IS NULL OR cf_893 = '''' THEN ''Không xác định''
														ELSE cf_893 END) AS ''cf_893''
										FROM vtiger_ticketcf) tcf
								ON tcf.ticketid = t.ticketid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = t.parent_id
								
								LEFT JOIN vtiger_users u
								ON u.id = c.smownerid
								
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = u.id
								
								LEFT JOIN (SELECT accountid, 
												(CASE WHEN cf_891 IS NULL OR cf_891 = '''' THEN ''Không xác định'' 
														ELSE cf_891 END) AS ''cf_891''
										FROM vtiger_accountscf ) a
								ON a.accountid = t.parent_id
								
								WHERE 1=1 AND t.status=''Đang mở''');
	
	SET myquery = CONCAT(myquery,' AND c.deleted = ''0''');
	
	/*Chọn theo khoảng thời gian*/
	IF (timetype = 0 OR timetype IS NULL) AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	ELSEIF timetype = 1  AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		  SET myquery = CONCAT(myquery,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' ');
	END IF;
	
	/*Chọn theo KH*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.parent_id = ''',account_id,'''');
	END IF;
			
	/*Chọn theo status KH*/
	IF(account_status IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.cf_891 = ''',account_status,'''');	
	END IF;
	
	/*Chọn theo NV*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ug.groupid = ''',dept_id,'''');
	END IF;
	
	/*Chọn theo trạng thái*/
	IF (status IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.status = ''',status,'''');
	END IF;
	
	/*Chọn theo col-val*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND t.ticketid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c2.label') THEN
		SET myquery = CONCAT(myquery,' AND t.parent_id = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label' AND col != 'c2.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	
	SET myquery = CONCAT(myquery, ' AND c2.deleted = ''0''');
	
	
	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_support_user
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_support_user`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `account_status` VARCHAR(50),
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `status` VARCHAR(50),
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(4000);

	SET myquery = CONCAT('SELECT u.user_name, COUNT(DISTINCT t.ticketid) num
								FROM vtiger_crmentity c 
	
								JOIN (SELECT ticketid,ticket_no,parent_id,
												(CASE WHEN priority= ''High'' THEN ''Cao''
													WHEN priority != '''' THEN priority
													ELSE ''Không xác định'' END) AS ''priority'',
													
												(CASE WHEN status = ''Closed'' THEN ''Đã hoàn thành''
													WHEN status = ''In Progress'' THEN ''Đang xử lý''
													WHEN status = ''Open'' OR status = ''Mở'' THEN ''Đang mở''
													WHEN status = ''Wait For Response'' THEN ''Chờ phản hồi''
													WHEN status IS NOT NULL THEN status
													ELSE ''Không xác định'' END) AS ''status'',
												category,title
											FROM vtiger_troubletickets) t
								ON t.ticketid = c.crmid
								
								JOIN (SELECT ticketid, 
												(CASE WHEN cf_893 IS NULL OR cf_893 = '''' THEN ''Không xác định''
														ELSE cf_893 END) AS ''cf_893''
										FROM vtiger_ticketcf) tcf
								ON tcf.ticketid = t.ticketid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = t.parent_id
								
								LEFT JOIN vtiger_users u
								ON u.id = c.smownerid
								
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = u.id
								
								LEFT JOIN (SELECT accountid, 
												(CASE WHEN cf_891 IS NULL OR cf_891 = '''' THEN ''Không xác định'' 
														ELSE cf_891 END) AS ''cf_891''
										FROM vtiger_accountscf ) a
								ON a.accountid = t.parent_id
												 
								WHERE 1=1');
							
	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0''');	
	SET myquery = CONCAT(myquery, ' AND c.deleted = ''0''');
	SET myquery = CONCAT(myquery, ' AND c2.deleted = ''0''');
	
	/*Chọn theo khoảng thời gian*/
	IF (timetype = 0 OR timetype IS NULL) AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	ELSEIF timetype = 1  AND start_date IS NOT NULL AND end_date IS NOT NULL THEN
		  SET myquery = CONCAT(myquery,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' ');
	END IF;
	
	/*Chọn theo KH*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.parent_id = ''',account_id,'''');
	END IF;
		
	/*Chọn theo status KH*/
	IF(account_status IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND a.cf_891 = ''',account_status,'''');	
	END IF;
		
	/*Chọn theo NV*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ug.groupid = ''',dept_id,'''');
	END IF;
	
	/*Chọn theo trạng thái*/
	IF (status IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.status = ''',status,'''');
	END IF;
	
	/*Chọn theo col-val*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND t.ticketid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c2.label') THEN
		SET myquery = CONCAT(myquery,' AND t.parent_id = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label' AND col != 'c2.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	SET myquery = CONCAT(myquery, ' GROUP BY 1 ORDER BY 2 DESC,1');


	
	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;	
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_support_year
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_support_year`(
	IN `timetype` INT,
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `account_status` VARCHAR(50),
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `status` VARCHAR(50),
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery_1 nvarchar(4000);
	DECLARE myquery_2 nvarchar(4000);
	
	
	SET myquery_1 = CONCAT('SELECT CAST(Year(c.createdtime) AS CHAR) year, COUNT(DISTINCT t.ticketid) num
								FROM vtiger_crmentity c 
	
								JOIN (SELECT ticketid,ticket_no,parent_id,
												(CASE WHEN priority= ''High'' THEN ''Cao''
													WHEN priority != '''' THEN priority
													ELSE ''Không xác định'' END) AS ''priority'',
													
												(CASE WHEN status = ''Closed'' THEN ''Đã hoàn thành''
													WHEN status = ''In Progress'' THEN ''Đang xử lý''
													WHEN status = ''Open'' OR status = ''Mở'' THEN ''Đang mở''
													WHEN status = ''Wait For Response'' THEN ''Chờ phản hồi''
													WHEN status IS NOT NULL THEN status
													ELSE ''Không xác định'' END) AS ''status'',
												category,title
											FROM vtiger_troubletickets) t
								ON t.ticketid = c.crmid
								
								JOIN (SELECT ticketid, 
												(CASE WHEN cf_893 IS NULL OR cf_893 = '''' THEN ''Không xác định''
														ELSE cf_893 END) AS ''cf_893''
										FROM vtiger_ticketcf) tcf
								ON tcf.ticketid = t.ticketid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = t.parent_id
								
								LEFT JOIN vtiger_users u
								ON u.id = c.smownerid
								
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = u.id
								
								LEFT JOIN (SELECT accountid, 
												(CASE WHEN cf_891 IS NULL OR cf_891 = '''' THEN ''Không xác định'' 
														ELSE cf_891 END) AS ''cf_891''
										FROM vtiger_accountscf ) a
								ON a.accountid = t.parent_id 
																		 
								WHERE 1=1');
								
								
	SET myquery_2 = CONCAT('SELECT CAST(Year(c.modifiedtime) AS CHAR) year, COUNT(DISTINCT t.ticketid) num
								FROM vtiger_crmentity c 
	
								JOIN (SELECT ticketid,ticket_no,parent_id,
												(CASE WHEN priority= ''High'' THEN ''Cao''
													WHEN priority != '''' THEN priority
													ELSE ''Không xác định'' END) AS ''priority'',
													
												(CASE WHEN status = ''Closed'' THEN ''Đã đóng''
													WHEN status = ''In Progress'' THEN ''Đang xử lý''
													WHEN status = ''Open'' THEN ''Mở''
													WHEN status = ''Wait For Response'' THEN ''Đợi phản hồi''
													WHEN status IS NOT NULL THEN status
													ELSE ''Không xác định'' END) AS ''status'',
												category,title
								FROM vtiger_troubletickets) t
								ON t.ticketid = c.crmid
								
								JOIN (SELECT ticketid, 
												(CASE WHEN cf_893 IS NULL OR cf_893 = '''' THEN ''Không xác định''
														ELSE cf_893 END) AS ''cf_893''
										FROM vtiger_ticketcf) tcf
								ON tcf.ticketid = t.ticketid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = t.parent_id
								
								LEFT JOIN vtiger_users u
								ON u.id = c.smownerid
								
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = u.id
																		 
								WHERE 1=1');
							

	SET myquery_1 = CONCAT(myquery_1, ' AND c.deleted = ''0''');
	SET myquery_1 = CONCAT(myquery_1, ' AND c2.deleted = ''0''');
	SET myquery_2 = CONCAT(myquery_2, ' AND c.deleted = ''0''');
	SET myquery_2 = CONCAT(myquery_2, ' AND c2.deleted = ''0''');

	
	/*Chọn theo khoảng thời gian*/
	IF (start_date IS NOT NULL AND end_date IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
		SET myquery_2 = CONCAT(myquery_2,' AND DATE(c.modifiedtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;
	
	/*Chọn theo KH*/
	IF(account_id IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND t.parent_id = ''',account_id,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND t.parent_id = ''',account_id,'''');
	END IF;
	
	/*Chọn theo status KH*/
	IF(account_status IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND a.cf_891 = ''',account_status,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND a.cf_891 = ''',account_status,'''');
	END IF;
		
	/*Chọn theo NV*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND c.smownerid = ''',user_assign,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND ug.groupid = ''',dept_id,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND ug.groupid = ''',dept_id,'''');
	END IF;
	
	/*Chọn theo trạng thái*/
	IF (status IS NOT NULL) THEN
		SET myquery_1 = CONCAT(myquery_1,' AND t.status = ''',status,'''');
		SET myquery_2 = CONCAT(myquery_2,' AND t.status = ''',status,'''');
	END IF;
	
	/*Chọn theo col-val*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery_1 = CONCAT(myquery_1,' AND t.ticketid = ''', val,''' ');
		SET myquery_2 = CONCAT(myquery_2,' AND t.ticketid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col = 'c2.label') THEN
		SET myquery_1 = CONCAT(myquery_1,' AND t.parent_id = ''', val,''' ');
		SET myquery_2 = CONCAT(myquery_2,' AND t.parent_id = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label' AND col != 'c2.label')  THEN
		SET myquery_1 = CONCAT(myquery_1,' AND ',col, ' = ''', val,''' ');
		SET myquery_2 = CONCAT(myquery_2,' AND ',col, ' = ''', val,''' ');
	END IF;
	
	SET myquery_1 = CONCAT(myquery_1, ' GROUP BY 1 ORDER BY 1');
	SET myquery_2 = CONCAT(myquery_2, ' GROUP BY 1 ORDER BY 1');
	
	
	
	IF (timetype = 0 OR timetype IS NULL) THEN
		SELECT myquery_1;
		SET @SQL := myquery_1;
	 	PREPARE my_query1 FROM @SQL;
		EXECUTE my_query1;
	ELSEIF (timetype = 1) THEN
		SELECT myquery_2;
		SET @SQL := myquery_2;
	 	PREPARE my_query2 FROM @SQL;
		EXECUTE my_query2;
	END IF;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_user_activity_day
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_activity_day`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)

)
BEGIN

	DECLARE myquery nvarchar(4000);

	
	
	SET myquery = CONCAT('SELECT CONCAT(DAY(a.date_start),''/'',MONTH(a.date_start),''/'', YEAR(a.date_start)) AS ''date'', COUNT(DISTINCT a.activityid) AS ''SL_activity''
								FROM vtiger_users u
								
								LEFT JOIN vtiger_crmentity c
								ON c.smownerid = u.id
								
								LEFT JOIN (SELECT activityid, subject, activitytype,date_start,due_date,time_start,time_end,
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_hours IS NULL THEN 0 ELSE duration_hours END AS ''duration_hours'',
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_minutes IS NULL THEN 0 ELSE duration_minutes END AS ''duration_minutes'',
												CASE WHEN status=''In Progress'' THEN ''Đang xử lý''
														WHEN status=''Completed'' OR status=''Hoàn thành'' THEN ''Đã hoàn thành''
														WHEN status=''Pending Input'' THEN ''Đang chờ xử lý''
														WHEN status=''Deferred'' THEN ''Trì hoãn''
														WHEN status=''Planned'' THEN ''Đã lên kế hoạch''
														WHEN eventstatus=''Planned'' THEN ''Lên kế hoạch''
														WHEN eventstatus=''Held'' OR eventstatus=''Đã tổ chức'' THEN ''Đã tổ chức''
														WHEN eventstatus=''Not Held'' THEN ''Không tổ chức''
														ELSE ''Không xác định'' END AS ''status''
										FROM vtiger_activity ) a
								ON c.crmid = a.activityid
								
								LEFT JOIN vtiger_seactivityrel sa
								ON sa.activityid = c.crmid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = sa.crmid
																
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g
								ON g.groupid = ug.groupid
								
								WHERE 1=1');
	
	

	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0'' AND u.status = ''Active''');
	SET myquery = CONCAT(myquery,' AND c.deleted = ''0''');
	SET myquery = CONCAT(myquery,' AND c2.deleted = ''0''');
	
	/*Chọn theo thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery  = CONCAT(myquery,' AND DATE(a.date_start) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c2.crmid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND g.groupid = ''',dept_id,'''');
	END IF;
	
	/*Chọn theo col*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;

	SET myquery = CONCAT (myquery,' GROUP BY 1 ORDER BY YEAR(a.date_start),MONTH(a.date_start),DAY(a.date_start)');
	
	

	

	SELECT myquery;
	SET @SQL := myquery;
	PREPARE my_query1 FROM @SQL;
	EXECUTE my_query1;

END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_user_activity_detail
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_activity_detail`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)



)
BEGIN

	DECLARE myquery nvarchar(4000);
	
	
	SET myquery = CONCAT('SELECT DISTINCT c.crmid, CONCAT(''['',c.label, '' ]'',''(http://crm.fastdn.com.vn/index.php?module=Calendar&view=Detail&record='',c.crmid,'')'') AS ''c.label'',
											u.user_name, a.activitytype, 
											a.status,
											DATE(c.createdtime),a.date_start,a.due_date,DATE(c.modifiedtime),
											CASE WHEN c2.setype = ''Accounts'' THEN c2.label ELSE '''' END AS ''c2.label''
								FROM vtiger_users u
								
								LEFT JOIN vtiger_crmentity c
								ON c.smownerid = u.id
																
								LEFT JOIN (SELECT activityid, subject, activitytype,date_start,due_date,time_start,time_end,
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_hours IS NULL THEN 0 ELSE duration_hours END AS ''duration_hours'',
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_minutes IS NULL THEN 0 ELSE duration_minutes END AS ''duration_minutes'',
												CASE WHEN status=''In Progress'' THEN ''Đang xử lý''
														WHEN status=''Completed'' OR status=''Hoàn thành'' THEN ''Đã hoàn thành''
														WHEN status=''Pending Input'' THEN ''Đang chờ xử lý''
														WHEN status=''Deferred'' THEN ''Trì hoãn''
														WHEN status=''Planned'' THEN ''Đã lên kế hoạch''
														WHEN eventstatus=''Planned'' THEN ''Lên kế hoạch''
														WHEN eventstatus=''Held'' OR eventstatus=''Đã tổ chức'' THEN ''Đã tổ chức''
														WHEN eventstatus=''Not Held'' THEN ''Không tổ chức''
														ELSE ''Không xác định'' END AS ''status''
										FROM vtiger_activity ) a
								ON c.crmid = a.activityid
								
								LEFT JOIN vtiger_seactivityrel sa
								ON sa.activityid = c.crmid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = sa.crmid
								
								
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g
								ON g.groupid = ug.groupid
								
								WHERE 1=1');
	
	

	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0'' AND u.status = ''Active''');
	SET myquery = CONCAT(myquery,' AND c.deleted = ''0''');
	SET myquery = CONCAT(myquery,' AND c2.deleted = ''0''');
	SET myquery = CONCAT(myquery,' AND DATE(a.due_date) != ''4031-02-23'' AND DATE(a.due_date) != ''4029-06-04'' AND DATE(a.due_date) != ''4032-07-09''');
	/*Chọn theo thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery  = CONCAT(myquery,' AND DATE(a.date_start) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;
		
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND AND c2.crmid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND g.groupid = ''',dept_id,'''');
	END IF;
	
	/*Chọn theo col*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;

	SET myquery = CONCAT(myquery,' ORDER BY 1');
	SELECT myquery;
	SET @SQL := myquery;
	PREPARE my_query1 FROM @SQL;
	EXECUTE my_query1;

END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_user_activity_month
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_activity_month`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)

)
BEGIN

	DECLARE myquery nvarchar(4000);
	
	
	SET myquery = CONCAT('SELECT CONCAT(Month(a.date_start),''/'', Year(a.date_start)) AS ''date'', COUNT(DISTINCT a.activityid) AS ''SL_activity''
								FROM vtiger_users u
								
								LEFT JOIN vtiger_crmentity c
								ON c.smownerid = u.id
																
								LEFT JOIN (SELECT activityid, subject, activitytype,date_start,due_date,time_start,time_end,
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_hours IS NULL THEN 0 ELSE duration_hours END AS ''duration_hours'',
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_minutes IS NULL THEN 0 ELSE duration_minutes END AS ''duration_minutes'',
												CASE WHEN status=''In Progress'' THEN ''Đang xử lý''
														WHEN status=''Completed'' OR status=''Hoàn thành'' THEN ''Đã hoàn thành''
														WHEN status=''Pending Input'' THEN ''Đang chờ xử lý''
														WHEN status=''Deferred'' THEN ''Trì hoãn''
														WHEN status=''Planned'' THEN ''Đã lên kế hoạch''
														WHEN eventstatus=''Planned'' THEN ''Lên kế hoạch''
														WHEN eventstatus=''Held'' OR eventstatus=''Đã tổ chức'' THEN ''Đã tổ chức''
														WHEN eventstatus=''Not Held'' THEN ''Không tổ chức''
														ELSE ''Không xác định'' END AS ''status''
										FROM vtiger_activity ) a
								ON c.crmid = a.activityid
								
								LEFT JOIN vtiger_seactivityrel sa
								ON sa.activityid = c.crmid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = sa.crmid
								
								
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g
								ON g.groupid = ug.groupid
								
								WHERE 1=1');
	
	

	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0'' AND u.status = ''Active''');
	SET myquery = CONCAT(myquery,' AND c.deleted = ''0''');
	SET myquery = CONCAT(myquery,' AND c2.deleted = ''0''');

	/*Chọn theo thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery  = CONCAT(myquery,' AND DATE(a.date_start) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND acc.accountid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND g.groupid = ''',dept_id,'''');
	END IF;
	
	/*Chọn theo col*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;

	SET myquery = CONCAT (myquery,' GROUP BY 1 ORDER BY YEAR(a.date_start), MONTH(a.date_start)');
	
	

	SELECT myquery;
	SET @SQL := myquery;
	PREPARE my_query1 FROM @SQL;
	EXECUTE my_query1;

END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_user_activity_quarter
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_activity_quarter`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)

)
BEGIN

	DECLARE myquery nvarchar(4000);

	
	
	SET myquery = CONCAT('SELECT CONCAT(YEAR(a.date_start),'' - Q'', QUARTER(a.date_start)) AS ''date'', COUNT(DISTINCT a.activityid) AS ''SL_activity''
								FROM vtiger_users u
								
								LEFT JOIN vtiger_crmentity c
								ON c.smownerid = u.id
																
								LEFT JOIN (SELECT activityid, subject, activitytype,date_start,due_date,time_start,time_end,
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_hours IS NULL THEN 0 ELSE duration_hours END AS ''duration_hours'',
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_minutes IS NULL THEN 0 ELSE duration_minutes END AS ''duration_minutes'',
												CASE WHEN status=''In Progress'' THEN ''Đang xử lý''
														WHEN status=''Completed'' OR status=''Hoàn thành'' THEN ''Đã hoàn thành''
														WHEN status=''Pending Input'' THEN ''Đang chờ xử lý''
														WHEN status=''Deferred'' THEN ''Trì hoãn''
														WHEN status=''Planned'' THEN ''Đã lên kế hoạch''
														WHEN eventstatus=''Planned'' THEN ''Lên kế hoạch''
														WHEN eventstatus=''Held'' OR eventstatus=''Đã tổ chức'' THEN ''Đã tổ chức''
														WHEN eventstatus=''Not Held'' THEN ''Không tổ chức''
														ELSE ''Không xác định'' END AS ''status''
										FROM vtiger_activity ) a
								ON c.crmid = a.activityid
								
								LEFT JOIN vtiger_seactivityrel sa
								ON sa.activityid = c.crmid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = sa.crmid
								
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g
								ON g.groupid = ug.groupid
								
								WHERE 1=1');
	
	

	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0'' AND u.status = ''Active''');
	SET myquery = CONCAT(myquery,' AND c.deleted = ''0''');
	SET myquery = CONCAT(myquery,' AND c2.deleted = ''0''');

	/*Chọn theo thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery  = CONCAT(myquery,' AND DATE(a.date_start) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c2.crmid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND g.groupid = ''',dept_id,'''');
	END IF;
	
	/*Chọn theo col*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;

	SET myquery = CONCAT (myquery,' GROUP BY 1 ORDER BY YEAR(a.date_start), QUARTER(a.date_start)');
	

	SELECT myquery;
	SET @SQL := myquery;
	PREPARE my_query1 FROM @SQL;
	EXECUTE my_query1;

END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_user_activity_year
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_activity_year`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)

)
BEGIN

	DECLARE myquery nvarchar(4000);
	
	
	SET myquery = CONCAT('SELECT CAST(Year(date_start) AS CHAR) AS ''date'', COUNT(DISTINCT a.activityid) AS ''SL_activity''
								FROM vtiger_users u
								
								LEFT JOIN vtiger_crmentity c
								ON c.smownerid = u.id
																
								LEFT JOIN (SELECT activityid, subject, activitytype,date_start,due_date,time_start,time_end,
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_hours IS NULL THEN 0 ELSE duration_hours END AS ''duration_hours'',
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_minutes IS NULL THEN 0 ELSE duration_minutes END AS ''duration_minutes'',
												CASE WHEN status=''In Progress'' THEN ''Đang xử lý''
														WHEN status=''Completed'' OR status=''Hoàn thành'' THEN ''Đã hoàn thành''
														WHEN status=''Pending Input'' THEN ''Đang chờ xử lý''
														WHEN status=''Deferred'' THEN ''Trì hoãn''
														WHEN status=''Planned'' THEN ''Đã lên kế hoạch''
														WHEN eventstatus=''Planned'' THEN ''Lên kế hoạch''
														WHEN eventstatus=''Held'' OR eventstatus=''Đã tổ chức'' THEN ''Đã tổ chức''
														WHEN eventstatus=''Not Held'' THEN ''Không tổ chức''
														ELSE ''Không xác định'' END AS ''status''
										FROM vtiger_activity ) a
								ON c.crmid = a.activityid
								
								LEFT JOIN vtiger_seactivityrel sa
								ON sa.activityid = c.crmid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = sa.crmid
									
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g
								ON g.groupid = ug.groupid
								
								WHERE 1=1');
	
	

	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0'' AND u.status = ''Active''');
	SET myquery = CONCAT(myquery,' AND c.deleted = ''0''');
	SET myquery = CONCAT(myquery,' AND c2.deleted = ''0''');
	
	/*Chọn theo thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery  = CONCAT(myquery,' AND DATE(a.date_start) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;
		
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c2.crmid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND g.groupid = ''',dept_id,'''');
	END IF;
		
	/*Chọn theo col*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;

	SET myquery = CONCAT (myquery,' GROUP BY 1 ORDER BY 1');

	

	SELECT myquery;
	SET @SQL := myquery;
	PREPARE my_query1 FROM @SQL;
	EXECUTE my_query1;

END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_user_all
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_all`(
	IN `id_proc` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
   /*Overview*/
	IF id_proc = 'ov_user' THEN
		CALL dsa_user_total(start_date,end_date,account_id,user_assign,dept_id,col,val);
	END IF;
	
	IF id_proc = 'ov_activity' THEN
		CALL dsa_user_total_activity(start_date,end_date,account_id,user_assign,dept_id,col,val);
	END IF;
	
	IF id_proc = 'ov_salesorder' THEN
		CALL dsa_user_total_salesorder(start_date,end_date,account_id,user_assign,dept_id,col,val);
	END IF;
	
	IF id_proc = 'ov_task_created' THEN
		CALL dsa_user_total_task_created(start_date,end_date,account_id,user_assign,dept_id,col,val);
	END IF;
	
	IF id_proc = 'ov_task_finished' THEN
		CALL dsa_user_total_task_finished(start_date,end_date,account_id,user_assign,dept_id,col,val);
	END IF;
	
	IF id_proc = 'ov_task_delay' THEN
		CALL dsa_user_total_task_delay(start_date,end_date,account_id,user_assign,dept_id,col,val);
	END IF;
	
	/*Bar chart*/
	
	IF id_proc = 'user_salesorder' THEN
		CALL dsa_user_salesorder(start_date,end_date,account_id,user_assign,dept_id,col,val);
	END IF;
	
	IF id_proc = 'user_task_created' THEN
		CALL dsa_user_task_created(start_date,end_date,account_id,user_assign,dept_id,col,val);
	END IF;
	
	IF id_proc = 'user_task_finished' THEN
		CALL dsa_user_task_finished(start_date,end_date,account_id,user_assign,dept_id,col,val);
	END IF;
	
	
	/*Table*/
	
		/*Bảng chi tiết hoạt động*/
	IF id_proc = 'activity_detail' THEN
		CALL dsa_user_activity_detail(start_date,end_date,account_id,user_assign,dept_id,col,val);
	END IF;
	
		/*Bảng nhân viên không có hoạt động*/
	IF id_proc = 'without_activity' THEN
		CALL dsa_user_without_activity(start_date,end_date,account_id,user_assign,dept_id,col,val);
	END IF;
	
		/*Bảng chi tiết task delay*/
	IF id_proc = 'task_delay_detail' THEN
		CALL dsa_user_task_delay_detail(start_date,end_date,account_id,user_assign,dept_id,col,val);
	END IF;
		/*Bảng NV không login*/
	IF id_proc = 'without_login' THEN
		CALL dsa_user_without_login(start_date,end_date,account_id,user_assign,dept_id,col,val);
	END IF;
	
	/*Line chart*/
	IF id_proc = 'user_activity_day' THEN
		CALL dsa_user_activity_day(start_date,end_date,account_id,user_assign,dept_id,col,val);
	END IF;
	
	IF id_proc = 'user_activity_month' THEN
		CALL dsa_user_activity_month(start_date,end_date,account_id,user_assign,dept_id,col,val);
	END IF;
	
	IF id_proc = 'user_activity_quarter' THEN
		CALL dsa_user_activity_quarter(start_date,end_date,account_id,user_assign,dept_id,col,val);
	END IF;
	
	IF id_proc = 'user_activity_year' THEN
		CALL dsa_user_activity_year(start_date,end_date,account_id,user_assign,dept_id,col,val);
	END IF;
	
	IF id_proc = 'user_productivity' THEN
		CALL dsa_user_productivity(start_date,end_date,account_id,user_assign,dept_id,col,val);
	END IF;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_user_ddl_account
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_ddl_account`()
BEGIN
	DECLARE myquery nvarchar(2000);
	
	SET myquery = CONCAT('SELECT c.crmid, CONCAT(c.label,'' ('', a.account_no, '')'')
								FROM vtiger_account a
								
								JOIN vtiger_crmentity c
								ON c.crmid = a.accountid
								
								WHERE c.deleted = ''0''		
								ORDER BY c.label');
								
	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_user_ddl_all
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_ddl_all`(
	IN `id_ddl` VARCHAR(50)
)
BEGIN
	IF id_ddl = 'ddl_account' THEN
		CALL dsa_user_ddl_account();
	END IF;
	
	IF id_ddl = 'ddl_dept' THEN
		CALL dsa_user_ddl_dept();
	END IF;

	IF id_ddl = 'ddl_user_assign' THEN
		CALL dsa_user_ddl_user_assign();
	END IF;
	

END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_user_ddl_dept
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_ddl_dept`()
BEGIN
	DECLARE myquery nvarchar(2000);

	SET myquery = CONCAT('SELECT g.groupid, g.groupname 
								FROM vtiger_groups g
								ORDER BY g.groupname');
	

	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_user_ddl_user_assign
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_ddl_user_assign`()
BEGIN
	DECLARE myquery nvarchar(2000);
	SET myquery = CONCAT('(SELECT u.id, CONCAT(u.last_name,'' '', u.first_name, '' ('', u.user_name, '')'') AS ''NV_assign''
								FROM vtiger_users u
								WHERE u.deleted = ''0'' and u.status = ''Active''
								ORDER BY u.user_name)');
	


	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_user_productivity
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_productivity`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)


)
BEGIN
	DECLARE myquery nvarchar(4000);
	
	SET myquery = CONCAT('SELECT CONCAT(Day(a.due_date),''/'',Month(a.due_date),''/'', Year(a.due_date)) AS DATE,
				 							CONCAT(ROUND((SUM(a.duration_hours)+SUM(a.duration_minutes)/60)/(8*COUNT(DISTINCT u.user_name))*100,2),''%'') AS Nang_suat				
								FROM vtiger_users u
								
								LEFT JOIN vtiger_crmentity c
								ON c.smownerid = u.id
								
								LEFT JOIN (SELECT activityid, subject, activitytype,date_start,due_date,time_start,time_end,
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_hours IS NULL THEN 0 ELSE duration_hours END AS ''duration_hours'',
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_minutes IS NULL THEN 0 ELSE duration_minutes END AS ''duration_minutes'',
												CASE WHEN status=''In Progress'' THEN ''Đang xử lý''
														WHEN status=''Completed'' OR status=''Hoàn thành'' THEN ''Đã hoàn thành''
														WHEN status=''Pending Input'' THEN ''Đang chờ xử lý''
														WHEN status=''Deferred'' THEN ''Trì hoãn''
														WHEN status=''Planned'' THEN ''Đã lên kế hoạch''
														WHEN eventstatus=''Planned'' THEN ''Lên kế hoạch''
														WHEN eventstatus=''Held'' OR eventstatus=''Đã tổ chức'' THEN ''Đã tổ chức''
														WHEN eventstatus=''Not Held'' THEN ''Không tổ chức''
														ELSE ''Không xác định'' END AS ''status''
										FROM vtiger_activity ) a
								ON c.crmid = a.activityid
								
								LEFT JOIN vtiger_seactivityrel sa
								ON sa.activityid = c.crmid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = sa.crmid
								
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g
								ON g.groupid = ug.groupid
								
								WHERE 1=1');
							
	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0'' AND u.status = ''Active''');	
	SET myquery = CONCAT(myquery, ' AND c.deleted = ''0''');
	SET myquery = CONCAT(myquery, ' AND a.due_date IS NOT NULL');
	SET myquery = CONCAT(myquery,	' AND (a.status = ''Đã hoàn thành'' OR a.status = ''Đã tổ chức'') ');
	
	/*Chọn theo thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery  = CONCAT(myquery,' AND DATE(a.due_date) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c2.crmid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND g.groupid = ''',dept_id,'''');
	END IF;
		
	/*Chọn theo col*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;

	SET myquery = CONCAT(myquery, ' GROUP BY 1 ORDER BY YEAR(a.due_date), MONTH(a.due_date), DAY(a.due_date)');
	
	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_user_salesorder
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_salesorder`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(4000);

	
	
	SET myquery = CONCAT('SELECT c.smownerid,u.user_name AS ''NV_assign'', COUNT(DISTINCT so.salesorderid) 
								FROM vtiger_users u	
								LEFT JOIN vtiger_crmentity c
								ON c.smownerid = u.id
								LEFT JOIN vtiger_salesorder so
								ON c.crmid = so.salesorderid 	
								LEFT JOIN vtiger_crmentity c2
								ON so.accountid = c2.crmid 		
									
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g
								ON g.groupid = ug.groupid
																		 
								WHERE 1=1');
							
	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0''');	
	SET myquery = CONCAT(myquery, ' AND c.deleted = ''0''');
	SET myquery = CONCAT(myquery, ' AND c2.deleted = ''0'''); 

	/*Chọn theo thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery  = CONCAT(myquery,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND AND c2.crmid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND g.groupid = ''',dept_id,'''');
	END IF;
		
	/*Chọn theo col*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;

	SET myquery = CONCAT(myquery, ' GROUP BY 1 ORDER BY 3 DESC,2');
	

	
	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;	
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_user_task_created
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_task_created`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)


)
BEGIN

	DECLARE myquery nvarchar(4000);

	
	
	SET myquery = CONCAT('SELECT c.smownerid,u.user_name AS ''NV_assign'', COUNT(DISTINCT a.activityid)
								FROM vtiger_users u
								
								LEFT JOIN vtiger_crmentity c
								ON c.smownerid = u.id
																
								LEFT JOIN (SELECT activityid, subject, activitytype,date_start,due_date,time_start,time_end,
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_hours IS NULL THEN 0 ELSE duration_hours END AS ''duration_hours'',
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_minutes IS NULL THEN 0 ELSE duration_minutes END AS ''duration_minutes'',
												CASE WHEN status=''In Progress'' THEN ''Đang xử lý''
														WHEN status=''Completed'' OR status=''Hoàn thành'' THEN ''Đã hoàn thành''
														WHEN status=''Pending Input'' THEN ''Đang chờ xử lý''
														WHEN status=''Deferred'' THEN ''Trì hoãn''
														WHEN status=''Planned'' THEN ''Đã lên kế hoạch''
														WHEN eventstatus=''Planned'' THEN ''Lên kế hoạch''
														WHEN eventstatus=''Held'' OR eventstatus=''Đã tổ chức'' THEN ''Đã tổ chức''
														WHEN eventstatus=''Not Held'' THEN ''Không tổ chức''
														ELSE ''Không xác định'' END AS ''status''
										FROM vtiger_activity ) a
								ON c.crmid = a.activityid
								
								LEFT JOIN vtiger_seactivityrel sa
								ON sa.activityid = c.crmid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = sa.crmid
									
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g
								ON g.groupid = ug.groupid
								
								
								WHERE 1=1');
	
	

	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0'' AND u.status = ''Active''');
	SET myquery = CONCAT(myquery,' AND c.deleted = ''0''');
	SET myquery = CONCAT(myquery,' AND c2.deleted = ''0''');

	
	/*Chọn theo thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery  = CONCAT(myquery,' AND DATE(a.date_start) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c2.crmid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND g.groupid = ''',dept_id,'''');
	END IF;
		
	/*Chọn theo col*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;

	SET myquery = CONCAT (myquery,' GROUP BY 1 ORDER BY 3 DESC,2');


	SELECT myquery;
	SET @SQL := myquery;
	PREPARE my_query1 FROM @SQL;
	EXECUTE my_query1;

END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_user_task_delay_detail
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_task_delay_detail`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `user_assign` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)





)
BEGIN

	DECLARE myquery nvarchar(4000);
	
	
	SET myquery = CONCAT('SELECT DISTINCT c.crmid, CONCAT(''['',c.label, '' ]'',''(http://crm.fastdn.com.vn/index.php?module=Calendar&view=Detail&record='',c.crmid,'')'') AS ''c.label'',
											u.user_name,
											a.status,
											DATEDIFF(DATE(NOW()), DATE(a.due_date)) AS delay_days
								FROM vtiger_users u
								
								LEFT JOIN vtiger_crmentity c
								ON c.smownerid = u.id
																
								LEFT JOIN (SELECT activityid, subject, activitytype,date_start,due_date,time_start,time_end,
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_hours IS NULL THEN 0 ELSE duration_hours END AS ''duration_hours'',
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_minutes IS NULL THEN 0 ELSE duration_minutes END AS ''duration_minutes'',
												CASE WHEN status=''In Progress'' THEN ''Đang xử lý''
														WHEN status=''Completed'' OR status=''Hoàn thành'' THEN ''Đã hoàn thành''
														WHEN status=''Pending Input'' THEN ''Đang chờ xử lý''
														WHEN status=''Deferred'' THEN ''Trì hoãn''
														WHEN status=''Planned'' THEN ''Đã lên kế hoạch''
														WHEN eventstatus=''Planned'' THEN ''Lên kế hoạch''
														WHEN eventstatus=''Held'' OR eventstatus=''Đã tổ chức'' THEN ''Đã tổ chức''
														WHEN eventstatus=''Not Held'' THEN ''Không tổ chức''
														ELSE ''Không xác định'' END AS ''status''
										FROM vtiger_activity ) a
								ON c.crmid = a.activityid
								
								LEFT JOIN vtiger_seactivityrel sa
								ON sa.activityid = c.crmid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = sa.crmid
								
								
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g
								ON g.groupid = ug.groupid
								
								WHERE 1=1');
	
	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0'' AND u.status = ''Active''');
	SET myquery = CONCAT(myquery,' AND c.deleted = ''0''');
	SET myquery = CONCAT(myquery,' AND c2.deleted = ''0''');
	SET myquery = CONCAT(myquery,' AND (a.status != ''Đã hoàn thành'' AND a.status != ''Đã tổ chức'')');
	
	SET myquery = CONCAT(myquery,' AND DATEDIFF(DATE(NOW()), DATE(a.due_date)) > 0');
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND AND c2.crmid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND g.groupid = ''',dept_id,'''');
	END IF;
		
	/*Chọn theo col*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;

	SET myquery = CONCAT(myquery,' ORDER BY delay_days DESC');
	SELECT myquery;
	SET @SQL := myquery;
	PREPARE my_query1 FROM @SQL;
	EXECUTE my_query1;

END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_user_task_finished
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_task_finished`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)




)
BEGIN

	DECLARE myquery nvarchar(4000);

	
	SET myquery = CONCAT('SELECT c.smownerid, u.user_name AS ''NV_assign'', COUNT(DISTINCT IF(a.status = ''Đã hoàn thành'' OR a.status = ''Đã tổ chức'',a.activityid,NULL))
								FROM vtiger_users u
								
								LEFT JOIN vtiger_crmentity c
								ON c.smownerid = u.id
																
								LEFT JOIN (SELECT activityid, subject, activitytype,date_start,due_date,time_start,time_end,
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_hours IS NULL THEN 0 ELSE duration_hours END AS ''duration_hours'',
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_minutes IS NULL THEN 0 ELSE duration_minutes END AS ''duration_minutes'',
												CASE WHEN status=''In Progress'' THEN ''Đang xử lý''
														WHEN status=''Completed'' OR status=''Hoàn thành'' THEN ''Đã hoàn thành''
														WHEN status=''Pending Input'' THEN ''Đang chờ xử lý''
														WHEN status=''Deferred'' THEN ''Trì hoãn''
														WHEN status=''Planned'' THEN ''Đã lên kế hoạch''
														WHEN eventstatus=''Planned'' THEN ''Lên kế hoạch''
														WHEN eventstatus=''Held'' OR eventstatus=''Đã tổ chức'' THEN ''Đã tổ chức''
														WHEN eventstatus=''Not Held'' THEN ''Không tổ chức''
														ELSE ''Không xác định'' END AS ''status''
										FROM vtiger_activity ) a
								ON c.crmid = a.activityid
								
								LEFT JOIN vtiger_seactivityrel sa
								ON sa.activityid = c.crmid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = sa.crmid
									
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g
								ON g.groupid = ug.groupid
								
								WHERE 1=1');
	
	

	SET myquery = CONCAT(myquery,' AND u.deleted = ''0'' AND u.status = ''Active''');
	SET myquery = CONCAT(myquery,' AND c.deleted = ''0''');
	SET myquery = CONCAT(myquery,' AND c2.deleted = ''0''');
	
	/*Chọn theo thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery  = CONCAT(myquery,' AND DATE(a.due_date) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;
	
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c2.crmid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND g.groupid = ''',dept_id,'''');
	END IF;	
	
	/*Chọn theo col*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;

	SET myquery = CONCAT (myquery,' GROUP BY 1 ORDER BY 3 DESC,2');

	
	
	
	SELECT myquery;
	SET @SQL := myquery;
	PREPARE my_query1 FROM @SQL;
	EXECUTE my_query1;

END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_user_total
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_total`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)

)
BEGIN
	DECLARE myquery nvarchar(2000);
	SET myquery = CONCAT('SELECT COUNT(DISTINCT u.user_name) 
								FROM vtiger_users u
									
								LEFT JOIN vtiger_crmentity c
								ON c.smownerid = u.id
																
								LEFT JOIN vtiger_activity a
								ON c.crmid = a.activityid
								
								LEFT JOIN vtiger_seactivityrel sa
								ON sa.activityid = c.crmid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = sa.crmid
								
									
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g
								ON g.groupid = ug.groupid
																					 
								WHERE 1=1');
							
	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0'' AND u.status = ''Active''');
	
	/*Chọn theo thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND DATE(date_entered) <= ''', end_date, ''' '); 
	END IF;	
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c2.crmid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND g.groupid = ''',dept_id,'''');
	END IF;
		
	/*Chọn theo col*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;

	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_user_total_activity
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_total_activity`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)

)
BEGIN

	DECLARE myquery nvarchar(4000);

	/*myquery: Phân công theo cá nhân NV*/
	SET myquery = CONCAT('SELECT COUNT(DISTINCT a.activityid) AS ''SL_activity''
								FROM vtiger_users u
								
								LEFT JOIN vtiger_crmentity c
								ON c.smownerid = u.id
																
								LEFT JOIN (SELECT activityid, subject, activitytype,date_start,due_date,time_start,time_end,
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_hours IS NULL THEN 0 ELSE duration_hours END AS ''duration_hours'',
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_minutes IS NULL THEN 0 ELSE duration_minutes END AS ''duration_minutes'',
												CASE WHEN status=''In Progress'' THEN ''Đang xử lý''
														WHEN status=''Completed'' OR status=''Hoàn thành'' THEN ''Đã hoàn thành''
														WHEN status=''Pending Input'' THEN ''Đang chờ xử lý''
														WHEN status=''Deferred'' THEN ''Trì hoãn''
														WHEN status=''Planned'' THEN ''Đã lên kế hoạch''
														WHEN eventstatus=''Planned'' THEN ''Lên kế hoạch''
														WHEN eventstatus=''Held'' OR eventstatus=''Đã tổ chức'' THEN ''Đã tổ chức''
														WHEN eventstatus=''Not Held'' THEN ''Không tổ chức''
														ELSE ''Không xác định'' END AS ''status''
										FROM vtiger_activity ) a
								ON c.crmid = a.activityid
								
								LEFT JOIN vtiger_seactivityrel sa
								ON sa.activityid = c.crmid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = sa.crmid
								
									
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g
								ON g.groupid = ug.groupid
								
								WHERE 1=1');
	
	

	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0'' AND u.status = ''Active''');
	SET myquery = CONCAT(myquery,' AND c.deleted = ''0''');
	SET myquery = CONCAT(myquery,' AND c2.deleted = ''0''');
	
	/*Chọn theo thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery  = CONCAT(myquery,' AND DATE(a.date_start) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;
		
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c2.crmid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND g.groupid = ''',dept_id,'''');
	END IF;
	
	/*Chọn theo col*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;

	SELECT myquery;
	SET @SQL := myquery;
	PREPARE my_query1 FROM @SQL;
	EXECUTE my_query1;

END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_user_total_salesorder
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_total_salesorder`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(4000);
	
	
	/*myquery: Phân công theo cá nhân NV*/
	SET myquery = CONCAT('SELECT COUNT(DISTINCT so.salesorderid) AS ''SL_salesorder''
								FROM vtiger_users u	
								LEFT JOIN vtiger_crmentity c
								ON c.smownerid = u.id
								LEFT JOIN vtiger_salesorder so
								ON c.crmid = so.salesorderid	
								LEFT JOIN vtiger_crmentity c2
								ON so.accountid = c2.crmid 
										
									
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g
								ON g.groupid = ug.groupid
																		 
								WHERE 1=1');
							
	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0''');	
	SET myquery = CONCAT(myquery, ' AND c.deleted = ''0''');
	SET myquery = CONCAT(myquery,' AND c2.deleted = ''0''');

	/*Chọn theo thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery  = CONCAT(myquery,' AND DATE(c.createdtime) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;
		
		/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c2.crmid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND g.groupid = ''',dept_id,'''');
	END IF;
	
		
	/*Chọn theo col*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;

	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;	
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_user_total_task_created
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_total_task_created`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)


)
BEGIN

	DECLARE myquery nvarchar(4000);

	
	/*myquery: Phân công theo cá nhân NV*/
	SET myquery = CONCAT('SELECT COUNT(DISTINCT a.activityid) AS ''SL_task''
								FROM vtiger_users u
								
								LEFT JOIN vtiger_crmentity c
								ON c.smownerid = u.id
																
								LEFT JOIN (SELECT activityid, subject, activitytype,date_start,due_date,time_start,time_end,
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_hours IS NULL THEN 0 ELSE duration_hours END AS ''duration_hours'',
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_minutes IS NULL THEN 0 ELSE duration_minutes END AS ''duration_minutes'',
												CASE WHEN status=''In Progress'' THEN ''Đang xử lý''
														WHEN status=''Completed'' OR status=''Hoàn thành'' THEN ''Đã hoàn thành''
														WHEN status=''Pending Input'' THEN ''Đang chờ xử lý''
														WHEN status=''Deferred'' THEN ''Trì hoãn''
														WHEN status=''Planned'' THEN ''Đã lên kế hoạch''
														WHEN eventstatus=''Planned'' THEN ''Lên kế hoạch''
														WHEN eventstatus=''Held'' OR eventstatus=''Đã tổ chức'' THEN ''Đã tổ chức''
														WHEN eventstatus=''Not Held'' THEN ''Không tổ chức''
														ELSE ''Không xác định'' END AS ''status''
										FROM vtiger_activity ) a
								ON c.crmid = a.activityid
								
								LEFT JOIN vtiger_seactivityrel sa
								ON sa.activityid = c.crmid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = sa.crmid
													
									
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g
								ON g.groupid = ug.groupid
								
								
								WHERE 1=1');
	
	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0'' AND u.status = ''Active''');
	SET myquery = CONCAT(myquery,' AND u.deleted = ''0''');
	SET myquery = CONCAT(myquery,' AND c.deleted = ''0''');
	SET myquery = CONCAT(myquery,' AND c2.deleted = ''0''');

	
	
	/*Chọn theo thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery  = CONCAT(myquery,' AND DATE(a.date_start) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;
		
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c2.crmid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND g.groupid = ''',dept_id,'''');
	END IF;
	
	/*Chọn theo col*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;

	SELECT myquery;
	SET @SQL := myquery;
	PREPARE my_query1 FROM @SQL;
	EXECUTE my_query1;

END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_user_total_task_delay
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_total_task_delay`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `user_assign` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)




)
BEGIN

	DECLARE myquery nvarchar(4000);
	
	
	SET myquery = CONCAT('SELECT COUNT(DISTINCT a.activityid) AS ''SL_task_delay''
								FROM vtiger_users u
								
								LEFT JOIN vtiger_crmentity c
								ON c.smownerid = u.id
																
								LEFT JOIN (SELECT activityid, subject, activitytype,date_start,due_date,time_start,time_end,
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_hours IS NULL THEN 0 ELSE duration_hours END AS ''duration_hours'',
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_minutes IS NULL THEN 0 ELSE duration_minutes END AS ''duration_minutes'',
												CASE WHEN status=''In Progress'' THEN ''Đang xử lý''
														WHEN status=''Completed'' OR status=''Hoàn thành'' THEN ''Đã hoàn thành''
														WHEN status=''Pending Input'' THEN ''Đang chờ xử lý''
														WHEN status=''Deferred'' THEN ''Trì hoãn''
														WHEN status=''Planned'' THEN ''Đã lên kế hoạch''
														WHEN eventstatus=''Planned'' THEN ''Lên kế hoạch''
														WHEN eventstatus=''Held'' OR eventstatus=''Đã tổ chức'' THEN ''Đã tổ chức''
														WHEN eventstatus=''Not Held'' THEN ''Không tổ chức''
														ELSE ''Không xác định'' END AS ''status''
										FROM vtiger_activity ) a
								ON c.crmid = a.activityid
								
								LEFT JOIN vtiger_seactivityrel sa
								ON sa.activityid = c.crmid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = sa.crmid
								
								
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g
								ON g.groupid = ug.groupid
								
								WHERE 1=1');
	
	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0'' AND u.status = ''Active''');
	SET myquery = CONCAT(myquery,' AND c.deleted = ''0''');
	SET myquery = CONCAT(myquery,' AND c2.deleted = ''0''');
	SET myquery = CONCAT(myquery,' AND (a.status != ''Đã hoàn thành'' AND a.status != ''Đã tổ chức'')');

	SET myquery = CONCAT(myquery,' AND DATEDIFF(DATE(NOW()), DATE(a.due_date)) > 0');

	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND AND c2.crmid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND g.groupid = ''',dept_id,'''');
	END IF;
		
	/*Chọn theo col*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;

	SET myquery = CONCAT(myquery,' ORDER BY 1');
	SELECT myquery;
	SET @SQL := myquery;
	PREPARE my_query1 FROM @SQL;
	EXECUTE my_query1;

END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_user_total_task_finished
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_total_task_finished`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)



)
BEGIN
	DECLARE myquery nvarchar(4000);


	/*myquery: Phân công theo cá nhân NV*/
	SET myquery = CONCAT('SELECT COUNT(DISTINCT IF(a.status = ''Đã hoàn thành'' OR a.status = ''Đã tổ chức'',a.activityid,NULL)) AS ''SL_task_finished''
								FROM vtiger_users u
								
								LEFT JOIN vtiger_crmentity c
								ON c.smownerid = u.id
																
								LEFT JOIN (SELECT activityid, subject, activitytype,date_start,due_date,time_start,time_end,
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_hours IS NULL THEN 0 ELSE duration_hours END AS ''duration_hours'',
												CASE WHEN time_end = '''' OR time_end =''00:00:00'' OR duration_minutes IS NULL THEN 0 ELSE duration_minutes END AS ''duration_minutes'',
												CASE WHEN status=''In Progress'' THEN ''Đang xử lý''
														WHEN status=''Completed'' OR status=''Hoàn thành'' THEN ''Đã hoàn thành''
														WHEN status=''Pending Input'' THEN ''Đang chờ xử lý''
														WHEN status=''Deferred'' THEN ''Trì hoãn''
														WHEN status=''Planned'' THEN ''Đã lên kế hoạch''
														WHEN eventstatus=''Planned'' THEN ''Lên kế hoạch''
														WHEN eventstatus=''Held'' OR eventstatus=''Đã tổ chức'' THEN ''Đã tổ chức''
														WHEN eventstatus=''Not Held'' THEN ''Không tổ chức''
														ELSE ''Không xác định'' END AS ''status''
										FROM vtiger_activity ) a
								ON c.crmid = a.activityid
								
								LEFT JOIN vtiger_seactivityrel sa
								ON sa.activityid = c.crmid
								
								LEFT JOIN vtiger_crmentity c2
								ON c2.crmid = sa.crmid
								
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g
								ON g.groupid = ug.groupid
								
								WHERE 1=1');
	
	

	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0'' AND u.status = ''Active''');
	SET myquery = CONCAT(myquery,' AND c.deleted = ''0''');
	SET myquery = CONCAT(myquery,' AND c2.deleted = ''0''');

	
	/*Chọn theo thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery  = CONCAT(myquery,' AND DATE(a.due_date) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;
	
	/*Chọn theo khách hàng*/
	IF(account_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c2.crmid = ''',account_id,'''');
	END IF;
	
	/*Chọn theo user được phân công*/
	IF(user_assign IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND c.smownerid = ''',user_assign,'''');
	END IF;
	
	/*Chọn theo phòng ban*/
	IF(dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND g.groupid = ''',dept_id,'''');
	END IF;
	
	/*Chọn theo col*/
	IF (col IS NOT NULL) AND (col = 'c.label') THEN
		SET myquery = CONCAT(myquery,' AND c.crmid = ''', val,''' ');
	END IF;
	
	IF (col IS NOT NULL) AND (col != 'c.label')  THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;

	SELECT myquery;
	SET @SQL := myquery;
	PREPARE my_query1 FROM @SQL;
	EXECUTE my_query1;

END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_user_without_activity
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_without_activity`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `user_assign` INT,
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)



)
BEGIN
	DECLARE myquery nvarchar(2000);
	DECLARE myquery1 nvarchar(2000);
					
	SET myquery  = CONCAT('SELECT u.user_name
								FROM vtiger_users u
								LEFT JOIN vtiger_crmentity c
								ON c.smownerid = u.id
								LEFT JOIN vtiger_activity a
								ON c.crmid = a.activityid
									
								LEFT JOIN vtiger_users2group ug
								ON ug.userid = c.smownerid
								
								LEFT JOIN vtiger_groups g
								ON g.groupid = ug.groupid
								
								
								WHERE 1=1');
							
	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0'' AND u.status = ''Active''');
	SET myquery = CONCAT(myquery, ' AND c.deleted = ''0''');

		/*Lọc theo khoảng thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery  = CONCAT(myquery,' AND DATE(a.date_start) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;

	
	SET myquery  = CONCAT(myquery , ' GROUP BY u.user_name ');
	
	SET myquery1 = CONCAT ('SELECT u.user_name,
											GROUP_CONCAT(DISTINCT CONCAT(Day(l.login_time),''/'',Month(l.login_time),''/'', Year(l.login_time)) ORDER BY YEAR(l.login_time), MONTH(l.login_time), DAY(l.login_time) SEPARATOR ''\n'')
									FROM vtiger_users u
									LEFT JOIN vtiger_loginhistory l
									ON l.user_name = u.user_name
										
									LEFT JOIN vtiger_users2group ug
									ON ug.userid = u.id
								
									LEFT JOIN vtiger_groups g
									ON g.groupid = ug.groupid
								
									WHERE u.deleted =''0'' AND u.status = ''Active'' 
									AND u.user_name NOT IN  (',myquery,')');	

	/*Lọc theo khoảng thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery1  = CONCAT(myquery1,' AND DATE(l.login_time) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;	
	
	/*Lọc theo nhân viên*/
	IF (user_assign IS NOT NULL) THEN
		SET myquery1 = CONCAT(myquery1,' AND u.id = ''', user_assign, '''');
	END IF;
	
	/*Lọc theo phòng ban*/
	IF (dept_id IS NOT NULL) THEN
		SET myquery1 = CONCAT(myquery1,' AND g.groupid = ''',dept_id, '''');
	END IF;
		
	/*Chọn theo col*/
	IF (col IS NOT NULL) AND (col != 'c.label') AND (col != 'c2.label') THEN
		SET myquery1 = CONCAT(myquery1,' AND ',col, ' = ''', val,''' ');
	END IF;

	SET myquery1 = CONCAT(myquery1,' GROUP BY u.user_name ORDER BY u.user_name');
	SELECT myquery1;
	SET @SQL := myquery1;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.dsa_user_without_login
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_without_login`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `account_id` INT,
	IN `user_assign` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)


)
BEGIN
	DECLARE myquery nvarchar(2000);
	DECLARE myquery1 nvarchar(2000);
						
	SET myquery  = CONCAT('SELECT DISTINCT u.user_name
								FROM vtiger_users u
								LEFT JOIN vtiger_loginhistory l
								ON l.user_name = u.user_name
								WHERE 1=1 ');
	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0'' AND u.status = ''Active''');
	
	/*Lọc theo khoảng thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) AND (start_date = end_date) THEN
		SET myquery  = CONCAT(myquery,' AND DATE(l.login_time) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;

	SET myquery  = CONCAT(myquery , ' GROUP BY u.user_name ');
	
	SET myquery1 = CONCAT ('SELECT DISTINCT u.user_name
									FROM vtiger_users u	
			
									LEFT JOIN vtiger_users2group ug
									ON ug.userid = u.id
									
									LEFT JOIN vtiger_groups g
									ON g.groupid = ug.groupid
									
									WHERE u.deleted =''0'' AND u.status = ''Active''
									AND u.user_name NOT IN (',myquery,')');	
				
	/*Lọc theo nhân viên*/
	IF (user_assign IS NOT NULL) THEN
		SET myquery1 = CONCAT(myquery1,' AND u.id = ''', user_assign, '''');
	END IF;
	
	/*Lọc theo phòng ban*/
	IF (dept_id IS NOT NULL) THEN
		SET myquery1 = CONCAT(myquery1,' AND g.groupid = ''',dept_id, '''');
	END IF;
		
	/*Chọn theo col*/
	IF (col IS NOT NULL) AND (col != 'c.label')  THEN
		SET myquery1 = CONCAT(myquery1,' AND ',col, ' = ''', val,''' ');
	END IF;	
	
	SET myquery1 = CONCAT(myquery1,' GROUP BY u.user_name ORDER BY u.user_name');
	

	SELECT myquery1;
	SET @SQL := myquery1;
	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.publish_vtiger_project
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `publish_vtiger_project`(
	IN `p1` VARCHAR(255),
	IN `p2` VARCHAR(255),
	IN `p3` VARCHAR(255)
)
BEGIN DECLARE cmd CHAR(255); 
    DECLARE result CHAR(255); 
    SET cmd = CONCAT('curl http://192.168.1.234:9090/vtiger_project/insert?id=',p1,'%26key=',p2,'%26status=',p3,'%26group=0'); 
    SET result = sys_exec(cmd);
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.SEND
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SEND`(
    id INT,
    user_name VARCHAR(50),
    ip VARCHAR(50),
STATUS VARCHAR
    (50)
)
BEGIN
    DECLARE
        cmd VARCHAR(255) ; DECLARE result VARCHAR(255) ;
    SET
        cmd = CONCAT(
            'curl http://192.168.1.234:9090/login/insert?id=',
            id,
            '%26key=',
            id,
            '%26user=',
            user_name,
            '%26ip=',
            ip,
            '%26status=',
        REPLACE
            (
        STATUS
            ,
            ' ',
            ''
        )
        ) ;
    SET
        result = sys_exec(cmd) ;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.sp_Card_Overview_KH
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Card_Overview_KH`(IN col CHAR(2), IN value_filter VARCHAR(100), IN ddl_NV VARCHAR(3), IN ddl_TT VARCHAR(30), IN ddl_TP VARCHAR(30), IN ddl_NG VARCHAR(50))
BEGIN
	DECLARE _query_ varchar(2000);
	DECLARE _check INT;
	SET _check = 0;
   SET _query_ = CONCAT('SELECT COUNT(vc.crmid) FROM vtiger_crmentity vc');
	
   IF (ddl_TP IS NOT NULL) Then
      SET _query_ = CONCAT(_query_, ' JOIN vtiger_accountshipads vasp ON vasp.ship_city = N''', ddl_TP, '''',
                                    ' AND vasp.accountaddressid = vc.crmid');
      SET _check = 1;
   END IF;
    
   IF (ddl_NG IS NOT NULL) Then
      SET _query_ = CONCAT(_query_, ' JOIN vtiger_account va ON va.industry = N''', ddl_NG, '''',
		  										' AND va.accountid = vc.crmid');
      SET _check = 1;
   END IF;
    
   IF (ddl_TT IS NOT NULL) Then
    	SET _query_ = CONCAT(_query_, ' JOIN vtiger_accountscf vas ON vas.cf_891 = ''', ddl_TT, '''',
		  										' AND vas.accountid = vc.crmid');
      SET _check = 1;
   END IF;
    
   IF (ddl_NV IS NOT NULL AND _check = 1) Then
      SET _query_ = CONCAT(_query_, ' AND vc.smownerid = ', ddl_NV);
   ELSEIF (ddl_NV IS NOT NULL AND _check = 0) Then
    	SET _query_ = CONCAT(_query_, ' WHERE vc.smownerid = ', ddl_NV);
      SET _check = 1;
   END IF;
    
	IF (col = 'NV') Then
		SET _query_ = CONCAT(_query_,' WHERE vc.smownerid = ', value_filter);
		SET _check = 1;
   ELSEIF (col = 'TP') Then
	   SET _query_ = CONCAT(_query_, ' JOIN vtiger_accountshipads vasp ON vasp.ship_city = ''', value_filter, '''',
                                    ' AND vc.crmid = vasp.accountaddressid');
   ELSEIF (col = 'NG') Then
      SET _query_ = CONCAT(_query_, ' JOIN vtiger_account va ON va.industry = N''', value_filter, '''',
		  										' AND va.accountid = vc.crmid');
	END IF;
	
   IF (_check = 1) Then
		SET _query_ = CONCAT(_query_, ' AND vc.setype = ''Accounts'';');
   ELSEIF (_check = 0) Then
    	SET _query_ = CONCAT(_query_, ' WHERE vc.setype = ''Accounts'';');
   END IF;
    
   SET @_query_ = _query_;
	PREPARE my_query FROM @_query_;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.sp_Card_Overview_NG
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Card_Overview_NG`(
	IN `col` CHAR(2),
	IN `value_filter` VARCHAR(100),
	IN `ddl_NV` VARCHAR(3),
	IN `ddl_TT` VARCHAR(30),
	IN `ddl_TP` VARCHAR(30)
)
BEGIN
    DECLARE _query_ VARCHAR(2000);
    SET _query_ = CONCAT('SELECT COUNT(distinct va.industry) FROM vtiger_account va',
                         ' JOIN vtiger_crmentity vc ON va.accountid = vc.crmid AND vc.setype = ''Accounts''');
                         
	IF (ddl_NV IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' AND vc.smownerid = ', ddl_NV);
    END IF;
    
    IF (ddl_TP IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_accountshipads vasp ON vasp.ship_city = N''', ddl_TP, '''',
                                      ' AND vasp.accountaddressid = vc.crmid');
    END IF;
    
    IF (ddl_TT IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_accountscf vas ON vas.accountid = va.accountid',
                                      ' AND vas.cf_891 = ''', ddl_TT, '''');
    END IF;
    
    IF (col = 'NV') Then
		SET _query_ = CONCAT(_query_,' AND vc.smownerid = ', value_filter);
    ELSEIF (col = 'TP') Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_accountshipads vasp ON vasp.ship_city = ''', value_filter, '''',
                                      ' AND vc.crmid = vasp.accountaddressid');
    END IF;
    
    SET _query_ = CONCAT(_query_,';');
    
	SET @_query_ = _query_;
	PREPARE my_query FROM @_query_;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.sp_Card_Overview_NV
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Card_Overview_NV`(
	IN `col` CHAR(2),
	IN `value_filter` VARCHAR(100),
	IN `ddl_TP` VARCHAR(20),
	IN `ddl_NG` VARCHAR(50),
	IN `ddl_TT` VARCHAR(30)
)
BEGIN
    DECLARE _query_ VARCHAR(2000);
    SET _query_ = CONCAT('SELECT COUNT(distinct vu.id) AS SLNV',
						 ' FROM vtiger_crmentity vc',
                         ' JOIN vtiger_users vu ON vc.smownerid = vu.id AND vc.setype = ''Accounts'' AND vu.status = ''Active''');
    
    IF (ddl_TP IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_accountshipads vasp ON vasp.ship_city like N''%', ddl_TP, '%''',
                                      ' AND vasp.accountaddressid = vc.crmid');
    END IF;
    
    IF (ddl_NG IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_account va ON va.industry like N''%', ddl_NG, '%''',
                                      ' AND va.accountid = vc.crmid');
    END IF;
    
    IF (ddl_TT IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_accountscf vas ON vas.cf_891 = ''', ddl_TT, '''',
                                      ' AND vas.accountid = vc.crmid');
    END IF;
    
	IF (col = 'TP') Then
		SET _query_ = CONCAT(_query_,' JOIN vtiger_accountshipads vas ON vc.crmid = vas.accountaddressid AND vas.ship_city LIKE');
        SET _query_ = CONCAT(_query_,' ''%', value_filter, '%''');
    ELSEIF (col = 'NG') Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_account va ON va.industry like N''%', value_filter, '%''',
                                      ' AND va.accountid = vc.crmid');
	END IF;
	
	SET _query_ = CONCAT(_query_,';');
	
	SET @_query_ = _query_;
	PREPARE my_query FROM @_query_;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.sp_Card_Overview_TP
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Card_Overview_TP`(
	IN `col` CHAR(2),
	IN `value_filter` VARCHAR(100),
	IN `ddl_NV` VARCHAR(3),
	IN `ddl_TT` VARCHAR(30),
	IN `ddl_NG` VARCHAR(50)
)
BEGIN
    DECLARE _query_ VARCHAR(2000);
    SET _query_ = CONCAT('SELECT COUNT(DISTINCT vasp.ship_city)',
                        ' FROM vtiger_account va JOIN vtiger_accountshipads vasp ON va.accountid = vasp.accountaddressid AND vasp.ship_city != ''''',
                        ' JOIN vtiger_crmentity vc ON va.accountid = vc.crmid AND vc.setype = ''Accounts''');
    
    IF (ddl_NV IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' AND vc.smownerid = ', ddl_NV);
    END IF;
    
    IF (ddl_TT IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_accountscf vas ON vas.cf_891 = ''', ddl_TT, '''',
                                      ' AND vas.accountid = va.accountid');
    END IF;
    
    IF (ddl_NG IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' AND va.industry = N''', ddl_NG, '''');
    END IF;

    IF (col = 'NV') THEN
        SET _query_ = CONCAT(_query_, ' AND vc.smownerid = ', value_filter);
    ELSEIF (col = 'NG') THEN
        SET _query_ = CONCAT(_query_, ' AND va.industry = N''', value_filter, '''');
    END IF;
    
    SET _query_ = CONCAT(_query_, ';');
	
	 SET @_query_ = _query_;
    PREPARE my_query FROM @_query_;
    EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.sp_ddl_filter_KH
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ddl_filter_KH`(
	IN `filter_name` CHAR(2)
)
BEGIN
    DECLARE _query_ VARCHAR(2000);
	
	IF (filter_name = 'TT') Then
		SET _query_ = 'SELECT distinct cf_891 FROM vtiger_accountscf;';
	END IF;

    IF (filter_name = 'NG') Then
        SET _query_ = 'SELECT distinct IF(industry IS NULL OR industry = '''', ''Trống'', industry) AS industry FROM vtiger_account ORDER BY industry;';
	END IF;
    
    IF (filter_name = 'TP') Then
		SET _query_ = 'SELECT DISTINCT ship_city FROM vtiger_accountshipads;';
	END IF;
    
    IF (filter_name = 'NV') Then
		SET _query_ = CONCAT('SELECT distinct vc.smownerid, CONCAT(vu.last_name, '' '', vu.first_name) AS HoTen ',
                             'FROM vtiger_users vu JOIN vtiger_crmentity vc ',
                             'ON vu.status = ''Active'' AND vu.id = vc.smownerid AND vc.setype = ''Accounts'';');
	END IF;
	
	SET @_query_ = _query_;
	PREPARE my_query FROM @_query_;
	EXECUTE my_query;

END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.sp_Demo
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Demo`(IN ddl_TP VARCHAR(30))
BEGIN
	DECLARE i INT;
	SET i = 0;
	IF (ddl_TP IS NOT NULL) Then
		SET i = 1;
	END IF;
	SELECT i;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.sp_KH_TT
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_KH_TT`(
	IN `col` CHAR(2),
	IN `value_filter` VARCHAR(100),
	IN `ddl_NV` VARCHAR(3),
	IN `ddl_TP` VARCHAR(20),
	IN `ddl_NG` VARCHAR(50)
)
BEGIN
    DECLARE _query_ VARCHAR(2000);
    SET _query_ = CONCAT('SELECT CASE WHEN vas.cf_891 = '''' Then ''Không có trạng thái'' ELSE vas.cf_891 END, COUNT(*) SLKH',
						 ' FROM vtiger_accountscf vas',
                         ' JOIN vtiger_crmentity vc ON vc.setype = ''Accounts'' AND vas.accountid = vc.crmid');
    
    IF (ddl_NV IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' AND vc.smownerid = ', ddl_NV);
    END IF;
    
    IF (ddl_TP IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_accountshipads vasp ON vasp.ship_city like N''%', ddl_TP, '%''',
                                      ' AND vas.accountid = vasp.accountaddressid');
    END IF;
    
    IF (ddl_NG IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_account va ON va.industry like N''%', ddl_NG, '%''',
                                      ' AND va.accountid = vas.accountid');
    END IF;
    
	IF (col = 'NV') Then
		SET _query_ = CONCAT(_query_, ' AND vc.smownerid = ', value_filter);
    ELSEIF (col = 'TP') Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_accountshipads vasp ON vasp.ship_city = N''', value_filter, '''',
                             ' AND vas.accountid = vasp.accountaddressid');
    ELSEIF (col = 'NG') Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_account va ON va.industry like N''%', value_filter, '%''',
                                      ' AND va.accountid = vas.accountid');
	END IF;
	
	SET _query_ = CONCAT(_query_,' GROUP BY vas.cf_891 ORDER BY SLKH desc;');
	
	SET @_query_ = _query_;
	PREPARE my_query FROM @_query_;
	EXECUTE my_query;

END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.sp_NG_SLKH
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_NG_SLKH`(
	IN `col` CHAR(2),
	IN `value_filter` VARCHAR(100),
	IN `ddl_NV` VARCHAR(3),
	IN `ddl_TT` VARCHAR(30),
	IN `ddl_TP` VARCHAR(30)
)
BEGIN
    DECLARE _query_ VARCHAR(2000);
    SET _query_ = CONCAT('SELECT CASE WHEN va.industry IS NULL OR va.industry = '''' THEN N''Trống''',
                         ' ELSE va.industry END AS Nganh, COUNT(va.accountid) SLKH FROM vtiger_account va',
                         ' JOIN vtiger_crmentity vc ON va.accountid = vc.crmid AND vc.setype = ''Accounts''');
                         
	IF (ddl_NV IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' AND vc.smownerid = ', ddl_NV);
    END IF;
    
    IF (ddl_TP IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_accountshipads vasp ON vasp.ship_city = N''', ddl_TP, '''',
                                      ' AND vasp.accountaddressid = vc.crmid');
    END IF;
    
    IF (ddl_TT IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_accountscf vas ON vas.accountid = va.accountid',
                                      ' AND vas.cf_891 = ''', ddl_TT, '''');
    END IF;
    
    IF (col = 'NV') Then
		SET _query_ = CONCAT(_query_,' AND vc.smownerid = ', value_filter);
    ELSEIF (col = 'TP') Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_accountshipads vasp ON vasp.ship_city = ''', value_filter, '''',
                                      ' AND vc.crmid = vasp.accountaddressid');
    END IF;
    
    SET _query_ = CONCAT(_query_,' GROUP BY Nganh ORDER BY SLKH desc;');
    
	SET @_query_ = _query_;
	PREPARE my_query FROM @_query_;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.sp_NV_KH_TT
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_NV_KH_TT`(
	IN `col` CHAR(2),
	IN `value_filter` VARCHAR(100),
	IN `ddl_NV` VARCHAR(3),
	IN `ddl_TT` VARCHAR(30),
	IN `ddl_TP` VARCHAR(30),
	IN `ddl_NG` VARCHAR(50)
)
BEGIN
    DECLARE _query_ VARCHAR(2000);
    SET _query_ = CONCAT('SELECT CONCAT(vu.last_name, '' '', vu.first_name) AS HoTen, va.accountname, vas.cf_891 AS TT',
						 ' FROM vtiger_account va JOIN vtiger_accountscf vas ON va.accountid = vas.accountid');
	
    SET _query_ = CONCAT(_query_, ' JOIN vtiger_crmentity vc ON',
                                  ' va.accountid = vc.crmid AND vc.setype = ''Accounts''',
                                  ' JOIN vtiger_users vu ON vc.smownerid = vu.id');
    IF (ddl_NV IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' AND vc.smownerid = ', ddl_NV);
    END IF;
    
    IF (ddl_TP IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_accountshipads vasp ON vasp.ship_city = N''', ddl_TP, '''',
                                      ' AND vasp.accountaddressid = vc.crmid');
    END IF;
    
    IF (ddl_NG IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' AND va.industry = N''', ddl_NG, '''');
    END IF;
    
    IF (ddl_TT IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' AND vas.cf_891 = ''', ddl_TT, '''');
    END IF;
    
	IF (col = 'NV') Then
		SET _query_ = CONCAT(_query_,' AND vc.smownerid = ', value_filter);
    ELSEIF (col = 'TP') Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_accountshipads vasp ON vasp.ship_city = ''', value_filter, '''',
                                      ' AND va.accountid = vasp.accountaddressid');
    ELSEIF (col = 'NG') Then
        SET _query_ = CONCAT(_query_, ' AND va.industry = N''', value_filter, '''');
	END IF;
    
    IF (col = '20') Then
        SET _query_ = CONCAT(_query_, ' LIMIT 20;');
    ELSEIF (col = '40') Then
        SET _query_ = CONCAT(_query_, ' LIMIT 40;');
    ELSEIF (col = '60') Then
        SET _query_ = CONCAT(_query_, ' LIMIT 60;');
    ELSEIF (col = '80') Then
        SET _query_ = CONCAT(_query_, ' LIMIT 80;');
    ELSEIF (col = 'AL') Then
        SET _query_ = CONCAT(_query_, ';');
    ELSE
        SET _query_ = CONCAT(_query_, ' LIMIT 20;');
    END IF;
   
   SET @_query_ = _query_;
	PREPARE my_query FROM @_query_;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.sp_NV_SLKH
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_NV_SLKH`(
	IN `col` CHAR(2),
	IN `value_filter` VARCHAR(100),
	IN `ddl_TP` VARCHAR(20),
	IN `ddl_NG` VARCHAR(50),
	IN `ddl_TT` VARCHAR(30)
)
BEGIN
    DECLARE _query_ VARCHAR(2000);
    SET _query_ = CONCAT('SELECT vc.smownerid AS ID, CONCAT(vu.last_name, '' '', vu.first_name) AS HoTen, COUNT(vc.crmid) AS SoLuongKH, vu.status',
						 ' FROM vtiger_crmentity vc',
                         ' JOIN vtiger_users vu ON vc.smownerid = vu.id AND vc.setype = ''Accounts''');
    
    /*AND vu.status = ''Active''*/
    
    IF (ddl_TP IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_accountshipads vasp ON vasp.ship_city like N''%', ddl_TP, '%''',
                                      ' AND vasp.accountaddressid = vc.crmid');
    END IF;
    
    IF (ddl_NG IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_account va ON va.industry like N''%', ddl_NG, '%''',
                                      ' AND va.accountid = vc.crmid');
    END IF;
    
    IF (ddl_TT IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_accountscf vas ON vas.cf_891 = ''', ddl_TT, '''',
                                      ' AND vas.accountid = vc.crmid');
    END IF;
    
	IF (col = 'TP') Then
		SET _query_ = CONCAT(_query_,' JOIN vtiger_accountshipads vas ON vc.crmid = vas.accountaddressid AND vas.ship_city LIKE');
        SET _query_ = CONCAT(_query_,' ''%', value_filter, '%''');
    ELSEIF (col = 'NG') Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_account va ON va.industry like N''%', value_filter, '%''',
                                      ' AND va.accountid = vc.crmid');
	END IF;
	
	SET _query_ = CONCAT(_query_,' GROUP BY vc.smownerid ORDER BY COUNT(vc.crmid) DESC;');
	
	SET @_query_ = _query_;
	PREPARE my_query FROM @_query_;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.sp_TG_SLKH
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TG_SLKH`(
	IN `col` CHAR(2),
	IN `value_filter` VARCHAR(100),
	IN `ddl_NV` VARCHAR(3),
	IN `ddl_TT` VARCHAR(30),
	IN `ddl_TP` VARCHAR(30),
	IN `ddl_NG` VARCHAR(50)
)
BEGIN
    DECLARE _query_ VARCHAR(2000);
    DECLARE _check INT;
	 SET _check = 0;
    SET _query_ = CONCAT('SELECT DATE_FORMAT(vc.createdtime,''%Y-%m'') Month_Year, COUNT(vc.crmid)',
						 		 ' FROM vtiger_crmentity vc');
    
    IF (ddl_TP IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_accountshipads vasp ON vasp.ship_city = N''', ddl_TP, '''',
                                      ' AND vasp.accountaddressid = vc.crmid');
        SET _check = 1;
    END IF;
    
    IF (ddl_NG IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_account va ON va.industry = N''', ddl_NG, '''',
		  										  ' AND va.accountid = vc.crmid');
        SET _check = 1;
    END IF;
    
    IF (ddl_TT IS NOT NULL) Then
    	  SET _query_ = CONCAT(_query_, ' JOIN vtiger_accountscf vas ON vas.cf_891 = ''', ddl_TT, '''',
		  										  ' AND vas.accountid = vc.crmid');
        SET _check = 1;
    END IF;
    
    IF (ddl_NV IS NOT NULL AND _check = 1) Then
        SET _query_ = CONCAT(_query_, ' AND vc.smownerid = ', ddl_NV);
    ELSEIF (ddl_NV IS NOT NULL AND _check = 0) Then
    	  SET _query_ = CONCAT(_query_, ' WHERE vc.smownerid = ', ddl_NV);
        SET _check = 1;
    END IF;
    
	IF (col = 'NV') Then
		SET _query_ = CONCAT(_query_,' WHERE vc.smownerid = ', value_filter);
		SET _check = 1;
    ELSEIF (col = 'TP') Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_accountshipads vasp ON vasp.ship_city = ''', value_filter, '''',
                                      ' AND vc.crmid = vasp.accountaddressid');
    ELSEIF (col = 'NG') Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_account va ON va.industry = N''', value_filter, '''',
		  										  ' AND va.accountid = vc.crmid');
	END IF;
	
    IF (_check = 1) Then
    	  SET _query_ = CONCAT(_query_, ' AND vc.setype = ''Accounts''');
    ELSEIF (_check = 0) Then
    	  SET _query_ = CONCAT(_query_, ' WHERE vc.setype = ''Accounts''');
    END IF;
	
	SET _query_ = CONCAT(_query_, ' GROUP BY Month_Year;');
   
   SET @_query_ = _query_;
	PREPARE my_query FROM @_query_;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.sp_TN_Group
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TN_Group`(
	IN `TP` VARCHAR(100),
	IN `NGUON` VARCHAR(100),
	IN `NGANH` VARCHAR(100),
	IN `NV` VARCHAR(100),
	IN `col` VARCHAR(100),
	IN `_values_` VARCHAR(100)

)
BEGIN 
	DECLARE _query_ VARCHAR(2000);
	SET _query_ = CONCAT('SELECT vtiger_groups.groupname, count(vtiger_users2group.userid)',
									' FROM vtiger_users2group',
									' INNER JOIN vtiger_groups ON vtiger_users2group.groupid = vtiger_groups.groupid',
									' INNER JOIN vtiger_crmentity vc ON vtiger_users2group.userid = vc.smownerid',
									' JOIN vtiger_leaddetails vl ON vl.leadid = vc.crmid');
									
	IF (TP IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_leadaddress vla ON vla.leadaddressid = vl.leadid AND vla.city = ''',TP,'''');
	END IF;
	
	IF (NGUON IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' AND vl.leadsource =''',NGUON,'''');
	END IF;
	
	IF (NGANH IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' AND vl.industry =''',NGANH,'''');
	END IF;
	
	IF(NV IS NOT NULL) THEN
		SET _query_ = CONCAT (_query_,' JOIN vtiger_users vu ON vu.id = vc.smownerid AND vu.user_name =''',NV,'''');
	END IF;
	
	IF (col = 'TP')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_leadaddress vla ON vla.leadaddressid = vl.leadid AND vla.city = ''',_values_,'''');
		
	ELSEIF (col = 'NGUON')THEN
		SET _query_ = CONCAT(_query_,' AND vl.leadsource =''',_values_,'''');
		
	ELSEIF (col = 'NGANH')THEN
		SET _query_ = CONCAT(_query_,' AND vl.industry =''',_values_,'''');
		
	ELSEIF (col = 'NV')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_users vu ON vu.id = vc.smownerid AND vu.user_name =''',_values_,'''');
		
	ELSEIF (col = 'HD')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_seactivityrel vse ON vc.crmid = vse.crmid JOIN vtiger_activity va ON va.activityid = vse.activityid AND va.activitytype =''',_values_,'''');
		
	ELSEIF (col = 'TGHD')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_seactivityrel vse ON vc.crmid = vse.crmid JOIN vtiger_activity va ON va.activityid = vse.activityid AND DATE_FORMAT(va.date_start,''%Y-%m'') =''',DATE_FORMAT(_values_,'%Y-%m'),'''');
		
	ELSEIF (col = 'TGNGUON')THEN
		SET _query_ = CONCAT(_query_,' AND DATE_FORMAT(vc.createdtime,"%Y-%m") =''',DATE_FORMAT(_values_,'%Y-%m'),'''');
	END IF;
	
	SET _query_ = CONCAT(_query_,' WHERE vc.setype=''Leads''');
	
	SET _query_ = CONCAT(_query_,' GROUP BY vtiger_groups.groupname',
											' ORDER BY count(vtiger_users2group.userid) DESC;');
	
	SET @_query_ = _query_;								
	PREPARE my_query FROM @_query_;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.sp_TN_HDNV
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TN_HDNV`(
	IN `TP` VARCHAR(100),
	IN `NGUON` VARCHAR(100),
	IN `NGANH` VARCHAR(100),
	IN `NV` VARCHAR(100),
	IN `col` VARCHAR(100),
	IN `_values_` VARCHAR(100)

)
BEGIN
	DECLARE _query_ VARCHAR(2000);
	SET _query_ = CONCAT('SELECT activitytype HDNV, count(va.activitytype) SLHD',
								' FROM vtiger_activity AS va JOIN vtiger_seactivityrel AS vse ON va.activityid = vse.activityid',
								' JOIN vtiger_crmentity vc ON vse.crmid = vc.crmid AND vc.setype = ''Leads''',
								' JOIN vtiger_leaddetails vl ON vl.leadid = vc.crmid');
	
	
	IF (TP IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_leadaddress vla ON vla.leadaddressid = vl.leadid AND vla.city = ''',TP,'''');
	END IF;
	
	IF (NGUON IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' AND vl.leadsource =''',NGUON,'''');
	END IF;
	
	IF (NGANH IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' AND vl.industry =''',NGANH,'''');
	END IF;
	
	IF(NV IS NOT NULL) THEN
		SET _query_ = CONCAT (_query_,' JOIN vtiger_users vu ON vu.id = vc.smownerid AND vu.user_name =''',NV,'''');
	END IF;
	
	IF (col = 'TP')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_leadaddress vla ON vla.leadaddressid = vl.leadid AND vla.city = ''',_values_,'''');
	ELSEIF (col = 'NGUON')THEN
		SET _query_ = CONCAT(_query_,' AND vl.leadsource =''',_values_,'''');
	ELSEIF (col = 'NGANH')THEN
		SET _query_ = CONCAT(_query_,' AND vl.industry =''',_values_,'''');
	ELSEIF (col = 'NV')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_users vu ON vu.id = vc.smownerid AND vu.user_name =''',_values_,'''');
	ELSEIF (col = 'HD')THEN
		SET _query_ = CONCAT(_query_,' AND va.activitytype =''',_values_,'''');
	ELSEIF (col = 'TGHD')THEN
		SET _query_ = CONCAT(_query_,' AND DATE_FORMAT(va.date_start,''%Y-%m'') =''',DATE_FORMAT(_values_,'%Y-%m'),'''');
	ELSEIF (col = 'TGNGUON')THEN
		SET _query_ = CONCAT(_query_,' AND DATE_FORMAT(vc.createdtime,"%Y-%m") =''',DATE_FORMAT(_values_,'%Y-%m'),'''');
	ELSEIF (col = 'Group')THEN
		SET _query_ = CONCAT (_query_,' JOIN vtiger_users2group vu2g ON vc.smownerid = vu2g.userid JOIN vtiger_groups vg ON vu2g.groupid = vg.groupid AND vg.groupname = ''',_values_,'''');
	END IF;
	 
	SET _query_ = CONCAT(_query_,' GROUP BY va.activitytype ORDER BY count(va.activitytype) DESC ;');
	
	SET @_query_ = _query_;
	PREPARE my_query FROM @_query_;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.sp_TN_Nganh
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TN_Nganh`(
	IN `TP` VARCHAR(100),
	IN `NGUON` VARCHAR(100),
	IN `NGANH` VARCHAR(100),
	IN `NV` VARCHAR(100),
	IN `col` VARCHAR(100),
	IN `_values_` VARCHAR(100)

)
BEGIN
	DECLARE _query_ VARCHAR(2000);
	SET _query_ = CONCAT(' SELECT vl.industry NGANH, COUNT(vl.leadid) SL',
								' FROM vtiger_crmentity vc JOIN vtiger_leaddetails vl ON vc.crmid = vl.leadid AND vc.setype = ''Leads''');
								
	IF (TP IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_leadaddress vla ON vla.leadaddressid = vl.leadid AND vla.city = ''',TP,'''');
	END IF;
	
	IF (NGUON IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' AND vl.leadsource =''',NGUON,'''');
	END IF;
	
	IF (NGANH IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' AND vl.industry =''',NGANH,'''');
	END IF;
	
	IF (NV IS NOT NULL) THEN
		SET _query_ = CONCAT (_query_,' JOIN vtiger_users vu ON vu.id = vc.smownerid AND vu.user_name =''',NV,'''');
	END IF;
	
	IF (col = 'TP')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_leadaddress vla ON vla.leadaddressid = vl.leadid AND vla.city = ''',_values_,'''');
	ELSEIF (col = 'NGUON')THEN
		SET _query_ = CONCAT(_query_,' AND vl.leadsource =''',_values_,'''');
	ELSEIF (col = 'NGANH')THEN
		SET _query_ = CONCAT(_query_,' AND vl.industry =''',_values_,'''');
	ELSEIF (col = 'NV')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_users vu ON vu.id = vc.smownerid AND vu.user_name =''',_values_,'''');
	ELSEIF (col = 'HD')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_seactivityrel vse ON vc.crmid = vse.crmid JOIN vtiger_activity va ON va.activityid = vse.activityid AND va.activitytype =''',_values_,'''');
	ELSEIF (col = 'TGHD')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_seactivityrel vse ON vc.crmid = vse.crmid JOIN vtiger_activity va ON va.activityid = vse.activityid AND DATE_FORMAT(va.date_start,''%Y-%m'') =''',DATE_FORMAT(_values_,'%Y-%m'),'''');
	ELSEIF (col = 'TGNGUON')THEN
		SET _query_ = CONCAT(_query_,' AND DATE_FORMAT(vc.createdtime,"%Y-%m") =''',DATE_FORMAT(_values_,'%Y-%m'),'''');
	ELSEIF (col = 'Group')THEN
		SET _query_ = CONCAT (_query_,' JOIN vtiger_users2group vu2g ON vc.smownerid = vu2g.userid JOIN vtiger_groups vg ON vu2g.groupid = vg.groupid AND vg.groupname = ''',_values_,'''');
	END IF;
	
	SET _query_ = CONCAT(_query_,' GROUP BY NGANH ORDER BY SL ASC ;');
	
	SET @_query_ = _query_;
	PREPARE my_query FROM @_query_;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.sp_TN_NGUON
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TN_NGUON`(
	IN `TP` VARCHAR(100),
	IN `NGUON` VARCHAR(100),
	IN `NGANH` VARCHAR(100),
	IN `NV` VARCHAR(100),
	IN `col` VARCHAR(100),
	IN `_values_` VARCHAR(100)

)
BEGIN
	DECLARE _query_ VARCHAR(2000);
	SET _query_ = CONCAT ('SELECT leadsource AS TenNguon, COUNT(vc.crmid) SLN',
								' FROM vtiger_crmentity vc JOIN vtiger_leaddetails vl ON vc.crmid = vl.leadid');
	
	IF (TP IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_leadaddress vla ON vla.leadaddressid = vl.leadid AND vla.city = ''',TP,'''');
	END IF;
	
	IF (NGUON IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' AND vl.leadsource =''',NGUON,'''');
	END IF;
	
	IF (NGANH IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' AND vl.industry =''',NGANH,'''');
	END IF;
	
	IF(NV IS NOT NULL) THEN
		SET _query_ = CONCAT (_query_,' JOIN vtiger_users vu ON vu.id = vc.smownerid AND vu.user_name =''',NV,'''');
	END IF;
	
	IF (col = 'TP')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_leadaddress vla ON vla.leadaddressid = vl.leadid AND vla.city = ''',_values_,'''');
	ELSEIF (col = 'NGUON')THEN
		SET _query_ = CONCAT(_query_,' AND vl.leadsource =''',_values_,'''');
	ELSEIF (col = 'NGANH')THEN
		SET _query_ = CONCAT(_query_,' AND vl.industry =''',_values_,'''');
	ELSEIF (col = 'NV')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_users vu ON vu.id = vc.smownerid AND vu.user_name =''',_values_,'''');
	ELSEIF (col = 'HD')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_seactivityrel vse ON vc.crmid = vse.crmid JOIN vtiger_activity va ON va.activityid = vse.activityid AND va.activitytype =''',_values_,'''');
	ELSEIF (col = 'TGHD')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_seactivityrel vse ON vc.crmid = vse.crmid JOIN vtiger_activity va ON va.activityid = vse.activityid AND DATE_FORMAT(va.date_start,''%Y-%m'') =''',DATE_FORMAT(_values_,'%Y-%m'),'''');
	ELSEIF (col = 'TGNGUON')THEN
		SET _query_ = CONCAT(_query_,' AND DATE_FORMAT(vc.createdtime,"%Y-%m") =''',DATE_FORMAT(_values_,'%Y-%m'),'''');
	ELSEIF (col = 'Group')THEN
		SET _query_ = CONCAT (_query_,' JOIN vtiger_users2group vu2g ON vc.smownerid = vu2g.userid JOIN vtiger_groups vg ON vu2g.groupid = vg.groupid AND vg.groupname = ''',_values_,'''');
	END IF;
	
	SET _query_ = CONCAT(_query_,' AND vc.setype = ''Leads''');
	
	SET _query_ = CONCAT(_query_,' GROUP BY leadsource ORDER BY SLN DESC;');
	
	SET @_query_ = _query_;
	PREPARE my_query FROM @_query_;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.sp_TN_NGUON_TP
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TN_NGUON_TP`(
	IN `TP` VARCHAR(100),
	IN `NGUON` VARCHAR(100),
	IN `NGANH` VARCHAR(100),
	IN `NV` VARCHAR(100),
	IN `col` VARCHAR(100),
	IN `_values_` VARCHAR(100)

)
BEGIN
	DECLARE _query_ VARCHAR(2000);
	SET _query_ = CONCAT('SELECT vla.city AS TenTP, COUNT(vc.crmid) SLN',
								' FROM vtiger_crmentity vc JOIN vtiger_leaddetails vl ON vc.crmid =  vl.leadid AND vc.setype = ''Leads''',
								' JOIN vtiger_leadaddress vla ON vl.leadid = vla.leadaddressid');
	
	IF (TP IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' AND vla.city = ''',TP,'''');
	END IF;
	
	IF (NGUON IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' AND vl.leadsource =''',NGUON,'''');
	END IF;
	
	IF (NGANH IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' AND vl.industry =''',NGANH,'''');
	END IF;
	
	IF(NV IS NOT NULL) THEN
		SET _query_ = CONCAT (_query_,' JOIN vtiger_users vu ON vu.id = vc.smownerid AND vu.user_name =''',NV,'''');
	END IF;
	
	IF (col = 'TP')THEN
		SET _query_ = CONCAT(_query_,' AND vla.city = ''',_values_,'''');
	ELSEIF (col = 'NGUON')THEN
		SET _query_ = CONCAT(_query_,' AND vl.leadsource =''',_values_,'''');
	ELSEIF (col = 'NGANH')THEN
		SET _query_ = CONCAT(_query_,' AND vl.industry =''',_values_,'''');
	ELSEIF (col = 'NV')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_users vu ON vu.id = vc.smownerid AND vu.user_name =''',_values_,'''');
	ELSEIF (col = 'HD')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_seactivityrel vse ON vc.crmid = vse.crmid JOIN vtiger_activity va ON va.activityid = vse.activityid AND va.activitytype =''',_values_,'''');
	ELSEIF (col = 'TGHD')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_seactivityrel vse ON vc.crmid = vse.crmid JOIN vtiger_activity va ON va.activityid = vse.activityid AND DATE_FORMAT(va.date_start,''%Y-%m'') =''',DATE_FORMAT(_values_,'%Y-%m'),'''');
	ELSEIF (col = 'TGNGUON')THEN
		SET _query_ = CONCAT(_query_,' AND DATE_FORMAT(vc.createdtime,"%Y-%m") =''',DATE_FORMAT(_values_,'%Y-%m'),'''');
	ELSEIF (col = 'Group')THEN
		SET _query_ = CONCAT (_query_,' JOIN vtiger_users2group vu2g ON vc.smownerid = vu2g.userid JOIN vtiger_groups vg ON vu2g.groupid = vg.groupid AND vg.groupname = ''',_values_,'''');
	END IF;
	
	SET _query_ = CONCAT(_query_,' GROUP BY TenTP ORDER BY SLN DESC;');
	
	SET @_query_ = _query_;
	PREPARE my_query FROM @_query_;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.sp_TN_NV
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TN_NV`(
	IN `TP` VARCHAR(100),
	IN `NGUON` VARCHAR(100),
	IN `NGANH` VARCHAR(100),
	IN `NV` VARCHAR(100),
	IN `col` VARCHAR(100),
	IN `_values_` VARCHAR(100)

)
BEGIN 
	DECLARE _query_ VARCHAR(2000);
	SET _query_ = CONCAT('SELECT vu.user_name, count(vc.crmid)',
								' FROM vtiger_users vu INNER JOIN vtiger_crmentity vc ON vu.id = vc.smownerid',
								' JOIN vtiger_leaddetails vl ON vl.leadid = vc.crmid');
									
	IF (TP IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_leadaddress vla ON vla.leadaddressid = vl.leadid AND vla.city = ''',TP,'''');
	END IF;
	
	IF (NGUON IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' AND vl.leadsource =''',NGUON,'''');
	END IF;
	
	IF (NGANH IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' AND vl.industry =''',NGANH,'''');
	END IF;
	
	IF(NV IS NOT NULL) THEN
		SET _query_ = CONCAT (_query_,' AND vu.user_name =''',NV,'''');
	END IF;
	
	IF (col = 'TP')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_leadaddress vla ON vla.leadaddressid = vl.leadid AND vla.city = ''',_values_,'''');	
	ELSEIF (col = 'NGUON')THEN
		SET _query_ = CONCAT(_query_,' AND vl.leadsource =''',_values_,'''');	
	ELSEIF (col = 'NGANH')THEN
		SET _query_ = CONCAT(_query_,' AND vl.industry =''',_values_,'''');
	ELSEIF (col = 'NV')THEN
		SET _query_ = CONCAT(_query_,' AND vu.user_name =''',_values_,'''');
	ELSEIF (col = 'HD')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_seactivityrel vse ON vc.crmid = vse.crmid JOIN vtiger_activity va ON va.activityid = vse.activityid AND va.activitytype =''',_values_,'''');
	ELSEIF (col = 'TGHD')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_seactivityrel vse ON vc.crmid = vse.crmid JOIN vtiger_activity va ON va.activityid = vse.activityid AND DATE_FORMAT(va.date_start,''%Y-%m'') =''',DATE_FORMAT(_values_,'%Y-%m'),'''');
	ELSEIF (col = 'TGNGUON')THEN
		SET _query_ = CONCAT(_query_,' AND DATE_FORMAT(vc.createdtime,"%Y-%m") =''',DATE_FORMAT(_values_,'%Y-%m'),'''');
	ELSEIF (col = 'Group')THEN
		SET _query_ = CONCAT (_query_,' JOIN vtiger_users2group vu2g ON vc.smownerid = vu2g.userid JOIN vtiger_groups vg ON vu2g.groupid = vg.groupid AND vg.groupname = ''',_values_,'''');	
	END IF;

	SET _query_ = CONCAT(_query_,' WHERE vc.setype=''Leads''');
	
	SET _query_ = CONCAT(_query_,' GROUP BY vu.user_name',
											' ORDER BY count(vc.crmid) DESC;');
	
	SET @_query_ = _query_;										
	PREPARE my_query FROM @_query_;
	EXECUTE my_query;

END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.sp_TN_SELECT_ddl
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TN_SELECT_ddl`(
	IN `TP` VARCHAR(100),
	IN `NGANH` VARCHAR(100),
	IN `NV` VARCHAR(100),
	IN `NGUON` VARCHAR(100)
)
BEGIN
	IF(TP IS NOT NULL)THEN
		SELECT vla.city FROM vtiger_leadaddress vla join vtiger_leaddetails vld ON vla.leadaddressid = vld.leadid 
															JOIN vtiger_crmentity vc ON vc.crmid = vld.leadid and vla.city != '' AND vc.setype = 'Leads'
		GROUP BY vla.city;
	END IF;
	
	IF(NGANH IS NOT NULL)THEN
		SELECT vld.industry FROM vtiger_leaddetails vld JOIN vtiger_crmentity vc ON vld.leadid = vc.crmid AND vc.setype = 'Leads'
		GROUP BY vld.industry;
	END IF;
	
	IF(NV IS NOT NULL)THEN
		SELECT vu.user_name ,CONCAT(vu.last_name,' ',vu.first_name) TenNV 
		FROM vtiger_users vu JOIN vtiger_crmentity vc ON vu.id = vc.smownerid
		GROUP BY vu.user_name, TenNV;
	END IF;
	
	IF(NGUON IS NOT NULL)THEN
		SELECT vls.leadsource FROM vtiger_leadsource vls;
	END IF;
	
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.sp_TN_SLHD
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TN_SLHD`(
	IN `TP` VARCHAR(100),
	IN `NGUON` VARCHAR(100),
	IN `NGANH` VARCHAR(100),
	IN `NV` VARCHAR(100),
	IN `col` VARCHAR(10),
	IN `_values_` VARCHAR(100)

)
BEGIN
	DECLARE _query_ VARCHAR(2000);
	SET _query_ = CONCAT('SELECT COUNT(va.activityid)',
								' FROM vtiger_activity va JOIN vtiger_seactivityrel vse ON va.activityid = vse.activityid',
								' JOIN vtiger_crmentity vc ON vc.crmid = vse.crmid AND vc.setype = ''Leads''',
								' JOIN vtiger_leaddetails vl ON vl.leadid = vc.crmid');
	
	IF (TP IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_leadaddress vla ON vla.leadaddressid = vl.leadid AND vla.city = ''',TP,'''');
	END IF;
	
	IF (NGUON IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' AND vl.leadsource =''',NGUON,'''');
	END IF;
	
	IF (NGANH IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' AND vl.industry =''',NGANH,'''');
	END IF;
	
	IF(NV IS NOT NULL) THEN
		SET _query_ = CONCAT (_query_,' JOIN vtiger_users vu ON vu.id = vc.smownerid AND vu.user_name =''',NV,'''');
	END IF;
	
	IF (col = 'TP')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_leadaddress vla ON vla.leadaddressid = vl.leadid AND vla.city = ''',_values_,'''');
	ELSEIF (col = 'NGUON')THEN
		SET _query_ = CONCAT(_query_,' AND vl.leadsource =''',_values_,'''');
	ELSEIF (col = 'NGANH')THEN
		SET _query_ = CONCAT(_query_,' AND vl.industry =''',_values_,'''');
	ELSEIF (col = 'NV')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_users vu ON vu.id = vc.smownerid AND vu.user_name =''',_values_,'''');
	ELSEIF (col = 'HD')THEN
		SET _query_ = CONCAT(_query_,' AND va.activitytype =''',_values_,'''');
	ELSEIF (col = 'TGHD')THEN
		SET _query_ = CONCAT(_query_,' AND DATE_FORMAT(va.date_start,''%Y-%m'') =''',DATE_FORMAT(_values_,'%Y-%m'),'''');
	ELSEIF (col = 'TGNGUON')THEN
		SET _query_ = CONCAT(_query_,' AND DATE_FORMAT(vc.createdtime,"%Y-%m") =''',DATE_FORMAT(_values_,'%Y-%m'),'''');
	ELSEIF (col = 'Group')THEN
		SET _query_ = CONCAT (_query_,' JOIN vtiger_users2group vu2g ON vc.smownerid = vu2g.userid JOIN vtiger_groups vg ON vu2g.groupid = vg.groupid AND vg.groupname = ''',_values_,'''');
	END IF;
	
	SET @_query_ = _query_;
	PREPARE my_query FROM @_query_;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.sp_TN_SLHDNV
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TN_SLHDNV`(
	IN `TP` VARCHAR(200),
	IN `NGUON` VARCHAR(200),
	IN `NGANH` VARCHAR(200),
	IN `NV` VARCHAR(200),
	IN `col` VARCHAR(200),
	IN `_values_` VARCHAR(200)

)
BEGIN
	DECLARE _query_ VARCHAR(2000);
	SET _query_ = CONCAT('SELECT vu.user_name user , COUNT(va.activityid) SLHD',
								' FROM vtiger_activity AS va JOIN vtiger_seactivityrel AS vse ON va.activityid = vse.activityid',
								' JOIN vtiger_crmentity vc ON vse.crmid = vc.crmid AND vc.setype = ''Leads''',
								' JOIN vtiger_users vu ON vc.smownerid = vu.id',
								' JOIN vtiger_leaddetails vl ON vl.leadid = vc.crmid');
								
	
	IF (TP IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_leadaddress vla ON vla.leadaddressid = vl.leadid AND vla.city = ''',TP,'''');
	END IF;
	
	IF (NGUON IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' AND vl.leadsource =''',NGUON,'''');
	END IF;
	
	IF (NGANH IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' AND vl.industry =''',NGANH,'''');
	END IF;
	
	IF(NV IS NOT NULL) THEN
		SET _query_ = CONCAT (_query_,' AND vu.user_name =''',NV,'''');
	END IF;
	
	IF (col = 'TP')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_leadaddress vla ON vla.leadaddressid = vl.leadid AND vla.city = ''',_values_,'''');
	ELSEIF (col = 'NGUON')THEN
		SET _query_ = CONCAT(_query_,' AND vl.leadsource =''',_values_,'''');
	ELSEIF (col = 'NGANH')THEN
		SET _query_ = CONCAT(_query_,' AND vl.industry =''',_values_,'''');
	ELSEIF (col = 'NV')THEN
		SET _query_ = CONCAT(_query_,' AND vu.user_name =''',_values_,'''');
	ELSEIF (col = 'HD')THEN
		SET _query_ = CONCAT(_query_,' AND va.activitytype =''',_values_,'''');
	ELSEIF (col = 'TGHD')THEN
		SET _query_ = CONCAT(_query_,' AND DATE_FORMAT(va.date_start,''%Y-%m'') =''',DATE_FORMAT(_values_,'%Y-%m'),'''');
	ELSEIF (col = 'TGNGUON')THEN
		SET _query_ = CONCAT(_query_,' AND DATE_FORMAT(vc.createdtime,"%Y-%m") =''',DATE_FORMAT(_values_,'%Y-%m'),'''');
	ELSEIF (col = 'Group')THEN
		SET _query_ = CONCAT (_query_,' JOIN vtiger_users2group vu2g ON vc.smownerid = vu2g.userid JOIN vtiger_groups vg ON vu2g.groupid = vg.groupid AND vg.groupname = ''',_values_,'''');
	END IF;
	
	SET _query_ = CONCAT(_query_,' GROUP BY user_name ORDER BY SLHD DESC;');
	
	SET @_query_ = _query_;
	PREPARE my_query FROM @_query_;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.sp_TN_SLHD_TG
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TN_SLHD_TG`(
	IN `TP` VARCHAR(100),
	IN `NGUON` VARCHAR(100),
	IN `NGANH` VARCHAR(100),
	IN `NV` VARCHAR(100),
	IN `col` VARCHAR(100),
	IN `_values_` VARCHAR(100)

)
BEGIN
	DECLARE _query_ VARCHAR(2000);
	SET _query_ = CONCAT('	SELECT COUNT(va.activityid) SLHD, DATE_FORMAT(va.date_start,''%Y-%m'') AS date_time',
								' FROM vtiger_activity va JOIN vtiger_seactivityrel vs ON va.activityid = vs.activityid',
								' JOIN vtiger_crmentity vc ON vs.crmid = vc.crmid AND vc.setype = ''Leads'' AND YEAR(va.date_start) > 2016',
								' JOIN vtiger_leaddetails vl ON vl.leadid = vc.crmid');
	
	
	IF (TP IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_leadaddress vla ON vla.leadaddressid = vl.leadid AND vla.city = ''',TP,'''');
	END IF;
	
	IF (NGUON IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' AND vl.leadsource =''',NGUON,'''');
	END IF;
	
	IF (NGANH IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' AND vl.industry =''',NGANH,'''');
	END IF;
	
	IF(NV IS NOT NULL) THEN
		SET _query_ = CONCAT (_query_,' JOIN vtiger_users vu ON vu.id = vc.smownerid AND vu.user_name =''',NV,'''');
	END IF;
	
	IF (col = 'TP')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_leadaddress vla ON vla.leadaddressid = vl.leadid AND vla.city = ''',_values_,'''');
	ELSEIF (col = 'NGUON')THEN
		SET _query_ = CONCAT(_query_,' AND vl.leadsource =''',_values_,'''');
	ELSEIF (col = 'NGANH')THEN
		SET _query_ = CONCAT(_query_,' AND vl.industry =''',_values_,'''');
	ELSEIF (col = 'NV')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_users vu ON vu.id = vc.smownerid AND vu.user_name =''',_values_,'''');
	ELSEIF (col = 'HD')THEN
		SET _query_ = CONCAT(_query_,' AND va.activitytype =''',_values_,'''');
	ELSEIF (col = 'TGNGUON')THEN
		SET _query_ = CONCAT(_query_,' AND DATE_FORMAT(va.date_start,''%Y-%m'') =''',DATE_FORMAT(_values_,'%Y-%m'),'''');
	ELSEIF (col = 'Group')THEN
		SET _query_ = CONCAT (_query_,' JOIN vtiger_users2group vu2g ON vc.smownerid = vu2g.userid JOIN vtiger_groups vg ON vu2g.groupid = vg.groupid AND vg.groupname = ''',_values_,'''');
	END IF;
	
	SET _query_ = CONCAT(_query_,' GROUP BY date_time;');
	
	SET @_query_ = _query_;
	PREPARE my_query FROM @_query_;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.sp_TN_SLNGUON
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TN_SLNGUON`(
	IN `TP` VARCHAR(100),
	IN `NGUON` VARCHAR(100),
	IN `NGANH` VARCHAR(100),
	IN `NV` VARCHAR(100),
	IN `col` VARCHAR(100),
	IN `_values_` VARCHAR(100)

)
BEGIN
	DECLARE _query_ VARCHAR(2000);
	SET _query_ = CONCAT('SELECT COUNT(vc.crmid) FROM vtiger_crmentity vc',
								' JOIN vtiger_leaddetails vl ON vl.leadid = vc.crmid');
	
	IF (TP IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_leadaddress vla ON vla.leadaddressid = vl.leadid AND vla.city = ''',TP,'''');
	END IF;
	
	IF (NGUON IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' AND vl.leadsource =''',NGUON,'''');
	END IF;
	
	IF (NGANH IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' AND vl.industry =''',NGANH,'''');
	END IF;
	
	IF(NV IS NOT NULL) THEN
		SET _query_ = CONCAT (_query_,' JOIN vtiger_users vu ON vu.id = vc.smownerid AND vu.user_name =''',NV,'''');
	END IF;
	
	IF (col = 'TP')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_leadaddress vla ON vla.leadaddressid = vl.leadid AND vla.city = ''',_values_,'''');
	ELSEIF (col = 'NGUON')THEN
		SET _query_ = CONCAT(_query_,' AND vl.leadsource =''',_values_,'''');
	ELSEIF (col = 'NGANH')THEN
		SET _query_ = CONCAT(_query_,' AND vl.industry =''',_values_,'''');
	ELSEIF (col = 'NV')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_users vu ON vu.id = vc.smownerid AND vu.user_name =''',_values_,'''');
	ELSEIF (col = 'HD')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_seactivityrel vse ON vc.crmid = vse.crmid JOIN vtiger_activity va ON va.activityid = vse.activityid AND va.activitytype =''',_values_,'''');
	ELSEIF (col = 'TGHD')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_seactivityrel vse ON vc.crmid = vse.crmid JOIN vtiger_activity va ON va.activityid = vse.activityid AND DATE_FORMAT(va.date_start,''%Y-%m'') =''',DATE_FORMAT(_values_,'%Y-%m'),'''');
	ELSEIF (col = 'TGNGUON')THEN
		SET _query_ = CONCAT(_query_,' AND DATE_FORMAT(vc.createdtime,"%Y-%m") =''',DATE_FORMAT(_values_,'%Y-%m'),'''');
	ELSEIF (col = 'Group')THEN
		SET _query_ = CONCAT (_query_,' JOIN vtiger_users2group vu2g ON vc.smownerid = vu2g.userid JOIN vtiger_groups vg ON vu2g.groupid = vg.groupid AND vg.groupname = ''',_values_,'''');
	END IF;
		
	SET _query_ = CONCAT(_query_,' WHERE vc.setype = ''Leads''');
	
	SET @_query_ = _query_;
	PREPARE my_query FROM @_query_;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.sp_TN_SLNGUON_TG
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TN_SLNGUON_TG`(
	IN `TP` VARCHAR(100),
	IN `NGUON` VARCHAR(100),
	IN `NGANH` VARCHAR(100),
	IN `NV` VARCHAR(100),
	IN `col` VARCHAR(100),
	IN `_values_` VARCHAR(100)

)
BEGIN 
	DECLARE _query_ VARCHAR(2000);
	SET _query_ = CONCAT('SELECT COUNT(vc.crmid) SLN,DATE_FORMAT(vc.createdtime,"%Y-%m" ) TG',
								' FROM vtiger_crmentity vc JOIN vtiger_leaddetails as vl ON vc.crmid = vl.leadid',
								' AND vc.setype = ''Leads'' AND YEAR(vc.createdtime) != 7687 AND YEAR(vc.createdtime) > 2016');
	
	IF (TP IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_leadaddress vla ON vla.leadaddressid = vl.leadid AND vla.city = ''',TP,'''');
	END IF;
	
	IF (NGUON IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' AND vl.leadsource =''',NGUON,'''');
	END IF;
	
	IF (NGANH IS NOT NULL) THEN
		SET _query_ = CONCAT(_query_,' AND vl.industry =''',NGANH,'''');
	END IF;
	
	IF(NV IS NOT NULL) THEN
		SET _query_ = CONCAT (_query_,' JOIN vtiger_users vu ON vu.id = vc.smownerid AND vu.user_name =''',NV,'''');
	END IF;
	
	IF (col = 'TP')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_leadaddress vla ON vla.leadaddressid = vl.leadid AND vla.city = ''',_values_,'''');
	ELSEIF (col = 'NGUON')THEN
		SET _query_ = CONCAT(_query_,' AND vl.leadsource =''',_values_,'''');
	ELSEIF (col = 'NGANH')THEN
		SET _query_ = CONCAT(_query_,' AND vl.industry =''',_values_,'''');
	ELSEIF (col = 'NV')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_users vu ON vu.id = vc.smownerid AND vu.user_name =''',_values_,'''');
	ELSEIF (col = 'HD')THEN
		SET _query_ = CONCAT(_query_,' JOIN vtiger_seactivityrel vse ON vc.crmid = vse.crmid JOIN vtiger_activity va ON va.activityid = vse.activityid AND va.activitytype =''',_values_,'''');
	ELSEIF (col = 'TGHD')THEN
		SET _query_ = CONCAT(_query_,' AND DATE_FORMAT(vc.createdtime,"%Y-%m") =''',DATE_FORMAT(_values_,'%Y-%m'),'''');
	ELSEIF (col = 'Group')THEN
		SET _query_ = CONCAT (_query_,' JOIN vtiger_users2group vu2g ON vc.smownerid = vu2g.userid JOIN vtiger_groups vg ON vu2g.groupid = vg.groupid AND vg.groupname = ''',_values_,'''');
	END IF;
	
	SET _query_ = CONCAT(_query_,' GROUP BY TG');
	
	SET @_query_ = _query_;
	PREPARE my_query FROM @_query_;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fcrm20.sp_TP_SLKH
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TP_SLKH`(
	IN `col` CHAR(2),
	IN `value_filter` VARCHAR(100),
	IN `ddl_NV` VARCHAR(3),
	IN `ddl_TT` VARCHAR(30),
	IN `ddl_NG` VARCHAR(50)
)
BEGIN
    DECLARE _query_ VARCHAR(2000);
    SET _query_ = CONCAT('SELECT va.accountid ID, vasp.ship_city, COUNT(vasp.ship_city) SLKH',
                        ' FROM vtiger_account va JOIN vtiger_accountshipads vasp ON va.accountid = vasp.accountaddressid',
                        ' JOIN vtiger_crmentity vc ON va.accountid = vc.crmid AND vc.setype = ''Accounts''');
    /*AND vasp.ship_city != ''''*/
    
    IF (ddl_NV IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' AND vc.smownerid = ', ddl_NV);
    END IF;
    
    IF (ddl_TT IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' JOIN vtiger_accountscf vas ON vas.cf_891 = ''', ddl_TT, '''',
                                      ' AND vas.accountid = va.accountid');
    END IF;
    
    IF (ddl_NG IS NOT NULL) Then
        SET _query_ = CONCAT(_query_, ' AND va.industry = N''', ddl_NG, '''');
    END IF;

    IF (col = 'NV') THEN
        SET _query_ = CONCAT(_query_, ' AND vc.smownerid = ', value_filter);
    ELSEIF (col = 'NG') THEN
        SET _query_ = CONCAT(_query_, ' AND va.industry = N''', value_filter, '''');
    END IF;
    
    SET _query_ = CONCAT(_query_, ' GROUP BY vasp.ship_city ORDER BY SLKH DESC;');
	 
	 SET @_query_ = _query_;
    PREPARE my_query FROM @_query_;
    EXECUTE my_query;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
