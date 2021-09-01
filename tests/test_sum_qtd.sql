with validation as (

    select 
    sum(orderqty) as sum_qty
    from {{ ref('fact_sales_details') }}
    where orderdate between '2012-01-01' and '2012-01-31' 
)

select * from validation where sum_qty != 3967