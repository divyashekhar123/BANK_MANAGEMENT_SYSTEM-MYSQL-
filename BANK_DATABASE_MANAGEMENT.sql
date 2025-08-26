CREATE DATABASE Bankingsystem;
USE Bankingsystem;

CREATE TABLE customers(
	customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dob DATE,
    address VARCHAR(255),
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Branch(
	branch_id INT auto_increment PRIMARY KEY,
	branch_name VARCHAR(100) NOT NULL,
    branch_city VARCHAR(100) NOT NULL
);

CREATE TABLE account(
	account_id INT auto_increment PRIMARY KEY,
    Customer_id INT,
    branch_id INT,
    account_type ENUM('saving', 'current', 'fixed deposit') NOT NULL,
    balance DECIMAL(12, 2) DEFAULT 0.00,
    foreign key (CUSTOMER_ID) references customers(customer_id),
    foreign key (branch_id) references branch(branch_id)
);

CREATE TABLE transaction(
	transaction_id INT auto_increment PRIMARY KEY,
    account_id INT,
    transaction_type ENUM('deposit', 'withdrawal', 'transfer') NOT NULL,
    amount DECIMAL(12, 2) NOT NULL,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES account(account_id)
);

CREATE TABLE loan(
	loan_id INT auto_increment PRIMARY KEY,
    customer_id INT,
    branch_id INT,
    loan_amount DECIMAL(22, 2) NOT NULL,
    loan_type ENUM('home', 'car', 'presonal', 'eductaion') NOT NULL,
    issue_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

INSERT INTO customers(name, dob, address, phone, email) VALUES
('SHEKHAR', '2004-03-21', 'BIHAR', '8434718335', 'divyashekhar1338@gmail.com'),
('jyoti', '2004-01-01', 'JHARKHAND', '9966773344', 'jyotisarangi1228@gmail.com');

INSERT INTO branch (branch_name, branch_city) VALUES
('PATNA', 'BIHAR'),
('RANCHI', 'JHARKHAND');

INSERT INTO account (customer_id, branch_id, account_type, balance) VALUES
(1, 1, 'saving', 50000.00),
(2, 2, 'current', 150000.00);

INSERT INTO transaction (account_id, transaction_type, amount) VALUES
(1, 'deposit', 10000.00),
(1, 'withdrawal', 5000.00),
(2, 'deposit', 20000.00);

INSERT INTO loan (customer_id, branch_id, loan_amount, loan_type, issue_date) VALUES
(1, 1, 250000.00, 'home', '2023-01-15'),
(2, 2, 500000.00, 'car', '2023-06-23');

SELECT c.name, a.account_type, a.balance
FROM account a
JOIN Customers c ON a.customer_id = c.customer_id;

SELECT c.name, t.transaction_type, t.amount, t.transaction_date
FROM transaction t
JOIN account a ON t.account_id=a.account_id
JOIN customers c ON a.customer_id=c.customer_id
WHERE c.name = 'SHEKHAR';

SELECT c.name, l.loan_type, l.loan_amount
FROM loan l
JOIN customers c ON l.customer_id = c.customer_id;