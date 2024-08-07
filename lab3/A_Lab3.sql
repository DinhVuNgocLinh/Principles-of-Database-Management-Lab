USE [master]
GO
/****** Object:  Database [ApressFinancial]    Script Date: 10/21/2023 12:27:40 PM ******/
CREATE DATABASE [ApressFinancial]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ApressFinancial', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\ApressFinancial.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ApressFinancial_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\ApressFinancial_log.ldf' , SIZE = 1072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ApressFinancial] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ApressFinancial].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ApressFinancial] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ApressFinancial] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ApressFinancial] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ApressFinancial] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ApressFinancial] SET ARITHABORT OFF 
GO
ALTER DATABASE [ApressFinancial] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [ApressFinancial] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ApressFinancial] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ApressFinancial] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ApressFinancial] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ApressFinancial] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ApressFinancial] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ApressFinancial] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ApressFinancial] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ApressFinancial] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ApressFinancial] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ApressFinancial] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ApressFinancial] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ApressFinancial] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ApressFinancial] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ApressFinancial] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ApressFinancial] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ApressFinancial] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ApressFinancial] SET  MULTI_USER 
GO
ALTER DATABASE [ApressFinancial] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ApressFinancial] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ApressFinancial] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ApressFinancial] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [ApressFinancial] SET DELAYED_DURABILITY = DISABLED 
GO
USE [ApressFinancial]
GO
/****** Object:  Schema [CustomerDetails]    Script Date: 10/21/2023 12:27:41 PM ******/
CREATE SCHEMA [CustomerDetails]
GO
/****** Object:  Schema [ShareDetails]    Script Date: 10/21/2023 12:27:41 PM ******/
CREATE SCHEMA [ShareDetails]
GO
/****** Object:  Schema [TransactionDetails]    Script Date: 10/21/2023 12:27:41 PM ******/
CREATE SCHEMA [TransactionDetails]
GO
/****** Object:  Table [CustomerDetails].[CustomerProducts]    Script Date: 10/21/2023 12:27:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CustomerDetails].[CustomerProducts](
	[CustomerFinancialProductId] [bigint] NOT NULL,
	[CustomerId] [bigint] NOT NULL,
	[FinancialProductId] [bigint] NOT NULL,
	[AmountToCollect] [money] NOT NULL,
	[Frequency] [smallint] NOT NULL,
	[LastCollected] [datetime] NOT NULL,
	[LastCollection] [datetime] NOT NULL,
	[Renewable] [bit] NOT NULL,
 CONSTRAINT [PK_CustomerProducts] PRIMARY KEY CLUSTERED 
(
	[CustomerFinancialProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [CustomerDetails].[Customers]    Script Date: 10/21/2023 12:27:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CustomerDetails].[Customers](
	[CustomerId] [bigint] IDENTITY(1,1) NOT NULL,
	[CustomerTitleId] [int] NOT NULL,
	[CustomerFirstName] [nvarchar](50) NOT NULL,
	[CustomerOtherInitials] [nvarchar](50) NULL,
	[CustomerLastName] [nvarchar](50) NOT NULL,
	[AddressId] [bigint] NOT NULL,
	[AccountNumber] [nvarchar](15) NOT NULL,
	[AccountTypeId] [int] NOT NULL,
	[ClearedBalance] [money] NOT NULL,
	[UnclearedBalance] [money] NOT NULL,
	[DateAddedd] [datetime] NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY NONCLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [CustomerDetails].[FinancialProducts]    Script Date: 10/21/2023 12:27:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CustomerDetails].[FinancialProducts](
	[ProductId] [bigint] NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustTemp]    Script Date: 10/21/2023 12:27:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustTemp](
	[Name] [nvarchar](101) NOT NULL,
	[ClearedBalance] [money] NOT NULL,
	[UnclearedBalance] [money] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[New_Table_Test]    Script Date: 10/21/2023 12:27:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[New_Table_Test](
	[ShareTickerId] [nvarchar](50) NULL,
	[CurrentPrice] [numeric](18, 5) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ShareDetails].[SharePrices]    Script Date: 10/21/2023 12:27:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ShareDetails].[SharePrices](
	[SharePriceId] [bigint] IDENTITY(1,1) NOT NULL,
	[ShareId] [bigint] NOT NULL,
	[Price] [numeric](18, 5) NOT NULL,
	[PriceDate] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ShareDetails].[Shares]    Script Date: 10/21/2023 12:27:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ShareDetails].[Shares](
	[ShareId] [bigint] IDENTITY(1,1) NOT NULL,
	[ShareDesc] [nvarchar](50) NOT NULL,
	[ShareTickerId] [nvarchar](50) NULL,
	[CurrentPrice] [numeric](18, 5) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [TransactionDetails].[Transactions]    Script Date: 10/21/2023 12:27:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [TransactionDetails].[Transactions](
	[TransactionId] [bigint] IDENTITY(1,1) NOT NULL,
	[CustomerId] [bigint] NOT NULL,
	[TransactionType] [int] NOT NULL,
	[DateEntered] [datetime] NOT NULL,
	[Amount] [numeric](18, 5) NOT NULL,
	[ReferenceDetails] [nvarchar](50) NULL,
	[Notes] [nvarchar](max) NULL,
	[RelatedShareId] [bigint] NULL,
	[RelatedProductId] [bigint] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [TransactionDetails].[TransactionTypes]    Script Date: 10/21/2023 12:27:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [TransactionDetails].[TransactionTypes](
	[TransactionTypeId] [int] IDENTITY(1,1) NOT NULL,
	[TransactionDescription] [nvarchar](30) NOT NULL,
	[CreditType] [bit] NOT NULL,
	[AffectCashBalance] [bit] NOT NULL
) ON [PRIMARY]

GO
ALTER TABLE [CustomerDetails].[CustomerProducts] ADD  CONSTRAINT [DF_CustProd_Renewable]  DEFAULT ((0)) FOR [Renewable]
GO
ALTER TABLE [CustomerDetails].[CustomerProducts]  WITH CHECK ADD  CONSTRAINT [FK_Customers_CustomerProducts] FOREIGN KEY([CustomerId])
REFERENCES [CustomerDetails].[Customers] ([CustomerId])
GO
ALTER TABLE [CustomerDetails].[CustomerProducts] CHECK CONSTRAINT [FK_Customers_CustomerProducts]
GO
ALTER TABLE [TransactionDetails].[Transactions]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Transactions] FOREIGN KEY([CustomerId])
REFERENCES [CustomerDetails].[Customers] ([CustomerId])
GO
ALTER TABLE [TransactionDetails].[Transactions] CHECK CONSTRAINT [FK_Customers_Transactions]
GO
ALTER TABLE [CustomerDetails].[CustomerProducts]  WITH NOCHECK ADD  CONSTRAINT [CK_CustProds_AmtCheck] CHECK  (([AmountToCollect]>(0)))
GO
ALTER TABLE [CustomerDetails].[CustomerProducts] CHECK CONSTRAINT [CK_CustProds_AmtCheck]
GO
ALTER TABLE [CustomerDetails].[CustomerProducts]  WITH CHECK ADD  CONSTRAINT [CK_CustProds_LastCol] CHECK  (([LastCollection]>=[LastCollected]))
GO
ALTER TABLE [CustomerDetails].[CustomerProducts] CHECK CONSTRAINT [CK_CustProds_LastCol]
GO
USE [master]
GO
ALTER DATABASE [ApressFinancial] SET  READ_WRITE 
GO
