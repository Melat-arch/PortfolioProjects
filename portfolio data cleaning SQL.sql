



Select * from [PortfolioProject].dbo.[NashvilleHousing]


Select saledate from [PortfolioProject].dbo.[NashvilleHousing]




 Alter table dbo.[NashvilleHousing]
 alter column saledate date

 Select PropertyAddress
 from [PortfolioProject].dbo.[NashvilleHousing]
 where PropertyAddress is null

 --we have 29 rows that are null

 --populate property address data

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress , ISNULL(a.PropertyAddress, b.PropertyAddress)
from [PortfolioProject].dbo.[NashvilleHousing] a
inner join [PortfolioProject].dbo.[NashvilleHousing] b
on a.ParcelID = b.ParcelID 
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

update a
set
PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from [PortfolioProject].dbo.[NashvilleHousing] a
inner join [PortfolioProject].dbo.[NashvilleHousing] b
on a.ParcelID = b.ParcelID 
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null


--breaking out address into individual columns(address, city, state)


Select PropertyAddress
 from [PortfolioProject].dbo.[NashvilleHousing]
 --where PropertyAddress is null

 select SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress)+1, CHARINDEX(',', PropertyAddress))
 --select CHARINDEX(',', PropertyAddress)
  from [PortfolioProject].dbo.[NashvilleHousing]


  select SUBSTRING(PropertyAddress,1, CHARINDEX(',', PropertyAddress)-1) as address,
  SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress)+1, CHARINDEX(',', PropertyAddress))
 --select CHARINDEX(',', PropertyAddress)
  from [PortfolioProject].dbo.[NashvilleHousing]
  --or
  
  select SUBSTRING(PropertyAddress,1, CHARINDEX(',', PropertyAddress)-1) as address,
  SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress)+1,len (PropertyAddress))
 --select CHARINDEX(',', PropertyAddress)
  from [PortfolioProject].dbo.[NashvilleHousing]


Alter table dbo.[NashvilleHousing]
Add propertySplitAddress nvarchar(255);

update dbo.[NashvilleHousing]
Set propertySplitAddress = SUBSTRING(PropertyAddress,1, CHARINDEX(',', PropertyAddress)-1)


Alter table dbo.[NashvilleHousing]
Add propertySplitcity nvarchar(255);

update dbo.[NashvilleHousing]
set propertySplitcity = SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress)+1,len (PropertyAddress))



Select *
from dbo.[NashvilleHousing]


Select PARSEname(replace(owneraddress, ',', '.'),3),
PARSEname(replace(owneraddress, ',', '.'),2),
PARSEname(replace(owneraddress, ',', '.'),1)
from dbo.[NashvilleHousing]




Alter table dbo.[NashvilleHousing]
Add ownerSplitAddress nvarchar(255);

update dbo.[NashvilleHousing]
set ownerSplitAddress =  PARSEname(replace(owneraddress, ',', '.'),3)

Alter table dbo.[NashvilleHousing]
Add ownerSplitcity nvarchar(255);

update dbo.[NashvilleHousing]
set ownerSplitcity = PARSEname(replace(owneraddress, ',', '.'),2)


Alter table dbo.[NashvilleHousing]
Add ownerSplitstate nvarchar(255);

update dbo.[NashvilleHousing]
set ownerSplitstate = PARSEname(replace(owneraddress, ',', '.'),1)



Select *
from dbo.[NashvilleHousing]

Select distinct (SoldAsVAcant) , count(soldasvacant)
from dbo.[NashvilleHousing]
group by soldasvacant
order by 2


select soldasvacant,
case when soldasvacant = 'N' then 'No'
     when soldasvacant = 'Y' then 'Yes'
	 else soldasvacant
	 end
from dbo.[NashvilleHousing]



update dbo.[NashvilleHousing]
set soldasvacant =
case when soldasvacant = 'N' then 'No'
     when soldasvacant = 'Y' then 'Yes'
	 else soldasvacant
	 end


--remove duplicates

;with cte as (
Select *, row_number() over (
          partition by [ParcelID],
[PropertyAddress],
[SalePrice],
[SaleDate],
[LegalReference]        
 order by [UniqueID ]) as rnk
from dbo.[NashvilleHousing]
--order by [ParcelID]
)
 delete from cte
 where rnk >1

 Select [ParcelID],
[PropertyAddress],
[SalePrice],
[SaleDate],
[LegalReference] , count(*)       
from dbo.[NashvilleHousing]

group by [ParcelID],
[PropertyAddress],
[SalePrice],
[SaleDate],
[LegalReference]
having  count(*) >1


--delete unused columns
Select * from [PortfolioProject].dbo.[NashvilleHousing]

alter table [PortfolioProject].dbo.[NashvilleHousing]
drop column owneraddress, taxdistrict, propertyAddress
















































