with validation as (

    select 
    count(distinct(salesorderid)) as qtd_orders
    from {{ ref('fact_sales_details') }}
    where orderdate between '2012-01-01' and '2012-01-31' 
)

select * from validation where qtd_orders != 336