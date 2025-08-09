-- models/marts/fact_stories.sql

with items as (

    select * from {{ ref('stg_hackernews__items') }}

)

select
    item_id,
    user_id,
    created_at_ts,
    item_url,
    score,
    title,
    descendant_count as comment_count
from items
where item_type = 'story'