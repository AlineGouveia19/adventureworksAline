with selSalesPerson as (

    select
     businessentityid	
   , salesquota
   , commissionpct	   	
   , bonus		

   from {{ ref('stg_salesperson') }} 

), salesPerson_with_employee as (

    select 

      selSalesPerson.*
   , employee.jobtitle	  
   , employee.hiredate		
   , employee.salariedflag		
     from  selSalesPerson   
     left join {{ ref('stg_employee') }} as employee
     on selSalesPerson.businessentityid = employee.businessentityid
    
), salesPerson_with_employee_and_person as (

    select
         swe.*
        , firstname	
        , lastname	
        , title	
        , persontype		
        , emailpromotion	 
       from salesPerson_with_employee as swe
       left join {{ ref('stg_person') }} as person 
       on person.businessentityid = swe.businessentityid       

), transformed as (

    select row_number() over (order by businessentityid) as employee_sk
           ,  salesPerson_with_employee_and_person.*
           from  salesPerson_with_employee_and_person

)

select * from transformed