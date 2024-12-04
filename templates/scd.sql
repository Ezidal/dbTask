INSERT INTO users (username, email)
VALUES 
    ('alice.smith', 'alice.smith@domain.com'),
    ('bob.johnson', 'bob.johnson@domain.com'),
    ('charlie.brown', 'charlie.brown@domain.com'),
    ('david.wilson', 'david.wilson@domain.com'),
    ('eve.davis', 'eve.davis@domain.com'),
    ('frank.miller', 'frank.miller@domain.com'),
    ('grace.lee', 'grace.lee@domain.com'),
    ('henry.thompson', 'henry.thompson@domain.com'),
    ('isabella.moore', 'isabella.moore@domain.com'),
    ('jack.white', 'jack.white@domain.com');

INSERT INTO tasks (user_id, task_description, is_completed)
VALUES 
    (1, 'Prepare project presentation for client meeting', FALSE),
    (2, 'Complete the quarterly financial report', TRUE),
    (3, 'Update the website content with new products', FALSE),
    (4, 'Schedule a team lunch for next week', TRUE),
    (5, 'Review and approve the marketing plan draft', FALSE),
    (6, 'Conduct a performance review for team members', TRUE),
    (7, 'Organize the office supply inventory', FALSE),
    (8, 'Create a training module for new employees', TRUE),
    (9, 'Plan the upcoming company retreat logistics', FALSE),
    (10, 'Research industry trends for the next strategy meeting', TRUE);