with creditcard as (

    select  *  from {{ ref('stg_creditcard') }}


), transformed as (

    select row_number() over (order by creditcardid) as creditcard_SK
          , creditcard.*
          from creditcard
)

select * from transformed