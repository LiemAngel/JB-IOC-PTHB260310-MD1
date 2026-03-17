-- 2. Tạo Schema shop
CREATE SCHEMA  shop;

-- 3. Bảng Categories - Danh mục sản phẩm (Tạo trước để Products tham chiếu)
CREATE TABLE shop.Categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL
);

-- 4. Bảng Users - Tài khoản người dùng
CREATE TABLE shop.Users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) DEFAULT 'Customer' CHECK (role IN ('Customer', 'Admin'))
);

-- 5. Bảng Products - Sản phẩm
CREATE TABLE shop.Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price NUMERIC(10,2) NOT NULL CHECK (price > 0),
    stock INT NOT NULL CHECK (stock >= 0),
    category_id INT,
    CONSTRAINT fk_category 
        FOREIGN KEY (category_id) 
        REFERENCES shop.Categories(category_id)
);

-- 6. Bảng Orders - Đơn hàng
CREATE TABLE shop.Orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATE NOT NULL DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'Pending' CHECK (status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled')),
    CONSTRAINT fk_user 
        FOREIGN KEY (user_id) 
        REFERENCES shop.Users(user_id)
);

-- 7. Bảng OrderDetails - Chi tiết đơn hàng
CREATE TABLE shop.OrderDetails (
    order_detail_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price_each NUMERIC(10,2) NOT NULL CHECK (price_each > 0),
    CONSTRAINT fk_order 
        FOREIGN KEY (order_id) 
        REFERENCES shop.Orders(order_id) ON DELETE CASCADE,
    CONSTRAINT fk_product 
        FOREIGN KEY (product_id) 
        REFERENCES shop.Products(product_id)
);

-- 8. Bảng Payments - Thanh toán
CREATE TABLE shop.Payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    amount NUMERIC(10,2) NOT NULL CHECK (amount >= 0),
    payment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    method VARCHAR(30) NOT NULL CHECK (method IN ('Credit Card', 'Momo', 'Bank Transfer', 'Cash')),
    CONSTRAINT fk_order_payment 
        FOREIGN KEY (order_id) 
        REFERENCES shop.Orders(order_id)
);