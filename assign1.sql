--CREATE THE TABLES--
CREATE TABLE folder
(
    folder_id   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    folder_name TEXT
);
--DROP TABLE folder cascade ;

CREATE TABLE label
(
    label_id   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    label_name TEXT
);
--DROP TABLE label cascade ;

CREATE TABLE contact
(

    contact_id   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    contact_name TEXT,
    contact_phone VARCHAR(25),
    contact_email_address TEXT,
    folder_id INTEGER REFERENCES folder(folder_id)

);
--DROP TABLE contact cascade;
 CREATE TABLE email
(
    email_id        INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email_date      TIMESTAMP DEFAULT now(),
    email_subject   TEXT,
    contact_id      INTEGER REFERENCES contact (contact_id)
);
--DROP TABLE email cascade ;
CREATE TABLE conversation
(
    conversation_id      INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    conversation_content TEXT,
    conversation_date    TIMESTAMP DEFAULT now(),
    contact_id            INTEGER REFERENCES contact(contact_id)
);
--DROP TABLE conversation cascade ;

/*CREATE TABLE groups
(
    group_id          INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    conversation_id   INTEGER REFERENCES conversation (conversation_id),
    members_count INTEGER,
    emails_of_members TEXT ARRAY

); */
--DROP TABLE groups cascade ;

CREATE TABLE member
(
member_id INTEGER GENERATED ALWAYS AS IDENTITY,
conversation_id INTEGER REFERENCES conversation(conversation_id),
primary key (member_id, conversation_id)
);
--DROP TABLE member cascade;
CREATE TABLE replay
(
    replay_id INTEGER GENERATED ALWAYS AS IDENTITY,
    replay_content TEXT,
    member_id INTEGER REFERENCES member(member_id) NOT NULL,
    primary key (replay_id, member_id)
);
CREATE TABLE email_label
(
    contact_id INTEGER REFERENCES contact(contact_id),
    label_id INTEGER REFERENCES label(label_id),
    primary key (contact_id, label_id)
);
CREATE TABLE email_group
(
    email_id INTEGER REFERENCES email(email_id),
    group_id INTEGER REFERENCES groups(group_id),
    primary key (email_id, group_id)
);
CREATE TABLE email_conversation:
(
    email_id INTEGER REFERENCES email(email_id),
    conversation_id INTEGER REFERENCES conversation(conversation_id),
    primary key (email_id, conversation_id)
);
--Drop TABLE replay cascade;
INSERT INTO label(label_name) VALUES ('DB class');
INSERT INTO folder(folder_name, folder_path, folder_size) VALUES ('first folder','c:/Desktop/new_folder', '20kb');
INSERT INTO contact(user_name, user_phone, user_email, folder_id) VALUES ('jade', '666-777-0000', '@gmail.com', 1);
INSERT INTO conversation(conversation_content, contact_id) VALUES ('let us talk about databases', 1);