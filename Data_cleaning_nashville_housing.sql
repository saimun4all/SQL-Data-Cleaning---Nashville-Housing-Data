------------------------------------ DATA CLEANING NASHVILLE EXCEL FILE ---------------------------------

------------------------------------------------------------------------------------------------------
--- Standardize Date Format

SELECT SaleDateConverted
FROM PortfolioProject.dbo.[Nashville Housing]

--- Does not Update the Table

UPDATE PortfolioProject.dbo.[Nashville Housing]
SET SaleDate = CONVERT(Date, SaleDate)

--- Alternate Solution

ALTER TABLE PortfolioProject.dbo.[Nashville Housing]
Add SaleDateConverted Date;

Update PortfolioProject.dbo.[Nashville Housing]
SET SaleDateConverted = CONVERT(Date,SaleDate)


------------------------------------------------------------------------------------------------------
--- Populate Property Address data

SELECT *
FROM PortfolioProject.dbo.[Nashville Housing]
WHERE PropertyAddress IS NULL
ORDER BY ParcelID

SELECT 
	a.ParcelID, 
	a.PropertyAddress, 
	b.ParcelID, 
	b.PropertyAddress,
	ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM PortfolioProject.dbo.[Nashville Housing] a
JOIN PortfolioProject.dbo.[Nashville Housing] b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM PortfolioProject.dbo.[Nashville Housing] a
JOIN PortfolioProject.dbo.[Nashville Housing] b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL


------------------------------------------------------------------------------------------------------
--- Breaking out Address into Individual Columns (Address, City, State)

SELECT
	SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) AS Address,
	SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) AS Address
FROM PortfolioProject.dbo.[Nashville Housing]

ALTER TABLE PortfolioProject.dbo.[Nashville Housing]
Add PropertySplitAddress Nvarchar(255);

Update PortfolioProject.dbo.[Nashville Housing]
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1)

ALTER TABLE PortfolioProject.dbo.[Nashville Housing]
Add PropertySplitCity Nvarchar(255);

Update PortfolioProject.dbo.[Nashville Housing]
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))

SELECT *
FROM PortfolioProject.dbo.[Nashville Housing]

------------------------------------------------------------------------------------------------------
--- Split Owner Address into (Address, City, State)

SELECT OwnerAddress
FROM PortfolioProject.dbo.[Nashville Housing]

