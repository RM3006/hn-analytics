-- models/marts/fact_edits_wiki.sql
select
    edit_id,
    edited_at_ts,
    page_title,
    user_name,
    is_bot,
    is_minor_edit,
    is_patrolled,
    characters_changed,
    wiki_domain
from {{ ref('stg_wikipedia__edits') }}