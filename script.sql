USE [master]
GO
/****** Object:  Database [silvioaa_ecom]    Script Date: 10/8/2024 15:41:23 ******/
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
/****** Object:  UserDefinedTableType [dbo].[PurchaseItems]    Script Date: 10/8/2024 15:41:25 ******/
CREATE TYPE [dbo].[PurchaseItems] AS TABLE(
	[ProductId] [int] NULL,
	[Amount] [int] NULL,
	[Price] [float] NULL
)
GO
/****** Object:  Table [dbo].[ProductsV2]    Script Date: 10/8/2024 15:41:25 ******/
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
/****** Object:  Table [dbo].[PurchasesV2]    Script Date: 10/8/2024 15:41:26 ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 10/8/2024 15:41:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[PasswordHash] [binary](64) NOT NULL,
	[UserRole] [int] NOT NULL,
	[Salt] [uniqueidentifier] NOT NULL,
	[SessionToken] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ProductsV2] ON 

INSERT [dbo].[ProductsV2] ([Id], [ProductName], [ProductImage], [ProductDescription], [ProductPrice]) VALUES (1, N'Shirt', N'shirt.jpg', N'An elegant shirt', 100)
INSERT [dbo].[ProductsV2] ([Id], [ProductName], [ProductImage], [ProductDescription], [ProductPrice]) VALUES (2, N'Tie', N'tie.jpg', N'A fine silk tie', 50)
INSERT [dbo].[ProductsV2] ([Id], [ProductName], [ProductImage], [ProductDescription], [ProductPrice]) VALUES (3, N'Pants', N'pants.jpg', N'Comfortable jean pants', 200)
SET IDENTITY_INSERT [dbo].[ProductsV2] OFF
GO
/****** Object:  StoredProcedure [dbo].[Insert_PurchaseV2]    Script Date: 10/8/2024 15:41:26 ******/
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

/*
	Declare @Detail dbo.PurchaseItems;
	Insert into @Detail (ProductId, Amount, Price) Values (7,4,2.5);
	Declare @Id int;
	Declare @Now datetime = getutcdate();

	Select * from dbo.PurchasesV2;

	Execute dbo.Insert_PurchaseV2
								8
								,@Now
								,@Detail
								,50.4
								,@Id OUTPUT

	Select @Id as Id;
	Select * from PurchasesV2;
*/

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
/****** Object:  StoredProcedure [dbo].[Insert_User]    Script Date: 10/8/2024 15:41:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Insert_User]
						@UserName NVARCHAR(50)
						,@Password NVARCHAR(50)
						,@UserRole INT
						,@ResponseMessage NVARCHAR(4000) OUTPUT

AS

/*

	Select * from dbo.Users;

	Declare @ResponseMessage NVARCHAR(MAX) = '';

	Execute Insert_User 
					'Silvio'
					,'SomeDifficultPassword5342??'
					,1
					,@ResponseMessage OUTPUT

	Select @ResponseMessage as ResponseMessage;
	Select * from dbo.Users;

*/

BEGIN

	IF ((SELECT TOP 1 UserName FROM dbo.Users WHERE UserName = @UserName) IS NOT NULL)
	BEGIN
		SET @ResponseMessage = 'User name already exists';
		SET NOEXEC ON;
	END

	BEGIN TRY
		DECLARE @Salt UNIQUEIDENTIFIER = NEWID();
		DECLARE @PasswordHash BINARY(64) = HASHBYTES('SHA2_512', @Password + CAST(@Salt as NVARCHAR(36)));

		INSERT INTO dbo.Users (UserName, PasswordHash, UserRole, Salt)
					   VALUES (@UserName, @PasswordHash, @UserRole, @Salt);
		SET @ResponseMessage = 'Success';
	END TRY

	BEGIN CATCH
		SET @ResponseMessage = ERROR_MESSAGE();
	END CATCH

	SET NOEXEC OFF;

END
GO
/****** Object:  StoredProcedure [dbo].[Login_User]    Script Date: 10/8/2024 15:41:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Login_User]
						@UserName NVARCHAR(50)
						,@Password NVARCHAR(50)
						,@ResponseMessage NVARCHAR(MAX) OUTPUT
						,@SessionToken UNIQUEIDENTIFIER OUTPUT

AS

/*

	-- Check if the token is changed correctly when correct user and password are inputed.
	Declare @ResponseMessage NVARCHAR(MAX);
	Declare @SessionToken UNIQUEIDENTIFIER;

	UPDATE dbo.Users
		SET SessionToken = NULL
	WHERE UserName = 'Silvio';

	Select * from dbo.Users where UserName = 'Silvio';
	Execute dbo.Login_User
						'Silvio'
						,'SomeDifficultPassword5342??'
						,@ResponseMessage OUTPUT
						,@SessionToken OUTPUT

	Select * from dbo.Users where UserName = 'Silvio';
	Select @ResponseMessage AS ResponseMessage;
	Select @SessionToken AS SessionToken;

	-- Check if proc detects when an user is already logged in
	Execute dbo.Login_User
						'Silvio'
						,'SomeDifficultPassword5342??'
						,@ResponseMessage OUTPUT
						,@SessionToken OUTPUT

	Select * from dbo.Users where UserName = 'Silvio';
	Select @ResponseMessage AS ResponseMessage;
	Select @SessionToken AS SessionToken;


	-- Check if when a wrong name is inputed, the correct response message is returned
	SET @ResponseMessage = null;
	SET @SessionToken = null;
	Execute dbo.Login_User
						'SomeNameThatDoesntExist'
						,'WhateverPassword'
						,@ResponseMessage OUTPUT
						,@SessionToken OUTPUT
	Select @ResponseMessage AS ResponseMessage;
	Select @SessionToken AS SessionToken;

	-- Check if when a wrong password is inputed, the correct response message is returned
	SET @ResponseMessage = null;
	SET @SessionToken = null;
	Execute dbo.Login_User
						'Silvio'
						,'SomeWrongPassword'
						,@ResponseMessage OUTPUT
						,@SessionToken OUTPUT
	Select @ResponseMessage AS ResponseMessage;
	Select @SessionToken AS SessionToken;

*/

