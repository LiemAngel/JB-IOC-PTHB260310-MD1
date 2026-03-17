CREATE SCHEMA sales
CREATE TABLE sales.Customers (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) UNIQUE,
	last_name VARCHAR(50) UNIQUE,
	email VARCHAR(100) UNIQUE NOT NULL,
	phone VARCHAR(20)
)
CREATE TABLE sales.Products (
	id  SERIAL PRIMARY KEY,
	product_name VARCHAR(100) UNIQUE NOT NULL,
	price numeric(10,2),
	stock_quantity int NOT NULL CHECK (stock_quantity >=0 )
)
CREATE TABLE sales.Orders (
	id SERIAL PRIMARY KEY,
	order_date timestamp,
	customer_id int NOT NULL,
	CONSTRAINT fk_customer
	FOREIGN KEY(customer_id)
	REFERENCES sales.Customers	
)
CREATE TABLE sales.OrderItem (
	id SERIAL PRIMARY KEY,
	order_id int NOT NULL,
	product_id int NOT NULL,
	quantity int CHECK (quantity >=1 ),
	CONSTRAINT fk_order
		FOREIGN KEY(order_id)
		REFERENCES sales.Orders,
	CONSTRAINT fk_product
		FOREIGN KEY(product_id)
		REFERENCES sales.Products
)