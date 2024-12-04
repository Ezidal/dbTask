INSERT INTO users (username, email)
VALUES 
    ('michael.brown', 'michael.brown@domain.com'),
    ('sarah.jones', 'sarah.jones@domain.com'),
    ('james.wilson', 'james.wilson@domain.com'),
    ('linda.taylor', 'linda.taylor@domain.com'),
    ('robert.anderson', 'robert.anderson@domain.com'),
    ('patricia.thomas', 'patricia.thomas@domain.com'),
    ('joseph.jackson', 'joseph.jackson@domain.com'),
    ('mary.martin', 'mary.martin@domain.com'),
    ('william.lee', 'william.lee@domain.com'),
    ('elizabeth.hall', 'elizabeth.hall@domain.com');

INSERT INTO tasks (user_id, task_description, is_completed)
VALUES 
    (1, 'Finalize the budget report for Q2', FALSE),
    (2, 'Organize the team-building event', TRUE),
    (3, 'Draft the new marketing strategy document', FALSE),
    (4, 'Conduct a client feedback survey', TRUE),
    (5, 'Review the latest product designs', FALSE),
    (6, 'Prepare a presentation for the board meeting', TRUE),
    (7, 'Update the employee handbook', FALSE),
    (8, 'Plan the office holiday party', TRUE),
    (9, 'Analyze sales data for trends', FALSE),
    (10, 'Research competitors’ pricing strategies', TRUE);