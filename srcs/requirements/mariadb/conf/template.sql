CREATE DATABASE wordpress;


-- Create the user and grant privileges
CREATE USER 'robin'@'localhost' IDENTIFIED BY 'robin';
GRANT ALL PRIVILEGES ON wordpress.* TO 'robin'@'localhost';
FLUSH PRIVILEGES;
