INSERT INTO users (username, email)
VALUES 
   ('madison.sanders','madison.sanders@example.com'), 
   ('dylan.phillips','dylan.phillips@example.com'), 
   ('lily.rivera','lily.rivera@example.com'), 
   ('mason.cook','mason.cook@example.com'), 
   ('samantha.ward','samantha.ward@example.com'), 
   ('aiden.bell','aiden.bell@example.com'), 
   ('natalie.hughes','natalie.hughes@example.com'), 
   ('ryan.morris','ryan.morris@example.com'), 
   ('victoria.reed','victoria.reed@example.com'), 
   ('caleb.price','caleb.price@example.com'); 

INSERT INTO tasks (user_id, task_description,is_completed) 
VALUES 
   (1,'Develop a new employee training program.',FALSE), 
   (2,'Audit current software licenses.',TRUE), 
   (3,'Implement new project management tool.',FALSE), 
   (4,'Schedule routine maintenance checks.',TRUE), 
   (5,'Conduct market research on competitors.',FALSE), 
   (6,'Organize team feedback sessions.',TRUE), 
   (7,'Update company policy documents.',FALSE), 
   (8,'Prepare annual budget proposals.',TRUE), 
   (9,'Review employee satisfaction survey results.',FALSE),  
   (10,'Plan quarterly team outing.',TRUE);  