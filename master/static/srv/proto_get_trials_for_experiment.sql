SELECT t.id AS id,
    t.experiment_id,
    'STATE_' || t.state AS state,
    t.start_time,
    t.end_time,
    t.hparams,
    (
        SELECT s.total_batch
        FROM steps s
        WHERE s.trial_id = t.id
            AND s.state = 'COMPLETED'
        ORDER BY s.total_batch DESC
        LIMIT 1
    ) AS total_batches_processed
FROM trials t
WHERE t.experiment_id = $1
