with selProducts as (

    select *
       from {{ ref('stg_product') }}
), transformed as(

    select row_number() over (order by productid) as product_SK
         , selProducts.*
         from selProducts
)

select * from transformed