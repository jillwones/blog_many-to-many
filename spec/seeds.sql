TRUNCATE TABLE posts, tags, posts_tags RESTART IDENTITY; 

INSERT INTO posts (title, content) VALUES ('A new day', 'interesting stuff here');
INSERT INTO posts (title, content) VALUES ('Second post', 'less interesting stuff here');
INSERT INTO tags (name) VALUES ('happy');
INSERT INTO tags (name) VALUES ('exciting');
INSERT INTO tags (name) VALUES ('sad');
INSERT INTO posts_tags (post_id, tag_id) VALUES(1,1);
INSERT INTO posts_tags (post_id, tag_id) VALUES(2,1);
INSERT INTO posts_tags (post_id, tag_id) VALUES(1,2);
INSERT INTO posts_tags (post_id, tag_id) VALUES(2,3);
INSERT INTO posts_tags (post_id, tag_id) VALUES(2,2);