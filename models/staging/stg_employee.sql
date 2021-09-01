with source as (

    select
     businessentityid
   , jobtitle	  
   , hiredate		
   , salariedflag	

    from {{ source('adventureworksss', 'humanresources_employee') }} 

)

select * from source