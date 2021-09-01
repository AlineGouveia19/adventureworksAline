with selAddress as (

    select
      addressid	
     , addressline1	
     , addressline2		
     , city		
     , stateprovinceid		
     , postalcode		
     , spatiallocation			
    

    from {{ source('adventureworksss', 'person_address') }}

), selStateprovince as (
  
      select
        stateprovinceid
      , stateprovincecode 
      , countryregioncode 
      , isonlystateprovinceflag 
      , name as name_province
      , territoryid
      from  {{ source('adventureworksss', 'person_stateprovince') }}


), selCountryregion as (

   select countryregioncode
         , name as name_country
          from {{ source('adventureworksss', 'person_countryregion') }}

), source as (

    select
      selAddress.addressid	
    , selAddress.addressline1	
    , selAddress.addressline2		
    , selAddress.city			
    , selAddress.postalcode		
    , selAddress.spatiallocation
    , selStateprovince.stateprovinceid
    , selStateprovince.stateprovincecode 
    , selStateprovince.countryregioncode 
    , selStateprovince.isonlystateprovinceflag 
    , selStateprovince.name_province
   , selStateprovince.territoryid
    , selCountryregion.name_country
    from selAddress 
      left join selStateprovince
       on selStateprovince.stateprovinceid = selAddress.stateprovinceid
      left join  selCountryregion
        on  selCountryregion.countryregioncode =  selStateprovince.countryregioncode

)


select * from source