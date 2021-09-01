with selCustomer as (

    select
         customerid
       , personid		         
    from {{ ref('stg_customer') }} 
    where personid != 0
 
),

selPerson as (
select 
        businessentityid	
      , firstname	 
      , lastname	
      , title	
      , persontype		
      , namestyle     
      from {{ ref('stg_person') }} 

), customer_with_person as (
    
    select
        selCustomer.customerid
      , selCustomer.personid		
      , selPerson.businessentityid	
      , selPerson.firstname	
      , selPerson.lastname	
      , selPerson.title	
      , selPerson.persontype		
      , selPerson.namestyle     
    from selCustomer
      left join selPerson on selPerson.businessentityid = selCustomer.personid
   

), transformed as (

        select
          row_number() over (order by customerID) as customer_SK
          , *
          from customer_with_person

)

select  * from transformed