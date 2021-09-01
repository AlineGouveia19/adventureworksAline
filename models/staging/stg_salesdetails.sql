with source as (

    select       	
         salesorderid		
       , salesorderdetailid	
       , productid
       , orderqty		
       , unitprice	

       , unitpricediscount	

      from {{ source('adventureworksss', 'sales_salesorderdetail') }}

)

select * from source