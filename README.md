# Bookstore Database

This project is a relational database schema for managing a bookstore, designed in MySQL. It includes entities such as books, authors, customers, orders, and shipping information, with roles and permissions for different types of users.

---

## Database Name
`bookstore`

---

## Tables Overview

### 1. Book Management
- **`book_language`**: Languages in which books are available.
- **`publisher`**: Book publishers.
- **`book`**: Main book table containing details like title, ISBN, price, etc.
- **`author`**: Author details.
- **`book_author`**: Many-to-many relationship between books and authors.

### 2. Customer Management
- **`customer`**: Stores customer information.
- **`address`**: Stores physical addresses.
- **`country`**: Country reference data.
- **`address_status`**: Status of the customer's address (e.g., Current, Billing).
- **`customer_address`**: Maps customers to addresses with a status.

### 3. Order Management
- **`cust_order`**: Orders placed by customers.
- **`order_line`**: Items in each order.
- **`order_status`**: Statuses for tracking orders (Pending, Shipped, etc.).
- **`order_history`**: Logs status changes of orders over time.
- **`shipping_method`**: Shipping options and associated costs.

---

## User Roles

- **`bookstore_admin`**: Full access to all tables and operations.
- **`bookstore_staff`**: Can read/write data but cannot alter the schema.
- **`bookstore_customer`**: Can read book data and create/manage orders and addresses.

---

## User Accounts

| Username         | Role               | Access Level              |
|------------------|--------------------|---------------------------|
| `nita`           | `bookstore_admin`  | Full access               |
| `obed_user`      | `bookstore_staff`  | Read/write                |
| `mpendulo_user`  | `bookstore_customer` | Limited (view books, manage orders) |

---

## Sample Data Included

- **Languages**: English, French, Spanish, Swahili, etc.
- **Publishers**: Penguin, HarperCollins, KU Press, etc.
- **Authors**: George Orwell, J.K. Rowling, etc.
- **Books**: Titles with ISBN, pricing, and stock.
- **Customers**: Sample customer data with addresses and orders.
- **Order Entries**: Example orders with shipping methods and history logs.

---

## Getting Started

1. Run the SQL script in a MySQL environment.
2. Ensure proper privileges are set up for your user roles.
3. Add more data or build a frontend to connect to this database.

---

## Notes

- Ensure MySQL is running with proper user permissions to create roles and users.
- You may want to use `INSERT IGNORE` or de-duplicate values to avoid conflicts.
- Consider adding indices for frequent lookups (e.g., `email`, `isbn`, `order_date`).


