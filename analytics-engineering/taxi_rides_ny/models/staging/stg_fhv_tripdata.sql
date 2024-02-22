{{
    config(
        materialized='view'
    )
}}

with tripdata as 
(
  select *
  from {{ source('staging','fhv_tripdata') }}
)
select
    -- identifiers
    {{ dbt_utils.generate_surrogate_key(['dispatching_base_num', 'pickup_datetime']) }} as tripid,
    dispatching_base_num as dispatching_base_num,
    affiliated_base_number as affiliated_base_number,
    {{ dbt.safe_cast("p_ulocation_id", api.Column.translate_type("integer")) }} as pickup_locationid,
    {{ dbt.safe_cast("d_olocation_id", api.Column.translate_type("integer")) }} as dropoff_locationid,
    
    -- timestamps
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(drop_off_datetime as timestamp) as dropoff_datetime,
    
    -- trip info
    sr_flag as sr_flag
from tripdata
where date(pickup_datetime) between '2019-01-01' and '2019-12-31'

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}