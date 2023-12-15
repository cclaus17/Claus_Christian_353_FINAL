
create database WeatherData;
go


use WeatherData;
go
--table to store information about cities
create table Cities (
    CityID int primary key,
    CityName varchar(100) NOT NULL,
    Country varchar(50),
    Region varchar(50),
    Population int,
    Latitude decimal(9, 6),
    Longitude decimal(9, 6)
);
go

--table to store average temperature data per month
create table AverageTemperature (
    TemperatureID int primary key,
    CityID int,
    Month int,
    AverageTemp decimal(5, 2),
    foreign key (CityID) references Cities(CityID)
);
GO
-- Create a table to store average precipitation data per month
create table AveragePrecipitation (
    PrecipitationID int primary key,
    CityID int,
    Month int,
    AveragePrecipitation decimal(5, 2),
    foreign key (CityID) references Cities(CityID)
);
go
--table to store sunny days data per year
create table SunnyDays (
    SunnyDaysID int primary key,
    CityID int,
    Year int,
    SunnyDaysCount int,
    foreign key (CityID) references Cities(CityID)
);
go

--This is where I create some stored procedures

-- Create a stored procedure to filter cities by average temperature and month
create or alter proc FilterCitiesByTemperatureAndMonth
    @MinTemp decimal(5, 2),
    @MaxTemp decimal(5, 2),
    @Month int
as
begin
    select 
        Cities.CityID,
        Cities.CityName,
        Cities.Country,
        Cities.Region,
        Cities.Population,
        Cities.Latitude,
        Cities.Longitude,
        AverageTemperature.Month,
        AverageTemperature.AverageTemp
    from
        Cities
    inner join
        AverageTemperature on Cities.CityID = AverageTemperature.CityID
    where
        AverageTemperature.AverageTemp between @MinTemp and @MaxTemp
        and AverageTemperature.Month = @Month;
end;
go

exec FilterCitiesByTemperatureAndMonth @MinTemp =60, @MaxTemp = 80, @Month = 12;
go

use WeatherData
go

create table SearchHistory (
    SearchId int primary key identity(1,1),
    UserId nvarchar(128),
    SearchDate datetime,
    MinTemperature decimal(5, 2),
    MaxTemperature decimal(5, 2),
    SelectedMonth int,
);
go

use WeatherData
go

select * from dbo.AspNetUsers
go

-- Add UserName column to SearchHistory table
ALTER TABLE SearchHistory
ADD UserName NVARCHAR(256);

-- Update existing records to have valid UserId values
UPDATE sh
SET sh.UserId = u.UserName
FROM SearchHistory sh
JOIN dbo.AspNetUsers u ON sh.UserId = u.UserName
WHERE sh.UserId IS NOT NULL AND u.UserName IS NOT NULL;
go


ALTER TABLE SearchHistory
ALTER COLUMN UserId nvarchar(256);
go


select * from SearchHistory
go

create or alter proc TrackSearch
    @UserName nvarchar(128),
    @MinTemperature decimal(5, 2),
    @MaxTemperature decimal(5, 2),
    @Month int
as
begin
    insert into SearchHistory (UserName, MinTemperature, MaxTemperature, SelectedMonth, SearchDate)
    values (@UserName, @MinTemperature, @MaxTemperature, @Month, GETDATE());
end;
go

drop proc TrackSearch
go

select * from SearchHistory
go




use WeatherData
go





use WeatherData
go


