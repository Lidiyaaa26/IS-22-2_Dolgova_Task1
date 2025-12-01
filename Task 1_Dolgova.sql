USE [master]
GO
/****** Object:  Database [Task 1_Dolgova]    Script Date: 01.12.2025 13:37:32 ******/
CREATE DATABASE [Task 1_Dolgova]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Task 1_Dolgova', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\Task 1_Dolgova.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Task 1_Dolgova_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\Task 1_Dolgova_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Task 1_Dolgova] SET COMPATIBILITY_LEVEL = 170
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Task 1_Dolgova].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Task 1_Dolgova] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Task 1_Dolgova] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Task 1_Dolgova] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Task 1_Dolgova] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Task 1_Dolgova] SET ARITHABORT OFF 
GO
ALTER DATABASE [Task 1_Dolgova] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Task 1_Dolgova] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Task 1_Dolgova] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Task 1_Dolgova] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Task 1_Dolgova] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Task 1_Dolgova] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Task 1_Dolgova] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Task 1_Dolgova] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Task 1_Dolgova] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Task 1_Dolgova] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Task 1_Dolgova] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Task 1_Dolgova] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Task 1_Dolgova] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Task 1_Dolgova] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Task 1_Dolgova] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Task 1_Dolgova] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Task 1_Dolgova] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Task 1_Dolgova] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Task 1_Dolgova] SET  MULTI_USER 
GO
ALTER DATABASE [Task 1_Dolgova] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Task 1_Dolgova] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Task 1_Dolgova] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Task 1_Dolgova] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Task 1_Dolgova] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Task 1_Dolgova] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Task 1_Dolgova] SET OPTIMIZED_LOCKING = OFF 
GO
ALTER DATABASE [Task 1_Dolgova] SET QUERY_STORE = ON
GO
ALTER DATABASE [Task 1_Dolgova] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Task 1_Dolgova]
GO
/****** Object:  Table [dbo].[Material]    Script Date: 01.12.2025 13:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Material](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NULL,
	[MaterialType] [int] NULL,
 CONSTRAINT [PK_Material] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MaterialsInProducts]    Script Date: 01.12.2025 13:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaterialsInProducts](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Material] [int] NULL,
	[Product] [int] NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK_MaterialsInProducts] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MaterialType]    Script Date: 01.12.2025 13:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaterialType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[PercentageOfDefectiveMaterials] [decimal](18, 2) NULL,
 CONSTRAINT [PK_MaterialType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Partner]    Script Date: 01.12.2025 13:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Partner](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PartnerType] [int] NULL,
	[Name] [nvarchar](75) NULL,
	[Director] [nvarchar](100) NULL,
	[Email] [nvarchar](50) NULL,
	[Phone] [nvarchar](20) NULL,
	[LegalAddress] [nvarchar](200) NULL,
	[INN] [nvarchar](12) NULL,
	[Rating] [int] NULL,
 CONSTRAINT [PK_Partner] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PartnerProducts]    Script Date: 01.12.2025 13:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PartnerProducts](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Product] [int] NULL,
	[Partner] [int] NULL,
	[QuantityOfProducts] [int] NULL,
 CONSTRAINT [PK_PartnerProducts] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PartnerType]    Script Date: 01.12.2025 13:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PartnerType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](15) NULL,
 CONSTRAINT [PK_PartnerType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 01.12.2025 13:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductType] [int] NULL,
	[Name] [nvarchar](200) NULL,
	[Item] [int] NULL,
	[MinimumPriceForPartner] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductType]    Script Date: 01.12.2025 13:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](75) NULL,
	[ProductTypeFactor] [decimal](18, 2) NULL,
 CONSTRAINT [PK_ProductType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[MaterialType] ON 
GO
INSERT [dbo].[MaterialType] ([ID], [Name], [PercentageOfDefectiveMaterials]) VALUES (1, N'Тип материала 1', CAST(0.20 AS Decimal(18, 2)))
GO
INSERT [dbo].[MaterialType] ([ID], [Name], [PercentageOfDefectiveMaterials]) VALUES (2, N'Тип материала 2', CAST(0.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[MaterialType] ([ID], [Name], [PercentageOfDefectiveMaterials]) VALUES (3, N'Тип материала 3', CAST(0.30 AS Decimal(18, 2)))
GO
INSERT [dbo].[MaterialType] ([ID], [Name], [PercentageOfDefectiveMaterials]) VALUES (4, N'Тип материала 4', CAST(0.15 AS Decimal(18, 2)))
GO
INSERT [dbo].[MaterialType] ([ID], [Name], [PercentageOfDefectiveMaterials]) VALUES (5, N'Тип материала 5', CAST(0.18 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[MaterialType] OFF
GO
SET IDENTITY_INSERT [dbo].[Partner] ON 
GO
INSERT [dbo].[Partner] ([ID], [PartnerType], [Name], [Director], [Email], [Phone], [LegalAddress], [INN], [Rating]) VALUES (1, 1, N'Стройдвор', N'Андреева Ангелина Николаевна', N'angelina7237@kart.ru', N'+7 (492) 452 22 82', N'143001, Московская область, город Одинцово, уд. Ленина, 21', N'9432455179', 5)
GO
INSERT [dbo].[Partner] ([ID], [PartnerType], [Name], [Director], [Email], [Phone], [LegalAddress], [INN], [Rating]) VALUES (2, 1, N'Самоделка', N'Мельников Максим Петрович', N'melnikov.maksim88@hm.ru', N'+7 (812) 267 19 59', N'306230, Курская область, город Обоянь, ул. 1 Мая, 89', N'7803888520', 3)
GO
INSERT [dbo].[Partner] ([ID], [PartnerType], [Name], [Director], [Email], [Phone], [LegalAddress], [INN], [Rating]) VALUES (3, 2, N'Деревянные изделия
', N'Лазарев Алексей Сергеевич
', N'aleksejlazarev@al.ru
', N'+7 (922) 467 93 83
', N'238340, Калининградская область, город Светлый, ул. Морская, 12
', N'8430391035
', 4)
GO
INSERT [dbo].[Partner] ([ID], [PartnerType], [Name], [Director], [Email], [Phone], [LegalAddress], [INN], [Rating]) VALUES (4, 2, N'Декор и отделка
', N'Саншокова Мадина Муратовна
', N'mmsanshokova@lss.ru
', N'+7 (413) 230 30 79
', N'685000, Магаданская область, город Магадан, ул. Горького, 15
', N'4318170454
', 7)
GO
INSERT [dbo].[Partner] ([ID], [PartnerType], [Name], [Director], [Email], [Phone], [LegalAddress], [INN], [Rating]) VALUES (5, 2, N'Паркет
', N'Иванов Дмитрий Сергеевич
', N'ivanov.dmitrij@mail.ru
', N'+7 (921) 851 21 22
', N'606440, Нижегородская область, город Бор, ул. Свободы, 3
', N'7687851800
', 7)
GO
INSERT [dbo].[Partner] ([ID], [PartnerType], [Name], [Director], [Email], [Phone], [LegalAddress], [INN], [Rating]) VALUES (6, 3, N'Дом и сад
', N'Аникеева Екатерина Алексеевна
', N'ekaterina.anikeeva@ml.ru
', N'+7 (499) 936 29 26
', N'393760, Тамбовская область, город Мичуринск, ул. Красная, 50
', N'6119144874
', 7)
GO
INSERT [dbo].[Partner] ([ID], [PartnerType], [Name], [Director], [Email], [Phone], [LegalAddress], [INN], [Rating]) VALUES (7, 4, N'Легкий шаг', N'Богданова Ксения Владимировна
', N'bogdanova.kseniya@bkv.ru
', N'+7 (495) 445 61 41
', N'307370, Курская область, город Рыльск, ул. Гагарина, 16
', N'1122170258
', 6)
GO
INSERT [dbo].[Partner] ([ID], [PartnerType], [Name], [Director], [Email], [Phone], [LegalAddress], [INN], [Rating]) VALUES (8, 3, N'СтройМатериалы
', N'Холодова Валерия Борисовна
', N'holodova@education.ru
', N'+7 (499) 234 56 78
', N'140300, Московская область, город Егорьевск, ул. Советская, 24
', N'8355114917
', 5)
GO
INSERT [dbo].[Partner] ([ID], [PartnerType], [Name], [Director], [Email], [Phone], [LegalAddress], [INN], [Rating]) VALUES (9, 4, N'Мир отделки
', N'Крылов Савелий Тимофеевич
', N'stkrylov@mail.ru
', N'+7 (908) 713 51 88
', N'344116, Ростовская область, город Ростов-на-Дону, ул. Артиллерийская, 4
', N'3532367439
', 8)
GO
INSERT [dbo].[Partner] ([ID], [PartnerType], [Name], [Director], [Email], [Phone], [LegalAddress], [INN], [Rating]) VALUES (10, 4, N'Технологии комфорта
', N'Белов Кирилл Александрович
', N'kirill_belov@kir.ru
', N'+7 (918) 432 12 34
', N'164500, Архангельская область, город Северодвинск, ул. Ломоносова, 29
', N'2362431140
', 4)
GO
INSERT [dbo].[Partner] ([ID], [PartnerType], [Name], [Director], [Email], [Phone], [LegalAddress], [INN], [Rating]) VALUES (11, 3, N'Твой дом
', N'Демидов Дмитрий Александрович
', N'dademidov@ml.ru
', N'+7 (9190 698 75 43
', N'354000, Краснодарский край, город Сочи, ул. Больничная, 11
', N'4159215346
', 10)
GO
INSERT [dbo].[Partner] ([ID], [PartnerType], [Name], [Director], [Email], [Phone], [LegalAddress], [INN], [Rating]) VALUES (12, 1, N'Новые краски
', N'Алиев Дамир Игоревич
', N'alievdamir@tk.ru
', N'+7 (812) 823 93 42
', N'187556, Ленинградская область, город Тихвин, ул. Гоголя, 18
', N'9032455179
', 9)
GO
INSERT [dbo].[Partner] ([ID], [PartnerType], [Name], [Director], [Email], [Phone], [LegalAddress], [INN], [Rating]) VALUES (13, 4, N'Политехник
', N'Котов Михаил Михайлович
', N'mmkotov56@educat.ru
', N'+7 (495) 895 71 77
', N'143960, Московская область, город Реутов, ул. Новая, 55
', N'3776671267
', 5)
GO
INSERT [dbo].[Partner] ([ID], [PartnerType], [Name], [Director], [Email], [Phone], [LegalAddress], [INN], [Rating]) VALUES (14, 4, N'СтройАрсенал
', N'Семенов Дмитрий Максимович
', N'semenov.dm@mail.ru
', N'+7 (896) 123 45 56
', N'242611, Брянская область, город Фокино, ул. Фокино, 23
', N'7447864518
', 5)
GO
INSERT [dbo].[Partner] ([ID], [PartnerType], [Name], [Director], [Email], [Phone], [LegalAddress], [INN], [Rating]) VALUES (15, 3, N'Декор и порядок
', N'Болотов Артем Игоревич
', N'artembolotov@ab.ru
', N'+7 (950) 234 12 12
', N'309500, Белгородская область, город Старый Оскол, ул. Цветочная, 20
', N'9037040523
', 5)
GO
INSERT [dbo].[Partner] ([ID], [PartnerType], [Name], [Director], [Email], [Phone], [LegalAddress], [INN], [Rating]) VALUES (16, 3, N'Умные решения
', N'Воронова Анастасия Валерьевна
', N'voronova_anastasiya@mail.ru
', N'+7 (923) 233 27 69
', N'652050, Кемеровская область, город Юрга, ул. Мира, 42
', N'6221520857
', 4)
GO
INSERT [dbo].[Partner] ([ID], [PartnerType], [Name], [Director], [Email], [Phone], [LegalAddress], [INN], [Rating]) VALUES (17, 1, N'Натуральные покрытия
', N'Горбунов Василий Петрович
', N'vpgorbunov24@vvs.ru
', N'+7 (902) 688 28 96
', N'188300, Ленинградская область, город Гатчина, пр. 25 Октября, 17
', N'2262431140
', 9)
GO
INSERT [dbo].[Partner] ([ID], [PartnerType], [Name], [Director], [Email], [Phone], [LegalAddress], [INN], [Rating]) VALUES (18, 2, N'СтройМастер
', N'Смирнов Иван Андреевич
', N'smirnov_ivan@kv.ru
', N'+7 (917) 234 75 55
', N'184250, Мурманская область, город Кировск, пр. Ленина, 24
', N'4155215346
', 9)
GO
INSERT [dbo].[Partner] ([ID], [PartnerType], [Name], [Director], [Email], [Phone], [LegalAddress], [INN], [Rating]) VALUES (19, 2, N'Гранит
', N'Джумаев Ахмед Умарович
', N'dzhumaev.ahmed@amail.ru
', N'+7 (495) 452 55 95
', N'162390, Вологодская область, город Великий Устюг, ул. Железнодорожная, 36
', N'3961234561
', 5)
GO
INSERT [dbo].[Partner] ([ID], [PartnerType], [Name], [Director], [Email], [Phone], [LegalAddress], [INN], [Rating]) VALUES (20, 1, N'Строитель
', N'Петров Николай Тимофеевич
', N'petrov.nikolaj31@mail.ru
', N'+7 (916) 596 15 55
', N'188910, Ленинградская область, город Приморск, ш. Приморское, 18
', N'9600275878
', 10)
GO
INSERT [dbo].[Partner] ([ID], [PartnerType], [Name], [Director], [Email], [Phone], [LegalAddress], [INN], [Rating]) VALUES (21, 1, N'ваыва', N'ываыв', N'ыва', N'ываыв', N'ываывв', NULL, 0)
GO
INSERT [dbo].[Partner] ([ID], [PartnerType], [Name], [Director], [Email], [Phone], [LegalAddress], [INN], [Rating]) VALUES (22, 1, N'sdf', N'sdf', N'dsdfs@gmail.com', N'+7 (999) 999 99 99', N'sdf', N'1231231231', 12)
GO
SET IDENTITY_INSERT [dbo].[Partner] OFF
GO
SET IDENTITY_INSERT [dbo].[PartnerProducts] ON 
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (2, 5, 2, 3000)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (3, 1, 3, 1000)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (4, 3, 4, 9500)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (5, 1, 5, 2000)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (6, 18, 6, 1100)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (7, 12, 7, 5000)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (8, 1, 8, 2500)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (9, 2, 9, 6000)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (10, 6, 10, 7000)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (11, 4, 11, 5000)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (12, 4, 12, 7500)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (13, 1, 13, 3000)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (14, 18, 14, 500)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (15, 16, 15, 7000)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (16, 9, 16, 4000)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (17, 1, 17, 3500)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (18, 1, 18, 7900)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (19, 15, 19, 9600)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (20, 15, 20, 1200)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (22, 8, 2, 3000)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (23, 2, 3, 3010)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (24, 7, 4, 3020)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (25, 5, 5, 3050)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (26, 14, 6, 3040)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (27, 19, 7, 3050)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (28, 4, 8, 3060)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (29, 18, 9, 3070)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (30, 9, 10, 5400)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (31, 12, 11, 5500)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (32, 11, 12, 5600)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (33, 9, 13, 5700)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (34, 14, 14, 5800)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (35, 2, 15, 5900)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (36, 12, 16, 6000)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (37, 6, 17, 6100)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (38, 9, 18, 8000)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (39, 3, 19, 7060)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (40, 17, 20, 6120)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (41, 15, 1, 5180)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (42, 10, 2, 4240)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (43, 10, 3, 3300)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (44, 10, 4, 2360)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (45, 8, 5, 1420)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (46, 11, 6, 1500)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (47, 5, 7, 1700)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (48, 12, 8, 1900)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (49, 15, 9, 2100)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (50, 12, 10, 2300)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (51, 8, 11, 2500)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (52, 15, 12, 2700)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (53, 12, 13, 2900)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (54, 1, 14, 3100)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (55, 18, 15, 3300)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (56, 20, 16, 3500)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (57, 10, 17, 3750)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (58, 14, 18, 6700)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (59, 7, 19, 6950)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (60, 11, 20, 7200)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (61, 17, 1, 7450)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (62, 19, 2, 7700)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (63, 20, 3, 7950)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (64, 8, 4, 8200)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (65, 10, 5, 8450)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (66, 7, 6, 8700)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (67, 8, 7, 8950)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (68, 20, 8, 9200)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (69, 4, 9, 1300)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (70, 16, 10, 1500)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (71, 16, 11, 1700)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (72, 12, 12, 1900)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (73, 20, 13, 2100)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (74, 9, 14, 2300)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (75, 13, 15, 2500)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (76, 13, 16, 2700)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (77, 12, 17, 2900)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (78, 3, 18, 3100)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (79, 14, 19, 3300)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (80, 18, 20, 3500)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (83, 1, 1, 100)
GO
INSERT [dbo].[PartnerProducts] ([ID], [Product], [Partner], [QuantityOfProducts]) VALUES (84, 8, 1, 5)
GO
SET IDENTITY_INSERT [dbo].[PartnerProducts] OFF
GO
SET IDENTITY_INSERT [dbo].[PartnerType] ON 
GO
INSERT [dbo].[PartnerType] ([ID], [Name]) VALUES (1, N'ЗАО')
GO
INSERT [dbo].[PartnerType] ([ID], [Name]) VALUES (2, N'ООО')
GO
INSERT [dbo].[PartnerType] ([ID], [Name]) VALUES (3, N'ПАО')
GO
INSERT [dbo].[PartnerType] ([ID], [Name]) VALUES (4, N'ОАО')
GO
SET IDENTITY_INSERT [dbo].[PartnerType] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 
GO
INSERT [dbo].[Product] ([ID], [ProductType], [Name], [Item], [MinimumPriceForPartner]) VALUES (1, 1, N'Фанера ФСФ 1800х1200х27 мм бежевая береза', 6549922, CAST(5100.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Product] ([ID], [ProductType], [Name], [Item], [MinimumPriceForPartner]) VALUES (2, 2, N'Мягкие панели прямоугольник велюр цвет оливковый 600х300х35 мм', 7018556, CAST(1880.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Product] ([ID], [ProductType], [Name], [Item], [MinimumPriceForPartner]) VALUES (3, 4, N'Бетонная плитка Белый кирпич микс 30х7,3 см', 5028272, CAST(2080.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Product] ([ID], [ProductType], [Name], [Item], [MinimumPriceForPartner]) VALUES (4, 3, N'Плитка Мозаика 10x10 см цвет белый глянец', 8028248, CAST(2500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Product] ([ID], [ProductType], [Name], [Item], [MinimumPriceForPartner]) VALUES (5, 5, N'Ламинат Дуб Античный серый 32 класс толщина 8 мм с фаской', 9250282, CAST(4050.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Product] ([ID], [ProductType], [Name], [Item], [MinimumPriceForPartner]) VALUES (6, 2, N'Стеновая панель МДФ Флора 1440x500x10 мм', 7130981, CAST(2100.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Product] ([ID], [ProductType], [Name], [Item], [MinimumPriceForPartner]) VALUES (7, 4, N'Бетонная плитка Красный кирпич 20x6,5 см', 5029784, CAST(2760.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Product] ([ID], [ProductType], [Name], [Item], [MinimumPriceForPartner]) VALUES (8, 5, N'Ламинат Канди Дизайн 33 класс толщина 8 мм с фаской', 9658953, CAST(3200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Product] ([ID], [ProductType], [Name], [Item], [MinimumPriceForPartner]) VALUES (9, 1, N'Плита ДСП 11 мм влагостойкая 594x1815 мм', 6026662, CAST(497.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Product] ([ID], [ProductType], [Name], [Item], [MinimumPriceForPartner]) VALUES (10, 5, N'Ламинат с натуральным шпоном Дуб Эксперт толщина 6 мм с фаской', 9159043, CAST(3750.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Product] ([ID], [ProductType], [Name], [Item], [MinimumPriceForPartner]) VALUES (11, 3, N'Плитка настенная Формат 20x40 см матовая цвет мята', 8588376, CAST(2500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Product] ([ID], [ProductType], [Name], [Item], [MinimumPriceForPartner]) VALUES (12, 1, N'Плита ДСП Кантри 16 мм 900x1200 мм', 6758375, CAST(1050.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Product] ([ID], [ProductType], [Name], [Item], [MinimumPriceForPartner]) VALUES (13, 2, N'Стеновая панель МДФ Сосна Полярная 60х280х4мсм цвет коричневый', 7759324, CAST(1700.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Product] ([ID], [ProductType], [Name], [Item], [MinimumPriceForPartner]) VALUES (14, 4, N'Клинкерная плитка коричневая 29,8х29,8 см', 5118827, CAST(860.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Product] ([ID], [ProductType], [Name], [Item], [MinimumPriceForPartner]) VALUES (15, 3, N'Плитка настенная Цветок 60x120 см цвет зелено-голубой', 8559898, CAST(2300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Product] ([ID], [ProductType], [Name], [Item], [MinimumPriceForPartner]) VALUES (16, 2, N'Пробковое настенное покрытие 600х300х3 мм белый ', 7259474, CAST(3300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Product] ([ID], [ProductType], [Name], [Item], [MinimumPriceForPartner]) VALUES (17, 3, N'Плитка настенная Нева 30x60 см цвет серый', 8115947, CAST(1700.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Product] ([ID], [ProductType], [Name], [Item], [MinimumPriceForPartner]) VALUES (18, 4, N'Гипсовая плитка настенная Дом на берегу кирпич белый 18,5х4,5 см', 5033136, CAST(499.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Product] ([ID], [ProductType], [Name], [Item], [MinimumPriceForPartner]) VALUES (19, 5, N'Ламинат Дуб Северный белый 32 класс толщина 8 мм с фаской', 9028048, CAST(2550.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Product] ([ID], [ProductType], [Name], [Item], [MinimumPriceForPartner]) VALUES (20, 1, N'Дерево волокнистая плита Дуб Винтаж 1200х620х3 мм светло-коричневый', 6123459, CAST(900.00 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductType] ON 
GO
INSERT [dbo].[ProductType] ([ID], [Name], [ProductTypeFactor]) VALUES (1, N'Древесно-плитные материалы
', CAST(1.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[ProductType] ([ID], [Name], [ProductTypeFactor]) VALUES (2, N'Декоративные панели
', CAST(3.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[ProductType] ([ID], [Name], [ProductTypeFactor]) VALUES (3, N'Плитка
', CAST(5.25 AS Decimal(18, 2)))
GO
INSERT [dbo].[ProductType] ([ID], [Name], [ProductTypeFactor]) VALUES (4, N'Фасадные материалы
', CAST(4.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[ProductType] ([ID], [Name], [ProductTypeFactor]) VALUES (5, N'Напольные покрытия
', CAST(2.17 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[ProductType] OFF
GO
ALTER TABLE [dbo].[Material]  WITH CHECK ADD  CONSTRAINT [FK_Material_MaterialType] FOREIGN KEY([MaterialType])
REFERENCES [dbo].[MaterialType] ([ID])
GO
ALTER TABLE [dbo].[Material] CHECK CONSTRAINT [FK_Material_MaterialType]
GO
ALTER TABLE [dbo].[MaterialsInProducts]  WITH CHECK ADD  CONSTRAINT [FK_MaterialsInProducts_Material] FOREIGN KEY([Material])
REFERENCES [dbo].[Material] ([ID])
GO
ALTER TABLE [dbo].[MaterialsInProducts] CHECK CONSTRAINT [FK_MaterialsInProducts_Material]
GO
ALTER TABLE [dbo].[MaterialsInProducts]  WITH CHECK ADD  CONSTRAINT [FK_MaterialsInProducts_Product] FOREIGN KEY([Product])
REFERENCES [dbo].[Product] ([ID])
GO
ALTER TABLE [dbo].[MaterialsInProducts] CHECK CONSTRAINT [FK_MaterialsInProducts_Product]
GO
ALTER TABLE [dbo].[Partner]  WITH CHECK ADD  CONSTRAINT [FK_Partner_PartnerType] FOREIGN KEY([PartnerType])
REFERENCES [dbo].[PartnerType] ([ID])
GO
ALTER TABLE [dbo].[Partner] CHECK CONSTRAINT [FK_Partner_PartnerType]
GO
ALTER TABLE [dbo].[PartnerProducts]  WITH CHECK ADD  CONSTRAINT [FK_PartnerProducts_Partner] FOREIGN KEY([Partner])
REFERENCES [dbo].[Partner] ([ID])
GO
ALTER TABLE [dbo].[PartnerProducts] CHECK CONSTRAINT [FK_PartnerProducts_Partner]
GO
ALTER TABLE [dbo].[PartnerProducts]  WITH CHECK ADD  CONSTRAINT [FK_PartnerProducts_Product] FOREIGN KEY([Product])
REFERENCES [dbo].[Product] ([ID])
GO
ALTER TABLE [dbo].[PartnerProducts] CHECK CONSTRAINT [FK_PartnerProducts_Product]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductType] FOREIGN KEY([ProductType])
REFERENCES [dbo].[ProductType] ([ID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_ProductType]
GO
USE [master]
GO
ALTER DATABASE [Task 1_Dolgova] SET  READ_WRITE 
GO
