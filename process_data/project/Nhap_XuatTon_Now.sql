USE [QUACONTRO_FBOHRMSP2255_App]
GO
/****** Object:  StoredProcedure [dbo].[dsa_sp_Nhap_Xuat_Ton_now]    Script Date: 12/14/2020 8:53:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[dsa_sp_Nhap_Xuat_Ton_now] @date DATE, @ma_vt CHAR(16)
AS
BEGIN

	DROP TABLE IF EXISTS #temp_dsa_NhapXuat
	DROP TABLE IF EXISTS ##temp_dsa_ton_now
	DROP TABLE IF EXISTS #temp_dsa_NhapXuatTon_now
	CREATE TABLE #temp_dsa_NhapXuat(type VARCHAR(30), value numeric(16, 2), text_value NVARCHAR(30))
	CREATE TABLE ##temp_dsa_ton_now(type VARCHAR(30), value numeric(16, 2), text_value NVARCHAR(30))
	CREATE TABLE #temp_dsa_NhapXuatTon_now(Loai VARCHAR(30), value_ton numeric(16, 2), value_nx numeric(16, 2), text_value_ton NVARCHAR(30), text_value_nx NVARCHAR(30))

	DECLARE @date_dk DATE

	IF @date IS NULL
		BEGIN
			SELECT @date = FORMAT(GETDATE(),'dd/MM/yyyy')
			SELECT @date_dk = DATEADD(day, -1, @date)
		END
	ELSE
		SELECT @date_dk =  DATEADD(day, -1, @date)

	PRINT(@date)
	PRINT(@date_dk)

	-- Thêm dữ liệu vào bảng #temp_dsa_NhapXuat
	INSERT #temp_dsa_NhapXuat EXEC dsa_sp_KHO_XUAT_NHAP 'GiaTriNX', @date, @date, @ma_vt, NULL
	
	-- Thêm dữ liệu vào bảng ##temp_dsa_ton_now
	EXECUTE dsa_sp_TonKho_PUBLISH 'ton_dk',@date_dk, @ma_vt
	EXECUTE dsa_sp_TonKho_PUBLISH 'ton_ck',@date, @ma_vt

	--Thêm dữ liệu vào 
	INSERT INTO #temp_dsa_NhapXuatTon_now SELECT 'TonDK_Nhap',(SELECT value FROM ##temp_dsa_ton_now WHERE type = 'TonDK'),(SELECT value FROM #temp_dsa_NhapXuat WHERE type = 'Nhap'),(SELECT text_value FROM ##temp_dsa_ton_now WHERE type = 'TonDK'),(SELECT text_value FROM #temp_dsa_NhapXuat WHERE type = 'Nhap')

	INSERT INTO #temp_dsa_NhapXuatTon_now SELECT 'TonCK_Xuat',(SELECT value FROM ##temp_dsa_ton_now WHERE type = 'TonCK'),(SELECT value FROM #temp_dsa_NhapXuat WHERE type = 'Xuat'),(SELECT text_value FROM ##temp_dsa_ton_now WHERE type = 'TonCK'),(SELECT text_value FROM #temp_dsa_NhapXuat WHERE type = 'Xuat')

	SELECT * FROM #temp_dsa_NhapXuatTon_now
END