--Using 10 random cities currently. I will continue to add more as I progress through A5.
insert into Cities (CityID, CityName, Country, Region, Population, Latitude, Longitude)
values 
    (101, 'New York', 'United States', 'Northeast', 8398748, 40.7128, -74.0060),
    (102, 'Los Angeles', 'United States', 'West', 3990456, 34.0522, -118.2437),
    (103, 'Chicago', 'United States', 'Midwest', 2705994, 41.8781, -87.6298),
    (104, 'Houston', 'United States', 'South', 2325502, 29.7604, -95.3698),
    (105, 'Phoenix', 'United States', 'West', 1680992, 33.4484, -112.0740),
    (106, 'Philadelphia', 'United States', 'Northeast', 1584064, 39.9526, -75.1652),
    (107, 'San Antonio', 'United States', 'South', 1547253, 29.4241, -98.4936),
    (108, 'San Diego', 'United States', 'West', 1423851, 32.7157, -117.1611),
    (109, 'Dallas', 'United States', 'South', 1343573, 32.7767, -96.7970),
    (110, 'San Jose', 'United States', 'West', 1030119, 37.3382, -121.8863);
	go

	insert into AveragePrecipitation (PrecipitationID, CityID, Month, AveragePrecipitation)
	values
	(01, 101, 01, 3.61), 
	(012, 101, 02, 3.68),
	(013, 101, 03, 4.03),
	(014, 101, 04, 4.45),
	(015, 101, 05, 4.89),
	(016, 101, 06, 5.14),
	(017, 101, 07, 4.99),
	(018, 101, 08, 5.05),
	(019, 101, 09, 3.62),
	(010, 101, 10, 4.57),
	(1011, 101, 11, 3.51),
	(1012, 101, 12, 5.14),
	(020, 102, 01, 3.14),
	(021, 102, 02, 2.56),
	(022, 102, 03, 2.14),
	(024, 102, 04, 0.71),
	(025, 102, 05, 0.39),
	(026, 102, 06, 0.02),
	(027, 102, 07, 0.04),
	(028, 102, 08, 0.00),
	(029, 102, 09, 0.25),
	(2020, 102, 10, 0.61),
	(0201, 102, 11, 0.91),
	(0202, 102, 12, 3.01),
	(031, 103, 01, 2.24),
    (032, 103, 02, 2.45),
    (033, 103, 03, 2.88),
    (034, 103, 04, 4.57),
    (035, 103, 05, 5.43),
    (036, 103, 06, 5.10),
    (037, 103, 07, 4.56),
    (038, 103, 08, 4.44),
    (039, 103, 09, 3.51),
    (030, 103, 10, 4.71),
    (0301, 103, 11, 2.36),
    (0302, 103, 12, 2.76),
	(041, 104, 01, 3.51),
    (042, 104, 02, 2.41),
    (043, 104, 03, 3.29),
    (044, 104, 04, 4.20),
    (045, 104, 05, 5.30),
    (046, 104, 06, 5.29),
    (047, 104, 07, 4.78),
    (048, 104, 08, 5.91),
    (049, 104, 09, 5.18),
    (040, 104, 10, 5.85),
    (0401, 104, 11, 2.62),
    (0402, 104, 12, 3.63),
	(051, 105, 01, 0.88),
    (052, 105, 02, 0.76),
    (053, 105, 03, 0.69),
    (054, 105, 04, 0.18),
    (055, 105, 05, 0.22),
    (056, 105, 06, 0.08),
    (057, 105, 07, 1.15),
    (058, 105, 08, 1.42),
    (059, 105, 09, 0.87),
    (050, 105, 10, 0.54),
    (0501, 105, 11, 0.57),
    (0502, 105, 12, 0.87),
	(061, 106, 01, 3.12),
    (062, 106, 02, 3.02),
    (063, 106, 03, 3.56),
    (064, 106, 04, 3.84),
    (065, 106, 05, 3.61),
    (066, 106, 06, 4.69),
    (067, 106, 07, 4.64),
    (068, 106, 08, 5.34),
    (069, 106, 09, 4.50),
    (060, 106, 10, 3.77),
    (0601, 106, 11, 3.09),
    (0602, 106, 12, 4.44),
	(071, 107, 01, 2.07),
    (072, 107, 02, 1.45),
    (073, 107, 03, 2.33),
    (074, 107, 04, 2.62),
    (075, 107, 05, 4.82),
    (076, 107, 06, 2.55),
    (077, 107, 07, 2.38),
    (078, 107, 08, 1.91),
    (079, 107, 09, 4.66),
    (070, 107, 10, 3.07),
    (0701, 107, 11, 1.55),
    (0702, 107, 12, 1.71),
	(081, 108, 01, 1.46),
    (082, 108, 02, 1.76),
    (083, 108, 03, 1.03),
    (084, 108, 04, 0.71),
    (085, 108, 05, 0.44),
    (086, 108, 06, 0.02),
    (087, 108, 07, 0.08),
    (088, 108, 08, 0.01),
    (089, 108, 09, 0.08),
    (080, 108, 10, 0.27),
    (0801, 108, 11, 0.73),
    (0802, 108, 12, 1.97),
	(091, 109, 01, 2.69),
    (092, 109, 02, 2.60),
    (093, 109, 03, 3.39),
    (094, 109, 04, 3.17),
    (095, 109, 05, 5.04),
    (096, 109, 06, 3.74),
    (097, 109, 07, 1.97),
    (098, 109, 08, 2.09),
    (099, 109, 09, 3.29),
    (090, 109, 10, 4.30),
    (0901, 109, 11, 2.29),
    (0902, 109, 12, 2.52),
	(101, 110, 01, 2.27),
    (102, 110, 02, 2.26),
    (103, 110, 03, 2.06),
    (104, 110, 04, 1.06),
    (105, 110, 05, 0.25),
    (106, 110, 06, 0.12),
    (107, 110, 07, 0.00),
    (108, 110, 08, 0.00),
    (109, 110, 09, 0.09),
    (100, 110, 10, 0.54),
    (1001, 110, 11, 1.22),
    (1002, 110, 12, 2.00)
	go
	
	--select * from averageprecipitation
	--go

	insert into AverageTemperature ( TemperatureID, CityID, month, AverageTemp)
	values
	(101, 101, 01, 32.6),
    (102, 101, 02, 34.1),
    (103, 101, 03, 41.8),
    (104, 101, 04, 52.8),
    (105, 101, 05, 63.4),
    (106, 101, 06, 72.4),
    (107, 101, 07, 78.9),
    (108, 101, 08, 76.2),
    (109, 101, 09, 69.4),
    (110, 101, 10, 57.7),
    (111, 101, 11, 46.3),
    (112, 101, 12, 38.0),
    (113, 102, 01, 60.7),
    (114, 102, 02, 59.4),
    (115, 102, 03, 60.6),
    (116, 102, 04, 62.2),
    (117, 102, 05, 63.5),
    (118, 102, 06, 66.7),
    (119, 102, 07, 70.4),
    (120, 102, 08, 71.3),
    (121, 102, 09, 71.6),
    (122, 102, 10, 69.4),
    (123, 102, 11, 64.8),
    (124, 102, 12, 59.5),
	(125, 103, 01, 26.4),
    (126, 103, 02, 28.0),
    (127, 103, 03, 40.3),
    (128, 103, 04, 50.6),
    (129, 103, 05, 62.2),
    (130, 103, 06, 72.1),
    (131, 103, 07, 77.0),
    (132, 103, 08, 75.3),
    (133, 103, 09, 68.2),
    (134, 103, 10, 55.1),
    (135, 103, 11, 42.5),
    (136, 103, 12, 31.9),
	(137, 104, 01, 63.8),
    (138, 104, 02, 68.0),
    (139, 104, 03, 74.8),
    (140, 104, 04, 80.3),
    (141, 104, 05, 86.8),
    (142, 104, 06, 92.9),
    (143, 104, 07, 94.1),
    (144, 104, 08, 95.4),
    (145, 104, 09, 90.3),
    (146, 104, 10, 83.1),
    (147, 104, 11, 73.2),
    (148, 104, 12, 65.7),
	(149, 105, 01, 70.7),
    (150, 105, 02, 74.3),
    (151, 105, 03, 81.4),
    (152, 105, 04, 87.9),
    (153, 105, 05, 94.8),
    (154, 105, 06, 104.7),
    (155, 105, 07, 106.1),
    (156, 105, 08, 105.0),
    (157, 105, 09, 100.7),
    (158, 105, 10, 91.2),
    (159, 105, 11, 80.2),
    (160, 105, 12, 69.2),
	(161, 106, 01, 42.0),
    (162, 106, 02, 44.2),
    (163, 106, 03, 53.3),
    (164, 106, 04, 65.2),
    (165, 106, 05, 75.0),
    (166, 106, 06, 83.5),
    (167, 106, 07, 88.7),
    (168, 106, 08, 85.8),
    (169, 106, 09, 79.5),
    (170, 106, 10, 67.9),
    (171, 106, 11, 56.0),
    (172, 106, 12, 46.9),
	 (173, 107, 01, 63.9),
    (174, 107, 02, 68.3),
    (175, 107, 03, 75.2),
    (176, 107, 04, 81.1),
    (177, 107, 05, 87.5),
    (178, 107, 06, 93.3),
    (179, 107, 07, 95.4),
    (180, 107, 08, 97.0),
    (181, 107, 09, 90.4),
    (182, 107, 10, 82.7),
    (183, 107, 11, 72.8),
    (184, 107, 12, 65.1),
	(185, 108, 01, 66.7),
    (186, 108, 02, 66.1),
    (187, 108, 03, 66.6),
    (188, 108, 04, 68.1),
    (189, 108, 05, 68.7),
    (190, 108, 06, 70.9),
    (191, 108, 07, 74.8),
    (192, 108, 08, 76.7),
    (193, 108, 09, 77.1),
    (194, 108, 10, 75.1),
    (195, 108, 11, 71.1),
    (196, 108, 12, 65.9),
	 (197, 109, 01, 57.3),
    (198, 109, 02, 60.8),
    (199, 109, 03, 70.1),
    (200, 109, 04, 76.6),
    (201, 109, 05, 84.0),
    (202, 109, 06, 92.7),
    (203, 109, 07, 95.8),
    (204, 109, 08, 96.7),
    (205, 109, 09, 89.2),
    (206, 109, 10, 78.8),
    (207, 109, 11, 68.0),
    (208, 109, 12, 58.2),
	(209, 109, 01, 58.6),
    (210, 109, 02, 61.6),
    (211, 109, 03, 64.2),
    (212, 109, 04, 67.1),
    (213, 109, 05, 70.5),
    (214, 109, 06, 75.4),
    (215, 109, 07, 76.9),
    (216, 109, 08, 76.8),
    (217, 109, 09, 77.5),
    (218, 109, 10, 73.5),
    (219, 109, 11, 65.0),
    (220, 109, 12, 58.3)
	go




	use WeatherData
