with source as (

   select
     businessentityid	
   , salesquota
   , salesytd	
   , saleslastyear		
   , commissionpct	   	
   , territoryid		
   , bonus		

   from {{ source('adventureworksss', 'sales_salesperson') }} 
)

select * from source