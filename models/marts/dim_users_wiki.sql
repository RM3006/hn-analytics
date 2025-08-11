-- models/marts/dim_users_wiki.sql
select
    user_name,
    min(edited_at_ts) as first_edit_at_ts,
    max(edited_at_ts) as last_edit_at_ts,
    count(*) as total_edits_count,
    boolor_agg(is_bot) as is_bot -- Vrai si l'utilisateur a déjà été un bot
from {{ ref('stg_wikipedia__edits') }}
where user_name is not null
group by 1