with customers as (

    select *
    from  {{ ref('dim_customer') }}
),
employees as (

    select *
    from {{ ref('dim_employee') }}
),
products as (

    select *
    from {{ ref('dim_product') }} 
),
dim_address as (

    select *
    from {{ ref('dim_address') }} 

),
creditcards as (
    
    select *
    from {{ ref('dim_creditcard') }} 

),

salesreason as (
    
    select *
    from {{ ref('dim_salesreason') }} 

),
sales_with_sk as (

    select 
         sales.salesorderid
       , customers.customer_sk
       , employees.employee_sk
       , dim_address.address_sk
       , salesreason.salesreason_SK
       , creditcards.creditcard_sk    
       , sales.taxamt		
       , sales.shiptoaddressid			
       , sales.status			
       , sales.orderdate		
       , sales.subtotal			
       , sales.freight		
       	
    from {{ ref('stg_sales') }} as sales
    left join employees   on employees.businessentityid  = sales.salespersonid 
    left join customers   on customers.customerid        = sales.customerid
    left join dim_address on dim_address.addressid      = sales.shiptoaddressid	
     left join salesreason on salesreason.salesorderid  = sales.salesorderid 
    left join creditcards on creditcards.creditcardid   = sales.creditcardid

), sales_details_with_sk as (

    select
      
         salesdetails.salesorderid		
       , salesdetails.salesorderdetailid	
       , products.product_sk
       , salesdetails.orderqty		
       , salesdetails.unitprice	
       , salesdetails.unitpricediscount	
       , (salesdetails.unitprice * salesdetails.orderqty) * (1 - salesdetails.unitpricediscount)  as valor_total
       from {{ ref('stg_salesdetails') }} as salesdetails
       left join products on products.productid  = salesdetails.productid

), final as (

    select
         sales_with_sk.salesorderid
        , sales_with_sk.customer_sk
        , sales_with_sk.employee_sk
       , sales_details_with_sk.product_sk
       , sales_with_sk.address_sk
       , sales_with_sk.salesreason_SK
       , sales_with_sk.creditcard_sk    
       , sales_with_sk.taxamt		
       , sales_with_sk.shiptoaddressid		
       , sales_with_sk.status		        	
       , sales_with_sk.orderdate	
       , sales_with_sk.subtotal		       	
       , sales_with_sk.freight    	
       , sales_details_with_sk.salesorderdetailid	       
       , sales_details_with_sk.orderqty		
       , sales_details_with_sk.unitprice
       , sales_details_with_sk.unitpricediscount	
       , sales_details_with_sk.valor_total 
       from sales_with_sk
       left join sales_details_with_sk on sales_details_with_sk.salesorderid = sales_with_sk.salesorderid


)

select * from final