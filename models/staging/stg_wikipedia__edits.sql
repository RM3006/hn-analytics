-- models/staging/stg_wikipedia__edits.sql

with source as (

    select * from {{ source('wikipedia', 'RAW_WIKIPEDIA') }}

),

renamed as (

    select
        raw_data:id::number as edit_id,
        to_timestamp_ntz(raw_data:timestamp::number) as edited_at_ts,
        raw_data:type::string as edit_type,

        -- Page information
        raw_data:title::string as page_title,
        raw_data:title_url::string as page_url,
        raw_data:namespace::number as page_namespace,

        -- User information
        raw_data:user::string as user_name,
        raw_data:bot::boolean as is_bot,

        -- Edit information
        raw_data:minor::boolean as is_minor_edit,
        raw_data:patrolled::boolean as is_patrolled,
        raw_data:comment::string as edit_comment,
        raw_data:length.new::number - raw_data:length.old::number as characters_changed,

        -- Server information
        raw_data:server_name::string as wiki_domain

    from source
    where raw_data:id is not null

)

select * from renamed