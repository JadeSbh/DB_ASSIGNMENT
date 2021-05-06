--CREATE THE TABLES--

/* according to my interruption of the text, there are 8 entities and one many_to_many
relationship. Therefore, I have 9 tables to create   */
CREATE TABLE users
(
    user_email    Text primary key,
    user_name     VARCHAR(50),
    user_password CHAR(60)
);
INSERT INTO users
VALUES ('jade@gmail.com', 'jade', 'hay');
--DROP TABLE users;

CREATE TABLE box
(
    box_id   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    box_name TEXT
);
INSERT INTO box(box_name)
VALUES ('Inbox');
INSERT INTO box(box_name)
VALUES ('Favorites');
--DROP TABLE box;

CREATE TABLE folder
(
    folder_id   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    folder_name TEXT,
    box_id      INTEGER REFERENCES box (box_id)
);
INSERT INTO folder(folder_name, box_id)
VALUES ('January email', 1);
INSERT INTO folder(folder_name, box_id)
VALUES ('NOT IMPORTANT', 1);
--DROP TABLE folder cascade ;
--DROP TABLE folder;

CREATE TABLE label
(
    label_id   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    label_name TEXT
);
INSERT INTO label(label_name)
VALUES ('Database class');
INSERT INTO label(label_name)
VALUES ('Internet class');

--DROP TABLE label cascade ;

CREATE TABLE contact
(
    contact_id            INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    contact_name          TEXT,
    contact_phone         VARCHAR(25),
    contact_email_address TEXT,
    user_email            text REFERENCES users (user_email) NOT NULL,
    folder_id             INTEGER REFERENCES folder (folder_id) NOT NULL

);
INSERT INTO contact(contact_name, contact_phone, contact_email_address, user_email, folder_id)
VALUES ('Alice', '555-666-0000', 'Alice@gmail.com', 'jade@gmail.com', 1);
INSERT INTO contact(contact_name, contact_phone, contact_email_address, user_email, folder_id)
VALUES ('John', '111-222-0000', 'john@gmail.com', 'jade@gmail.com', 1);
INSERT INTO contact(contact_name, contact_phone, contact_email_address, user_email, folder_id)
VALUES ('Lara', '777-777-7777', 'Lara@gmail.com', 'jade@gmail.com', 1);
INSERT INTO contact(contact_name, contact_phone, contact_email_address, user_email, folder_id)
VALUES ('Rana', '777-222-9999', 'Rana@gmail.com', 'jade@gmail.com', 1);


--DROP TABLE contact cascade;

CREATE TABLE email
(
    email_id      INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email_date    TIMESTAMP DEFAULT now(),
    email_subject TEXT,
    email_content TEXT,
    contact_id    INTEGER REFERENCES contact (contact_id),
    user_email    text REFERENCES users (user_email)
);
INSERT INTO email(email_date, email_subject, email_content, contact_id,user_email)
VALUES ('2021-05-05', 'Database exercises', 'HI, its Alice, Did you enjoy the exercises with Mr.Denis', 1,'jade@gmail.com' );
INSERT INTO email(email_date, email_subject, email_content, contact_id,user_email)
VALUES ('2021-05-05', 'Programing modification assignment', 'Hi its John, How do you find the assignment?', 2,'jade@gmail.com');
--DROP TABLE email cascade ;
CREATE TABLE conversation
(
    conversation_id   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    conversation_date TIMESTAMP DEFAULT now(),
    contact_id        INTEGER REFERENCES contact (contact_id),
    email_id          INTEGER REFERENCES email (email_id) NOT NULL
);
INSERT INTO conversation(conversation_date, email_id)
VALUES ('2021-05-05', 1);
INSERT INTO conversation(conversation_date, email_id)
VALUES ('2021-05-05', 2);
--DROP TABLE conversation cascade ;

/* little note: on ER relationship model, It is possible to make
   the entity conversation a weak entity. in that case,
   in the relational schema here the primary key would be
   constrained of (conversation-id, contact-id)
 */

/*
CREATE TABLE member
(
    member_id       INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    contact_id      INTEGER REFERENCES contact (contact_id),
    conversation_id INTEGER REFERENCES conversation (conversation_id)
);
/* Here are two members (Rana & Lara) of the conversation that the
   contact Alice initiated with her email that its email-id is 1
 */
INSERT INTO member(contact_id, conversation_id)
VALUES (3, 1);
INSERT INTO member(contact_id, conversation_id)
VALUES (4, 1);
SELECT *
FROM member;
--DROP TABLE member cascade;
/* little note: as before this one could be represented as a weak
   entity in ER relational model.*/
*/
CREATE TABLE reply
(
    reply_id       INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    conversation_id INTEGER REFERENCES conversation (conversation_id) NOT NULL,
    reply_content  TEXT,
    parent_id       INTEGER REFERENCES reply(reply_id)

);
INSERT INTO reply(conversation_id,parent_id, reply_content)
VALUES (1, NULL, 'HI Alice, its Lara, yes I do enjoy his database class');
INSERT INTO reply(conversation_id, parent_id, reply_content)
VALUES (1, 1, 'HI Alice, its Rana, yes I did enjoy it, you?');
SELECT *
FROM reply;
CREATE TABLE contact_label
(
    contact_id INTEGER REFERENCES contact (contact_id) NOT NULL,
    label_id   INTEGER REFERENCES label (label_id)     NOT NULL,
    primary key (contact_id, label_id)
);

Drop TABLE reply cascade;
CREATE TABLE contact_conversation
(
    contact_id      INTEGER REFERENCES contact (contact_id),
    conversation_id INTEGER REFERENCES conversation (conversation_id),
    primary key (contact_id, conversation_id)

);
CREATE TABLE contact_email
(
    contact_id INTEGER REFERENCES contact (contact_id),
    email_id   INTEGER REFERENCES email (email_id),
    primary key (contact_id, email_id)
)
