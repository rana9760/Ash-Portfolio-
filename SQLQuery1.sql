---- #### Cleaning Data in SQL Queries #### ----

select *
 from National_Housing_Project

 ---- #### Changing the data type of SaleDate Column in SQL Queries #### ----


select SaleDate, Convert(date,SaleDate) Formated_Date
 from National_Housing_Project

 ---- By Droping Table Data Type

 Alter Table National_Housing_Project Alter Column SaleDate date

 select SaleDate
 from National_Housing_Project

 ---- #### Populate Property Address data #### ----


select * from National_Housing_Project
order by [UniqueID ]

---- Here I have found that there is duplicate PropertyAddress

select distinct PropertyAddress from National_Housing_Project
where PropertyAddress is not null 
order by PropertyAddress

select  PropertyAddress from National_Housing_Project
where PropertyAddress is not null 
order by PropertyAddress

---- To resolve the issue where we have  PropertyAddress is null . I Will Solve it by using Self Join..

select  a.ParcelID , a.PropertyAddress,b.ParcelID , b.PropertyAddress,ISNULL(a.PropertyAddress,b.PropertyAddress)Missing_Adress_Value 
     from National_Housing_Project a
    join  National_Housing_Project b
   on a.ParcelID = b.ParcelID and a.uniqueId <> b.uniqueId

where a.PropertyAddress is  null 
order by a.PropertyAddress


---- Here I will update value

update a
SET a.PropertyAddress=ISNULL(a.PropertyAddress,b.PropertyAddress)
   from National_Housing_Project a
   join  National_Housing_Project b
   on a.ParcelID = b.ParcelID and a.uniqueId <> b.uniqueId
   where a.PropertyAddress is null


-- Now it is giving none value

select  a.ParcelID , a.PropertyAddress,b.ParcelID , b.PropertyAddress,ISNULL(a.PropertyAddress,b.PropertyAddress)Missing_Adress_Value 
     from National_Housing_Project a
    join  National_Housing_Project b
   on a.ParcelID = b.ParcelID and a.uniqueId <> b.uniqueId

where a.PropertyAddress is  null 
order by a.PropertyAddress


---- #### Breaking out Address into Individual Columns (Address,City,State) #### ----

select PropertyAddress,LEFT(PropertyAddress,CHARINDEX(',',PropertyAddress,0) -1 ) House_No_Address,
       Right(PropertyAddress,CHARINDEX(' ',Reverse(PropertyAddress),0))City
       from National_Housing_Project

 
 select [UniqueID ],ParcelID,OwnerAddress,OwnerName
 from National_Housing_Project
 where OwnerAddress is null

 select OwnerAddress
 from National_Housing_Project
 
select OwnerAddress,
PARSENAME(Replace(ownerAddress,',','.'),3) House_No,
PARSENAME(Replace(ownerAddress,',','.'),2) City,
PARSENAME(Replace(ownerAddress,',','.'),1) State
from National_Housing_Project
 
 ---- By Alter & Update 

 Alter Table National_Housing_Project
 add OwnerHouse_No nvarchar(255);

 update National_Housing_Project
set OwnerHouse_No = PARSENAME(Replace(ownerAddress,',','.'),3)

 Alter Table National_Housing_Project
 add OwnerCity nvarchar(255);

 update National_Housing_Project
set OwnerCity = PARSENAME(Replace(ownerAddress,',','.'),2)

 Alter Table National_Housing_Project
 add OwnerState nvarchar(255);

 update National_Housing_Project
set OwnerState = PARSENAME(Replace(ownerAddress,',','.'),1)

 
 
 select *
 from National_Housing_Project


 ----##### Change the value in Database in Y to yes  and N to No #####------


 select  SoldAsVacant,
 case
 when SoldAsVacant = 'y' then 'YES'
 when SoldAsVacant = 'n' then 'NO'
 else SoldAsVacant 
 end Updated_result
from National_Housing_Project


 ----##### Duplicate Value Table #####------

-- Inline Views 
 
 select * from (
   select *,Row_Number() over (partition by parcelid,propertyaddress,saleprice,saledate,legalreference
  order by uniqueid asc) Row_No
 from National_Housing_Project ) a
 where Row_No > 1


 ---- Create Temporary Table sa Duplicate Value 

 with Abc
 as (
     select *,Row_Number() over (partition by parcelid,propertyaddress,saleprice,saledate,legalreference
     order by uniqueid asc) Row_No
     from National_Housing_Project
	 )

select * from Abc
 where Row_No > 1





































