CREATE TABLE IF NOT EXISTS SILVER_CUSTOMERS
(
    customer_id STRING,
    company_name STRING,
    contact_name STRING,
    contact_title STRING,
    country STRING,
    city STRING,
    address STRING,
    phone STRING,
    postal_code STRING,
    filename STRING,
    created_at TIMESTAMP
)

SELECT * FROM SILVER_CUSTOMERS;


INSERT INTO SILVER_CUSTOMERS

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
    filename,
    current_timestamp as created_at
    
FROM bronze_customers;
    
