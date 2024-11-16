UPDATE sms_auth
SET
    status = @status,
    updated_at = NOW(3)
WHERE id IN (@ids);
