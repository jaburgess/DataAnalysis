

select *
from SQLCleaningData.dbo.NashvilleHousing


--Standardize Date Format
--I selected SaleDate, CONVERT(Date,SaleDate) from NashvilleHousing and 
--Updated SaleDate with its converted date. Then added SaleDateConverted, updated, and displayed the converted SaleDate.

select SaleDate, CONVERT(Date,SaleDate)
from SQLCleaningData.dbo.NashvilleHousing

update NashvilleHousing
sET SaleDate = CONVERT(Date,SaleDate)

alter table NashvilleHousing
add SaleDateConverted Date;

update NashvilleHousing
set SaleDateConverted = CONVERT(Date,SaleDate)

select SaleDateConverted, CONVERT(Date,SaleDate)
from SQLCleaningData.dbo.NashvilleHousing


--Populate Property Address data
--Found some null values where there should be none
--All same parcelID have the same address, if the address is null, find a copy address from same parcelID

Select *
from SQLCleaningData.dbo.NashvilleHousing
where PropertyAddress is null
order by ParcelID

--Have to preform a self join to allow a check or same parcelID to same addresses
--Although parcelID ar not all unique, uniqueID are all unique, check to make sure they differ
--UPDATE: no output, seccess
select first.ParcelID, first.PropertyAddress, second.ParcelID, second.PropertyAddress, ISNULL(first.PropertyAddress,second.PropertyAddress)
from SQLCleaningData.dbo.NashvilleHousing first
join SQLCleaningData.dbo.NashvilleHousing second
	on first.ParcelID = second.ParcelID
	and first.[UniqueID ] <> second.[UniqueID ]
where first.PropertyAddress is null


update first
sET PropertyAddress = ISNULL(first.PropertyAddress,second.PropertyAddress)
from SQLCleaningData.dbo.NashvilleHousing first
join SQLCleaningData.dbo.NashvilleHousing second
	on first.ParcelID = second.ParcelID
	and first.[UniqueID ] <> second.[UniqueID ]
where first.PropertyAddress is null





--Breaking out Address into Individual Columns (Address, City, State)
--Where commas seperate them. Using substring to split. 

select PropertyAddress
from SQLCleaningData.dbo.NashvilleHousing

--Where PropertyAddress is null
--order by ParcelID

select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address
from SQLCleaningData.dbo.NashvilleHousing


alter table NashvilleHousing
add PropertySplitAddress Nvarchar(255);

update NashvilleHousing
set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


alter table NashvilleHousing
add PropertySplitCity Nvarchar(255);

update NashvilleHousing
set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))

--Check to make sure it worked
--UPDATE: Success
select *
from SQLCleaningData.dbo.NashvilleHousing



--Splitting up OwnerAddress into Individual Columns (Address, City, State)
--Using parsename to help split up
select OwnerAddress
from SQLCleaningData.dbo.NashvilleHousing


select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
from SQLCleaningData.dbo.NashvilleHousing

alter table NashvilleHousing
add OwnerSplitAddress Nvarchar(255);

update NashvilleHousing
set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)

alter table NashvilleHousing
set OwnerSplitCity Nvarchar(255);

update NashvilleHousing
set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

alter table NashvilleHousing
add OwnerSplitState Nvarchar(255);

update NashvilleHousing
set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

--Check to make sure it worked
--UPDATE: Success
select *
from SQLCleaningData.dbo.NashvilleHousing





--Change Y and N to Yes and No in "Sold as Vacant" field
--Using case statements to check and replace

select distinct(SoldAsVacant), Count(SoldAsVacant)
from SQLCleaningData.dbo.NashvilleHousing
group by SoldAsVacant
order by 2




select SoldAsVacant
, case when SoldAsVacant = 'Y' then 'Yes'
	   when SoldAsVacant = 'N' then 'No'
	   else SoldAsVacant
	   end
from SQLCleaningData.dbo.NashvilleHousing


update NashvilleHousing
set SoldAsVacant = case 
	  when SoldAsVacant = 'Y' then 'Yes'
	  when SoldAsVacant = 'N' then 'No'
	  else SoldAsVacant
	  end



-- Remove Duplicates by looking to entries with all same data 
--UPDATE: Success
with RowNumCTE as(
select *,
	ROW_NUMBER() over (
	partition by ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
	order by UniqueID 
	)
	row_num
from SQLCleaningData.dbo.NashvilleHousing

)
select *
from RowNumCTE
where row_num > 1
order by PropertyAddress

--Delete

--with RowNumCTE as(
--select *,
--	ROW_NUMBER() over (
--	partition by ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
--	order by UniqueID 
--	)
--	row_num
--from SQLCleaningData.dbo.NashvilleHousing

--)
--delete 
--from RowNumCTE
--where row_num > 1

select *
from SQLCleaningData.dbo.NashvilleHousing




--Delete Unused Columns
--We created new columns for SaleDate,OwnerAddress,PropertyAddress. We can drop the old ones. 
select *
from SQLCleaningData.dbo.NashvilleHousing


--alter table SQLCleaningData.dbo.NashvilleHousing
--drop column OwnerAddress, PropertyAddress, SaleDate


