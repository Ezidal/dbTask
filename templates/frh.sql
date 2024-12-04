INSERT INTO users (username, email)
VALUES 
    ('charlie.jameson', 'charlie.jameson@domain.com'),
    ('grace.perez', 'grace.perez@domain.com'),
    ('henry.kim', 'henry.kim@domain.com'),
    ('isabella.brownlee', 'isabella.brownlee@domain.com'),
    ('oliver.johnsonson', 'oliver.johnsonson@domain.com'),
    ('amelia.torres', 'amelia.torres@domain.com'),
    ('ethan.whitehead', 'ethan.whitehead@domain.com'),
    ('zoe.clarkson', 'zoe.clarkson@domain.com'),
    ('alexander.carter', 'alexander.carter@domain.com'),
    ('scarlett.adams', 'scarlett.adams@domain.com');

INSERT INTO tasks (user_id, task_description, is_completed)
VALUES 
    (1, 'Design a new logo for the product line', FALSE),
    (2, 'Research potential partnerships with influencers', TRUE),
    (3, 'Create an onboarding checklist for new employees', FALSE),
    (4, 'Evaluate current vendor contracts and renewals', TRUE),
    (5, 'Update training materials for staff development programs', FALSE),
    (6, 'Conduct a risk assessment for ongoing projects', TRUE),
    (7, 'Prepare a summary of last quarter's sales performance', FALSE),
    (8, 'Compile a list of industry conferences to attend this year', TRUE),
    (9, 'Create a FAQ document for customer support team', FALSE),
    (10, 'Plan and execute a charity event for team bonding', TRUE);