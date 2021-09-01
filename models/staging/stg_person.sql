with source as (
select
      businessentityid
    , rowguid	      
    , firstname	
    , middlename	
    , lastname	
    , title	
    , persontype		
    , namestyle	
    , suffix		
    , modifieddate		
    , emailpromotion	    			

from {{ source('adventureworksss', 'person_person') }}



)

select * from source