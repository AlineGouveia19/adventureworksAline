with selProduct as (

    select
         productid	
       , name  
       , productnumber	
       , color		
       , safetystocklevel
       , reorderpoint
       , standardcost
       , listprice
       , size		
       , sizeunitmeasurecode
       , weightunitmeasurecode
       , weight
       , daystomanufacture
       , productline
       , class	
       , sellenddate		
       , style	
       , productsubcategoryid	
       , productmodelid		
       , sellstartdate		



    from {{ source('adventureworksss' , 'production_product') }}

), selSubCategory as (

    select  
         productsubcategoryid	
       , productcategoryid	
       , name as name_subcategory		


       from {{ source('adventureworksss' , 'production_productsubcategory') }}

), selProductCategory as (

    select
      productcategoryid		
    , name	as name_category	
 		
    from {{ source('adventureworksss' , 'production_productcategory') }}

), source as (

    select
         selProduct.productid	
       , selProduct.name  
       , selProduct.productnumber	
       , selProduct.color		
       , selProduct.safetystocklevel
       , selProduct.reorderpoint
       , selProduct.standardcost
       , selProduct.listprice
       , selProduct.size		
       , selProduct.sizeunitmeasurecode
       , selProduct.weightunitmeasurecode
       , selProduct.weight
       , selProduct.daystomanufacture
       , selProduct.productline
       , selProduct.class	
       , selProduct.sellenddate		
       , selProduct.style	
       , selProduct.productsubcategoryid	
       , selProduct.productmodelid		
       , selProduct.sellstartdate
       , selSubCategory.productcategoryid	
       , selSubCategory.name_subcategory
       , selProductCategory.name_category	

       from selProduct	
        left join selSubCategory
        on selSubCategory.productsubcategoryid = selProduct.productsubcategoryid
        left join selProductCategory
        on selProductCategory.productcategoryid = selSubCategory.productcategoryid



)


select * from source