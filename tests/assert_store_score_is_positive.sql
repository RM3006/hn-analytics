-- tests/assert_story_score_is_positive.sql

-- Ce test recherche toutes les stories dont le score est négatif.
-- S'il en trouve, le test échouera.

select
    item_id,
    score
from {{ ref('fact_stories') }} -- On teste la table finale
where score < 0