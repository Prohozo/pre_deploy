USE [master]
GO
/****** Object:  Database [Permission]    Script Date: 8/3/2020 9:43:03 AM ******/
CREATE DATABASE [Permission]

GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Permission].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Permission] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Permission] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Permission] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Permission] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Permission] SET ARITHABORT OFF 
GO
ALTER DATABASE [Permission] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Permission] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Permission] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Permission] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Permission] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Permission] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Permission] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Permission] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Permission] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Permission] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Permission] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Permission] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Permission] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Permission] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Permission] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Permission] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Permission] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Permission] SET RECOVERY FULL 
GO
ALTER DATABASE [Permission] SET  MULTI_USER 
GO
ALTER DATABASE [Permission] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Permission] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Permission] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Permission] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Permission] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Permission', N'ON'
GO
USE [Permission]
GO
/****** Object:  Table [dbo].[roles]    Script Date: 8/3/2020 9:43:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](30) NOT NULL,
	[description] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[roles_users]    Script Date: 8/3/2020 9:43:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles_users](
	[user_id] [int] NOT NULL,
	[role_id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 8/3/2020 9:43:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[email] [varchar](20) NOT NULL,
	[password] [varchar](255) NOT NULL,
	[name] [nvarchar](30) NOT NULL,
	[created_date] [datetime] NOT NULL,
	[active] [bit] NOT NULL,
	[change_pwd] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[roles] ON 

-- Change name dashboard and description
--INSERT [dbo].[roles] ([id], [name], [description]) VALUES (1, N'Quản trị hệ thống', N'Quyền cao nhất')
--INSERT [dbo].[roles] ([id], [name], [description]) VALUES (2, N'Dashboard Kế Toán', N'Truy cập xem được Dashboard Kế Toán')
--INSERT [dbo].[roles] ([id], [name], [description]) VALUES (3, N'Dashboard Kế Toán', N'Truy cập xem được Dashboard Kế Toán')
--INSERT [dbo].[roles] ([id], [name], [description]) VALUES (4, N'Dashboard Kho Xe', N'Truy cập xem được Dashboard Kho Xe')
--INSERT [dbo].[roles] ([id], [name], [description]) VALUES (5, N'Dashboard Kho Vật Tư', N'Truy cập xem được Dashboard Kho Vật Tư')
--INSERT [dbo].[roles] ([id], [name], [description]) VALUES (6, N'Dashboard Bán Hàng', N'Truy cập xem được Dashboard Bán Hàng')
--INSERT [dbo].[roles] ([id], [name], [description]) VALUES (7, N'Dashboard KPI Bán Hàng', N'Truy cập xem được Dashboard KPI')
--INSERT [dbo].[roles] ([id], [name], [description]) VALUES (8, N'Dashboard Dịch Vụ', N'Truy cập xem được Dashboard Dịch Vụ')
SET IDENTITY_INSERT [dbo].[roles] OFF

INSERT [dbo].[roles_users] ([user_id], [role_id]) VALUES (1, 1)
INSERT [dbo].[roles_users] ([user_id], [role_id]) VALUES (2, 1)
SET IDENTITY_INSERT [dbo].[users] ON

-- Pass admin default: 12345678
INSERT [dbo].[users] ([id], [email], [password], [name], [created_date], [active], [change_pwd]) VALUES (1, N'admin', N'$pbkdf2-sha512$25000$qDVmTOkdQ2htjdE6B4AQIg$G9y4Q.7eJ9T8fI6GZU34cmvOtPiAt9pTTRilyDKjLPmLg8.zg/yEBz1ZYvvsXy11woJGU85s7X0F.VNpck4aSw', N'Administrator ', CAST(N'2021-01-28T06:16:37.000' AS DateTime), 1, 1)
INSERT [dbo].[users] ([id], [email], [password], [name], [created_date], [active], [change_pwd]) VALUES (2, N'tongttq', N'$pbkdf2-sha512$25000$PsfYmxPiXKuV8n7PufdeKw$PPrIEY/rJ8L8.OOATr09UNnSsSi13f4/76n8fYO0f5mbAch5hnMXd8k8dtpO073qrXuhMi7LBWt/5DKIokEbXw', N'Trần Thiên Quốc Tổng', CAST(N'2021-01-19T12:05:47.000' AS DateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[users] OFF

ALTER TABLE [dbo].[roles_users]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[roles] ([id])
GO
ALTER TABLE [dbo].[roles_users]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
USE [master]
GO
ALTER DATABASE [Permission] SET  READ_WRITE 
GO

select * from [users]