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


