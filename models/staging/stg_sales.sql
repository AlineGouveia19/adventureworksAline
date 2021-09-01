with source as (

    select 
         salesorderid    
       , salespersonid     
       , taxamt		
       , shiptoaddressid		
       , territoryid		
       , status			
       , orderdate		
       , subtotal		
       , creditcardid			
       , freight			
       , customerid		
       	
    from {{ source('adventureworksss', 'sales_salesorderheader') }}

)

select * from source