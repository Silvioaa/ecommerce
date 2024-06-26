/****** Object:  Database [silvioaa_ecom]    Script Date: 8/6/2024 16:47:58 ******/
CREATE DATABASE [silvioaa_ecom]  
GO
ALTER DATABASE [silvioaa_ecom] SET COMPATIBILITY_LEVEL = 130
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
ALTER DATABASE [silvioaa_ecom] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [silvioaa_ecom] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [silvioaa_ecom] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [silvioaa_ecom] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [silvioaa_ecom] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [silvioaa_ecom] SET  MULTI_USER 
GO
ALTER DATABASE [silvioaa_ecom] SET ENCRYPTION ON
GO
ALTER DATABASE [silvioaa_ecom] SET QUERY_STORE = ON
GO
ALTER DATABASE [silvioaa_ecom] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
/*** The scripts of database scoped configurations in Azure should be executed inside the target database connection. ***/
GO
-- ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 8;
GO

USE [silvioaa_ecom]
GO

/****** Object:  Table [dbo].[Products]    Script Date: 8/6/2024 16:47:58 ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Purchases]    Script Date: 8/6/2024 16:47:58 ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [ProductName], [ProductImage], [ProductDescription], [ProductPrice]) VALUES (1, N'Shirt', N'shirt.jpg', N'An elegant shirt', 100)
INSERT [dbo].[Products] ([Id], [ProductName], [ProductImage], [ProductDescription], [ProductPrice]) VALUES (2, N'Tie', N'tie.jpg', N'A fine silk tie', 50)
INSERT [dbo].[Products] ([Id], [ProductName], [ProductImage], [ProductDescription], [ProductPrice]) VALUES (3, N'Pants', N'pants.jpg', N'Comfortable jean pants', 200)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
/****** Object:  StoredProcedure [dbo].[Insert_Purchase]    Script Date: 8/6/2024 16:47:58 ******/
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
/****** Object:  StoredProcedure [dbo].[Select_Products]    Script Date: 8/6/2024 16:47:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
ALTER DATABASE [silvioaa_ecom] SET  READ_WRITE 
GO

CREATE LOGIN dbuser WITH PASSWORD = 'Somereallydifficultpassword1425!';
GO

CREATE USER dbuser FOR LOGIN dbuser;
GO

GRANT EXECUTE TO dbuser;
GO