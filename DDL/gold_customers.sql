--DDL

CREATE OR REPLACE TABLE  gold_dim_customers (
    customer_sk BIGINT AUTOINCREMENT,
    customer_id VARCHAR(20),
    company_name VARCHAR(100),
    contact_name VARCHAR(200),
    contact_title VARCHAR(100),
    address VARCHAR(300),
    city VARCHAR(100),
    postal_code VARCHAR(100),
    country VARCHAR(100),
    phone VARCHAR(100),
    hash_diff VARCHAR(300),
    created_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

merge into gold_dim_customers g
using(
select
customer_id,
    company_name,
    contact_name,
    contact_title,
    address,
    city,
    postal_code,
    country,
    phone,
    md5(
        NVL(company_name,'') || '|' ||
        NVL(contact_name,'') || '|' ||
        NVL(address,'') || '|' ||
        NVL(city,'') || '|' ||
        NVL(postal_code,'') || '|' ||
        NVL(country,'') || '|' ||
        NVL(phone,'')
        ) AS hash_diff
from silver_customers
) s


on g.customer_id = s.customer_id

when matched and g.hash_diff != s.hash_diff then

update set
    g.company_name = s.company_name,
    g.contact_name = s.contact_name,
    g.contact_title = s.contact_title,
    g.address = s.address,
    g.city = s.city,
    g.postal_code = s.postal_code,
    g.country = s.country,
    g.phone  = s.phone,
    g.hash_diff = s.hash_diff
    
    
    
    when not matched then
        insert(
        customer_id,
        company_name,
        contact_name,
        contact_title,
        address,
        city,
        postal_code,
        country,
        phone
        )
    values
        (
        s.customer_id,
        s.company_name,
        s.contact_name,
        s.contact_title,
        s.address,
        s.city,
        s.postal_code,
        s.country,
        s.phone
        )
    ;
