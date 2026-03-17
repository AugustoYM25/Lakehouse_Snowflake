CREATE TABLE IF NOT EXISTS BRONZE_CUSTOMERS

(
    raw_rata VARIANT,
    filename STRING,
    created_at TIMESTAMP
);

SELECT * FROM BRONZE_CUSTOMERS;

INSERT INTO BRONZE_CUSTOMERS
SELECT DISTINCT 
    CAST($1 as variant) raw_data,  
    metadata$filename, 
    current_timestamp created_at
from @PUBLIC.NORTH/customers
(FILE_FORMAT => 'PARQUET_FORMAT');

CREATE TABLE IF NOT EXISTS SILVER_CUSTOMERS

SELECT 
    upper($1:"customer_id"::string) as customer_id,
    upper($1:"company_name"::string) as company_name,
    upper($1:"contact_name"::string) as contact_name,
    upper($1:"contact_title"::string) as contact_title,
    upper($1:"country"::string) as country,
    upper($1:"city"::string) as city,
    upper($1:"address"::string) as address,
    upper($1:"phone"::string) as phone,
    upper($1:"postal_code"::string) as postal_code,
    upper($1:"customer_id"::string) as customer_id,
    upper($1:"customer_id"::string) as customer_id,
    filename,
    current_timestamp as created_at
    
FROM bronze_customers;
    



{
  "address": "Obere Str. 57",
  "city": "Berlin",
  "company_name": "Alfreds Futterkiste",
  "contact_name": "Maria Anders",
  "contact_title": "Sales Representative",
  "country": "Germany",
  "customer_id": "ALFKI",
  "fax": "030-0076545",
  "phone": "030-0074321",
  "postal_code": "12209"
}
