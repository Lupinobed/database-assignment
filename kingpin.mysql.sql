CREATE DATABASE bookstore;
USE bookstore;
-- Book Language
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_code VARCHAR(8) NOT NULL,
    language_name VARCHAR(50) NOT NULL
);

-- Publisher
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(100) NOT NULL
);

-- Country
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(50) NOT NULL
);

-- Address Status
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    address_status VARCHAR(20) NOT NULL
);

-- Order Status
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_value VARCHAR(20) NOT NULL
);

-- Shipping Method
CREATE TABLE shipping_method (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL,
    cost DECIMAL(6, 2) NOT NULL
);-- Book
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    num_pages INT,
    publication_date DATE,
    publisher_id INT,
    language_id INT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

-- Author
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

-- Book-Author Relationship (many-to-many)
CREATE TABLE book_author (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);-- Customer
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Address
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street_number VARCHAR(10) NOT NULL,
    street_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country_id INT NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- Customer-Address Relationship
CREATE TABLE customer_address (
    customer_id INT NOT NULL,
    address_id INT NOT NULL,
    status_id INT NOT NULL,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);-- Customer Order
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    customer_id INT NOT NULL,
    shipping_address_id INT NOT NULL,
    shipping_method_id INT NOT NULL,
    order_total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_address_id) REFERENCES address(address_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id)
);

-- Order Line
CREATE TABLE order_line (
    line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- Order History
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    status_id INT NOT NULL,
    status_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);-- Create roles
CREATE ROLE 'bookstore_admin', 'bookstore_staff', 'bookstore_customer';

-- Admin privileges (full access)
GRANT ALL PRIVILEGES ON bookstore.* TO 'bookstore_admin';

-- Staff privileges (read/write access but no schema changes)
GRANT SELECT, INSERT, UPDATE, DELETE ON bookstore.* TO 'bookstore_staff';

-- Customer privileges (read access to books, write access to orders)
GRANT SELECT ON bookstore.book TO 'bookstore_customer';
GRANT SELECT ON bookstore.author TO 'bookstore_customer';
GRANT SELECT ON bookstore.book_author TO 'bookstore_customer';
GRANT SELECT ON bookstore.publisher TO 'bookstore_customer';
GRANT SELECT ON bookstore.book_language TO 'bookstore_customer';
GRANT SELECT, INSERT, UPDATE ON bookstore.cust_order TO 'bookstore_customer';
GRANT SELECT, INSERT, UPDATE ON bookstore.order_line TO 'bookstore_customer';
GRANT SELECT, INSERT, UPDATE ON bookstore.customer TO 'bookstore_customer';
GRANT SELECT, INSERT, UPDATE ON bookstore.address TO 'bookstore_customer';
GRANT SELECT, INSERT, UPDATE ON bookstore.customer_address TO 'bookstore_customer';

-- Create users and assign roles
CREATE USER 'nita'@'localhost' IDENTIFIED BY 'secure_password';
CREATE USER 'obed_user'@'localhost' IDENTIFIED BY 'staff_password';
CREATE USER 'mpendulo_user'@'localhost' IDENTIFIED BY 'customer_password';

GRANT 'bookstore_admin' TO 'nita'@'localhost';
GRANT 'bookstore_staff' TO 'obed_user'@'localhost';
GRANT 'bookstore_customer' TO 'mpendulo_user'@'localhost';

-- Activate roles for users
SET DEFAULT ROLE ALL TO 'nita'@'localhost';
SET DEFAULT ROLE ALL TO 'obed_user'@'localhost';
SET DEFAULT ROLE ALL TO 'mpendulo_user'@'localhost';

-- Insert into book_language
INSERT INTO book_language (language_code, language_name) VALUES 
('EN', 'English'),
('FR', 'French'),
('ES', 'Spanish'),
('DE', 'German');

-- Insert into publisher
INSERT INTO publisher (publisher_name) VALUES 
('Penguin Random House'),
('HarperCollins'),
('Simon & Schuster'),
('Hachette Livre');

-- Insert into country
INSERT INTO country (country_name) VALUES 
('United States'),
('United Kingdom'),
('France'),
('Germany'),
('Spain');

-- Insert into address_status
INSERT INTO address_status (address_status) VALUES 
('Current'),
('Previous'),
('Billing'),
('Shipping');

-- Insert into order_status
INSERT INTO order_status (status_value) VALUES 
('Pending'),
('Processing'),
('Shipped'),
('Delivered'),
('Cancelled');

