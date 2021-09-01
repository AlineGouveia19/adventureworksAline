with reason_distinct as (

    select salesorderid ,
           max(salesreasonid)     as salesreasonid                 
          from {{ source('adventureworksss', 'sales_salesorderheadersalesreason') }}
          group by salesorderid 
                     


),  SelSalesReason as (

    select salesreasonid
           , reasontype 
           , name
           from {{ source('adventureworksss', 'sales_salesreason') }} 

) , source as (

    select
        reason_distinct.salesorderid
       , reason_distinct.salesreasonid 
       , SelSalesReason.reasontype 
       , SelSalesReason.name
    from  reason_distinct
       left join  SelSalesReason
      on SelSalesReason.salesreasonid = reason_distinct.salesreasonid
)

select * from source