BEGIN
	BEGIN TRY
		IF ((SELECT TOP 1 UserName FROM dbo.Users WHERE UserName = @UserName) IS NOT NULL)
		BEGIN
			DECLARE @Salt UNIQUEIDENTIFIER = (SELECT Salt FROM dbo.Users WHERE UserName = @UserName);
			DECLARE @PasswordHash BINARY(64) = HASHBYTES('SHA2_512',@Password + CAST(@Salt as NVARCHAR(36)));
			IF(@PasswordHash = (SELECT PasswordHash FROM dbo.Users WHERE UserName = @UserName))
			BEGIN
				DECLARE @OriginalSessionToken UNIQUEIDENTIFIER = (SELECT SessionToken FROM dbo.Users WHERE UserName = @UserName);
				IF (@OriginalSessionToken IS NULL OR @OriginalSessionToken != @SessionToken)
				BEGIN
					SET @SessionToken = NEWID();
					UPDATE dbo.Users
						SET SessionToken = @SessionToken
					WHERE UserName = @UserName;
					SET @ResponseMessage = 'Success';
				END
				ELSE
				BEGIN
					SET @ResponseMessage = 'User already logged in';
				END
			END
			ELSE
			BEGIN
				SET @ResponseMessage = 'Incorrect password';
			END
		END
		ELSE
		BEGIN
			SET @ResponseMessage = 'User does not exist';
		END
	END TRY
	BEGIN CATCH
		SET @ResponseMessage = ERROR_MESSAGE();
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Logout_User]    Script Date: 10/8/2024 15:41:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Logout_User]
						@UserName NVARCHAR(50)
						,@ResponseMessage NVARCHAR(MAX) OUTPUT
						,@SessionToken UNIQUEIDENTIFIER

AS

/*
	DECLARE @ResponseMessage NVARCHAR(MAX) = '';
	DECLARE @TestToken UNIQUEIDENTIFIER = NEWID();

	-- Check if user logs out correctly when already logged in.
	
	UPDATE dbo.Users
		SET SessionToken = @TestToken
	WHERE UserName = 'Silvio';
	Select * from dbo.Users WHERE UserName = 'Silvio'
	Execute dbo.Logout_User
						'Silvio'
						,@ResponseMessage OUTPUT
						,@TestToken
	Select @ResponseMessage as ResponseMessage;
	Select * from dbo.Users WHERE UserName = 'Silvio'

	-- Check if the correct message shows when trying to logout an user that doesn't exist

	Set @ResponseMessage = NULL;
	Execute dbo.Logout_User
						'SomeInexistentUser'
						,@ResponseMessage OUTPUT
						,@TestToken
	Select @ResponseMessage as ResponseMessage;

	-- Check if the correct message shows when trying to logout without providing a token.

	Set @ResponseMessage = NULL;
	Execute dbo.Logout_User
						'Silvio'
						,@ResponseMessage OUTPUT
						,NULL
	Select @ResponseMessage as ResponseMessage;

	-- Check if the correct message shows when trying to logout providing a wrong token.

	Set @ResponseMessage = NULL;
	DECLARE @WrongToken UNIQUEIDENTIFIER = NEWID();
	Execute dbo.Logout_User
						'Silvio'
						,@ResponseMessage OUTPUT
						,@WrongToken
	Select @ResponseMessage as ResponseMessage; -- This message should be 'User not logged in', 
												-- because the SessionToken in the record
												-- is null at this point.

	UPDATE dbo.Users
		SET SessionToken = @TestToken
	WHERE UserName = 'Silvio';

	Set @ResponseMessage = NULL;
	Execute dbo.Logout_User
						'Silvio'
						,@ResponseMessage OUTPUT
						,@WrongToken
	Select @ResponseMessage as ResponseMessage; -- This message should be 'Invalid Token'

	UPDATE dbo.Users
		SET SessionToken = NULL
	WHERE UserName = 'Silvio';

	Select * from dbo.Users where UserName = 'Silvio'

*/

BEGIN
	BEGIN TRY
		IF(@SessionToken IS NOT NULL AND @SessionToken != (CAST(CAST(0 AS BINARY) AS UNIQUEIDENTIFIER)))
		BEGIN
			IF ((SELECT TOP 1 1 FROM dbo.Users WHERE UserName = @UserName) IS NOT NULL)
			BEGIN
				IF ((SELECT TOP 1 SessionToken FROM dbo.Users WHERE UserName = @UserName) = @SessionToken)
				BEGIN
					UPDATE dbo.Users
						SET SessionToken = NULL
					WHERE UserName = @UserName;
					SET @ResponseMessage = 'Success';
				END
				ELSE
				BEGIN
						SET @ResponseMessage = 'Token mismatch';
				END
			END
			ELSE
			BEGIN
				SET @ResponseMessage = 'The user does not exist';
			END
		END
		ELSE
		BEGIN
			SET @ResponseMessage = 'Token not provided or invalid';
		END
	END TRY
	BEGIN CATCH
		SET @ResponseMessage = ERROR_MESSAGE();
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Select_ProductsV2]    Script Date: 10/8/2024 15:41:26 ******/
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
USE [master]
GO
ALTER DATABASE [silvioaa_ecom] SET  READ_WRITE 
GO