-- Insert into shipping_method
INSERT INTO shipping_method (method_name, cost) VALUES 
('Standard Shipping', 5.99),
('Express Shipping', 12.99),
('International Shipping', 25.99);

-- Insert into author
INSERT INTO author (first_name, last_name) VALUES 
('George', 'Orwell'),
('J.K.', 'Rowling'),
('Stephen', 'King'),
('Agatha', 'Christie'),
('Ernest', 'Hemingway');

-- Insert into book
INSERT INTO book (title, isbn, num_pages, publication_date, publisher_id, language_id, price, stock_quantity) VALUES 
('1984', '9780451524935', 328, '1949-06-08', 1, 1, 9.99, 50),
('Harry Potter and the Philosopher''s Stone', '9780747532743', 223, '1997-06-26', 2, 1, 12.99, 100),
('The Shining', '9780307743657', 447, '1977-01-28', 3, 1, 14.99, 30),
('Murder on the Orient Express', '9780062073501', 256, '1934-01-01', 4, 1, 8.99, 40),
('The Old Man and the Sea', '9780684801223', 127, '1952-09-01', 1, 1, 7.99, 25);

-- Insert into book_author (linking books to authors)
INSERT INTO book_author (book_id, author_id) VALUES 
(1, 1), -- 1984 by George Orwell
(2, 2), -- Harry Potter by J.K. Rowling
(3, 3), -- The Shining by Stephen King
(4, 4), -- Murder on the Orient Express by Agatha Christie
(5, 5); -- The Old Man and the Sea by Ernest Hemingway

-- Insert into customer
INSERT INTO customer (first_name, last_name, email, phone) VALUES 
('obed', 'magori', 'obed.magori@example.com', '+1234567890'),
('nita', 'Smith', 'nita.smith@example.com', '+1987654321'),
('mpendulo', 'soutafrica', 'mike.johnson@example.com', '+1122334455');

-- Insert into address
INSERT INTO address (street_number, street_name, city, country_id, postal_code) VALUES 
('123', 'Main St', 'New York', 1, '10001'),
('456', 'Elm St', 'London', 2, 'SW1A 1AA'),
('789', 'Oak Ave', 'Paris', 3, '75001');

-- Insert into customer_address (linking customers to addresses)
INSERT INTO customer_address (customer_id, address_id, status_id) VALUES 
(1, 1, 1), -- John Doe's current address
(2, 2, 1), -- Jane Smith's current address
(3, 3, 1); -- Mike Johnson's current address

-- Insert into cust_order (sample orders)
INSERT INTO cust_order (customer_id, shipping_address_id, shipping_method_id, order_total) VALUES 
(1, 1, 1, 24.98), -- John's order
(2, 2, 2, 12.99), -- Jane's order
(3, 3, 3, 14.99); -- Mike's order

-- Insert into order_line (books in each order)
INSERT INTO order_line (order_id, book_id, quantity, price) VALUES 
(1, 1, 1, 9.99), -- John bought 1984
(1, 2, 1, 12.99), -- John also bought Harry Potter
(2, 3, 1, 14.99), -- Jane bought The Shining
(3, 4, 1, 8.99); -- Mike bought Murder on the Orient Express

-- Insert into order_history (tracking order status changes)
INSERT INTO order_history (order_id, status_id) VALUES 
(1, 1), -- John's order is Pending
(2, 3), -- Jane's order is Shipped
(3, 4); -- Mike's order is Delivered
-- Book Languages
INSERT INTO book_language (language_code, language_name) VALUES 
('EN', 'English'),
('FR', 'French'),
('ES', 'Spanish'),
('DE', 'swahili'),
('IT', 'Italian'),
('RU', 'Russian'),
('JA', 'Japanese'),
('ZH', 'Chinese');

-- Publishers
INSERT INTO publisher (publisher_name) VALUES 
('kenyatta university'),
('HarperCollins'),
('Simon & Schuster'),
('Hachette Livre'),
('Macmillan Publishers'),
('Scholastic Corporation'),
('Pearson Education'),
('Oxford University Press'),
('Cambridge University Press'),
('Wiley');

-- Countries
INSERT INTO country (country_name) VALUES 
('United States'),
('United Kingdom'),
('France'),
('kenya'),
('Spain'),
('Italy'),
('Canada'),
('Australia'),
('Japan'),
('China');

-- Address Statuses
INSERT INTO address_status (address_status) VALUES 
('Current'),
('Previous'),
('Billing'),
('Shipping'),
('Work'),
('Vacation');
