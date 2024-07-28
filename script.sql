USE [master]
GO
/****** Object:  Database [silvioaa_ecom]    Script Date: 27/7/2024 15:28:19 ******/
CREATE DATABASE [silvioaa_ecom]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'silvioaa_ecom', FILENAME = N'D:\sql-freeasphost-user-dbs\silvioaa_ecom.mdf' , SIZE = 10240KB , MAXSIZE = 51200KB , FILEGROWTH = 5120KB )
 LOG ON 
( NAME = N'silvioaa_ecom_log', FILENAME = N'D:\sql-freeasphost-user-dbs\silvioaa_ecom.ldf' , SIZE = 5120KB , MAXSIZE = 25600KB , FILEGROWTH = 5120KB )
GO
ALTER DATABASE [silvioaa_ecom] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [silvioaa_ecom].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [silvioaa_ecom] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET ARITHABORT OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [silvioaa_ecom] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [silvioaa_ecom] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET  ENABLE_BROKER 
GO
ALTER DATABASE [silvioaa_ecom] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [silvioaa_ecom] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET RECOVERY FULL 
GO
ALTER DATABASE [silvioaa_ecom] SET  MULTI_USER 
GO
ALTER DATABASE [silvioaa_ecom] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [silvioaa_ecom] SET DB_CHAINING OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [silvioaa_ecom] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [silvioaa_ecom] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [silvioaa_ecom] SET QUERY_STORE = OFF
GO
USE [silvioaa_ecom]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [silvioaa_ecom]
GO
/****** Object:  UserDefinedTableType [dbo].[PurchaseItems]    Script Date: 27/7/2024 15:28:23 ******/
CREATE TYPE [dbo].[PurchaseItems] AS TABLE(
	[ProductId] [int] NULL,
	[Amount] [int] NULL,
	[Price] [float] NULL
)
GO
/****** Object:  Table [dbo].[Products]    Script Date: 27/7/2024 15:28:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](45) NOT NULL,
	[ProductImage] [nvarchar](200) NOT NULL,
	[ProductDescription] [nvarchar](100) NOT NULL,
	[ProductPrice] [int] NOT NULL,
 CONSTRAINT [PRIMARYPRODUCTS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductsV2]    Script Date: 27/7/2024 15:28:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductsV2](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](45) NOT NULL,
	[ProductImage] [nvarchar](200) NOT NULL,
	[ProductDescription] [nvarchar](100) NOT NULL,
	[ProductPrice] [float] NOT NULL,
 CONSTRAINT [PRIMARYPRODUCTSV2] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Purchases]    Script Date: 27/7/2024 15:28:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Purchases](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PurchaseTime] [datetime] NOT NULL,
	[Detail] [nvarchar](max) NOT NULL,
	[Total] [int] NOT NULL,
 CONSTRAINT [PRIMARYPURCHASES] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchasesV2]    Script Date: 27/7/2024 15:28:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchasesV2](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[PurchaseTime] [datetime] NOT NULL,
	[Detail] [nvarchar](max) NOT NULL,
	[Total] [float] NOT NULL,
 CONSTRAINT [PRIMARYPURCHASESV2] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [ProductName], [ProductImage], [ProductDescription], [ProductPrice]) VALUES (1, N'Shirt', N'shirt.jpg', N'An elegant shirt', 100)
INSERT [dbo].[Products] ([Id], [ProductName], [ProductImage], [ProductDescription], [ProductPrice]) VALUES (2, N'Tie', N'tie.jpg', N'A fine silk tie', 50)
INSERT [dbo].[Products] ([Id], [ProductName], [ProductImage], [ProductDescription], [ProductPrice]) VALUES (3, N'Pants', N'pants.jpg', N'Comfortable jean pants', 200)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductsV2] ON 

INSERT [dbo].[ProductsV2] ([Id], [ProductName], [ProductImage], [ProductDescription], [ProductPrice]) VALUES (1, N'Shirt', N'shirt.jpg', N'An elegant shirt', 100)
INSERT [dbo].[ProductsV2] ([Id], [ProductName], [ProductImage], [ProductDescription], [ProductPrice]) VALUES (2, N'Tie', N'tie.jpg', N'A fine silk tie', 50)
INSERT [dbo].[ProductsV2] ([Id], [ProductName], [ProductImage], [ProductDescription], [ProductPrice]) VALUES (3, N'Pants', N'pants.jpg', N'Comfortable jean pants', 200)
SET IDENTITY_INSERT [dbo].[ProductsV2] OFF
GO
/****** Object:  StoredProcedure [dbo].[Insert_Purchase]    Script Date: 27/7/2024 15:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [dbo].[Insert_Purchase] 
							@TimeOfPurchase DATETIME
							,@PurchaseDetail NVARCHAR(MAX)
							,@PurchaseTotal INT
							,@Id INT OUTPUT

AS

BEGIN

	INSERT INTO dbo.Purchases 
								(PurchaseTime
								,Detail
								,Total)
								VALUES
								(@TimeOfPurchase
								,@PurchaseDetail
								,@PurchaseTotal)
	SET @Id = SCOPE_IDENTITY();

END
GO
/****** Object:  StoredProcedure [dbo].[Insert_PurchaseV2]    Script Date: 27/7/2024 15:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [dbo].[Insert_PurchaseV2] 
							@UserId INT
							,@TimeOfPurchase DATETIME
							,@PurchaseDetail dbo.PurchaseItems READONLY
							,@PurchaseTotal FLOAT
							,@Id INT OUTPUT

AS

BEGIN

	DECLARE @Detail NVARCHAR(MAX) = (SELECT * FROM @PurchaseDetail FOR JSON PATH);

	INSERT INTO dbo.PurchasesV2 
								(UserId
								,PurchaseTime
								,Detail
								,Total)
								VALUES
								(@UserId
								,@TimeOfPurchase
								,@Detail
								,@PurchaseTotal)
	SET @Id = SCOPE_IDENTITY();

END
GO
/****** Object:  StoredProcedure [dbo].[Select_Products]    Script Date: 27/7/2024 15:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[Insert_Purchase]    Script Date: 1/5/2024 15:02:21 ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO




CREATE PROC [dbo].[Select_Products]
								@Id INT = NULL
								,@ProductName NVARCHAR(MAX) = NULL

AS

BEGIN

	IF @Id IS NOT NULL
		SELECT * FROM dbo.Products WHERE Id = @Id;
	ELSE IF @ProductName IS NOT NULL
		SELECT * FROM dbo.Products WHERE ProductName LIKE '%' + @ProductName + '%';
	ELSE
		SELECT * FROM dbo.Products;

END


GO
/****** Object:  StoredProcedure [dbo].[Select_ProductsV2]    Script Date: 27/7/2024 15:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[Insert_Purchase]    Script Date: 1/5/2024 15:02:21 ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO




CREATE PROC [dbo].[Select_ProductsV2]
								@Id INT = NULL
								,@ProductName NVARCHAR(MAX) = NULL

AS

BEGIN

	IF @Id IS NOT NULL
		SELECT * FROM dbo.ProductsV2 WHERE Id = @Id;
	ELSE IF @ProductName IS NOT NULL
		SELECT * FROM dbo.ProductsV2 WHERE ProductName LIKE '%' + @ProductName + '%';
	ELSE
		SELECT * FROM dbo.ProductsV2;

END
GO
EXEC sys.sp_addextendedproperty @name=N'Database', @value=N'ecom' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Insert_Purchase'
GO
USE [master]
GO
ALTER DATABASE [silvioaa_ecom] SET  READ_WRITE 
GO
