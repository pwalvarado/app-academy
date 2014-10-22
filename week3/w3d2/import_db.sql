CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255),
  lname VARCHAR(255)
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255),
  body TEXT,
  user_id INTEGER,
  
  FOREIGN KEY (user_id) REFERENCES users(id),
  unique (title, user_id)
);

CREATE TABLE question_followers (
  id INTEGER PRIMARY KEY,
  user_id INTEGER,
  question_id INTEGER,
  
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT,
  user_id INTEGER,
  question_id INTEGER,
  parent_id INTEGER,
  
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id)
);

CREATE TABLE question_likes(
  id INTEGER PRIMARY KEY,
  user_id INTEGER,
  question_id INTEGER,
  
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Isis', 'Wenger'), ('David', 'Runger'), ('YanRan', 'Zen');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('Great Question', 'What is the answer to the great question?', 
  (SELECT id FROM users WHERE fname = 'Isis' AND lname = 'Wenger')),
  ('Hygiene', 'Why wouldnt you shower and use deodorant?',
  (SELECT id FROM users WHERE fname = 'David' AND lname = 'Runger'));

INSERT INTO
  question_followers (user_id, question_id)
VALUES
  (
    (SELECT id FROM users WHERE fname = 'David' AND lname = 'Runger'), 
    (SELECT id FROM questions WHERE title = 'Great Question'AND user_id = (SELECT id FROM users WHERE fname = 'Isis' AND lname = 'Wenger'))
  ),
  (
    (SELECT id FROM users WHERE fname = 'YanRan' AND lname = 'Zen'), 
    (SELECT id FROM questions WHERE title = 'Great Question'AND user_id = (SELECT id FROM users WHERE fname = 'Isis' AND lname = 'Wenger'))
  ),
  (
    (SELECT id FROM users WHERE fname = 'David' AND lname = 'Runger'), 
    (SELECT id FROM questions WHERE title = 'Hygiene'AND user_id = (SELECT id FROM users WHERE fname = 'David' AND lname = 'Runger'))
  );
  
  
INSERT INTO
  replies (body, user_id, question_id, parent_id)
VALUES
  (
    'They are afraid of carcinogens and are too poor for all-natural.',
    (SELECT id FROM users WHERE fname = 'YanRan' AND lname = 'Zen'),
    (SELECT id FROM questions WHERE title = 'Hygiene' AND user_id = (SELECT id FROM users WHERE fname = 'David' AND lname = 'Runger')),
    NULL
  ),
  (
    
    'Uhhmm... thats ignorant!',
    (SELECT id FROM users WHERE fname = 'Isis' AND lname = 'Wenger'),
    (SELECT id FROM questions WHERE title = 'Hygiene' AND user_id = (SELECT id FROM users WHERE fname = 'David' AND lname = 'Runger')),
    (SELECT id FROM replies WHERE body = 'They are afraid of carcinogens and are too poor for all-natural.')
  );

INSERT INTO
  question_likes (user_id, question_id)
VALUES
(
  (SELECT id FROM users WHERE fname = 'YanRan' AND lname = 'Zen'), 
  (SELECT id FROM questions WHERE title = 'Great Question'AND user_id = (SELECT id FROM users WHERE fname = 'Isis' AND lname = 'Wenger'))
),
(
  (SELECT id FROM users WHERE fname = 'Isis' AND lname = 'Wenger'), 
  (SELECT id FROM questions WHERE title = 'Great Question'AND user_id = (SELECT id FROM users WHERE fname = 'Isis' AND lname = 'Wenger'))
),
(
  (SELECT id FROM users WHERE fname = 'David' AND lname = 'Runger'), 
  (SELECT id FROM questions WHERE title = 'Hygiene'AND user_id = (SELECT id FROM users WHERE fname = 'David' AND lname = 'Runger'))
);