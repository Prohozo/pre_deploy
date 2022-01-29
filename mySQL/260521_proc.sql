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


-- Dumping database structure for fpms
CREATE DATABASE IF NOT EXISTS `fpms` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `fpms`;

-- Dumping structure for procedure fpms.dsa_sp_action_tron
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_sp_action_tron`(
	IN `name_` NVARCHAR(200),
	IN `col_` NVARCHAR(20),
	IN `values_` NVARCHAR(100)
)
BEGIN

	DECLARE query_ nvarchar(2000);
	SET query_ = CONCAT('SELECT b.action, COUNT(distinct(b.id)) Soluot',
								 ' FROM zt_project a',
								 ' JOIN zt_action b ON a.id = b.project WHERE b.objectType = ''project'' AND a.deleted = ''0''');
	/* Lọc theo dự án */
	IF (name_ IS NOT NULL) Then
        SET query_ = CONCAT(query_ , ' AND a.name = ', name_);
   END IF;
   /* Lọc tương tác với các biểu đồ*/
   If (col_ = 'name_') Then
   	SET query_ = CONCAT(query_, ' AND a.name = ''', values_, '''');
   END IF;
	SET query_ = CONCAT(query_ ,' GROUP BY b.action');
	
	SET @SQL := query_;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
				
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_sp_ddl_dept
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_sp_ddl_dept`(
	IN `type_` nvarchar(20)
)
    DETERMINISTIC
