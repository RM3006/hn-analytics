{% snapshot scd_pages %}

{{
    config(
      target_schema='ANALYTICS',
      strategy='check',
      unique_key='page_title',
      check_cols=['wiki_domain'],
    )
}}

-- On sélectionne les données depuis le staging
select 
    page_title,
    wiki_domain
from {{ ref('stg_wikipedia__edits') }}

-- On ajoute une clause de déduplication
qualify row_number() over (partition by page_title order by edited_at_ts desc) = 1

{% endsnapshot %}