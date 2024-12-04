INSERT INTO users (username, email)
VALUES 
    ('olivia.miller', 'olivia.miller@domain.com'),
    ('noah.davis', 'noah.davis@domain.com'),
    ('ava.garcia', 'ava.garcia@domain.com'),
    ('liam.rodriguez', 'liam.rodriguez@domain.com'),
    ('sophia.wilson', 'sophia.wilson@domain.com'),
    ('benjamin.martinez', 'benjamin.martinez@domain.com'),
    ('ella.hernandez', 'ella.hernandez@domain.com'),
    ('lucas.lopez', 'lucas.lopez@domain.com'),
    ('mia.gonzalez', 'mia.gonzalez@domain.com'),
    ('jack.smith', 'jack.smith@domain.com');

INSERT INTO tasks (user_id, task_description, is_completed)
VALUES 
    (1, 'Create a social media campaign plan', FALSE),
    (2, 'Update the website SEO settings', TRUE),
    (3, 'Conduct a training session for new hires', FALSE),
    (4, 'Prepare quarterly performance reviews', TRUE),
    (5, 'Organize files in the shared drive', FALSE),
    (6, 'Draft an article for the company newsletter', TRUE),
    (7, 'Set up a meeting with potential clients', FALSE),
    (8, 'Review the IT security protocols', TRUE),
    (9, 'Compile customer feedback for analysis', FALSE),
    (10, 'Plan a webinar on industry trends', TRUE);