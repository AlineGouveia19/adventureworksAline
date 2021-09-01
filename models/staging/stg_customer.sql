with source as (

    select 
         customerid
      ,  personid		
      ,  storeid
      ,  territoryid		

        from {{ source('adventureworksss', 'sales_customer') }}


)

select * from source