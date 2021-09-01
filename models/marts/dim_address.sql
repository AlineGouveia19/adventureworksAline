with Sel_address as (

    select * from {{ ref('stg_address') }}


),transformed as (

      select
          row_number() over (order by addressid) as address_SK
          , *
          from Sel_address

)

select * from transformed