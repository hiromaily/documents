UPDATE chat_room
SET
    preferred_reply_at = NULL,
    u1_replied_at = NULL,
    u1_not_need_outline_support_at = NULL,
    updated_at = NOW(3)
WHERE
    preferred_reply_at IS NOT NULL
    OR u1_replied_at IS NOT NULL
    OR u1_not_need_outline_support_at IS NOT NULL;

WITH selecting_chat_room AS (
    SELECT
        id,
        case_id,
        main_responsible_by
    FROM chat_room
    WHERE
        is_continuation_mode
        AND last_browser_opened_at < NOW() - INTERVAL 5 MINUTE
),

updating_chat_room_id AS (
    SELECT DISTINCT scr.id
    FROM (SELECT * FROM selecting_chat_room) AS scr
    INNER JOIN `case` AS c
        ON
            scr.case_id = c.id
            AND c.insurance_type IN ('car', 'fire')
    INNER JOIN hosa_user AS hu
        ON scr.main_responsible_by = hu.id
    INNER JOIN kyoten_chat_setting AS kcs
        ON
            hu.kyoten_id = kcs.kyoten_id
            AND kcs.is_enabled
)

UPDATE chat_room
SET
    is_continuation_mode = FALSE,
    updated_at = NOW(3)
WHERE id IN (SELECT id FROM updating_chat_room_id);