BEGIN
	DECLARE query_ nvarchar(2000);
	
	IF (type_ = 'ddl_dept') Then
		SET query_ = CONCAT('SELECT id, name FROM zt_dept');
		
	END IF;
						
	SET @SQL := query_;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_sp_ddl_project
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_sp_ddl_project`(
	IN `type_` nvarchar(20)
)
    DETERMINISTIC
BEGIN
	DECLARE query_ nvarchar(2000);
	
	IF (type_ = 'ddl_name') Then
		SET query_ = CONCAT('SELECT id, name FROM zt_project WHERE deleted = ''0''');
		ELSEIF (type_ = 'ddl_action') Then
			SET query_ = CONCAT('SELECT DISTINCT(action) FROM zt_action where objectType = ''project''');
	END IF;
						
	SET @SQL := query_;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_sp_detail_DuAn_Bang
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_sp_detail_DuAn_Bang`(
	IN `name_` NVARCHAR(200),
	IN `dept_` NVARCHAR(20),
	IN `col_` NVARCHAR(20),
	IN `values_` NVARCHAR(100)
)
BEGIN

	DECLARE query_ nvarchar(2000);
	DECLARE query_lh nvarchar(200);
	DECLARE query_action nvarchar(300);
	
	SET query_action = CASE WHEN col_ = 'action' THEN CONCAT('a.action = ''', values_, '''') ELSE 'a.action IN ( ''opened'', ''closed'', ''started'' , ''suspended'')' END;
	SET query_ = CONCAT('SELECT c.name, DATEDIFF( CURDATE(), MAX(a.date)) tt_date',
	  							 ', CASE WHEN b.story_num IS NULL THEN 0 ELSE b.story_num END story_num', 
								 ', CASE WHEN c.status = ''suspended'' then c.status',
				   			 ' WHEN c.status = ''wait'' then c.status', 
				  				 ' WHEN c.status = ''doing'' AND CURDATE() > c.end then ''doing (delay)''',
				 			    ' WHEN c.status = ''doing'' AND CURDATE() <= c.end then c.status' ,		 			    
				  				 ' ELSE ''closed'' END AS LoaiHinh',  							 
								 ' FROM zt_action a',
								 ' LEFT JOIN (SELECT project, COUNT(project) story_num FROM zt_projectstory GROUP BY project) b ON a.project = b.project', 
								 ' LEFT JOIN zt_project c ON a.project = c.id ',
								 ' LEFT JOIN zt_user d ON a.actor = d.account',
								 ' LEFT JOIN zt_dept e ON d.dept = e.id',
								 ' WHERE c.id IN (SELECT DISTINCT(project) FROM zt_action a WHERE objectType = ''project'' AND ', query_action, ') 
								   AND c.status <>''closed'' AND c.name IS NOT NULL AND c.deleted = ''0''');
						

	/* Lọc theo dự án */
	IF (name_ IS NOT NULL) Then
        SET query_ = CONCAT(query_ , ' AND c.id = ''', name_,'''');
   END IF;
   	/* Lọc theo dept */
	IF (dept_ IS NOT NULL) Then
        SET query_ = CONCAT(query_ , ' AND e.id = ''', dept_,'''');
   END IF;
   /* Lọc tương tác với các biểu đồ*/
   If (col_ = 'name') Then
   	SET query_ = CONCAT(query_ ,' AND c.name = ''', values_, '''');
   END IF;
   /* Lọc tương tác với các biểu đồ*/
   If (col_ = 'dept') Then
   	SET query_ = CONCAT(query_ ,' AND e.name = ''', values_, '''');
   END IF;
   If (col_ = 'LoaiHinh') Then
		SET query_lh = CASE WHEN values_ IN ('suspended', 'wait') THEN CONCAT(' AND c.status = ''', values_ ,'''')
								  WHEN values_ = 'doing (delay)' THEN ' AND c.status = ''doing'' AND CURDATE() > c.end'
								  WHEN values_ = 'doing' THEN ' AND c.status = ''doing'' AND CURDATE() <= c.end' 
								  WHEN values_ = 'closed (delay)' THEN ' AND c.status = ''closed'' AND c.end < CAST(c.closedDate AS DATE)'
								  WHEN values_ = 'closed (on-time)' THEN ' AND c.status = ''closed'' AND c.end = CAST(c.closedDate AS DATE)'
								  WHEN values_ = 'closed' THEN ' AND c.status = ''closed'' AND c.closedDate = ''0000-00-00 00:00:00'''
								  ELSE ' AND c.status = ''closed'' AND c.end > CAST(c.closedDate AS DATE)' END;
								  
   	SET query_ = CONCAT(query_, query_lh);
   END IF;
	SET query_ = CONCAT(query_ ,' GROUP BY c.name, CASE WHEN b.story_num IS NULL THEN 0 ELSE b.story_num END');


	SET @SQL := query_;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
				
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_sp_overview_DuAn
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_sp_overview_DuAn`(
	IN `name_` NVARCHAR(200),
	IN `dept_` NVARCHAR(20),
	IN `col_` NVARCHAR(20),
	IN `values_` NVARCHAR(100)
)
BEGIN

	DECLARE query_ nvarchar(2000);
	DECLARE query_lh nvarchar(200);
	DECLARE query_action nvarchar(300);
	
	SET query_action = CASE WHEN col_ = 'action' THEN CONCAT('e.action = ''', values_, '''') ELSE 'e.action IN ( ''opened'', ''closed'', ''started'' , ''suspended'')' END;
	
	SET query_ = CONCAT(' SELECT  COUNT(DISTINCT d.id) SoDA
 								FROM zt_project d LEFT JOIN zt_task a ON d.id = a.project
								LEFT JOIN zt_user b ON a.finishedBy = b.account 
								LEFT JOIN zt_dept c ON b.dept = c.id
								WHERE d.id IN (SELECT DISTINCT(project) FROM zt_action e WHERE objectType = ''project'' AND ', query_action, ') AND d.deleted = ''0''');
	/* Lọc theo dự án */
	IF (name_ IS NOT NULL) Then
        SET query_ = CONCAT(query_ , ' AND d.id = ''', name_, '''');
   END IF;
	/*Lọc theo action*/
	IF (dept_ IS NOT NULL) Then
        SET query_ = CONCAT(query_ , ' AND c.id = ''', dept_,'''');
   END IF;
   /* Lọc tương tác với các biểu đồ*/
   If (col_ = 'name') Then
   	SET query_ = CONCAT(query_, ' AND d.name = ''', values_, '''');
   END IF;
   If (col_ = 'dept') Then
   	SET query_ = CONCAT(query_, ' AND c.name = ''', values_, '''');
   END IF;
  
	If (col_ = 'LoaiHinh') Then
		SET query_lh = CASE WHEN values_ IN ('suspended', 'wait') THEN CONCAT(' AND d.status = ''', values_ ,'''')
								  WHEN values_ = 'doing (delay)' THEN ' AND d.status = ''doing'' AND CURDATE() > d.end'
								  WHEN values_ = 'doing' THEN ' AND d.status = ''doing'' AND CURDATE() <= d.end' 
								  WHEN values_ = 'closed (delay)' THEN ' AND d.status = ''closed'' AND d.end < CAST(d.closedDate AS DATE)'
								  WHEN values_ = 'closed (on-time)' THEN ' AND d.status = ''closed'' AND d.end = CAST(d.closedDate AS DATE)'
								  WHEN values_ = 'closed' THEN ' AND d.status = ''closed'' AND d.closedDate = ''0000-00-00 00:00:00'''
								  ELSE ' AND d.status = ''closed'' AND d.end > CAST(d.closedDate AS DATE)' END;
								  
   	SET query_ = CONCAT(query_, query_lh);
   END IF;		
							
	SET @SQL := query_;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
				
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_sp_overview_DuAn_doing
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_sp_overview_DuAn_doing`(
	IN `name_` NVARCHAR(200),
	IN `dept_` NVARCHAR(20),
	IN `col_` NVARCHAR(20),
	IN `values_` NVARCHAR(100)
)
BEGIN

	DECLARE query_ nvarchar(2000);
	DECLARE query_lh nvarchar(200);
	DECLARE query_action nvarchar(300);
	SET query_action = CASE WHEN col_ = 'action' THEN CONCAT('e.action = ''', values_, '''') ELSE 'e.action IN ( ''opened'', ''closed'', ''started'' , ''suspended'')' END;
	SET query_ = CONCAT(' SELECT COUNT(DISTINCT d.id) SoDA
 								FROM zt_project d LEFT JOIN zt_task a ON d.id = a.project
								LEFT JOIN zt_user b ON a.finishedBy = b.account 
								LEFT JOIN zt_dept c ON b.dept = c.id
								WHERE d.id IN (SELECT DISTINCT(project) FROM zt_action e WHERE objectType = ''project'' AND ', query_action, ') AND d.status = ''doing''AND d.deleted = ''0''');
	/* Lọc theo dự án */
	IF (name_ IS NOT NULL) Then
        SET query_ = CONCAT(query_ , ' AND d.id = ''', name_, '''');
   END IF;
	/*Lọc theo dept*/
	IF (dept_ IS NOT NULL) Then
        SET query_ = CONCAT(query_ , ' AND c.id = ''', dept_,'''');
   END IF;
   /* Lọc tương tác với các biểu đồ*/
   If (col_ = 'name') Then
   	SET query_ = CONCAT(query_, ' AND d.name = ''', values_, '''');
   END IF;
   If (col_ = 'dept') Then
   	SET query_ = CONCAT(query_, ' AND c.name = ''', values_, '''');
   END IF;
	If (col_ = 'LoaiHinh') Then
		SET query_lh = CASE WHEN values_ IN ('suspended', 'wait') THEN CONCAT(' AND d.status = ''', values_ ,'''')
								  WHEN values_ = 'doing (delay)' THEN ' AND d.status = ''doing'' AND CURDATE() > d.end'
								  WHEN values_ = 'doing' THEN ' AND d.status = ''doing'' AND CURDATE() <= d.end' 
								  WHEN values_ = 'closed (delay)' THEN ' AND d.status = ''closed'' AND d.end < CAST(d.closedDate AS DATE)'
								  WHEN values_ = 'closed (on-time)' THEN ' AND d.status = ''closed'' AND d.end = CAST(d.closedDate AS DATE)'
								  WHEN values_ = 'closed' THEN ' AND d.status = ''closed'' AND d.closedDate = ''0000-00-00 00:00:00'''
								  ELSE ' AND d.status = ''closed'' AND d.end > CAST(d.closedDate AS DATE)' END;
								  
   	SET query_ = CONCAT(query_, query_lh);
   END IF;		
								
	SET @SQL := query_;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
				
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_sp_overview_DuAn_suspended
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_sp_overview_DuAn_suspended`(
	IN `name_` NVARCHAR(200),
	IN `dept_` NVARCHAR(20),
	IN `col_` NVARCHAR(20),
	IN `values_` NVARCHAR(100)
)
BEGIN

	DECLARE query_ nvarchar(2000);
	DECLARE query_lh nvarchar(200);
	DECLARE query_action nvarchar(300);
	
	SET query_action = CASE WHEN col_ = 'action' THEN CONCAT('e.action = ''', values_, '''') ELSE 'e.action IN ( ''opened'', ''closed'', ''started'' , ''suspended'')' END;
	SET query_ = CONCAT(' SELECT COUNT(DISTINCT d.id) SoDA
 								FROM zt_project d LEFT JOIN zt_task a ON d.id = a.project
								LEFT JOIN zt_user b ON a.finishedBy = b.account 
								LEFT JOIN zt_dept c ON b.dept = c.id
								WHERE d.id IN (SELECT DISTINCT(project) FROM zt_action e WHERE objectType = ''project'' AND ', query_action, ') AND d.status = ''suspended''AND d.deleted = ''0''');
								
	/* Lọc theo dự án */
	IF (name_ IS NOT NULL) Then
        SET query_ = CONCAT(query_ , ' AND d.id = ''', name_, '''');
   END IF;
	/*Lọc theo dept*/
	IF (dept_ IS NOT NULL) Then
        SET query_ = CONCAT(query_ , ' AND c.id = ''', dept_,'''');
   END IF;
   /* Lọc tương tác với các biểu đồ*/
   If (col_ = 'name') Then
   	SET query_ = CONCAT(query_, ' AND d.name = ''', values_, '''');
   END IF;
   If (col_ = 'dept') Then
   	SET query_ = CONCAT(query_, ' AND c.name = ''', values_, '''');
   END IF;
	If (col_ = 'LoaiHinh') Then
		SET query_lh = CASE WHEN values_ IN ('suspended', 'wait') THEN CONCAT(' AND d.status = ''', values_ ,'''')
								  WHEN values_ = 'doing (delay)' THEN ' AND d.status = ''doing'' AND CURDATE() > d.end'
								  WHEN values_ = 'doing' THEN ' AND d.status = ''doing'' AND CURDATE() <= d.end' 
								  WHEN values_ = 'closed (delay)' THEN ' AND d.status = ''closed'' AND d.end < CAST(d.closedDate AS DATE)'
								  WHEN values_ = 'closed (on-time)' THEN ' AND d.status = ''closed'' AND d.end = CAST(d.closedDate AS DATE)'
								  WHEN values_ = 'closed' THEN ' AND d.status = ''closed'' AND d.closedDate = ''0000-00-00 00:00:00'''
								  ELSE ' AND d.status = ''closed'' AND d.end > CAST(d.closedDate AS DATE)' END;
								  
   	SET query_ = CONCAT(query_, query_lh);
   END IF;		
							
							
	SET @SQL := query_;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
				
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_sp_overview_DuAn_wait
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_sp_overview_DuAn_wait`(
	IN `name_` NVARCHAR(200),
	IN `dept_` NVARCHAR(20),
	IN `col_` NVARCHAR(20),
	IN `values_` NVARCHAR(100)
)
BEGIN

	DECLARE query_ nvarchar(2000);
	DECLARE query_lh nvarchar(200);
	DECLARE query_action nvarchar(300);
	
	SET query_action = CASE WHEN col_ = 'action' THEN CONCAT('e.action = ''', values_, '''') ELSE 'e.action IN ( ''opened'', ''closed'', ''started'' , ''suspended'')' END;
	SET query_ = CONCAT(' SELECT COUNT(DISTINCT d.id) SoDA
 								FROM zt_project d LEFT JOIN zt_task a ON d.id = a.project
								LEFT JOIN zt_user b ON a.finishedBy = b.account 
								LEFT JOIN zt_dept c ON b.dept = c.id
								WHERE d.id IN (SELECT DISTINCT(project) FROM zt_action e WHERE objectType = ''project'' AND ', query_action, ') AND d.status = ''wait''AND d.deleted = ''0''');
	/* Lọc theo dự án */
	IF (name_ IS NOT NULL) Then
        SET query_ = CONCAT(query_ , ' AND d.id = ''', name_, '''');
   END IF;
	/*Lọc theo dept*/
	IF (dept_ IS NOT NULL) Then
        SET query_ = CONCAT(query_ , ' AND c.id = ''', dept_,'''');
   END IF;
   /* Lọc tương tác với các biểu đồ*/
   If (col_ = 'name') Then
   	SET query_ = CONCAT(query_, ' AND d.name = ''', values_, '''');
   END IF;
   If (col_ = 'dept') Then
   	SET query_ = CONCAT(query_, ' AND c.name = ''', values_, '''');
   END IF;
	If (col_ = 'LoaiHinh') Then
		SET query_lh = CASE WHEN values_ IN ('suspended', 'wait') THEN CONCAT(' AND d.status = ''', values_ ,'''')
								  WHEN values_ = 'doing (delay)' THEN ' AND d.status = ''doing'' AND CURDATE() > d.end'
								  WHEN values_ = 'doing' THEN ' AND d.status = ''doing'' AND CURDATE() <= d.end' 
								  WHEN values_ = 'closed (delay)' THEN ' AND d.status = ''closed'' AND d.end < CAST(d.closedDate AS DATE)'
								  WHEN values_ = 'closed (on-time)' THEN ' AND d.status = ''closed'' AND d.end = CAST(d.closedDate AS DATE)'
								  WHEN values_ = 'closed' THEN ' AND d.status = ''closed'' AND d.closedDate = ''0000-00-00 00:00:00'''
								  ELSE ' AND d.status = ''closed'' AND d.end > CAST(d.closedDate AS DATE)' END;
								  
   	SET query_ = CONCAT(query_, query_lh);
   END IF;		
							
	SET @SQL := query_;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
				
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_sp_SoDuAn_dept
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_sp_SoDuAn_dept`(
	IN `name_` NVARCHAR(200),
	IN `dept_` NVARCHAR(20),
	IN `col_` NVARCHAR(20),
	IN `values_` NVARCHAR(200)
)
BEGIN
	DECLARE query_ nvarchar(2000);
	DECLARE query_lh nvarchar(200);
	DECLARE query_action nvarchar(300);
	
	SET query_action = CASE WHEN col_ = 'action' THEN CONCAT('e.action = ''', values_, '''') ELSE 'e.action IN ( ''opened'', ''closed'', ''started'' , ''suspended'')' END;
	SET query_ = CONCAT(' SELECT c.name, COUNT(DISTINCT a.project) SoDA
								FROM zt_task a LEFT JOIN zt_user b ON a.finishedBy = b.account 
								LEFT JOIN zt_dept c ON b.dept = c.id
								LEFT JOIN zt_project d ON a.project = d.id 
								WHERE a.id IN (SELECT DISTINCT(project) FROM zt_action e WHERE objectType = ''project'' AND ', query_action, ') AND a.deleted = ''0'' AND b.deleted = ''0''');
								
	/* Lọc theo dự án */
	IF (name_ IS NOT NULL) Then
        SET query_ = CONCAT(query_ , ' AND d.id = ''', name_, '''');
   END IF;
   /* Lọc theo bộ phận */
	IF (dept_ IS NOT NULL) Then
        SET query_ = CONCAT(query_ , ' AND c.id = ''', dept_, '''');
   END IF;
   /* Lọc tương tác với các biểu đồ*/
   If (col_ = 'name') Then
   	SET query_ = CONCAT(query_, ' AND d.name = ''', values_, '''');
   END IF;
   /* Lọc tương tác với các biểu đồ cột*/
   If (col_ = 'dept') Then
   	SET query_ = CONCAT(query_, ' AND c.name = ''', values_, '''');
   END IF;
   If (col_ = 'LoaiHinh') Then
		SET query_lh = CASE WHEN values_ IN ('suspended', 'wait') THEN CONCAT(' AND d.status = ''', values_ ,'''')
								  WHEN values_ = 'doing (delay)' THEN ' AND d.status = ''doing'' AND CURDATE() > a.end'
								  WHEN values_ = 'doing' THEN ' AND d.status = ''doing'' AND CURDATE() <= d.end' 
								  WHEN values_ = 'closed (delay)' THEN ' AND d.status = ''closed'' AND d.end < CAST(d.closedDate AS DATE)'
								  WHEN values_ = 'closed (on-time)' THEN ' AND d.status = ''closed'' AND d.end = CAST(a.closedDate AS DATE)'
								  WHEN values_ = 'closed' THEN ' AND d.status = ''closed'' AND d.closedDate = ''0000-00-00 00:00:00'''
								  ELSE ' AND d.status = ''closed'' AND d.end > CAST(d.closedDate AS DATE)' END;
								  
   	SET query_ = CONCAT(query_, query_lh);
   END IF;
	SET query_ = CONCAT(query_ ,' GROUP BY c.name  ORDER BY COUNT(DISTINCT a.project) DESC');
	
	SET @SQL := query_;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_sp_status_DuAn_tron
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_sp_status_DuAn_tron`(
	IN `name_` nvarchar(200),
	IN `dept_` NVARCHAR(20),
	IN `col_` NVARCHAR(20),
	IN `values_` NVARCHAR(100)
)
BEGIN

	DECLARE query_ nvarchar(2000);
	DECLARE query_lh nvarchar(200);
	DECLARE query_action nvarchar(300);
	
	SET query_action = CASE WHEN col_ = 'action' THEN CONCAT('e.action = ''', values_, '''') ELSE 'e.action IN ( ''opened'', ''closed'', ''started'' , ''suspended'')' END;
	
	SET query_ = CONCAT('SELECT CASE WHEN a.status = ''suspended'' then a.status', 
	 			   			' WHEN a.status = ''wait'' then a.status',
	 			  				' WHEN a.status = ''doing'' AND CURDATE() > a.end then ''doing (delay)''',
				 			   ' WHEN a.status = ''doing'' AND CURDATE() <= a.end then a.status' ,
				 			   ' WHEN a.status = ''closed'' AND a.end < CAST(a.closedDate AS DATE) then ''closed (delay)''' ,
				 			   ' WHEN a.status = ''closed'' AND a.end = CAST(a.closedDate AS DATE) then ''closed (on-TIME)''' ,
				 			   ' WHEN a.status = ''closed'' AND a.closedDate = ''0000-00-00 00:00:00'' then a.status',
	 			  				' ELSE ''finish-soon'' END  LoaiHinh',
								', count(distinct(a.id)) tong', 
								' from zt_project a', 
								' LEFT JOIN zt_task b ON a.id = b.project',
								' LEFT JOIN zt_user c ON b.finishedBy = c.account' ,
								' LEFT JOIN zt_dept d ON c.dept = d.id',								
								' WHERE a.id IN (SELECT DISTINCT(project) FROM zt_action e WHERE objectType = ''project'' AND ', query_action, ') AND a.deleted = ''0''');


	/* Lọc theo dự án */
	IF (name_ IS NOT NULL) Then
        SET query_ = CONCAT(query_ , ' AND a.id = ''', name_, '''');
   END IF;
   /* Lọc theo dept */
	IF (dept_ IS NOT NULL) Then
        SET query_ = CONCAT(query_ , ' AND d.id = ''', dept_, '''');
   END IF;
   /* Lọc tương tác với các biểu đồ*/
   If (col_ = 'name') Then
   	SET query_ = CONCAT(query_ ,' AND a.name = ''', values_, '''');
   END IF;
   If (col_ = 'dept') Then
   	SET query_ = CONCAT(query_ ,' AND d.name = ''', values_, '''');
   END IF;
   If (col_ = 'LoaiHinh') Then
		SET query_lh = CASE WHEN values_ IN ('suspended', 'wait') THEN CONCAT(' AND a.status = ''', values_ ,'''')
								  WHEN values_ = 'doing (delay)' THEN ' AND a.status = ''doing'' AND CURDATE() > a.end'
								  WHEN values_ = 'doing' THEN ' AND a.status = ''doing'' AND CURDATE() <= a.end' 
								  WHEN values_ = 'closed (delay)' THEN ' AND a.status = ''closed'' AND a.end < CAST(a.closedDate AS DATE)'
								  WHEN values_ = 'closed (on-time)' THEN ' AND a.status = ''closed'' AND a.end = CAST(a.closedDate AS DATE)'
								  WHEN values_ = 'closed' THEN ' AND a.status = ''closed'' AND a.closedDate = ''0000-00-00 00:00:00'''
								  ELSE ' AND a.status = ''closed'' AND a.end > CAST(a.closedDate AS DATE)' END;
								  
   	SET query_ = CONCAT(query_, query_lh);
   END IF;		
        
	SET query_ = CONCAT(query_ , ' GROUP BY CASE ',
													 	' WHEN a.status = ''suspended'' then a.status' ,
													 	' WHEN a.status = ''wait'' then a.status' ,
													 	' WHEN a.status = ''doing'' AND CURDATE() > a.end then ''doing (delay)''',
													 	' WHEN a.status = ''doing'' AND CURDATE() <= a.end then a.status',
														' WHEN a.status = ''closed'' AND a.end < CAST(a.closedDate AS DATE) then ''closed (delay)''',
													 	' WHEN a.status = ''closed'' AND a.end = CAST(a.closedDate AS DATE) then ''closed (on-time)''', 
													 	' WHEN a.status = ''closed'' AND a.closedDate = ''0000-00-00 00:00:00'' then a.status',
													 	' ELSE ''finish-soon'' END');
	/*PRINT(query_)*/
	SET @SQL := query_;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_sp_status_MucdoTT_DuAn_BANG
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_sp_status_MucdoTT_DuAn_BANG`(
	IN `name_` NVARCHAR(200),
	IN `dept_` NVARCHAR(20),
	IN `col_` NVARCHAR(20),
	IN `values_` NVARCHAR(100)
)
BEGIN

	DECLARE query_ nvarchar(2000);
	DECLARE query_lh nvarchar(200);
	SET query_ = CONCAT('SELECT a.name, DATEDIFF( CURDATE(), MAX(b.date)) tt_date, CASE WHEN a.status = ''suspended'' then a.status',
				   			 ' WHEN a.status = ''Wait'' then a.status', 
				  				 ' WHEN a.status = ''doing'' AND CURDATE() > a.end then ''doing (delay)''',
				 			    ' WHEN a.status = ''doing'' AND CURDATE() <= a.end then a.status' ,		 			    
				  				 ' ELSE ''closed'' END AS LoaiHinh',
								 ' FROM zt_project a',
								 ' LEFT JOIN zt_action b ON a.id = b.project',						
								 ' WHERE a.status <>''closed'' AND a.deleted = ''0''');
						 
								 
	/* Lọc theo dự án */
	IF (name_ IS NOT NULL) Then
        SET query_ = CONCAT(query_ , ' AND a.id = ''', name_, '''');
   END IF;
   /* Lọc tương tác với các biểu đồ*/
   If (col_ = 'name') Then
   	SET query_ = CONCAT(query_ ,' AND a.name = ''', values_, '''');
   END IF;
   If (col_ = 'LoaiHinh') Then
		SET query_lh = CASE WHEN values_ IN ('suspended', 'wait') THEN CONCAT(' AND a.status = ''', values_ ,'''')
								  WHEN values_ = 'doing (delay)' THEN ' AND a.status = ''doing'' AND CURDATE() > a.end'
								  WHEN values_ = 'doing' THEN ' AND a.status = ''doing'' AND CURDATE() <= a.end' 
								  WHEN values_ = 'closed (delay)' THEN ' AND a.status = ''closed'' AND a.end < a.closedDate'
								  WHEN values_ = 'closed (on-time)' THEN ' AND a.status = ''closed'' AND a.end = a.closedDate'
								  ELSE ' AND a.status = ''closed'' AND a.end > a.closedDate' END;
								  
   	SET query_ = CONCAT(query_, query_lh);
   END IF;	
	SET query_ = CONCAT(query_ ,' GROUP BY CASE'
	 							 ' WHEN a.status = ''wait'' then a.status',
	 			  				 ' WHEN a.status = ''doing'' AND CURDATE() > a.end then ''doing (delay)''',
				 			    ' WHEN a.status = ''doing'' AND CURDATE() <= a.end then a.status' ,
				 			    ' ELSE ''closed'' END, a.name', 
								 ' ORDER BY tt_date DESC' );


 	SET @SQL := query_;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
				
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_sp_ThongKe_DuAn_BANG
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_sp_ThongKe_DuAn_BANG`(
	IN `name_` NVARCHAR(200),
	IN `dept_` NVARCHAR(20),
	IN `col_` NVARCHAR(20),
	IN `values_` NVARCHAR(100)
)
BEGIN

	DECLARE query_ nvarchar(2000);
	DECLARE query_lh nvarchar(200);
	DECLARE query_action nvarchar(300);
	
	SET query_action = CASE WHEN col_ = 'action' THEN CONCAT('e.action = ''', values_, '''') ELSE 'e.action IN ( ''opened'', ''closed'', ''started'' , ''suspended'')' END;
 	SET query_ = CONCAT('SELECT a.NAME, CASE WHEN a.status = ''suspended'' then a.status', 
		   			' WHEN a.status = ''wait'' then a.status' ,
		  				' WHEN a.status = ''doing'' AND CURDATE() > a.end then ''doing (delay)''',
		 			   ' WHEN a.status = ''doing'' AND CURDATE() <= a.end then a.status' ,
		 			   ' WHEN a.status = ''closed'' AND a.end < CAST(a.closedDate AS DATE) then ''closed (delay)''', 
		 			   ' WHEN a.status = ''closed'' AND a.end = CAST(a.closedDate AS DATE) then ''closed (on-TIME)''',
		 			   ' WHEN a.status = ''closed'' AND a.closedDate = ''0000-00-00 00:00:00'' then a.status',
		  				' ELSE ''finish-soon'' END AS LoaiHinh',
	 	 		 ', CASE WHEN a.status = ''doing'' AND CURDATE() > a.end Then DATEDIFF(a.end, CURDATE())',
	 	 		 		' WHEN a.status = ''doing'' AND CURDATE() <= a.end Then DATEDIFF( a.end, CURDATE())' ,
						' WHEN a.status = ''closed'' AND a.end > CAST(a.closedDate AS DATE) Then DATEDIFF( a.end, a.closedDate)',
						' WHEN a.status = ''closed'' AND a.end < CAST(a.closedDate AS DATE)Then DATEDIFF( a.end, a.closedDate)',
						' WHEN a.status = ''wait'' Then DATEDIFF(CURDATE(), a.begin)',
						' WHEN a.status = ''closed'' AND a.end = CAST(a.closedDate AS DATE)Then DATEDIFF( a.end, a.closedDate)',
					 	' ELSE ''Null'' END AS SoNgay' ,
				', COUNT(distinct(assignedTo)) AS Nguoi',
				', COUNT(b.id) AS TASK' ,		 		
				' from zt_project a', 
				' LEFT JOIN zt_task b ON a.id = b.project',
				' LEFT JOIN zt_user c ON b.finishedBy = c.account' ,
				' LEFT JOIN zt_dept d ON c.dept = d.id',								
				' WHERE a.id IN (SELECT DISTINCT(project) FROM zt_action e WHERE objectType = ''project'' AND ', query_action, ') AND a.deleted = ''0''');
		/* Lọc theo dự án */
	IF (name_ IS NOT NULL) Then
        SET query_ = CONCAT(query_ , ' AND a.id = ''', name_, '''');
   END IF;
   	/* Lọc theo dept */
	IF (dept_ IS NOT NULL) Then
        SET query_ = CONCAT(query_ , ' AND d.id = ''', dept_, '''');
   END IF;
   /* Lọc tương tác với các biểu đồ*/
   If (col_ = 'name') Then
   	SET query_ = CONCAT(query_ ,' AND a.name = ''', values_, '''');
   END IF;
   If (col_ = 'dept') Then
   	SET query_ = CONCAT(query_ ,' AND d.name = ''', values_, '''');
   END IF;
   If (col_ = 'LoaiHinh') Then
		SET query_lh = CASE WHEN values_ IN ('suspended', 'wait') THEN CONCAT(' AND a.status = ''', values_ ,'''')
								  WHEN values_ = 'doing (delay)' THEN ' AND a.status = ''doing'' AND CURDATE() > a.end'
								  WHEN values_ = 'doing' THEN ' AND a.status = ''doing'' AND CURDATE() <= a.end' 
								  WHEN values_ = 'closed (delay)' THEN ' AND a.status = ''closed'' AND a.end < CAST(a.closedDate AS DATE)'
								  WHEN values_ = 'closed (on-time)' THEN ' AND a.status = ''closed'' AND a.end = CAST(a.closedDate AS DATE)'
								  WHEN values_ = 'closed' THEN ' AND a.status = ''closed'' AND a.closedDate = ''0000-00-00 00:00:00'''
								  ELSE ' AND a.status = ''closed'' AND a.end > CAST(a.closedDate AS DATE)' END;
								  
   	SET query_ = CONCAT(query_, query_lh);
   END IF;	
	SET query_ = CONCAT(query_ , ' GROUP BY  CASE WHEN a.status = ''suspended'' then a.status' ,
													 	' WHEN a.status = ''wait'' then a.status' ,
													 	' WHEN a.status = ''doing'' AND CURDATE() > a.end then ''doing (delay)''',
													 	' WHEN a.status = ''doing'' AND CURDATE() <= a.end then a.status',
														' WHEN a.status = ''closed'' AND a.end < CAST(a.closedDate AS DATE) then ''closed (delay)''',
													 	' WHEN a.status = ''closed'' AND a.end = CAST(a.closedDate AS DATE) then ''closed (on-time)''', 
													 	' WHEN a.status = ''closed'' AND a.closedDate = ''0000-00-00 00:00:00'' then a.status',
													 	' ELSE ''finish-soon'' END, a.id ');
														
														

								
	SET @SQL := query_;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
				
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_sp_Tiendo_duan
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_sp_Tiendo_duan`(
	IN `name_` NVARCHAR(200),
	IN `dept_` NVARCHAR(20),
	IN `col_` NVARCHAR(200),
	IN `values_` NVARCHAR(200)
)
BEGIN 
	DECLARE query_ nvarchar(2000);
	DECLARE query_lh nvarchar(200);
	DECLARE query_action nvarchar(300);
	
	SET query_action = CASE WHEN col_ = 'action' THEN CONCAT('e.action = ''', values_, '''') ELSE 'e.action IN ( ''opened'', ''closed'', ''started'' , ''suspended'')' END;
	SET query_ = CONCAT(' SELECT d.name, SUM(a.left) AS left_, SUM(a.consumed) COST, 
		 						 CONCAT(CAST(CAST(SUM(a.consumed) /( SUM(a.consumed)+SUM(a.left))*100 AS DECIMAL(10,2)) AS NCHAR), ''%'') txt_tile_ht',
						' FROM zt_project d LEFT JOIN zt_task a ON d.id = a.project',
						' LEFT JOIN zt_user b ON a.finishedBy = b.account',  
						' LEFT JOIN zt_dept c ON b.dept = c.id',
						' WHERE d.id IN (SELECT DISTINCT(project) FROM zt_action e WHERE objectType = ''project'' AND ', query_action, ') AND a.deleted = ''0'' AND d.deleted = ''0'' AND a.parent <> ''-1''');

	/* Lọc theo dự án */
	IF (name_ IS NOT NULL) Then
        SET query_ = CONCAT(query_ , ' AND d.id = ''', name_, '''');
   END IF;
   /* Lọc theo bộ phận */
	IF (dept_ IS NOT NULL) Then
        SET query_ = CONCAT(query_ , ' AND c.id = ''', dept_, '''');
   END IF;
   /* Lọc tương tác với các biểu đồ*/
   If (col_ = 'name') Then
   	SET query_ = CONCAT(query_, ' AND d.name = ''', values_, '''');
   END IF;
   /* Lọc tương tác với các biểu đồ cột*/
   If (col_ = 'dept') Then
   	SET query_ = CONCAT(query_, ' AND c.name = ''', values_, '''');
   END IF;
   If (col_ = 'LoaiHinh') Then
		SET query_lh = CASE WHEN values_ IN ('suspended', 'wait') THEN CONCAT(' AND d.status = ''', values_ ,'''')
								  WHEN values_ = 'doing (delay)' THEN ' AND d.status = ''doing'' AND CURDATE() > a.end'
								  WHEN values_ = 'doing' THEN ' AND d.status = ''doing'' AND CURDATE() <= d.end' 
								  WHEN values_ = 'closed (delay)' THEN ' AND d.status = ''closed'' AND d.end < CAST(d.closedDate AS DATE)'
								  WHEN values_ = 'closed (on-time)' THEN ' AND d.status = ''closed'' AND d.end = CAST(a.closedDate AS DATE)'
								  WHEN values_ = 'closed' THEN ' AND d.status = ''closed'' AND d.closedDate = ''0000-00-00 00:00:00'''
								  ELSE ' AND d.status = ''closed'' AND d.end > CAST(d.closedDate AS DATE)' END;
								  
   	SET query_ = CONCAT(query_, query_lh);
   END IF;						
	SET query_ = CONCAT(query_ ,' GROUP BY d.name ORDER BY CONCAT(CAST(CAST(SUM(a.consumed) /( SUM(a.consumed)+SUM(a.left))*100 AS DECIMAL(10,2)) AS NCHAR), ''%'') DESC');
	
	SET @SQL := query_;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
				
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_sp_TL_DuAn_dept
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_sp_TL_DuAn_dept`(
	IN `name_` NVARCHAR(200),
	IN `dept_` NVARCHAR(20),
	IN `col_` NVARCHAR(20),
	IN `values_` NVARCHAR(200)
)
BEGIN
	DECLARE query_ nvarchar(2000);
	DECLARE query_lh nvarchar(200);
	DECLARE query_action nvarchar(300);
	
	   SET query_action = CASE WHEN col_ = 'action' THEN CONCAT('e.action = ''', values_, '''') ELSE 'e.action IN ( ''opened'', ''closed'', ''started'' , ''suspended'')' END;
	
		SET query_ = CONCAT(' SELECT c.name, COUNT(DISTINCT a.project)/(SELECT COUNT(*) FROM zt_project WHERE deleted = ''0'') * 100 AS TiLe,
									CONCAT(CAST(CAST(COUNT(DISTINCT a.project)/(SELECT COUNT(*) FROM zt_project WHERE deleted = ''0'') * 100 AS DECIMAL(10,2)) AS NCHAR), ''%'') text_tile
									FROM zt_task a LEFT JOIN zt_user b ON a.finishedBy = b.account 
									LEFT JOIN zt_dept c ON b.dept = c.id
									LEFT JOIN zt_project d ON a.project = d.id 
									WHERE d.id IN (SELECT DISTINCT(project) FROM zt_action e WHERE objectType = ''project'' AND ', query_action, ') AND d.deleted = ''0''  AND b.deleted = ''0''');
								
	/* Lọc theo dự án */
	IF (name_ IS NOT NULL) Then
        SET query_ = CONCAT(query_ , ' AND d.id = ''', name_, '''');
   END IF;
   	/* Lọc theo bộ phận */
	IF (dept_ IS NOT NULL) Then
        SET query_ = CONCAT(query_ , ' AND c.id = ''', dept_, '''');
   END IF;
   /* Lọc tương tác với các biểu đồ*/
   If (col_ = 'name') Then
   	SET query_ = CONCAT(query_, ' AND d.name = ''', values_, '''');
   END IF;
   If (col_ = 'dept') Then
   	SET query_ = CONCAT(query_, ' AND c.name = ''', values_, '''');
   END IF;
   If (col_ = 'LoaiHinh') Then
		SET query_lh = CASE WHEN values_ IN ('suspended', 'wait') THEN CONCAT(' AND d.status = ''', values_ ,'''')
								  WHEN values_ = 'doing (delay)' THEN ' AND d.status = ''doing'' AND CURDATE() > d.end'
								  WHEN values_ = 'doing' THEN ' AND d.status = ''doing'' AND CURDATE() <= d.end' 
								  WHEN values_ = 'closed (delay)' THEN ' AND d.status = ''closed'' AND d.end < CAST(d.closedDate AS DATE)'
								  WHEN values_ = 'closed (on-time)' THEN ' AND d.status = ''closed'' AND d.end = CAST(a.closedDate AS DATE)'
								  WHEN values_ = 'closed' THEN ' AND d.status = ''closed'' AND d.closedDate = ''0000-00-00 00:00:00'''
								  ELSE ' AND d.status = ''closed'' AND d.end > CAST(d.closedDate AS DATE)' END;
								  
   	SET query_ = CONCAT(query_, query_lh);
   END IF;	
	SET query_ = CONCAT(query_ ,' GROUP BY c.name order by COUNT(DISTINCT a.project)/(SELECT COUNT(*) FROM zt_project WHERE deleted = ''0'') desc ');
	
	SET @SQL := query_;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_task_all
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_task_all`(
	IN `id_proc` VARCHAR(35),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `story` INT,
	IN `dept` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300),
	IN `year_` ENUM('Y','N'),
	IN `month_` ENUM('Y','N'),
	IN `day_` ENUM('Y','N')
)
BEGIN

	IF id_proc = 'detail_open' THEN
		CALL `dsa_task_all_detail_open`(start_date, end_date, project_id, username, story, dept, col, val, year_, month_, day_) ;
	END IF;
	
	IF id_proc = 'detail_finish' THEN
		CALL `dsa_task_all_detail_finish`(start_date, end_date, project_id, username, story, dept, col, val, year_, month_, day_) ;
	END IF;
	
	IF id_proc = 'detail_assign' THEN
		CALL `dsa_task_all_detail_assign`(start_date, end_date, project_id, username, story, dept, col, val, year_, month_, day_) ;
	END IF;

	IF id_proc = 'delay_detail' THEN
		CALL `dsa_task_delay_detail`(start_date, end_date, project_id, username, story, dept, col, val, year_, month_, day_) ;
	END IF;
	
	IF id_proc = 'num_hour_bytime' THEN
		CALL `dsa_task_num_hour_bytime`(start_date, end_date, project_id, username, story, dept, col, val, year_, month_, day_);
	END IF;
	
	IF id_proc = 'num_est_hour_bytime' THEN
		CALL `dsa_task_num_est_hour_bytime`(start_date, end_date, project_id, username, story, dept, col, val, year_, month_, day_);
	END IF;
	
	IF id_proc = 'num_pri' THEN
		CALL `dsa_task_num_pri`(start_date, end_date, project_id, username, story, dept, col, val, year_, month_, day_);
	END IF;
	
	IF id_proc = 'num_task_byproject' THEN
		CALL `dsa_task_num_task_byproject` (start_date, end_date, project_id, username, story, dept, col, val, year_, month_, day_);
	END IF;
	
	IF id_proc = 'num_task_bystory' THEN
		CALL `dsa_task_num_task_bystory` (start_date, end_date, project_id, username, story, dept, col, val, year_, month_, day_);
	END IF;
	
	IF id_proc = 'num_task_bytime' THEN
		CALL `dsa_task_num_task_bytime` (start_date, end_date, project_id, username, story, dept, col, val, year_, month_, day_);
	END IF;
	
	IF id_proc = 'total_delay_task' THEN
		CALL `dsa_task_total_delay_task` (start_date, end_date, project_id, username, story, dept, col, val, year_, month_, day_);
	END IF;
	
	IF id_proc = 'total_hour' THEN
		CALL `dsa_task_total_hour` (start_date, end_date, project_id, username, story, dept, col, val, year_, month_, day_);
	END IF;
	
	IF id_proc = 'total_task' THEN
		CALL `dsa_task_total_task` (start_date, end_date, project_id, username, story, dept, col, val, year_, month_, day_);
	END IF;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_task_all_detail_assign
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_task_all_detail_assign`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `story` INT,
	IN `dept` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300),
	IN `year_` ENUM('Y','N'),
	IN `month_` ENUM('Y','N'),
	IN `day_` ENUM('Y','N')
)
BEGIN
	DECLARE QUERY1 NVARCHAR(4000);
	
	-- Liệt kê các trường dữ liệu cần hiển thị của 2 bảng zt_task, zt_project
	SET QUERY1 = 
	'SELECT
		p.name as ''Dự án'',
		t.status as ''Trạng thái'',
		t.assignedTo as ''Người được giao'',
		t.name as ''Tên task'',
		t.assignedDate as ''Ngày giao task'',
		t.realStarted as ''Ngày bắt đầu'', 
		t.estimate as ''Số giờ ước tính'', 
		t.consumed as ''Số giờ thực hiện'', 
		t.deadline as ''Deadline''
	FROM
		zt_task t
	INNER JOIN
		zt_project p
	ON
		t.project = p.id 
	WHERE 1=1 ';
	
	-- Lọc các task , project chưa bị xóa
	SET QUERY1 = CONCAT(QUERY1, 'AND t.deleted <> ''1'' AND p.deleted <> ''1'' AND t.parent<>-1 ');
	
	-- Lọc các task có thời gian mở nằm trong khoảng đã cho
	IF start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.assignedDate BETWEEN \' ',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
	END IF;
	
	-- Lọc các task theo dự án
	IF project_id IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.project = ', project_id,' )');
	END IF;
	
	-- Lọc các task theo user
	IF username IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.assignedTo = \'', username ,'\' )');
	END IF;
	
	-- Lọc các task theo mức độ ưu tiên
	IF story IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.story = ', story,')');
	END IF;
	
	-- Lọc các task theo department
	IF dept IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.assignedTo IN (SELECT u.account FROM zt_user u INNER JOIN zt_dept d ON u.dept = d.id WHERE u.dept= ',dept,'))');
	END IF;
	
	CASE
		-- col, val binh thuong
		WHEN col IS NOT NULL AND col <> 's.title' AND col <>'p.name' AND col <> 't.pri' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND (', col, ' LIKE N\'%', val ,'%\')');
		
		-- Loc theo story
		WHEN col IS NOT NULL AND col = 's.title' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.story IN (SELECT id FROM zt_story WHERE title=N\'',val,'\' AND deleted <> ''1'')' );
		
		-- Loc theo du an
		WHEN col IS NOT NULL AND col = 'p.name' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.project = (SELECT id FROM zt_project WHERE name=N\'',val,'\' AND deleted <> ''1'')' );
		
		-- Loc theo uu tien
		WHEN col IS NOT NULL AND col = 't.pri' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.pri = CONVERT(RIGHT(\'',val,'\',1),SIGNED INTEGER)' );
		
		ELSE SELECT 1;
		
	END CASE;
	
	-- Sắp xếp theo ngày mở task
	SET QUERY1 = CONCAT(QUERY1,' ORDER BY 5 DESC');
	
	-- In và khởi chạy query
	-- SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt FROM @SQL;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_task_all_detail_finish
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_task_all_detail_finish`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `story` INT,
	IN `dept` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300),
	IN `year_` ENUM('Y','N'),
	IN `month_` ENUM('Y','N'),
	IN `day_` ENUM('Y','N')
)
BEGIN
	DECLARE QUERY1 NVARCHAR(4000);
	
	-- Liệt kê các trường dữ liệu cần hiển thị của 2 bảng zt_task, zt_project
	SET QUERY1 = 
	'SELECT
		p.name as ''Dự án'',
		t.status as ''Trạng thái'',
		t.finishedBy as ''Người hoàn thành'',
		t.name as ''Tên task'',
		t.finishedDate as ''Ngày hoàn thành'',
		t.realStarted as ''Ngày bắt đầu'', 
		t.estimate as ''Số giờ ước tính'', 
		t.consumed as ''Số giờ thực hiện'', 
		t.deadline as ''Deadline''
	FROM
		zt_task t
	INNER JOIN
		zt_project p
	ON
		t.project = p.id 
	WHERE 1=1 ';
	
	-- Lọc các task , project chưa bị xóa
	SET QUERY1 = CONCAT(QUERY1, 'AND t.deleted <> ''1'' AND p.deleted <> ''1'' AND t.parent<>-1 AND t.status IN (''done'', ''closed'')');
	
	-- Lọc các task có thời gian mở nằm trong khoảng đã cho
	IF start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.finishedDate BETWEEN \' ',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' ) ' );
	END IF;
	
	-- Lọc các task theo dự án
	IF project_id IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.project = ', project_id,' )');
	END IF;
	
	-- Lọc các task theo user
	IF username IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.finishedBy = \'', username ,'\' )');
	END IF;
	
	-- Lọc các task theo mức độ ưu tiên
	IF story IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.story = ', story,')');
	END IF;
	
	-- Lọc các task theo department
	IF dept IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.finishedBy IN (SELECT u.account FROM zt_user u INNER JOIN zt_dept d ON u.dept = d.id WHERE u.dept= ',dept,'))');
	END IF;
	
	CASE
		-- col, val binh thuong
		WHEN col IS NOT NULL AND col <> 's.title' AND col <>'p.name' AND col <> 't.pri' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND (', col, ' LIKE N\'%', val ,'%\') ');
		
		-- Loc theo story
		WHEN col IS NOT NULL AND col = 's.title' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.story IN (SELECT id FROM zt_story WHERE title=N\'',val,'\' AND deleted <> ''1'') ' );
		
		-- Loc theo du an
		WHEN col IS NOT NULL AND col = 'p.name' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.project = (SELECT id FROM zt_project WHERE name=N\'',val,'\' AND deleted <> ''1'') ' );
		
		-- Loc theo uu tien
		WHEN col IS NOT NULL AND col = 't.pri' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.pri = CONVERT(RIGHT(\'',val,'\',1),SIGNED INTEGER)' );
		
		ELSE SELECT 1;
		
	END CASE;
	
	-- Sắp xếp theo ngày mở task
	SET QUERY1 = CONCAT(QUERY1,' ORDER BY t.finishedDate DESC');
	
	-- In và khởi chạy query
	-- SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt FROM @SQL;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_task_all_detail_open
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_task_all_detail_open`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `story` INT,
	IN `dept` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300),
	IN `year_` ENUM('Y','N'),
	IN `month_` ENUM('Y','N'),
	IN `day_` ENUM('Y','N')
)
BEGIN
	DECLARE QUERY1 NVARCHAR(4000);
	
	-- Liệt kê các trường dữ liệu cần hiển thị của 2 bảng zt_task, zt_project
	SET QUERY1 = 
	'SELECT
		p.name as ''Dự án'',
		t.status as ''Trạng thái'',
		t.assignedTo as ''Người được giao'',
		t.name as ''Tên task'',
		t.openedDate as ''Ngày mở task'',
		t.realStarted as ''Ngày bắt đầu'', 
		t.estimate as ''Số giờ ước tính'', 
		t.consumed as ''Số giờ thực hiện'', 
		t.deadline as ''Deadline''
	FROM
		zt_task t
	INNER JOIN
		zt_project p
	ON
		t.project = p.id 
	WHERE 1=1 ';
	
	-- Lọc các task , project chưa bị xóa
	SET QUERY1 = CONCAT(QUERY1, 'AND t.deleted <> ''1'' AND p.deleted <> ''1'' AND t.parent<>-1');
	
	-- Lọc các task có thời gian mở nằm trong khoảng đã cho
	IF start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.openedDate BETWEEN \' ',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
	END IF;
	
	-- Lọc các task theo dự án
	IF project_id IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.project = ', project_id,' )');
	END IF;
	
	-- Lọc các task theo user
	IF username IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.assignedTo = \'', username ,'\' )');
	END IF;
	
	-- Lọc các task theo story
	IF story IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.story = ', story,')');
	END IF;
	
	-- Lọc các task theo department
	IF dept IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.assignedTo IN (SELECT u.account FROM zt_user u INNER JOIN zt_dept d ON u.dept = d.id WHERE u.dept= ',dept,'))');
	END IF;
	
	CASE
		-- col, val binh thuong
		WHEN col IS NOT NULL AND col <> 's.title' AND col <>'p.name' AND col <> 't.pri' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND (', col, ' LIKE N\'%', val ,'%\')');
		
		-- Loc theo story
		WHEN col IS NOT NULL AND col = 's.title' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.story IN (SELECT id FROM zt_story WHERE title=N\'',val,'\' AND deleted <> ''1'')' );
		
		-- Loc theo du an
		WHEN col IS NOT NULL AND col = 'p.name' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.project = (SELECT id FROM zt_project WHERE name=N\'',val,'\' AND deleted <> ''1'')' );
		
		-- Loc theo uu tien
		WHEN col IS NOT NULL AND col = 't.pri' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.pri = CONVERT(RIGHT(\'',val,'\',1),SIGNED INTEGER)' );
		
		ELSE SELECT 1;
		
	END CASE;
	
	-- Sắp xếp theo ngày mở task
	SET QUERY1 = CONCAT(QUERY1,' ORDER BY 5 DESC');
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt FROM @SQL;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_task_ddl_all
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_task_ddl_all`(
	IN `id_ddl` VARCHAR(35)
)
BEGIN
	IF id_ddl = 'ddl_task_project' THEN
		CALL `dsa_task_ddl_project`;
	END IF;
	
	IF id_ddl = 'ddl_task_user' THEN
		CALL `dsa_task_ddl_user`;
	END IF;
	
	IF id_ddl = 'ddl_task_story' THEN
		CALL `dsa_task_ddl_story`;
	END IF;
	
	IF id_ddl = 'ddl_task_dept' THEN
		CALL `dsa_task_ddl_dept`;
	END IF;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_task_ddl_dept
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_task_ddl_dept`()
BEGIN
	SELECT 
		id,
		CONCAT(name, ' (', id, ')') as department
	FROM
		zt_dept;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_task_ddl_project
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_task_ddl_project`()
BEGIN
	SELECT 
		DISTINCT p.id, 
		CONCAT(p.NAME,' (',p.id,')') project_name 
	FROM 
		zt_project p 
	INNER JOIN 
		zt_task t 
	ON 
		p.id = t.project 
	WHERE 
		t.deleted = '0' 
		AND p.deleted = '0'
	ORDER BY 2;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_task_ddl_story
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_task_ddl_story`()
BEGIN
	SELECT 
		DISTINCT s.id, 
		CONCAT(s.title,' (',s.id,')') story_name 
	FROM 
		zt_story s 
	INNER JOIN 
		zt_task t 
	ON 
		s.id = t.story 
	WHERE 
		t.deleted = '0' 
		AND s.deleted = '0'
	ORDER BY 2;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_task_ddl_user
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_task_ddl_user`()
BEGIN
	SELECT 
		account, 
		CONCAT(realname, ' (', account,')') 
	FROM 
		zt_user 
	WHERE 
		deleted = '0'
	ORDER BY 1;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_task_delay_detail
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_task_delay_detail`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `story` INT,
	IN `dept` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300),
	IN `year_` ENUM('Y','N'),
	IN `month_` ENUM('Y','N'),
	IN `day_` ENUM('Y','N')
)
BEGIN
	DECLARE QUERY1 NVARCHAR(4000);
	
	-- Liệt kê các trường dữ liệu cần hiển thị của 2 bảng zt_task, zt_project
	SET QUERY1 = 
	'SELECT
		p.name as ''p.name'',
		t.name as ''t.name'',
		t.assignedTo as ''t.assignedTo'',
		t.status as ''t.status'',
		DATEDIFF(DATE(NOW()), DATE(t.deadline)) AS delay_days
	FROM
		zt_task t
	INNER JOIN
		zt_project p
	ON
		t.project = p.id
	WHERE 1=1 ';
	
	-- Lọc các task có trạng thái chưa hoàn thành và cũng không xóa, cũng như project chưa bị xóa
	SET QUERY1 = CONCAT(QUERY1, 'AND t.STATUS IN (''doing'', ''wait'', ''pause'') AND t.deleted <> ''1'' AND p.deleted <> ''1'' AND t.parent<>-1 AND NOT (t.deadline = ''0000-00-00'' AND t.status=''wait'')');
	
	-- Lọc các task có thời gian tương tác lần cuối nằm trong khoảng đã cho
	IF start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' ' );
	END IF;
	
	-- Lọc các task theo dự án
	IF project_id IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.project = ', project_id,' )');
	END IF;
	
	-- Lọc các task theo user
	IF username IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.assignedTo = \'', username ,'\' )');
	END IF;
	
	-- Lọc các task theo story
	IF story IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.story = ', story,')');
	END IF;
	
	-- Lọc các task theo department
	IF dept IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.assignedTo IN (SELECT u.account FROM zt_user u INNER JOIN zt_dept d ON u.dept = d.id WHERE u.dept= ',dept,'))');
	END IF;
	
	-- col, val
	CASE
		-- col, val binh thuong
		WHEN col IS NOT NULL AND col<>'s.title' AND col <> 'p.name' AND col <> 't.pri' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND (', col, ' LIKE N\'%', val ,'%\')');
			
		-- Loc theo story
		WHEN col IS NOT NULL AND col = 's.title' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.story IN (SELECT id FROM zt_story WHERE title=N\'',val,'\' AND deleted <> ''1'')' );
		
		-- Loc theo du an
		WHEN col IS NOT NULL AND col = 'p.name' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.project = (SELECT id FROM zt_project WHERE name=N\'',val,'\' AND deleted <> ''1'')' );
		
		-- Loc theo uu tien
		WHEN col IS NOT NULL AND col = 't.pri' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.pri = CONVERT(RIGHT(\'',val,'\',1),SIGNED INTEGER)' );
		
		ELSE SELECT 1;
	END CASE;
	
	-- Lọc các task delay trên 7 ngày và sắp xếp theo số ngày delay giảm dần
	SET QUERY1  = CONCAT(QUERY1, ' HAVING Delay_Days >= 7 ORDER BY Delay_Days DESC');
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt FROM @SQL;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_task_num_est_hour_bytime
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_task_num_est_hour_bytime`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `story` INT,
	IN `dept` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300),
	IN `year_` ENUM('Y','N'),
	IN `month_` ENUM('Y','N'),
	IN `day_` ENUM('Y','N')
)
BEGIN
	DECLARE QUERY1_1 NVARCHAR(4000);
	DECLARE QUERY2_1 NVARCHAR(4000);
	DECLARE QUERY3_1 NVARCHAR(4000);
	DECLARE QUERY4_1 NVARCHAR(4000);
	DECLARE QUERY1_2 NVARCHAR(4000);
	DECLARE QUERY2_2 NVARCHAR(4000);
	DECLARE QUERY3_2 NVARCHAR(4000);
	DECLARE QUERY4_2 NVARCHAR(4000);
	DECLARE QUERY1 NVARCHAR(4000);
	DECLARE QUERY2 NVARCHAR(4000);
	DECLARE QUERY3 NVARCHAR(4000);
	DECLARE QUERY4 NVARCHAR(4000);
	
	-- Đếm các task theo ngày hoàn thành
	SET QUERY1_1 = 
		'(SELECT
			CONCAT(Day(t.finishedDate),''/'',Month(t.finishedDate),''/'', Year(t.finishedDate)) AS ''date_'',
			ROUND(SUM(t.estimate)) value,
			''Ước tính'' type
		FROM
			zt_task t
		INNER JOIN
			zt_project p
		ON
			t.project = p.id
		WHERE t.deleted <> ''1'' AND p.deleted <> ''1'' AND t.parent <> -1 AND (t.status IN (''done'', ''closed'')) AND 1=1 ';
		
	SET QUERY1_2 = 
		'(SELECT
			CONCAT(Day(t.finishedDate),''/'',Month(t.finishedDate),''/'',Year(t.finishedDate) ) AS ''date_'',
			ROUND(SUM(t.consumed)) value,
			''Thực hiện'' type
		FROM
			zt_task t
		INNER JOIN
			zt_project p
		ON
			t.project = p.id
		WHERE t.deleted <> ''1'' AND p.deleted <> ''1'' AND (t.status IN (''done'', ''closed'')) AND t.parent <> -1 AND 1=1 ';
	
	SET QUERY2_1 = 
		'(SELECT
			Year(t.finishedDate) AS ''date_'',
			ROUND(SUM(t.estimate)) value,
			''Ước tính'' type
		FROM
			zt_task t
		INNER JOIN
			zt_project p
		ON
			t.project = p.id
		WHERE t.deleted <> ''1'' AND p.deleted <> ''1'' AND t.parent <> -1 AND (t.status IN (''done'', ''closed'')) AND 1=1 ';
	
	SET QUERY2_2 = 
		'(SELECT
			Year(t.finishedDate) AS ''date_'',
			ROUND(SUM(t.consumed)) value,
			''Thực hiện'' type
		FROM
			zt_task t
		INNER JOIN
			zt_project p
		ON
			t.project = p.id
		WHERE t.deleted <> ''1'' AND p.deleted <> ''1'' AND t.parent <> -1 AND (t.status IN (''done'', ''closed'')) AND 1=1 ';
	
	SET QUERY3_1 = 
		'(SELECT
			CONCAT(Month(t.finishedDate),''/'', Year(t.finishedDate)) AS ''date_'',
			ROUND(SUM(t.estimate)) value,
			''Ước tính'' type
		FROM
			zt_task t
		INNER JOIN
			zt_project p
		ON
			t.project = p.id
		WHERE t.deleted <> ''1'' AND p.deleted <> ''1'' AND t.parent <> -1 AND (t.status IN (''done'', ''closed'')) AND 1=1 ';

	SET QUERY3_2 = 
		'(SELECT
			CONCAT(Month(t.finishedDate),''/'', Year(t.finishedDate)) AS ''date_'',
			ROUND(SUM(t.consumed)) value,
			''Thực hiện'' type
		FROM
			zt_task t
		INNER JOIN
			zt_project p
		ON
			t.project = p.id
		WHERE t.deleted <> ''1'' AND p.deleted <> ''1'' AND t.parent <> -1  AND (t.status IN (''done'', ''closed'')) AND 1=1 ';
	
	SET QUERY4_1 = 
		'(SELECT
			CONCAT(Day(t.finishedDate),''/'',Month(t.finishedDate),''/'', Year(t.finishedDate)) AS ''date_'',
			ROUND(SUM(t.estimate)) value,
			''Ước tính'' type
		FROM
			zt_task t
		INNER JOIN
			zt_project p
		ON
			t.project = p.id
		WHERE t.deleted <> ''1'' AND p.deleted <> ''1'' AND t.parent <> -1 AND (t.status IN (''done'', ''closed'')) AND 1=1 ';
	
	SET QUERY4_2 = 
		'(SELECT
			CONCAT(Day(t.finishedDate),''/'',Month(t.finishedDate),''/'',Year(t.finishedDate) ) AS ''date_'',
			ROUND(SUM(t.consumed)) value,
			''Thực hiện'' type
		FROM
			zt_task t
		INNER JOIN
			zt_project p
		ON
			t.project = p.id
		WHERE t.deleted <> ''1'' AND p.deleted <> ''1'' AND t.parent <> -1 AND (t.status IN (''done'', ''closed'')) AND 1=1 ';

	-- Lọc các task có thời gian hoàn thành nằm trong khoảng đã cho
	IF start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET QUERY1_1 = CONCAT(QUERY1_1,' AND (t.finishedDate BETWEEN \' ',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
		SET QUERY2_1 = CONCAT(QUERY2_1,' AND (t.finishedDate BETWEEN \' ',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
		SET QUERY3_1 = CONCAT(QUERY3_1,' AND (t.finishedDate BETWEEN \' ',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
		SET QUERY4_1 = CONCAT(QUERY4_1,' AND (t.finishedDate BETWEEN \' ',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
		SET QUERY1_2 = CONCAT(QUERY1_2,' AND (t.finishedDate BETWEEN \' ',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
		SET QUERY2_2 = CONCAT(QUERY2_2,' AND (t.finishedDate BETWEEN \' ',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
		SET QUERY3_2 = CONCAT(QUERY3_2,' AND (t.finishedDate BETWEEN \' ',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
		SET QUERY4_2 = CONCAT(QUERY4_2,' AND (t.finishedDate BETWEEN \' ',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
	END IF;
	
	-- Lọc các task theo dự án
	IF project_id IS NOT NULL THEN
		SET QUERY1_1 = CONCAT(QUERY1_1,' AND (t.project = ', project_id,' )');
		SET QUERY2_1 = CONCAT(QUERY2_1,' AND (t.project = ', project_id,' )');
		SET QUERY3_1 = CONCAT(QUERY3_1,' AND (t.project = ', project_id,' )');
		SET QUERY4_1 = CONCAT(QUERY4_1,' AND (t.project = ', project_id,' )');
		SET QUERY1_2 = CONCAT(QUERY1_2,' AND (t.project = ', project_id,' )');
		SET QUERY2_2 = CONCAT(QUERY2_2,' AND (t.project = ', project_id,' )');
		SET QUERY3_2 = CONCAT(QUERY3_2,' AND (t.project = ', project_id,' )');
		SET QUERY4_2 = CONCAT(QUERY4_2,' AND (t.project = ', project_id,' )');
	END IF;
	
	-- Lọc các task theo user
	IF username IS NOT NULL THEN
		SET QUERY1_1 = CONCAT(QUERY1_1,' AND (t.finishedBy = \'', username ,'\' )');
		SET QUERY2_1 = CONCAT(QUERY2_1,' AND (t.finishedBy = \'', username ,'\' )');
		SET QUERY3_1 = CONCAT(QUERY3_1,' AND (t.finishedBy = \'', username ,'\' )');
		SET QUERY4_1 = CONCAT(QUERY4_1,' AND (t.finishedBy = \'', username ,'\' )');
		SET QUERY1_2 = CONCAT(QUERY1_2,' AND (t.finishedBy = \'', username ,'\' )');
		SET QUERY2_2 = CONCAT(QUERY2_2,' AND (t.finishedBy = \'', username ,'\' )');
		SET QUERY3_2 = CONCAT(QUERY3_2,' AND (t.finishedBy = \'', username ,'\' )');
		SET QUERY4_2 = CONCAT(QUERY4_2,' AND (t.finishedBy = \'', username ,'\' )');
	END IF;
	
	-- Lọc các task theo story
	IF story IS NOT NULL THEN
		SET QUERY1_1 = CONCAT(QUERY1_1,' AND (t.story = ', story,')');
		SET QUERY2_1 = CONCAT(QUERY2_1,' AND (t.story = ', story,')');
		SET QUERY3_1 = CONCAT(QUERY3_1,' AND (t.story = ', story,')');
		SET QUERY4_1 = CONCAT(QUERY4_1,' AND (t.story = ', story,')');
		SET QUERY1_2 = CONCAT(QUERY1_2,' AND (t.story = ', story,')');
		SET QUERY2_2 = CONCAT(QUERY2_2,' AND (t.story = ', story,')');
		SET QUERY3_2 = CONCAT(QUERY3_2,' AND (t.story = ', story,')');
		SET QUERY4_2 = CONCAT(QUERY4_2,' AND (t.story = ', story,')');
	END IF;
	
	-- Lọc các task theo dept
	IF dept IS NOT NULL THEN
		SET QUERY1_1 = CONCAT(QUERY1_1,' AND (t.finishedBy IN (SELECT u.account FROM zt_user u INNER JOIN zt_dept d ON u.dept = d.id WHERE u.dept= ',dept,'))');
		SET QUERY1_2 = CONCAT(QUERY1_2,' AND (t.finishedBy IN (SELECT u.account FROM zt_user u INNER JOIN zt_dept d ON u.dept = d.id WHERE u.dept= ',dept,'))');
		SET QUERY2_1 = CONCAT(QUERY2_1,' AND (t.finishedBy IN (SELECT u.account FROM zt_user u INNER JOIN zt_dept d ON u.dept = d.id WHERE u.dept= ',dept,'))');
		SET QUERY2_2 = CONCAT(QUERY2_2,' AND (t.finishedBy IN (SELECT u.account FROM zt_user u INNER JOIN zt_dept d ON u.dept = d.id WHERE u.dept= ',dept,'))');
		SET QUERY3_1 = CONCAT(QUERY3_1,' AND (t.finishedBy IN (SELECT u.account FROM zt_user u INNER JOIN zt_dept d ON u.dept = d.id WHERE u.dept= ',dept,'))');
		SET QUERY3_2 = CONCAT(QUERY3_2,' AND (t.finishedBy IN (SELECT u.account FROM zt_user u INNER JOIN zt_dept d ON u.dept = d.id WHERE u.dept= ',dept,'))');
		SET QUERY4_1 = CONCAT(QUERY4_1,' AND (t.finishedBy IN (SELECT u.account FROM zt_user u INNER JOIN zt_dept d ON u.dept = d.id WHERE u.dept= ',dept,'))');
		SET QUERY4_2 = CONCAT(QUERY4_2,' AND (t.finishedBy IN (SELECT u.account FROM zt_user u INNER JOIN zt_dept d ON u.dept = d.id WHERE u.dept= ',dept,'))');
	END IF;
	
	-- Loc theo story
	IF col IS NOT NULL AND col = 's.title' THEN 
		SET QUERY1_1 = CONCAT(QUERY1_1,' AND t.story IN (SELECT id FROM zt_story WHERE title=N\'',val,'\' AND deleted <> ''1'')' );
		SET QUERY2_1 = CONCAT(QUERY2_1,' AND t.story IN (SELECT id FROM zt_story WHERE title=N\'',val,'\' AND deleted <> ''1'')' );
		SET QUERY3_1 = CONCAT(QUERY3_1,' AND t.story IN (SELECT id FROM zt_story WHERE title=N\'',val,'\' AND deleted <> ''1'')' );
		SET QUERY4_1 = CONCAT(QUERY4_1,' AND t.story IN (SELECT id FROM zt_story WHERE title=N\'',val,'\' AND deleted <> ''1'')' );
		SET QUERY1_2 = CONCAT(QUERY1_2,' AND t.story IN (SELECT id FROM zt_story WHERE title=N\'',val,'\' AND deleted <> ''1'')' );
		SET QUERY2_2 = CONCAT(QUERY2_2,' AND t.story IN (SELECT id FROM zt_story WHERE title=N\'',val,'\' AND deleted <> ''1'')' );
		SET QUERY3_2 = CONCAT(QUERY3_2,' AND t.story IN (SELECT id FROM zt_story WHERE title=N\'',val,'\' AND deleted <> ''1'')' );
		SET QUERY4_2 = CONCAT(QUERY4_2,' AND t.story IN (SELECT id FROM zt_story WHERE title=N\'',val,'\' AND deleted <> ''1'')' );
	END IF;
	
	-- Loc theo du an
	IF col IS NOT NULL AND col = 'p.name' THEN 
		SET QUERY1_1 = CONCAT(QUERY1_1,' AND t.project = (SELECT id FROM zt_project WHERE name=N\'',val,'\' AND deleted <> ''1'')' );
		SET QUERY2_1 = CONCAT(QUERY2_1,' AND t.project = (SELECT id FROM zt_project WHERE name=N\'',val,'\' AND deleted <> ''1'')' );
		SET QUERY3_1 = CONCAT(QUERY3_1,' AND t.project = (SELECT id FROM zt_project WHERE name=N\'',val,'\' AND deleted <> ''1'')' );
		SET QUERY4_1 = CONCAT(QUERY4_1,' AND t.project = (SELECT id FROM zt_project WHERE name=N\'',val,'\' AND deleted <> ''1'')' );
		SET QUERY1_2 = CONCAT(QUERY1_2,' AND t.project = (SELECT id FROM zt_project WHERE name=N\'',val,'\' AND deleted <> ''1'')' );
		SET QUERY2_2 = CONCAT(QUERY2_2,' AND t.project = (SELECT id FROM zt_project WHERE name=N\'',val,'\' AND deleted <> ''1'')' );
		SET QUERY3_2 = CONCAT(QUERY3_2,' AND t.project = (SELECT id FROM zt_project WHERE name=N\'',val,'\' AND deleted <> ''1'')' );
		SET QUERY4_2 = CONCAT(QUERY4_2,' AND t.project = (SELECT id FROM zt_project WHERE name=N\'',val,'\' AND deleted <> ''1'')' );
	END IF;
	
	-- Loc theo uu tien
	IF col IS NOT NULL AND col = 't.pri' THEN 
		SET QUERY1_1 = CONCAT(QUERY1_1,' AND t.pri = CONVERT(RIGHT(\'',val,'\',1),SIGNED INTEGER)' );
		SET QUERY2_1 = CONCAT(QUERY2_1,' AND t.pri = CONVERT(RIGHT(\'',val,'\',1),SIGNED INTEGER)' );
		SET QUERY3_1 = CONCAT(QUERY3_1,' AND t.pri = CONVERT(RIGHT(\'',val,'\',1),SIGNED INTEGER)' );
		SET QUERY4_1 = CONCAT(QUERY4_1,' AND t.pri = CONVERT(RIGHT(\'',val,'\',1),SIGNED INTEGER)' );
		SET QUERY1_2 = CONCAT(QUERY1_2,' AND t.pri = CONVERT(RIGHT(\'',val,'\',1),SIGNED INTEGER)' );
		SET QUERY2_2 = CONCAT(QUERY2_2,' AND t.pri = CONVERT(RIGHT(\'',val,'\',1),SIGNED INTEGER)' );
		SET QUERY3_2 = CONCAT(QUERY3_2,' AND t.pri = CONVERT(RIGHT(\'',val,'\',1),SIGNED INTEGER)' );
		SET QUERY4_2 = CONCAT(QUERY4_2,' AND t.pri = CONVERT(RIGHT(\'',val,'\',1),SIGNED INTEGER)' );
	END IF;
		
	-- Lọc các task theo col, val
	IF col IS NOT NULL AND col <> 's.title' AND col <> 'p.name' AND col <>'t.pri' THEN
		SET QUERY1_1 = CONCAT(QUERY1_1,' AND (', col, ' LIKE N\'%', val ,'%\')');
		SET QUERY2_1 = CONCAT(QUERY2_1,' AND (', col, ' LIKE N\'%', val ,'%\')');
		SET QUERY3_1 = CONCAT(QUERY3_1,' AND (', col, ' LIKE N\'%', val ,'%\')');
		SET QUERY4_1 = CONCAT(QUERY4_1,' AND (', col, ' LIKE N\'%', val ,'%\')');
		SET QUERY1_2 = CONCAT(QUERY1_2,' AND (', col, ' LIKE N\'%', val ,'%\')');
		SET QUERY2_2 = CONCAT(QUERY2_2,' AND (', col, ' LIKE N\'%', val ,'%\')');
		SET QUERY3_2 = CONCAT(QUERY3_2,' AND (', col, ' LIKE N\'%', val ,'%\')');
		SET QUERY4_2 = CONCAT(QUERY4_2,' AND (', col, ' LIKE N\'%', val ,'%\')');
	END IF;
	
	SET QUERY1_1 = CONCAT(QUERY1_1, ' GROUP BY date_) ');
	SET QUERY1_2 = CONCAT(QUERY1_2, ' GROUP BY date_) ');
	SET QUERY1 = CONCAT(QUERY1_1,' UNION ALL ', QUERY1_2);
	SET QUERY2_1 = CONCAT(QUERY2_1, ' GROUP BY date_ ) ');
	SET QUERY2_2 = CONCAT(QUERY2_2, ' GROUP BY date_ ) ');
	SET QUERY2 = CONCAT(QUERY2_1,' UNION ALL ', QUERY2_2);
	SET QUERY3_1 = CONCAT(QUERY3_1, ' GROUP BY date_) ');
	SET QUERY3_2 = CONCAT(QUERY3_2, ' GROUP BY date_) ');
	SET QUERY3 = CONCAT(QUERY3_1,' UNION ALL ', QUERY3_2);
	SET QUERY4_1 = CONCAT(QUERY4_1, ' GROUP BY date_) ');
	SET QUERY4_2 = CONCAT(QUERY4_2, ' GROUP BY date_) ');
	SET QUERY4 = CONCAT(QUERY4_1,' UNION ALL ', QUERY4_2);
	
	-- Gộp theo ngày và sắp xếp theo ngày từ h về trước
	SET QUERY1 = CONCAT(QUERY1,' ORDER BY STR_TO_DATE(date_, ''%d/%m/%Y'') ');
	SET QUERY2 = CONCAT(QUERY2,' ORDER BY date_ ');
	SET QUERY3 = CONCAT(QUERY3,' ORDER BY RIGHT(date_,4), CAST(date_ AS UNSIGNED) ');
	SET QUERY4 = CONCAT(QUERY4,' ORDER BY STR_TO_DATE(date_, ''%d/%m/%Y'') ');
	
	IF year_ IS NULL AND month_ IS NULL AND day_ IS NULL THEN
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

-- Dumping structure for procedure fpms.dsa_task_num_pri
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_task_num_pri`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `story` INT,
	IN `dept` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300),
	IN `year_` ENUM('Y','N'),
	IN `month_` ENUM('Y','N'),
	IN `day_` ENUM('Y','N')
)
BEGIN
	DECLARE QUERY1 NVARCHAR(4000);
	
	-- Đếm các task theo độ ưu tiên
	SET QUERY1 = 
	'SELECT 
		COUNT(t.id) as ''number'',
		CASE
			WHEN t.pri = 1 THEN ''Ưu tiên 1''
			WHEN t.pri = 2 THEN ''Ưu tiên 2''
			WHEN t.pri = 3 THEN ''Ưu tiên 3''
			WHEN t.pri = 4 THEN ''Ưu tiên 4''
		END as ''t.pri''
	FROM
		zt_task t
	INNER JOIN
		zt_project p
	ON
		p.id = t.project
	WHERE 1=1 ';
	
	-- Lọc ra các task chưa bị xóa
	SET QUERY1 = CONCAT(QUERY1, ' AND t.pri <> 0 AND t.deleted <>''1'' AND p.deleted <>''1'' AND t.parent <> -1');
	
	-- Lọc các task có thời gian tạo nằm trong khoảng đã cho
	IF start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.openedDate BETWEEN \' ',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
	END IF;
	
	-- Lọc các task theo dự án
	IF project_id IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.project = ', project_id,' )');
	END IF;
	
	-- Lọc các task theo user
	IF username IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.assignedTo = \'', username ,'\' )');
	END IF;
	
	-- Lọc các task theo user
	IF story IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.story = \'', story ,'\' )');
	END IF;
	
	-- Lọc các task theo department
	IF dept IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.assignedTo IN (SELECT u.account FROM zt_user u INNER JOIN zt_dept d ON u.dept = d.id WHERE u.dept= ',dept,'))');
	END IF;
	
	CASE
		-- col, val binh thuong
		WHEN col IS NOT NULL AND col <> 's.title' AND col <> 'p.name' AND col <> 't.pri'THEN SET
			QUERY1 = CONCAT(QUERY1,' AND (', col, ' LIKE N\'%', val ,'%\')');
		
		-- Loc theo du an
		WHEN col IS NOT NULL AND col = 'p.name' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.project = (SELECT id FROM zt_project WHERE name=N\'',val,'\' AND deleted <> ''1'')' );
		
		-- Loc theo story
		WHEN col IS NOT NULL AND col = 's.title' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.story IN (SELECT id FROM zt_story WHERE title=N\'',val,'\' AND deleted <> ''1'')' );
		
		-- Loc theo uu tien
		WHEN col IS NOT NULL AND col = 't.pri' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.pri = CONVERT(RIGHT(\'',val,'\',1),SIGNED INTEGER)' );
		
		ELSE SELECT 1;
		
	END CASE;
	
	-- Gộp nhóm theo loại trạng thái và sắp xếp số lượng task giảm dần
	SET QUERY1  = CONCAT(QUERY1, ' GROUP BY t.pri');
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_task_num_task_byproject
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_task_num_task_byproject`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `story` INT,
	IN `dept` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300),
	IN `year_` ENUM('Y','N'),
	IN `month_` ENUM('Y','N'),
	IN `day_` ENUM('Y','N')
)
BEGIN
	DECLARE QUERY1 NVARCHAR(4000);
	
	-- Đếm số task trong mỗi project và hiển thị tên project đó
	SET QUERY1 = 
		'SELECT
			p.name as ''p.name'',
			COUNT(CASE WHEN (t.openedDate <> ''0000-00-00 00:00:00'')  THEN t.id ELSE NULL END) num_task_open,
			COUNT(CASE WHEN (t.openedDate <> ''0000-00-00 00:00:00'') AND (t.finishedDate = ''0000-00-00 00:00:00'') AND (t.status NOT IN (''closed'',''done'')) THEN t.id ELSE NULL END) num_task_doing,
			COUNT(CASE WHEN (t.openedDate <> ''0000-00-00 00:00:00'') AND (t.finishedDate <> ''0000-00-00 00:00:00'') AND (t.status IN (''closed'',''done'')) THEN t.id ELSE NULL END) num_task_finish,
			COUNT(CASE WHEN (t.openedDate <> ''0000-00-00 00:00:00'') AND (t.finishedDate = ''0000-00-00 00:00:00'') AND (t.status = ''closed'' AND t.closedDate <> ''0000-00-00 00:00:00'' AND t.finishedDate = ''0000-00-00 00:00:00'' AND t.canceledDate = ''0000-00-00 00:00:00'') THEN t.id ELSE NULL END) num_task_close,
			COUNT(CASE WHEN (t.openedDate <> ''0000-00-00 00:00:00'') AND (t.finishedDate = ''0000-00-00 00:00:00'') AND (t.status = ''closed'' AND t.canceledDate <> ''0000-00-00 00:00:00'') THEN t.id ELSE NULL END) num_task_cancel
		FROM
			zt_task t
		INNER JOIN
			zt_project p
		ON
			t.project = p.id
		WHERE 1=1 ';

	-- Lọc các task và dự án chưa xóa
	SET QUERY1 = CONCAT(QUERY1, 'AND p.deleted <> ''1'' AND t.deleted <> ''1'' AND t.parent<>-1');

	-- Lọc các project có thời gian tạo nằm trong khoảng đã cho
	IF start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.openedDate BETWEEN \' ',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
	END IF;

	-- Lọc các task theo dự án
	IF project_id IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.project = ', project_id,' )');
	END IF;
	
	-- Lọc các task theo user
	IF username IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.assignedTo = \'', username ,'\' )');
	END IF;
	
	-- Lọc các task theo story
	IF story IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.story = ', story,')');
	END IF;
	
	-- Lọc các task theo department
	IF dept IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.assignedTo IN (SELECT u.account FROM zt_user u INNER JOIN zt_dept d ON u.dept = d.id WHERE u.dept= ',dept,'))');
	END IF;
	
	CASE
		-- col, val binh thuong
		WHEN col IS NOT NULL AND col <> 's.title' AND col <> 'p.name' AND col <> 't.pri' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND (', col, ' LIKE N\'%', val ,'%\')');
		
		-- Loc theo story
		WHEN col IS NOT NULL AND col = 's.title' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.story IN (SELECT id FROM zt_story WHERE title=N\'',val,'\' AND deleted <> ''1'')' );
		
		-- Loc theo du an
		WHEN col IS NOT NULL AND col = 'p.name' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.project = (SELECT id FROM zt_project WHERE name=N\'',val,'\' AND deleted <> ''1'')' );
		
		-- Loc theo uu tien
		WHEN col IS NOT NULL AND col = 't.pri' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.pri = CONVERT(RIGHT(\'',val,'\',1),SIGNED INTEGER)' );
		
		ELSE SELECT 1;
		
	END CASE;
		
	-- Nhóm theo project và sắp xếp theo số lượng task giảm dần
	SET QUERY1  = CONCAT(QUERY1, ' GROUP BY p.name ORDER BY num_task_open DESC');
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt FROM @SQL;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_task_num_task_bystory
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_task_num_task_bystory`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `story` INT,
	IN `dept` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300),
	IN `year_` ENUM('Y','N'),
	IN `month_` ENUM('Y','N'),
	IN `day_` ENUM('Y','N')
)
BEGIN
	-- Đếm các task đã tạo theo story
	DECLARE QUERY1 NVARCHAR(4000);
	SET QUERY1 = 
		'SELECT 
			s.title as ''s.title'',
			COUNT(t.id) as num_task 
		 FROM 
		 	((zt_task t 
		 INNER JOIN 
		 	zt_story s ON t.story = s.id)
		 INNER JOIN 
		 	zt_project p ON p.id = t.project)
		 WHERE 1=1 ';
		 
	-- Lọc các task, project, story chưa bị xóa
	SET QUERY1 = CONCAT(QUERY1, ' AND s.deleted <>''1'' AND t.deleted <>''1'' AND p.deleted <>''1'' AND t.parent<>-1');
	
	-- Lọc các task có thời gian mở nằm trong khoảng đã cho
	IF start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.openedDate BETWEEN \' ',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
	END IF;
	
	-- Lọc các task theo dự án
	IF project_id IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.project = ', project_id,' )');
	END IF;
	
	-- Lọc các task theo user
	IF username IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.assignedTo = \'', username ,'\' )');
	END IF;
	
	-- Lọc các task theo mức độ ưu tiên
	IF story IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.story = ', story,')');
	END IF;
	
	-- Lọc các task theo department
	IF dept IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.assignedTo IN (SELECT u.account FROM zt_user u INNER JOIN zt_dept d ON u.dept = d.id WHERE u.dept= ',dept,'))');
	END IF;
	
	CASE
		-- col, val binh thuong
		WHEN col IS NOT NULL AND col <> 't.finishedDate' AND col <> 't.openedDate' AND col <> 'p.name' AND col <> 't.pri' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND (', col, ' LIKE N\'%', val ,'%\')');
		
		-- Loc theo du an
		WHEN col IS NOT NULL AND col = 'p.name' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.project = (SELECT id FROM zt_project WHERE name=N\'',val,'\' AND deleted <> ''1'')' );
		
		-- Loc theo uu tien
		WHEN col IS NOT NULL AND col = 't.pri' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.pri = CONVERT(RIGHT(\'',val,'\',1),SIGNED INTEGER)' );
		
		ELSE SELECT 1;
		
	END CASE;
	
	SET QUERY1 = CONCAT(QUERY1,' GROUP BY 1 ORDER BY 2 DESC');
	
	-- In và khởi chạy query
	-- SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt FROM @SQL;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_task_num_task_bytime
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_task_num_task_bytime`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `story` INT,
	IN `dept` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300),
	IN `year_` ENUM('Y','N'),
	IN `month_` ENUM('Y','N'),
	IN `day_` ENUM('Y','N')
)
BEGIN
	DECLARE QUERY1 NVARCHAR(4000);
	DECLARE QUERY2 NVARCHAR(4000);
	DECLARE QUERY3 NVARCHAR(4000);
	DECLARE QUERY4 NVARCHAR(4000);
	
	-- Đếm các task đã mở theo ngày
	SET QUERY1 = 
		'SELECT
			DATE(t.openedDate) AS ''t.openedDate'',
			COUNT(t.id) num
		FROM
			zt_task t
		INNER JOIN
			zt_project p
		ON
			t.project = p.id
		WHERE t.deleted <> ''1'' AND p.deleted <> ''1'' AND t.parent<>-1 AND 1=1 ';
	
	SET QUERY2 = 
		'SELECT
			CAST(Year(t.openedDate) AS CHAR) AS ''t.openedDate'',
			COUNT(t.id) num
		FROM
			zt_task t
		INNER JOIN
			zt_project p
		ON
			t.project = p.id
		WHERE t.deleted <> ''1'' AND p.deleted <> ''1'' AND t.parent<>-1 AND 1=1 ';
	
	SET QUERY3 = 
		'SELECT
			CONCAT(Month(t.openedDate),''/'', Year(t.openedDate)) AS ''t.openedDate'',
			COUNT(t.id) num
		FROM
			zt_task t
		INNER JOIN
			zt_project p
		ON
			t.project = p.id
		WHERE t.deleted <> ''1'' AND p.deleted <> ''1'' AND t.parent<>-1 AND 1=1 ';
	
	SET QUERY4 = 
		'SELECT
			CONCAT(Day(t.openedDate),''/'',Month(t.openedDate),''/'', Year(t.openedDate)) AS ''t.openedDate'',
			COUNT(t.id) num
		FROM
			zt_task t
		INNER JOIN
			zt_project p
		ON
			t.project = p.id
		WHERE t.deleted <> ''1'' AND p.deleted <> ''1'' AND t.parent<>-1 AND 1=1 ';

	-- Lọc các task có thời gian hoàn thành nằm trong khoảng đã cho
	IF start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.openedDate BETWEEN \' ',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
		SET QUERY2 = CONCAT(QUERY2,' AND (t.openedDate BETWEEN \' ',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
		SET QUERY3 = CONCAT(QUERY3,' AND (t.openedDate BETWEEN \' ',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
		SET QUERY4 = CONCAT(QUERY4,' AND (t.openedDate BETWEEN \' ',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
	END IF;
	
	-- Lọc các task theo dự án
	IF project_id IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.project = ', project_id,' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (t.project = ', project_id,' )');
		SET QUERY3 = CONCAT(QUERY3,' AND (t.project = ', project_id,' )');
		SET QUERY4 = CONCAT(QUERY4,' AND (t.project = ', project_id,' )');
	END IF;
	
	-- Lọc các task theo user
	IF username IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.openedBy = \'', username ,'\' )');
		SET QUERY2 = CONCAT(QUERY2,' AND (t.openedBy = \'', username ,'\' )');
		SET QUERY3 = CONCAT(QUERY3,' AND (t.openedBy = \'', username ,'\' )');
		SET QUERY4 = CONCAT(QUERY4,' AND (t.openedBy = \'', username ,'\' )');
	END IF;
	
	-- Lọc các task theo story
	IF story IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.story = ', story,')');
		SET QUERY2 = CONCAT(QUERY2,' AND (t.story = ', story,')');
		SET QUERY3 = CONCAT(QUERY3,' AND (t.story = ', story,')');
		SET QUERY4 = CONCAT(QUERY4,' AND (t.story = ', story,')');
	END IF;
	
	-- Lọc các task theo dept
	IF dept IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.openedBy IN (SELECT u.account FROM zt_user u INNER JOIN zt_dept d ON u.dept = d.id WHERE u.dept= ',dept,'))');
		SET QUERY2 = CONCAT(QUERY2,' AND (t.openedBy IN (SELECT u.account FROM zt_user u INNER JOIN zt_dept d ON u.dept = d.id WHERE u.dept= ',dept,'))');
		SET QUERY3 = CONCAT(QUERY3,' AND (t.openedBy IN (SELECT u.account FROM zt_user u INNER JOIN zt_dept d ON u.dept = d.id WHERE u.dept= ',dept,'))');
		SET QUERY4 = CONCAT(QUERY4,' AND (t.openedBy IN (SELECT u.account FROM zt_user u INNER JOIN zt_dept d ON u.dept = d.id WHERE u.dept= ',dept,'))');
	END IF;
	
	-- col, val
	-- Loc theo story
	IF col IS NOT NULL AND col = 's.title' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND t.story IN (SELECT id FROM zt_story WHERE title=N\'',val,'\' AND deleted <> ''1'')' );
		SET QUERY2 = CONCAT(QUERY2,' AND t.story IN (SELECT id FROM zt_story WHERE title=N\'',val,'\' AND deleted <> ''1'')' );
		SET QUERY3 = CONCAT(QUERY3,' AND t.story IN (SELECT id FROM zt_story WHERE title=N\'',val,'\' AND deleted <> ''1'')' );
		SET QUERY4 = CONCAT(QUERY4,' AND t.story IN (SELECT id FROM zt_story WHERE title=N\'',val,'\' AND deleted <> ''1'')' );
	END IF;
	
	-- Loc theo du an
	IF col IS NOT NULL AND col = 'p.name' THEN 
		SET QUERY1 = CONCAT(QUERY1,' AND (t.project = (SELECT id FROM zt_project WHERE name=N\'',val,'\' AND deleted <> ''1''))' );
		SET QUERY2 = CONCAT(QUERY2,' AND (t.project = (SELECT id FROM zt_project WHERE name=N\'',val,'\' AND deleted <> ''1''))' );
		SET QUERY3 = CONCAT(QUERY3,' AND (t.project = (SELECT id FROM zt_project WHERE name=N\'',val,'\' AND deleted <> ''1''))' );
		SET QUERY4 = CONCAT(QUERY4,' AND (t.project = (SELECT id FROM zt_project WHERE name=N\'',val,'\' AND deleted <> ''1''))' );
	END IF;
	
	-- Loc theo uu tien
	IF col IS NOT NULL AND col = 't.pri' THEN
		SET QUERY1 = CONCAT(QUERY1,' AND t.pri = CONVERT(RIGHT(\'',val,'\',1),SIGNED INTEGER) ' );
		SET QUERY2 = CONCAT(QUERY2,' AND t.pri = CONVERT(RIGHT(\'',val,'\',1),SIGNED INTEGER) ' );
		SET QUERY3 = CONCAT(QUERY3,' AND t.pri = CONVERT(RIGHT(\'',val,'\',1),SIGNED INTEGER) ' );
		SET QUERY4 = CONCAT(QUERY4,' AND t.pri = CONVERT(RIGHT(\'',val,'\',1),SIGNED INTEGER) ' );
	END IF;
	
	-- Lọc các task theo col, val
	IF col IS NOT NULL AND col <> 's.title' AND col <> 'p.name' AND col <> 't.pri' THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (', col, ' LIKE N\'%', val ,'%\')');
		SET QUERY2 = CONCAT(QUERY2,' AND (', col, ' LIKE N\'%', val ,'%\')');
		SET QUERY3 = CONCAT(QUERY3,' AND (', col, ' LIKE N\'%', val ,'%\')');
		SET QUERY4 = CONCAT(QUERY4,' AND (', col, ' LIKE N\'%', val ,'%\')');
	END IF;
	
	-- Gộp theo ngày và sắp xếp theo ngày từ h về trước
	SET QUERY1 = CONCAT(QUERY1,'GROUP BY 1 ORDER BY 1');
	SET QUERY2 = CONCAT(QUERY2,'GROUP BY 1 ORDER BY 1');
	SET QUERY3 = CONCAT(QUERY3,'GROUP BY 1 ORDER BY Year(t.openedDate), Month(t.openedDate)');
	SET QUERY4 = CONCAT(QUERY4,'GROUP BY 1 ORDER BY Year(t.openedDate), Month(t.openedDate), Day(t.openedDate)');
	
	IF year_ IS NULL AND month_ IS NULL AND day_ IS NULL THEN
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
	
	IF month_ IS NOT NULL THEN
		-- In và khởi chạy query
		-- SELECT QUERY3;
		SET @SQL := QUERY3;
		PREPARE stmt3 FROM @SQL;
		EXECUTE stmt3;
		DEALLOCATE PREPARE stmt3;
	END IF;
	
	IF day_ IS NOT NULL THEN
		-- In và khởi chạy query
		-- SELECT QUERY4;
		SET @SQL := QUERY4;
		PREPARE stmt4 FROM @SQL;
		EXECUTE stmt4;
		DEALLOCATE PREPARE stmt4;
	END IF;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_task_total_delay_task
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_task_total_delay_task`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `story` INT,
	IN `dept` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300),
	IN `year_` ENUM('Y','N'),
	IN `month_` ENUM('Y','N'),
	IN `day_` ENUM('Y','N')
)
BEGIN
	DECLARE QUERY1 NVARCHAR(4000);
	
	-- Trả về tổng số task trễ
	SET QUERY1 = 
	'SELECT
		COUNT(t.id) as total_delay_task
	FROM
		zt_task t
	INNER JOIN
		zt_project p
	ON
		t.project = p.id 
	WHERE 1=1 ';
	
	-- Lọc các task có số ngày tương tác lần cuối là >= 7, trạng thái chưa hoàn thành và cũng không đóng hay xóa, cũng như lọc project mà chưa xóa
	SET QUERY1 = CONCAT(QUERY1, 'AND DATEDIFF(DATE(NOW()), DATE(t.deadline)) >= 7 AND t.STATUS IN (''doing'', ''wait'', ''pause'')AND NOT (t.deadline = ''0000-00-00'' AND t.status=''wait'') AND t.deleted <> ''1'' AND p.deleted <> ''1''');
	
	-- Lọc các task có thời gian hoàn thành nằm trong khoảng đã cho
	IF start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' ' );
	END IF;

	-- Lọc các task theo dự án
	IF project_id IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.project = ', project_id,' )');
	END IF;
	
	-- Lọc các task theo user
	IF username IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.assignedTo = \'', username ,'\' )');
	END IF;
	
	-- Lọc các task theo mức độ ưu tiên
	IF story IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.story = ', story,')');
	END IF;
	
	-- Lọc các task theo department
	IF dept IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.lastEditedDate IN (SELECT u.account FROM zt_user u INNER JOIN zt_dept d ON u.dept = d.id WHERE u.dept= ',dept,'))');
	END IF;
	
	CASE
		-- col, val binh thuong
		WHEN col IS NOT NULL AND col <> 't.finishedDate' AND col <> 't.openedDate' AND col <> 's.title' AND col <> 'p.name' AND col <> 't.pri' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND (', col, ' LIKE N\'%', val ,'%\')');
		
		-- Loc theo du an
		WHEN col IS NOT NULL AND col = 'p.name' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.project = (SELECT id FROM zt_project WHERE name=N\'',val,'\' AND deleted <> ''1'')' );
			
		-- Loc theo story
		WHEN col IS NOT NULL AND col = 's.title' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.story IN (SELECT id FROM zt_story WHERE title=N\'',val,'\' AND deleted <> ''1'')' );
		
		-- Loc theo uu tien
		WHEN col IS NOT NULL AND col = 't.pri' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.pri = CONVERT(RIGHT(\'',val,'\',1),SIGNED INTEGER)' );
		
		ELSE SELECT 1;
		
	END CASE;
	
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt FROM @SQL;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
	
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_task_total_hour
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_task_total_hour`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `story` INT,
	IN `dept` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300),
	IN `year_` ENUM('Y','N'),
	IN `month_` ENUM('Y','N'),
	IN `day_` ENUM('Y','N')
)
BEGIN
	-- Tính tổng thời gian thực hiện của các task đã hoàn thành
	DECLARE QUERY1 NVARCHAR(4000);
	SET QUERY1 = 
	'SELECT 
		CASE
			WHEN SUM(t.consumed) IS NULL THEN 0
			ELSE SUM(t.consumed)
		END 
			total_hour
	FROM 
		zt_task t
	INNER JOIN 
		zt_project p 
	ON 
		t.project = p.id
	WHERE 1=1 ';
	
	-- Lọc các task có trạng thái đã hoàn thành, không phải là task parent và chưa bị xóa
	SET QUERY1 = CONCAT(QUERY1, ' AND (t.status IN (''done'', ''closed'')) AND (t.parent <> -1) AND (t.deleted <>''1'') AND (p.deleted <>''1'') ');
	
	-- Lọc các task có thời gian hoàn thành nằm trong khoảng đã cho
	IF start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.finishedDate BETWEEN \' ',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
	END IF;
	
	-- Lọc các task theo dự án
	IF project_id IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.project = ', project_id,' )');
	END IF;
	
	-- Lọc các task theo user
	IF username IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.finishedBy = \'', username ,'\' )');
	END IF;
	
	-- Lọc các task theo story
	IF story IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.story = ', story,')');
	END IF;
	
	-- Lọc các task theo department
	IF dept IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.finishedBy IN (SELECT u.account FROM zt_user u INNER JOIN zt_dept d ON u.dept = d.id WHERE u.dept= ',dept,'))');
	END IF;
	
	CASE
		-- col, val binh thuong
		WHEN col IS NOT NULL AND col <> 's.title' AND col <> 'p.name' AND col <> 't.pri' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND (', col, ' LIKE N\'%', val ,'%\')');
		
		-- Loc theo du an
		WHEN col IS NOT NULL AND col = 'p.name' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.project = (SELECT id FROM zt_project WHERE name=N\'',val,'\' AND deleted <> ''1'')' );
		
		-- Loc theo story
		WHEN col IS NOT NULL AND col = 's.title' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.story IN (SELECT id FROM zt_story WHERE title=N\'',val,'\' AND deleted <> ''1'')' );
		
		-- Loc theo uu tien
		WHEN col IS NOT NULL AND col = 't.pri' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.pri = CONVERT(RIGHT(\'',val,'\',1),SIGNED INTEGER)' );
		
		ELSE SELECT 1;
		
	END CASE;
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_task_total_task
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_task_total_task`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `story` INT,
	IN `dept` INT,
	IN `col` VARCHAR(300),
	IN `val` VARCHAR(300),
	IN `year_` ENUM('Y','N'),
	IN `month_` ENUM('Y','N'),
	IN `day_` ENUM('Y','N')
)
BEGIN
	-- Đếm các task đã tạo
	DECLARE QUERY1 NVARCHAR(4000);
	SET QUERY1 = 
	'SELECT 
		COUNT(t.id) as total_task 
    FROM 
	 	zt_task t
    INNER JOIN 
	 	zt_project p
    ON 
	 	t.project = p.id
    WHERE 1=1 ';
    
   -- Lọc các task, project chưa bị xóa 
	SET QUERY1 = CONCAT(QUERY1, ' AND t.deleted <>''1'' AND p.deleted <>''1'' AND t.parent<>-1');
	
	-- Lọc các task có thời gian hoàn thành nằm trong khoảng đã cho
	IF start_date IS NOT NULL AND end_date IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.openedDate BETWEEN \'',start_date,' 00:00:00 \' ',' AND \' ', end_date, ' 23:59:59\' )' );
	END IF;
	
	-- Lọc các task theo dự án
	IF project_id IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.project = ', project_id,' )');
	END IF;
	
	-- Lọc các task theo user
	IF username IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.assignedTo = \'', username ,'\' )');
	END IF;
	
	-- Lọc các task theo story
	IF story IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.story = ', story,')');
	END IF;
	
	-- Lọc các task theo department
	IF dept IS NOT NULL THEN
		SET QUERY1 = CONCAT(QUERY1,' AND (t.openedBy IN (SELECT u.account FROM zt_user u INNER JOIN zt_dept d ON u.dept = d.id WHERE u.dept= ',dept,'))');
	END IF;

	# col, val
	CASE
		-- col, val binh thuong
		WHEN col IS NOT NULL AND col <> 's.title' AND col <> 'p.name' AND col <> 't.pri'THEN SET
			QUERY1 = CONCAT(QUERY1,' AND (', col, ' LIKE N\'%', val ,'%\')');
		
		-- Loc theo story
		WHEN col IS NOT NULL AND col = 's.title' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.story IN (SELECT id FROM zt_story WHERE title=N\'',val,'\' AND deleted <> ''1'')' );
			
		-- Loc theo du an
		WHEN col IS NOT NULL AND col = 'p.name' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.project = (SELECT id FROM zt_project WHERE name=N\'',val,'\' AND deleted <> ''1'')' );
			
		-- Loc theo uu tien
		WHEN col IS NOT NULL AND col = 't.pri' THEN SET
			QUERY1 = CONCAT(QUERY1,' AND t.pri = CONVERT(RIGHT(\'',val,'\',1),SIGNED INTEGER)' );
		
		ELSE SELECT 1;
		
	END CASE;
	
	-- In và khởi chạy query
	SELECT QUERY1;
	SET @SQL := QUERY1;
	PREPARE stmt4 FROM @SQL;
	EXECUTE stmt4;
	DEALLOCATE PREPARE stmt4;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_user
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user`(
	IN `id_proc` VARCHAR(50),
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50),
	IN `year_` INT,
	IN `month_` INT,
	IN `day_` INT

)
BEGIN
	
	IF id_proc = 'user_0_task' THEN
		CALL dsa_user_without_task (start_date,end_date,project_id,username,dept_id,col,val);
	END IF;
	
   /*Overview*/
	IF id_proc = 'ov_NV' THEN
		CALL dsa_user_total_bang (start_date,end_date,project_id,username,dept_id,col,val);
	END IF;
	
	IF id_proc = 'ov_taskopened' THEN
		CALL dsa_user_taskopened_total (start_date,end_date,project_id,username,dept_id,col,val);
	END IF;
	
	IF id_proc = 'ov_taskdone' THEN
		CALL dsa_user_taskdone_total (start_date,end_date,project_id,username,dept_id,col,val);
	END IF;
	
	/*Bar chart*/
	IF id_proc = 'bar_taskopened' THEN
		CALL dsa_user_taskopened_bar (start_date,end_date,project_id,username,dept_id,col,val);
	END IF;
	
	IF id_proc = 'bar_taskdone' THEN
		CALL dsa_user_taskdone_bar (start_date,end_date,project_id,username,dept_id,col,val);
	END IF;
	
	/*Pie chart*/
	IF id_proc = 'pie_taskdone' THEN
		CALL dsa_user_taskdone_detail_pie (start_date,end_date,project_id,username,dept_id,col,val);
	END IF;
	
	/*Line chart*/
	IF id_proc = 'line_taskopened' THEN
		CALL dsa_user_taskopened_bytime_line (start_date,end_date,project_id,username,dept_id,col,val,year_,month_,day_);
	END IF;
	
	IF id_proc = 'line_taskdone' THEN
		CALL dsa_user_taskdone_bytime_line (start_date,end_date,project_id,username,dept_id,col,val,year_,month_,day_);
	END IF;
	
	/*Bar chart project*/
	IF id_proc = 'bar_project' THEN
		CALL dsa_user_project_bar(start_date,end_date,project_id,username,dept_id,col,val);
	END IF;
	
	IF id_proc = 'table_project' THEN
		CALL dsa_user_project_table(start_date,end_date,project_id,username,dept_id,col,val);
	END IF;
	
	IF id_proc = 'line_productivity' THEN
		CALL dsa_user_productivity_line(start_date,end_date,project_id,username,dept_id,col,val);
	END IF;
	
	IF id_proc = 'ov_taskdone_percentage' THEN
		CALL dsa_user_taskdone_percentage(start_date,end_date,project_id,username,dept_id,col,val);
	END IF;
	
	IF id_proc = 'ov_taskdone_byopenedby' THEN
		CALL dsa_user_taskdone_byopenedby(start_date,end_date,project_id,username,dept_id,col,val);
	END IF;
	
	IF id_proc = 'ov_taskdone_byothers' THEN
		CALL dsa_user_taskdone_byothers(start_date,end_date,project_id,username,dept_id,col,val);
	END IF;
	
	IF id_proc = 'bar_taskstarted' THEN
		CALL dsa_user_task_started_bar(start_date,end_date,project_id,username,dept_id,col,val);
	END IF;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_user_ddl
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_ddl`(
	IN `id_ddl` VARCHAR(50)
)
BEGIN
	IF id_ddl = 'ddl_project' THEN
		CALL dsa_user_dropdown_project();
	END IF;
	
	IF id_ddl = 'ddl_user' THEN
		CALL dsa_user_dropdown_username();
	END IF;
	
	IF id_ddl = 'ddl_dept' THEN
		CALL dsa_user_dropdown_department();
	END IF;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_user_dropdown_department
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_dropdown_department`()
BEGIN
	DECLARE myquery nvarchar(2000);
	
	SET myquery = CONCAT('SELECT DISTINCT id, name
								FROM zt_dept
								ORDER BY name');
							
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_user_dropdown_project
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_dropdown_project`()
BEGIN
	DECLARE myquery nvarchar(2000);
	
	SET myquery = CONCAT('SELECT DISTINCT id, CONCAT(NAME,'' ('',id,'')'')
								FROM zt_project
								WHERE deleted = ''0''
								ORDER BY name ');
							
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_user_dropdown_username
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_dropdown_username`()
BEGIN
	DECLARE myquery nvarchar(2000);
	
	SET myquery = CONCAT('SELECT DISTINCT account, CONCAT(realname,'' ('',account,'')'') AS name
								FROM zt_user
								WHERE deleted = ''0''
								ORDER BY account ');
	

	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_user_productivity_line
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_productivity_line`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(2000);
	
	/* Hiển thị account NV, tên NV và tổng số dự án hoàn thành */
	SET myquery = CONCAT('SELECT CONCAT(Day(t.finishedDate),''/'',Month(t.finishedDate),''/'', Year(t.finishedDate)) AS thoi_gian, 
									(CASE WHEN SUM(t.consumed) IS NULL THEN 0
										ELSE CONCAT(ROUND (SUM(t.consumed)/(8*COUNT(DISTINCT u.account))*100,2),''%'')  
										END) AS Nang_suat
										
								FROM (SELECT *,
								   (CASE WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline = ''0000-00-00'' THEN ''Không có deadline''
											WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) > deadline 
																												OR (DATE(finishedDate) = deadline AND (consumed > estimate))) THEN ''Nộp trễ''
											WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) < deadline 
																												OR (DATE(finishedDate) = deadline AND (consumed < estimate))) THEN ''Nộp sớm''
														
											WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND DATE(finishedDate) = deadline AND (consumed = estimate) THEN ''Nộp đúng giờ''
											WHEN DATE(finishedDate) IS NULL THEN ''Không xác định được finishedDate''
											ELSE '''' END) AS TT_MORONG
								FROM zt_task) t
								JOIN zt_user u
								ON u.account = t.finishedBy
								LEFT JOIN zt_dept d
								ON u.dept = d.id
								WHERE 1=1');
	SET myquery = CONCAT(myquery, ' AND t.deleted = ''0''');	
	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0''');	
	SET myquery = CONCAT(myquery, ' AND t.parent !=-1');
	SET myquery = CONCAT(myquery, ' AND YEAR(t.finishedDate) != ''1970'' ');
	
	/* Lọc theo tên NV */							
	IF (username) IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND t.finishedBy = ''', username, '''');							
	END IF;
	
	/*Lọc các task theo khoảng thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND DATE(t.finishedDate ) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;	
	
	/*Lọc SL task theo project*/
	IF (project_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.project = ''', project_id, '''');
	END IF;
	
	/*Lọc SL task theo department*/
	IF (dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND u.dept = ''', dept_id, '''');
	END IF;
	
	/*Lọc theo col,val*/
	IF (col IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;	
	
	SET myquery = CONCAT(myquery, ' GROUP BY 1 ORDER BY YEAR(t.finishedDate), MONTH(t.finishedDate), DAY(t.finishedDate)');
	
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_user_project_bar
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_project_bar`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(2000);
	
	/* Hiển thị account NV, tên NV và tổng số dự án hoàn thành */
	SET myquery = CONCAT('SELECT tm.account,COUNT(tm.id)
								FROM zt_team tm
								JOIN zt_project p
								ON tm.root = p.id
								JOIN zt_user u
								ON tm.account = u.account
								LEFT JOIN zt_dept d
								ON u.dept = d.id
								WHERE 1=1');
	SET myquery = CONCAT(myquery, ' AND p.deleted = ''0''');	
	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0''');	
	
	/* Lọc theo tên NV */							
	IF (username) IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND tm.account = ''', username, '''');							
	END IF;
	
	/*Lọc theo khoảng thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND tm.join BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;	
	
	/*Lọc theo project*/
	IF (project_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND tm.root = ''', project_id, '''');
	END IF;
	
		/*Lọc SL task theo department*/
	IF (dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND u.dept = ''', dept_id, '''');
	END IF;
	
	
	/*Lọc theo col,val*/
	IF (col IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;	
	
	SET myquery = CONCAT(myquery, ' GROUP BY tm.account ORDER BY COUNT(tm.id) DESC, tm.account');
	
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_user_project_table
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_project_table`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(2000);
	
	/* Hiển thị account NV, tên NV và tổng số dự án hoàn thành */
	SET myquery = CONCAT('SELECT u.account, GROUP_CONCAT(p.name ORDER BY p.name SEPARATOR ''\n'' )
								FROM zt_team tm
								JOIN zt_project p ON tm.root = p.id
								JOIN zt_user u ON tm.account = u.account
								LEFT JOIN zt_dept d ON u.dept = d.id
								WHERE 1=1');
	SET myquery = CONCAT(myquery, ' AND p.deleted = ''0''');	
	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0''');	
	
	/* Lọc theo tên NV */							
	IF (username) IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND tm.account = ''', username, '''');							
	END IF;
	
	/*Lọc theo khoảng thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND tm.join BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;	
	
	/*Lọc theo project*/
	IF (project_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND tm.root = ''', project_id, '''');
	END IF;
	
	/*Lọc SL task theo department*/
	IF (dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND u.dept = ''', dept_id, '''');
	END IF;
	/*Lọc theo col,val*/
	IF (col IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;	
	
	SET myquery = CONCAT(myquery, ' GROUP BY tm.account ORDER BY tm.account');
	
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_user_taskdone_bar
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_taskdone_bar`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(2000);
	
	/* Hiển thị account NV, tên NV và tổng số dự án hoàn thành */
	SET myquery = CONCAT('SELECT t.finishedBy AS NV_Account, u.realname AS name, COUNT(t.id) AS So_luong_task_hoan_thanh
							   FROM (SELECT *,
									   (CASE WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline = ''0000-00-00'' THEN ''Không có deadline''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) > deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed > estimate))) THEN ''Nộp trễ''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) < deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed < estimate))) THEN ''Nộp sớm''
															
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND DATE(finishedDate) = deadline AND (consumed = estimate) THEN ''Nộp đúng giờ''
												WHEN DATE(finishedDate) IS NULL THEN ''Không xác định được finishedDate''
												ELSE '''' END) AS TT_MORONG
									FROM zt_task) t
								JOIN zt_user u
								ON u.account = t.finishedBy
								LEFT JOIN zt_dept d
								ON u.dept = d.id
								WHERE 1=1');
	SET myquery = CONCAT(myquery, ' AND t.deleted = ''0''');	
	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0''');	
	SET myquery = CONCAT(myquery, ' AND t.parent !=-1');
	SET myquery = CONCAT(myquery, ' AND YEAR(t.finishedDate) != ''1970'' ');
	
	/* Lọc theo tên NV */							
	IF (username) IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND t.finishedBy = ''', username, '''');							
	END IF;
	
	/*Lọc các task theo khoảng thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND DATE(t.finishedDate ) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;	
	
	/*Lọc SL task theo project*/
	IF (project_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.project = ''', project_id, '''');
	END IF;
	
	/*Lọc SL task theo department*/
	IF (dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND u.dept = ''', dept_id, '''');
	END IF;
	
	/*Lọc theo col,val*/
	IF col IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;	
	
	SET myquery = CONCAT(myquery, ' GROUP BY t.finishedBy ORDER BY COUNT(t.id) DESC, t.finishedBy');
	
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_user_taskdone_byopenedby
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_taskdone_byopenedby`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(2000);
	SET myquery = CONCAT('SELECT COUNT(t.id) AS So_luong_task_hoan_thanh_boi_nguoi_tao
							   FROM (SELECT *,
									   (CASE WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline = ''0000-00-00'' THEN ''Không có deadline''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) > deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed > estimate))) THEN ''Nộp trễ''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) < deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed < estimate))) THEN ''Nộp sớm''
															
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND DATE(finishedDate) = deadline AND (consumed = estimate) THEN ''Nộp đúng giờ''
												WHEN DATE(finishedDate) IS NULL THEN ''Không xác định được finishedDate''
												ELSE '''' END) AS TT_MORONG
									FROM zt_task) t
							JOIN zt_user u
							ON u.account = t.openedBy
							LEFT JOIN zt_dept d
							ON u.dept = d.id
							WHERE 1=1');
							
	SET myquery = CONCAT(myquery, ' AND t.deleted = ''0''');	
	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0''');	
	SET myquery = CONCAT(myquery, ' AND t.parent !=-1');
	SET myquery = CONCAT(myquery, ' AND YEAR(t.finishedDate) != ''1970'' ');
	SET myquery = CONCAT(myquery, ' AND t.finishedBy = t.openedBy');
	
	/*Lọc SL task theo tên NV*/
	IF (username IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND u.account = ''', username, '''');							
   END IF;
   
	/*Lọc SL task theo khoảng thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND DATE(t.finishedDate) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;					
	
	/*Lọc SL task theo project*/
	IF (project_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.project = ''', project_id, '''');
	END IF;
	
	/*Lọc SL task theo department*/
	IF (dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND u.dept = ''', dept_id, '''');
	END IF;
	
	/*Lọc theo col,val*/
	IF (col IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;	
	
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;	
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_user_taskdone_byothers
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_taskdone_byothers`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(2000);
	SET myquery = CONCAT('SELECT COUNT(t.id) AS So_luong_task_da_tao_hoan_thanh_boi_nguoi_khac
							   FROM (SELECT *,
									   (CASE WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline = ''0000-00-00'' THEN ''Không có deadline''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) > deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed > estimate))) THEN ''Nộp trễ''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) < deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed < estimate))) THEN ''Nộp sớm''
															
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND DATE(finishedDate) = deadline AND (consumed = estimate) THEN ''Nộp đúng giờ''
												WHEN DATE(finishedDate) IS NULL THEN ''Không xác định được finishedDate''
												ELSE '''' END) AS TT_MORONG
									FROM zt_task) t
							JOIN zt_user u
							ON u.account = t.openedBy
							LEFT JOIN zt_dept d
							ON u.dept = d.id
							WHERE 1=1');
							
	SET myquery = CONCAT(myquery, ' AND t.deleted = ''0''');	
	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0''');	
	SET myquery = CONCAT(myquery, ' AND t.parent !=-1');
	SET myquery = CONCAT(myquery, ' AND t.finishedBy != '''' ');
	SET myquery = CONCAT(myquery, ' AND YEAR(t.finishedDate) != ''1970'' ');
	SET myquery = CONCAT(myquery, ' AND t.finishedBy != t.openedBy');
	
	/*Lọc SL task theo tên NV*/
	IF (username IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND u.account = ''', username, '''');							
   END IF;
   
	/*Lọc SL task theo khoảng thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND DATE(t.finishedDate) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;					
	
	/*Lọc SL task theo project*/
	IF (project_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.project = ''', project_id, '''');
	END IF;
	
	/*Lọc SL task theo department*/
	IF (dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND u.dept = ''', dept_id, '''');
	END IF;
	
	/*Lọc theo col,val*/
	IF (col IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;	
	
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;	
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_user_taskdone_bytime_line
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_taskdone_bytime_line`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50),
	IN `year_` ENUM('Y','N'),
	IN `month_` ENUM('Y','N'),
	IN `day_` ENUM('Y','N')
)
BEGIN
	DECLARE QUERY1 nvarchar(2000);
	DECLARE QUERY2 nvarchar(2000);
	DECLARE QUERY3 nvarchar(2000);
	DECLARE QUERY4 nvarchar(2000);
	
	/*Chọn các task theo thời gian tạo*/
	SET QUERY1 = CONCAT('SELECT DATE(t.finishedDate) AS thoi_gian, COUNT(t.id) AS SL_task_hoan_thanh
							   FROM (SELECT *,
									   (CASE WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline = ''0000-00-00'' THEN ''Không có deadline''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) > deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed > estimate))) THEN ''Nộp trễ''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) < deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed < estimate))) THEN ''Nộp sớm''
															
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND DATE(finishedDate) = deadline AND (consumed = estimate) THEN ''Nộp đúng giờ''
												WHEN DATE(finishedDate) IS NULL THEN ''Không xác định được finishedDate''
												ELSE '''' END) AS TT_MORONG
									FROM zt_task) t
								JOIN zt_user u
								ON u.account = t.finishedBy
								LEFT JOIN zt_dept d
								ON u.dept = d.id
								WHERE t.deleted = ''0'' AND u.deleted = ''0'' AND t.parent !=-1 AND YEAR(t.finishedDate) !=''1970'' AND DATE(t.finishedDate) !=''0000-00-00''');
							
	SET QUERY2 = CONCAT('SELECT CAST(Year(t.finishedDate) AS CHAR) AS thoi_gian, COUNT(t.id) AS SL_task_hoan_thanh
							   FROM (SELECT *,
									   (CASE WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline = ''0000-00-00'' THEN ''Không có deadline''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) > deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed > estimate))) THEN ''Nộp trễ''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) < deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed < estimate))) THEN ''Nộp sớm''
															
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND DATE(finishedDate) = deadline AND (consumed = estimate) THEN ''Nộp đúng giờ''
												WHEN DATE(finishedDate) IS NULL THEN ''Không xác định được finishedDate''
												ELSE '''' END) AS TT_MORONG
									FROM zt_task) t
								JOIN zt_user u
								ON u.account = t.finishedBy
								LEFT JOIN zt_dept d
								ON u.dept = d.id
								WHERE t.deleted = ''0'' AND u.deleted = ''0'' AND t.parent !=-1 AND YEAR(t.finishedDate) !=''1970'' AND DATE(t.finishedDate) !=''0000-00-00''');
								
	SET QUERY3 = CONCAT('SELECT CONCAT(Month(t.finishedDate),''/'', Year(t.finishedDate)) AS thoi_gian, COUNT(t.id) AS SL_task_hoan_thanh
							   FROM (SELECT *,
									   (CASE WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline = ''0000-00-00'' THEN ''Không có deadline''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) > deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed > estimate))) THEN ''Nộp trễ''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) < deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed < estimate))) THEN ''Nộp sớm''
															
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND DATE(finishedDate) = deadline AND (consumed = estimate) THEN ''Nộp đúng giờ''
												WHEN DATE(finishedDate) IS NULL THEN ''Không xác định được finishedDate''
												ELSE '''' END) AS TT_MORONG
									FROM zt_task) t
								JOIN zt_user u
								ON u.account = t.finishedBy
								LEFT JOIN zt_dept d
								ON u.dept = d.id
								WHERE t.deleted = ''0'' AND u.deleted = ''0'' AND t.parent !=-1 AND YEAR(t.finishedDate) !=''1970'' AND DATE(t.finishedDate) !=''0000-00-00''');	
									
	SET QUERY4 = CONCAT('SELECT CONCAT(Day(t.finishedDate),''/'',Month(t.finishedDate),''/'', Year(t.finishedDate)) AS thoi_gian, COUNT(t.id) AS SL_task_hoan_thanh
							   FROM (SELECT *,
									   (CASE WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline = ''0000-00-00'' THEN ''Không có deadline''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) > deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed > estimate))) THEN ''Nộp trễ''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) < deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed < estimate))) THEN ''Nộp sớm''
															
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND DATE(finishedDate) = deadline AND (consumed = estimate) THEN ''Nộp đúng giờ''
												WHEN DATE(finishedDate) IS NULL THEN ''Không xác định được finishedDate''
												ELSE '''' END) AS TT_MORONG
									FROM zt_task) t
								JOIN zt_user u
								ON u.account = t.finishedBy
								LEFT JOIN zt_dept d
								ON u.dept = d.id
								WHERE t.deleted = ''0'' AND u.deleted = ''0'' AND t.parent !=-1 AND YEAR(t.finishedDate) !=''1970'' AND DATE(t.finishedDate) !=''0000-00-00''');
										
	/*Lọc SL task theo tên NV*/
	IF (username IS NOT NULL) THEN
		SET QUERY1 = CONCAT(QUERY1,' AND t.finishedBy = ''', username, '''');
		SET QUERY2 = CONCAT(QUERY2,' AND t.finishedBy = ''', username, '''');
		SET QUERY3 = CONCAT(QUERY3,' AND t.finishedBy = ''', username, '''');
		SET QUERY4 = CONCAT(QUERY4,' AND t.finishedBy = ''', username, '''');									
   END IF;										
																													
	/*Lọc SL task theo khoảng thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET QUERY1 = CONCAT(QUERY1,' AND DATE(t.finishedDate) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
		SET QUERY2 = CONCAT(QUERY2,' AND DATE(t.finishedDate) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
		SET QUERY3 = CONCAT(QUERY3,' AND DATE(t.finishedDate) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
		SET QUERY4 = CONCAT(QUERY4,' AND DATE(t.finishedDate) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;	
	
	/*Lọc SL task theo project*/
	IF (project_id IS NOT NULL) THEN
		SET QUERY1 = CONCAT(QUERY1,' AND t.project = ''', project_id, '''');
		SET QUERY2 = CONCAT(QUERY2,' AND t.project = ''', project_id, '''');
		SET QUERY3 = CONCAT(QUERY3,' AND t.project = ''', project_id, '''');
		SET QUERY4 = CONCAT(QUERY4,' AND t.project = ''', project_id, '''');
	END IF;
	
	/*Lọc SL task theo department*/
	IF (dept_id IS NOT NULL) THEN
		SET QUERY1 = CONCAT(QUERY1,' AND u.dept = ''', dept_id, '''');
		SET QUERY2 = CONCAT(QUERY1,' AND u.dept = ''', dept_id, '''');
		SET QUERY3 = CONCAT(QUERY1,' AND u.dept = ''', dept_id, '''');
		SET QUERY4 = CONCAT(QUERY1,' AND u.dept = ''', dept_id, '''');
	END IF;
	
	/*Lọc theo col,val*/
	IF (col IS NOT NULL) THEN
		SET QUERY1 = CONCAT(QUERY1,' AND ',col, ' = ''', val,''' ');
		SET QUERY2 = CONCAT(QUERY2,' AND ',col, ' = ''', val,''' ');
		SET QUERY3 = CONCAT(QUERY3,' AND ',col, ' = ''', val,''' ');
		SET QUERY4 = CONCAT(QUERY4,' AND ',col, ' = ''', val,''' ');
	END IF;	
	
	SET QUERY1 = CONCAT(QUERY1,' GROUP BY 1 ORDER BY 1');
	SET QUERY2 = CONCAT(QUERY2,' GROUP BY 1 ORDER BY 1');	
	SET QUERY3 = CONCAT(QUERY3,' GROUP BY 1 ORDER BY YEAR(t.finishedDate), MONTH(t.finishedDate)');
	SET QUERY4 = CONCAT(QUERY4,' GROUP BY 1 ORDER BY YEAR(t.finishedDate), MONTH(t.finishedDate), DAY(t.finishedDate)');
	
	/*Hiển thị tất cả*/
	IF (year_ IS NULL) AND (month_ IS NULL) AND (day_ IS NULL) THEN
	
	SET @SQL1 := QUERY1;
 	PREPARE my_query1 FROM @SQL1;
	EXECUTE my_query1;
	END IF;
	
	/*Lọc theo từng năm*/
	IF (year_ IS NOT NULL) THEN
	SET @SQL2 := QUERY2;
 	PREPARE my_query2 FROM @SQL2;
	EXECUTE my_query2;
	END IF;
	
	/*Lọc theo từng tháng*/
	IF (month_ IS NOT NULL) THEN
	SET @SQL3 := QUERY3;
 	PREPARE my_query3 FROM @SQL3;
	EXECUTE my_query3;
	END IF;
		
	/*Lọc theo từng ngày*/
	IF (day_ IS NOT NULL) THEN
	SET @SQL4 := QUERY4;
 	PREPARE my_query4 FROM @SQL4;
	EXECUTE my_query4;
	END IF;
		
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_user_taskdone_detail_pie
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_taskdone_detail_pie`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(2000);
   SET myquery = CONCAT(
		'SELECT t.TT_MORONG AS Trang_thai,COUNT(t.id) AS SL_Task
		FROM (SELECT *,
				   (CASE WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline = ''0000-00-00'' THEN ''Không có deadline''
							WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) > deadline 
																								OR (DATE(finishedDate) = deadline AND (consumed > estimate))) THEN ''Nộp trễ''
							WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) < deadline 
																								OR (DATE(finishedDate) = deadline AND (consumed < estimate))) THEN ''Nộp sớm''
										
							WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND DATE(finishedDate) = deadline AND (consumed = estimate) THEN ''Nộp đúng giờ''
							WHEN DATE(finishedDate) IS NULL THEN ''Không xác định được finishedDate''
							ELSE '''' END) AS TT_MORONG
				FROM zt_task) t
		JOIN zt_user u
		ON u.account = t.finishedBy
		LEFT JOIN zt_dept d
		ON u.dept = d.id
		WHERE 1=1'
	);

	SET myquery = CONCAT(myquery, ' AND t.deleted = ''0''');	
	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0''');	
	SET myquery = CONCAT(myquery, ' AND t.parent !=-1');
	SET myquery = CONCAT(myquery, ' AND YEAR(t.finishedDate) != ''1970'' ');
	
		/*Lọc theo tên nhân viên*/
	IF (username) IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND t.finishedBy = ''', username, '''');							
	END IF;
	
	/*Lọc các task theo khoảng thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND DATE(t.finishedDate) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;

	/*Lọc các task theo project*/
	IF (project_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.project = ''', project_id, '''');
	END IF;
	
	/*Lọc SL task theo department*/
	IF (dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND u.dept = ''', dept_id, '''');
	END IF;
	
	/*Lọc theo col,val*/
	IF (col IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;	
	
	SET myquery = CONCAT(myquery,' GROUP BY t.TT_MORONG');
	
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;		
			
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_user_taskdone_percentage
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_taskdone_percentage`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(2000);
	
	/* Hiển thị account NV, tên NV và tổng số dự án hoàn thành */
	SET myquery = CONCAT('SELECT CONCAT(COUNT(IF(t.finishedBy != '''',1,NULL)),'' ('',ROUND((COUNT(IF(t.finishedBy!='''',1,NULL))/COUNT(t.openedBy))*100,2),''%'','')'') AS Do_hoan_thanh_task_da_tao
							   FROM (SELECT *,
									   (CASE WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline = ''0000-00-00'' THEN ''Không có deadline''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) > deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed > estimate))) THEN ''Nộp trễ''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) < deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed < estimate))) THEN ''Nộp sớm''
															
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND DATE(finishedDate) = deadline AND (consumed = estimate) THEN ''Nộp đúng giờ''
												WHEN DATE(finishedDate) IS NULL THEN ''Không xác định được finishedDate''
												ELSE '''' END) AS TT_MORONG
									FROM zt_task) t
								JOIN zt_user u
								ON u.account = t.openedBy
								LEFT JOIN zt_dept d
								ON u.dept = d.id
								WHERE 1=1');
	SET myquery = CONCAT(myquery, ' AND t.deleted = ''0''');	
	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0''');	
	SET myquery = CONCAT(myquery, ' AND t.parent !=-1');
	SET myquery = CONCAT(myquery, ' AND YEAR(t.finishedDate) != ''1970'' ');
	
	/* Lọc theo tên NV */							
	IF (username) IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND u.account = ''', username, '''');							
	END IF;
	
	/*Lọc các task theo khoảng thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND DATE(t.openedDate ) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;	
	
	/*Lọc SL task theo project*/
	IF (project_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.project = ''', project_id, '''');
	END IF;
	
	/*Lọc SL task theo department*/
	IF (dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND u.dept = ''', dept_id, '''');
	END IF;
	
	/*Lọc theo col,val*/
	IF col IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;	
	
	
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_user_taskdone_total
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_taskdone_total`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(2000);
	SET myquery = CONCAT('SELECT COUNT(t.id) AS So_luong_task_hoan_thanh
							   FROM (SELECT *,
									   (CASE WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline = ''0000-00-00'' THEN ''Không có deadline''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) > deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed > estimate))) THEN ''Nộp trễ''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) < deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed < estimate))) THEN ''Nộp sớm''
															
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND DATE(finishedDate) = deadline AND (consumed = estimate) THEN ''Nộp đúng giờ''
												WHEN DATE(finishedDate) IS NULL THEN ''Không xác định được finishedDate''
												ELSE '''' END) AS TT_MORONG
									FROM zt_task) t
							JOIN zt_user u
							ON u.account = t.finishedBy
							LEFT JOIN zt_dept d
							ON u.dept = d.id
							WHERE 1=1');
							
	SET myquery = CONCAT(myquery, ' AND t.deleted = ''0''');	
	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0''');	
	SET myquery = CONCAT(myquery, ' AND t.parent !=-1');
	SET myquery = CONCAT(myquery, ' AND YEAR(t.finishedDate) != ''1970'' ');
	
	/*Lọc SL task theo tên NV*/
	IF (username IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.finishedBy = ''', username, '''');							
   END IF;
   
	/*Lọc SL task theo khoảng thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND DATE(t.finishedDate) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;					
	
	/*Lọc SL task theo project*/
	IF (project_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.project = ''', project_id, '''');
	END IF;
	
	/*Lọc SL task theo department*/
	IF (dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND u.dept = ''', dept_id, '''');
	END IF;
	
	/*Lọc theo col,val*/
	IF (col IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;	
	
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;		
			

END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_user_taskopened_bar
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_taskopened_bar`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(2000);
	
	/* Hiển thị account NV, tên NV và tổng số dự án hoàn thành */
	SET myquery = CONCAT('SELECT t.openedBy AS NV_Account, u.realname AS name, COUNT(t.id) AS So_luong_task_hoan_thanh
							   FROM (SELECT *,
									   (CASE WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline = ''0000-00-00'' THEN ''Không có deadline''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) > deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed > estimate))) THEN ''Nộp trễ''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) < deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed < estimate))) THEN ''Nộp sớm''
															
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND DATE(finishedDate) = deadline AND (consumed = estimate) THEN ''Nộp đúng giờ''
												WHEN DATE(finishedDate) IS NULL THEN ''Không xác định được finishedDate''
												ELSE '''' END) AS TT_MORONG
									FROM zt_task) t
								JOIN zt_user u
								ON u.account = t.openedBy
								LEFT JOIN zt_dept d
								ON u.dept = d.id
								WHERE 1=1');
	SET myquery = CONCAT(myquery, ' AND t.deleted = ''0''');	
	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0''');	
	SET myquery = CONCAT(myquery, ' AND t.parent !=-1');
	SET myquery = CONCAT(myquery, ' AND YEAR(t.finishedDate) != ''1970'' ');
	
	/* Lọc theo tên NV */							
	IF (username) IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND t.openedBy = ''', username, '''');							
	END IF;
	
	/*Lọc các task theo khoảng thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND DATE(t.openedDate) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;	
	
	/*Lọc SL task theo project*/
	IF (project_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.project = ''', project_id, '''');
	END IF;
	
	/*Lọc SL task theo department*/
	IF (dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND u.dept = ''', dept_id, '''');
	END IF;
	
	/*Lọc theo col,val*/
	IF (col IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;	
	
	SET myquery = CONCAT(myquery, ' GROUP BY t.openedBy ORDER BY COUNT(t.id) DESC, t.openedBy');
	
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;		
			
	
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_user_taskopened_bytime_line
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_taskopened_bytime_line`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50),
	IN `year_` ENUM('Y','N'),
	IN `month_` ENUM('Y','N'),
	IN `day_` ENUM('Y','N')
)
BEGIN
	DECLARE QUERY1 nvarchar(2000);
	DECLARE QUERY2 nvarchar(2000);
	DECLARE QUERY3 nvarchar(2000);
	DECLARE QUERY4 nvarchar(2000);
	
	/*Chọn các task theo thời gian tạo*/
	SET QUERY1 = CONCAT('SELECT DATE(t.openedDate) AS thoi_gian, COUNT(t.id) AS SL_task_da_tao
							   FROM (SELECT *,
									   (CASE WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline = ''0000-00-00'' THEN ''Không có deadline''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) > deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed > estimate))) THEN ''Nộp trễ''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) < deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed < estimate))) THEN ''Nộp sớm''
															
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND DATE(finishedDate) = deadline AND (consumed = estimate) THEN ''Nộp đúng giờ''
												WHEN DATE(finishedDate) IS NULL THEN ''Không xác định được finishedDate''
												ELSE '''' END) AS TT_MORONG
									FROM zt_task) t
								JOIN zt_user u
								ON u.account = t.openedBy
								LEFT JOIN zt_dept d
								ON u.dept = d.id
								WHERE t.deleted = ''0'' AND u.deleted = ''0'' AND t.parent !=-1 ');
							
	SET QUERY2 = CONCAT('SELECT CAST(Year(t.openedDate) AS CHAR) AS thoi_gian, COUNT(t.id) AS SL_task_da_tao
							   FROM (SELECT *,
									   (CASE WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline = ''0000-00-00'' THEN ''Không có deadline''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) > deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed > estimate))) THEN ''Nộp trễ''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) < deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed < estimate))) THEN ''Nộp sớm''
															
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND DATE(finishedDate) = deadline AND (consumed = estimate) THEN ''Nộp đúng giờ''
												WHEN DATE(finishedDate) IS NULL THEN ''Không xác định được finishedDate''
												ELSE '''' END) AS TT_MORONG
									FROM zt_task) t
								JOIN zt_user u
								ON u.account = t.openedBy
								LEFT JOIN zt_dept d
								ON u.dept = d.id
								WHERE t.deleted = ''0'' AND u.deleted = ''0'' AND t.parent !=-1 ');
								
	SET QUERY3 = CONCAT('SELECT CONCAT(Month(t.openedDate),''/'', Year(t.openedDate)) AS thoi_gian, COUNT(t.id) AS SL_task_da_tao
							   FROM (SELECT *,
									   (CASE WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline = ''0000-00-00'' THEN ''Không có deadline''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) > deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed > estimate))) THEN ''Nộp trễ''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) < deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed < estimate))) THEN ''Nộp sớm''
															
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND DATE(finishedDate) = deadline AND (consumed = estimate) THEN ''Nộp đúng giờ''
												WHEN DATE(finishedDate) IS NULL THEN ''Không xác định được finishedDate''
												ELSE '''' END) AS TT_MORONG
									FROM zt_task) t
								JOIN zt_user u
								ON u.account = t.openedBy
								LEFT JOIN zt_dept d
								ON u.dept = d.id
								WHERE t.deleted = ''0'' AND u.deleted = ''0'' AND t.parent !=-1 ');	
									
	SET QUERY4 = CONCAT('SELECT CONCAT(Day(t.openedDate),''/'',Month(t.openedDate),''/'', Year(t.openedDate)) AS thoi_gian, COUNT(t.id) AS SL_task_da_tao
							   FROM (SELECT *,
									   (CASE WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline = ''0000-00-00'' THEN ''Không có deadline''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) > deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed > estimate))) THEN ''Nộp trễ''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) < deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed < estimate))) THEN ''Nộp sớm''
															
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND DATE(finishedDate) = deadline AND (consumed = estimate) THEN ''Nộp đúng giờ''
												WHEN DATE(finishedDate) IS NULL THEN ''Không xác định được finishedDate''
												ELSE '''' END) AS TT_MORONG
									FROM zt_task) t
								JOIN zt_user u
								ON u.account = t.openedBy
								LEFT JOIN zt_dept d
								ON u.dept = d.id
								WHERE t.deleted = ''0'' AND u.deleted = ''0'' AND t.parent !=-1 ');
										
	/*Lọc SL task theo tên NV*/
	IF (username IS NOT NULL) THEN
		SET QUERY1 = CONCAT(QUERY1,' AND t.openedBy = ''', username, '''');
		SET QUERY2 = CONCAT(QUERY2,' AND t.openedBy = ''', username, '''');
		SET QUERY3 = CONCAT(QUERY3,' AND t.openedBy = ''', username, '''');
		SET QUERY4 = CONCAT(QUERY4,' AND t.openedBy = ''', username, '''');									
   END IF;										
																													
	/*Lọc SL task theo khoảng thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET QUERY1 = CONCAT(QUERY1,' AND DATE(t.openedDate) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
		SET QUERY2 = CONCAT(QUERY2,' AND DATE(t.openedDate) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
		SET QUERY3 = CONCAT(QUERY3,' AND DATE(t.openedDate) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
		SET QUERY4 = CONCAT(QUERY4,' AND DATE(t.openedDate) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;	
	
	/*Lọc SL task theo project*/
	IF (project_id IS NOT NULL) THEN
		SET QUERY1 = CONCAT(QUERY1,' AND t.project = ''', project_id, '''');
		SET QUERY2 = CONCAT(QUERY2,' AND t.project = ''', project_id, '''');
		SET QUERY3 = CONCAT(QUERY3,' AND t.project = ''', project_id, '''');
		SET QUERY4 = CONCAT(QUERY4,' AND t.project = ''', project_id, '''');
	END IF;
	
	/*Lọc SL task theo department*/
	IF (dept_id IS NOT NULL) THEN
		SET QUERY1 = CONCAT(QUERY1,' AND u.dept = ''', dept_id, '''');
		SET QUERY2 = CONCAT(QUERY1,' AND u.dept = ''', dept_id, '''');
		SET QUERY3 = CONCAT(QUERY1,' AND u.dept = ''', dept_id, '''');
		SET QUERY4 = CONCAT(QUERY1,' AND u.dept = ''', dept_id, '''');
	END IF;
	
	/*Lọc theo col,val*/
	IF (col IS NOT NULL) THEN
		SET QUERY1 = CONCAT(QUERY1,' AND ',col, ' = ''', val,''' ');
		SET QUERY2 = CONCAT(QUERY2,' AND ',col, ' = ''', val,''' ');
		SET QUERY3 = CONCAT(QUERY3,' AND ',col, ' = ''', val,''' ');
		SET QUERY4 = CONCAT(QUERY4,' AND ',col, ' = ''', val,''' ');
	END IF;	
	
	SET QUERY1 = CONCAT(QUERY1,' GROUP BY 1 ORDER BY 1');
	SET QUERY2 = CONCAT(QUERY2,' GROUP BY 1 ORDER BY 1');	
	SET QUERY3 = CONCAT(QUERY3,' GROUP BY 1 ORDER BY YEAR(t.openedDate), MONTH(t.openedDate)');
	SET QUERY4 = CONCAT(QUERY4,' GROUP BY 1 ORDER BY YEAR(t.openedDate), MONTH(t.openedDate), DAY(t.openedDate)');
	
	/*Hiển thị tất cả*/
	IF (year_ IS NULL) AND (month_ IS NULL) AND (day_ IS NULL) THEN
	SET @SQL1 := QUERY1;
 	PREPARE my_query1 FROM @SQL1;
	EXECUTE my_query1;		
			
	END IF;
	
	/*Lọc theo từng năm*/
	IF (year_ IS NOT NULL) THEN
	SET @SQL2 := QUERY2;
 	PREPARE my_query2 FROM @SQL2;
	EXECUTE my_query2;	
	END IF;
	
	/*Lọc theo từng tháng*/
	IF (month_ IS NOT NULL) THEN
	SET @SQL3 := QUERY3;
 	PREPARE my_query3 FROM @SQL3;
	EXECUTE my_query3;	
	END IF;
		
	/*Lọc theo từng ngày*/
	IF (day_ IS NOT NULL) THEN
	SET @SQL4 := QUERY4;
 	PREPARE my_query4 FROM @SQL4;
	EXECUTE my_query4;	
	END IF;
		
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_user_taskopened_total
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_taskopened_total`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(2000);
	SET myquery = CONCAT('SELECT COUNT(t.id) AS So_luong_task_da_tao
							   FROM (SELECT *,
									   (CASE WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline = ''0000-00-00'' THEN ''Không có deadline''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) > deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed > estimate))) THEN ''Nộp trễ''
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND (DATE(finishedDate) < deadline 
																													OR (DATE(finishedDate) = deadline AND (consumed < estimate))) THEN ''Nộp sớm''
															
												WHEN DATE(finishedDate) != ''0000-00-00'' AND deadline != ''0000-00-00'' AND DATE(finishedDate) = deadline AND (consumed = estimate) THEN ''Nộp đúng giờ''
												WHEN DATE(finishedDate) IS NULL THEN ''Không xác định được finishedDate''
												ELSE '''' END) AS TT_MORONG
									FROM zt_task) t
							JOIN zt_user u
							ON u.account = t.openedBy
							LEFT JOIN zt_dept d
							ON u.dept = d.id
							WHERE 1=1');
							
	SET myquery = CONCAT(myquery, ' AND t.deleted = ''0''');	
	SET myquery = CONCAT(myquery, ' AND u.deleted = ''0''');	
	SET myquery = CONCAT(myquery, ' AND t.parent !=-1');
	SET myquery = CONCAT(myquery, ' AND YEAR(t.finishedDate) != ''1970'' ');
	
	/*Lọc SL task theo tên NV*/
	IF (username IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.openedBy = ''', username, '''');							
   END IF;
   
	/*Lọc SL task theo khoảng thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND DATE(t.openedDate) BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;					
	
	/*Lọc SL task theo project*/
	IF (project_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND t.project = ''', project_id, '''');
	END IF;
	
	/*Lọc SL task theo department*/
	IF (dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND u.dept = ''', dept_id, '''');
	END IF;
	
	/*Lọc theo col,val*/
	IF (col IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;	
	
	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;	
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_user_task_started_bar
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_task_started_bar`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)

)
BEGIN
	DECLARE myquery nvarchar(2000);
	/* Hiển thị account NV, tên NV và tổng số dự án hoàn thành */						
	SET myquery  = CONCAT('SELECT u.account,u.realname, COUNT(t.id) 
								FROM  zt_task t
								JOIN zt_action a
								ON a.objectID = t.id
								JOIN zt_user u
								ON u.account = a.actor
								WHERE 1=1 ');
	SET myquery  = CONCAT(myquery , ' AND t.deleted = ''0''');	
	SET myquery  = CONCAT(myquery , ' AND u.deleted = ''0''');	
	SET myquery  = CONCAT(myquery , ' AND t.parent !=-1');
	SET myquery  = CONCAT(myquery , ' AND a.objectType = ''task''');
	SET myquery  = CONCAT(myquery , ' AND a.action = ''started'' ');
	
	/* Lọc theo tên NV */							
	IF (username) IS NOT NULL THEN
		SET myquery  = CONCAT(myquery ,' AND u.account = ''', username, '''');							
	END IF;
	
	/*Lọc theo khoảng thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery  = CONCAT(myquery ,' AND a.date BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;	
	
	/*Lọc theo project*/
	IF (project_id IS NOT NULL) THEN
		SET myquery  = CONCAT(myquery ,' AND t.project = ''', project_id, '''');
	END IF;
	
	/*Lọc SL task theo department*/

	/*Lọc theo col,val*/
	IF (col IS NOT NULL) THEN
		SET myquery  = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;	
	
	SET myquery  = CONCAT(myquery , ' GROUP BY u.account ORDER BY COUNT(t.id) ASC');
	
	
	SELECT myquery;
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_user_total_bang
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_total_bang`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(2000);
	SET myquery = CONCAT('SELECT COUNT(DISTINCT tm.account) as tong_SL_nhan_vien
								FROM zt_project p
								JOIN zt_team tm
								ON tm.root = p.id	
								JOIN zt_user u
								ON u.account = tm.account
								LEFT JOIN zt_dept d
								ON u.dept = d.id										 
								WHERE 1=1');

	SET myquery = CONCAT(myquery,' AND u.deleted = ''0''');
	SET myquery = CONCAT(myquery,' AND p.deleted = ''0''');
	SET myquery = CONCAT(myquery,' AND tm.type = ''project''');
	
	/* Lọc theo tên NV */							
	IF (username) IS NOT NULL THEN
		SET myquery = CONCAT(myquery,' AND u.account = ''', username, '''');							
	END IF;
	
	
	/*Lọc SL NV theo khoảng thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND u.join <= ''', end_date, ''' '); 
	END IF;					
	
	/*Lọc SL NV theo project*/
	IF (project_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND p.id = ''', project_id, '''');
	END IF;
	
	/*Lọc SL task theo department*/
	IF (dept_id IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND u.dept = ''', dept_id, '''');
	END IF;
	
	/*Lọc theo col,val*/	
	IF (col IS NOT NULL) THEN
		SET myquery = CONCAT(myquery,' AND ',col, ' = ''', val,''' ');
	END IF;	
	
	SET @SQL := myquery;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;	
END//
DELIMITER ;

-- Dumping structure for procedure fpms.dsa_user_without_task
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dsa_user_without_task`(
	IN `start_date` DATE,
	IN `end_date` DATE,
	IN `project_id` INT,
	IN `username` VARCHAR(50),
	IN `dept_id` INT,
	IN `col` VARCHAR(50),
	IN `val` VARCHAR(50)
)
BEGIN
	DECLARE myquery nvarchar(2000);
	DECLARE myquery1 nvarchar(2000);
	/* Hiển thị account NV, tên NV và tổng số dự án hoàn thành */						
	SET myquery  = CONCAT('SELECT u.account 
								FROM  zt_task t
								JOIN zt_action a
								ON a.objectID = t.id
								JOIN zt_user u
								ON u.account = a.actor
								WHERE 1=1 ');
	SET myquery  = CONCAT(myquery , ' AND t.deleted = ''0''');	
	SET myquery  = CONCAT(myquery , ' AND u.deleted = ''0''');	
	SET myquery  = CONCAT(myquery , ' AND t.parent !=-1');
	SET myquery  = CONCAT(myquery , ' AND a.objectType = ''task''');
	SET myquery  = CONCAT(myquery , ' AND a.action = ''started'' ');
	
		/*Lọc theo khoảng thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery  = CONCAT(myquery,' AND a.date BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;

	
	SET myquery  = CONCAT(myquery , ' GROUP BY u.account ');
	
	SET myquery1 = CONCAT ('SELECT u.account,GROUP_CONCAT(DISTINCT CONCAT(Day(a.date),''/'',Month(a.date),''/'', Year(a.date)) ORDER BY YEAR(a.date), MONTH(a.date), DAY(a.date) SEPARATOR ''\n'')
									FROM zt_user u
									JOIN zt_action a
									ON account = a.actor
									LEFT JOIN zt_dept d
									ON dept = d.id
									WHERE deleted =''0'' AND u.account NOT IN (',myquery,')');	
	
	
	/* Lọc theo tên NV */							
	IF (username) IS NOT NULL THEN
		SET myquery1  = CONCAT(myquery1 ,' AND u.account = ''', username, '''');							
	END IF;
	/*Lọc SL task theo department*/							
	IF (dept_id IS NOT NULL) THEN
		SET myquery1  = CONCAT(myquery1,' AND dept = ''', dept_id, '''');
	END IF;
		/*Lọc theo khoảng thời gian*/
	IF (start_date IS NOT NULL) AND (end_date IS NOT NULL) THEN
		SET myquery1  = CONCAT(myquery1,' AND a.date BETWEEN ''', start_date, ''' AND ''',  end_date, ''' '); 
	END IF;	
	
	/*Lọc theo project*/
	IF (project_id IS NOT NULL) THEN
		SET myquery1  = CONCAT(myquery1,' AND t.project = ''', project_id, '''');
	END IF;
	
		/*Lọc theo col,val*/
	IF (col IS NOT NULL) THEN
		SET myquery1  = CONCAT(myquery1,' AND ',col, ' = ''', val,''' ');
	END IF;	
	
	SET myquery1 = CONCAT(myquery1,' GROUP BY u.account ORDER BY u.account');
	
	SELECT myquery1;
	SET @SQL := myquery1;
 	PREPARE my_query FROM @SQL;
	EXECUTE my_query;
	
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
