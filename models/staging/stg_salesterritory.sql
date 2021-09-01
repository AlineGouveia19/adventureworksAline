with source as (

select
     t1.territoryid	
   , t1.name  	
   , t1.countryregioncode
   , t1.group 	
   , t1.salesytd			
   , t1.saleslastyear	
   , t1.costytd	  	
   , t1.costlastyear	  	
   	
	
   
   from {{ source('adventureworksss', 'sales_salesterritory') }} as t1


)

select * from source