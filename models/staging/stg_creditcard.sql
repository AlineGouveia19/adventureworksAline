with sel_creditcard as (

    select
        creditcardid		       
       , cardtype		
       , cardnumber	
       , expmonth	
       , expyear	      		
      -- , modifieddate	 
      -- , _sdc_received_at		
      -- , _sdc_sequence		 
      -- , _sdc_table_version		 
      -- , _sdc_batched_at		
      -- , _sdc_extracted_at		
        from {{ source('adventureworksss', 'sales_creditcard') }}    

),  selCreditcardPerson as (

      select           
           businessentityid
         , creditcardid
          from  {{ source('adventureworksss', 'sales_personcreditcard') }} 
          

), source as (

    select
         sel_creditcard.creditcardid		       
       , sel_creditcard.cardtype		
       , sel_creditcard.cardnumber	
       , sel_creditcard.expmonth	
       , sel_creditcard.expyear	
       , selCreditcardPerson.businessentityid
        from sel_creditcard
        left join selCreditcardPerson 
        on selCreditcardPerson.creditcardid = sel_creditcard.creditcardid
)

select * from source