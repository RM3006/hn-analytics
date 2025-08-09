-- models/marts/dim_users.sql

with items as (

    select * from {{ ref('stg_hackernews__items') }}

)

select
    user_id,
    min(created_at_ts) as first_seen_at_ts,
    max(created_at_ts) as last_seen_at_ts,
    count(distinct item_id) as items_submitted_count
from items
where user_id is not null
group by 1