-- models/staging/stg_hackernews__items.sql

with source as (

    select * from {{ source('hackernews', 'RAW_HACKERNEWS') }}

),

renamed as (

    select
        raw_data:id::number as item_id,
        raw_data:type::string as item_type,
        raw_data:"by"::string as user_id,
        to_timestamp_ntz(raw_data:time::number) as created_at_ts,
        raw_data:text::string as item_text,
        raw_data:parent::number as parent_item_id,
        raw_data:url::string as item_url,
        raw_data:score::number as score,
        raw_data:title::string as title,
        raw_data:descendants::number as descendant_count

    from source
    where raw_data:id is not null -- On filtre les enregistrements invalides

)

select * from renamed