go

create or alter proc FilterCitiesByTemperatureAndMonth
    @MinTemp decimal(5, 2),
    @MaxTemp decimal(5, 2),
    @Month int
as
begin
    select 
        Cities.CityID,
        Cities.CityName,
        Cities.Country,
        Cities.Region,
        Cities.Population,
        Cities.Latitude,
        Cities.Longitude,
        AverageTemperature.Month,
        AverageTemperature.AverageTemp
    from
        Cities
    inner join
        AverageTemperature on Cities.CityID = AverageTemperature.CityID
    where
        AverageTemperature.AverageTemp between @MinTemp and @MaxTemp
        and AverageTemperature.Month = @Month;
end;
go

exec FilterCitiesByTemperatureAndMonth @MinTemp =60, @MaxTemp = 80, @Month = 12;
go

use WeatherData
go

create table SearchHistory (
    SearchId int primary key identity(1,1),
    UserId nvarchar(128),
    SearchDate datetime,
    MinTemperature decimal(5, 2),
    MaxTemperature decimal(5, 2),
    SelectedMonth int,
);
go

use WeatherData
go

select * from dbo.AspNetUsers
go

-- Add UserName column to SearchHistory table
alter table SearchHistory
add UserName nvarchar(256);

-- Update existing records to have valid UserId values
update sh
set sh.UserId = u.UserName
from SearchHistory sh
join dbo.AspNetUsers u on sh.UserId = u.UserName
where sh.UserId IS NOT NULL AND u.UserName IS NOT NULL;
go


alter table SearchHistory
use WeatherData;
go

alter column UserId nvarchar(256);
go


select * from SearchHistory
go

create or alter proc TrackSearch
    @UserName nvarchar(128),
    @MinTemperature decimal(5, 2),
    @MaxTemperature decimal(5, 2),
    @Month int
as
begin
    insert into SearchHistory (UserName, MinTemperature, MaxTemperature, SelectedMonth, SearchDate)
    values (@UserName, @MinTemperature, @MaxTemperature, @Month, GETDATE());
end;
go

drop proc TrackSearch
go

select * from SearchHistory
go




use WeatherData
go


use WeatherData;
go

create table BlogPosts (
    PostID int primary key identity (1,1),
    Title nvarchar(256),
    Content nvarchar(MAX),
    PostDate datetime,
    Author nvarchar(256)
);
go

