CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL, -- Tên danh mục không được để trống 
    description TEXT -- Mô tả chi tiết thể loại
);

CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL, -- Tên tác giả không được để trống
    biography TEXT
);

CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL, -- Tên sách không được để trống
    publish_year int check (publish_year <= EXTRACT(YEAR FROM CURRENT_DATE)), -- Chặn input năm xuất bản ở tương lai
    stock_quantity int DEFAULT 0 CHECK (stock_quantity >= 0),
    category_id int not null, 
    CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
);

CREATE TABLE book_author ( -- Bảng trung gian giải quyết quan hệ N-N
    book_id int not null, -- Khóa ngoại trỏ về book
    author_id int not null, -- Khóa ngoại trỏ về author
    PRIMARY KEY (book_id, author_id),
    CONSTRAINT fk_book FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE, 
    CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES authors(id) ON DELETE CASCADE
);

CREATE TABLE members (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL, -- Tên member không được để trống
    date_of_birth DATE,
    address VARCHAR(500),
    phone VARCHAR(15) UNIQUE, -- Chỉ có 1 sdt 
    email VARCHAR(255) UNIQUE, -- Chỉ có 1 email
    joined_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(50) DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'LOCKED', 'EXPIRED')) -- Quy định trang thái hoạt động của tài khoản
);

CREATE TABLE borrow_tickets (
    id SERIAL PRIMARY KEY,
    member_id INT NOT NULL, 
    borrow_date DATE DEFAULT CURRENT_DATE,
    due_date DATE NOT NULL, -- Ngày hạn trả 
    CONSTRAINT fk_member FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE,
    CONSTRAINT check_dates CHECK (due_date >= borrow_date)
);

CREATE TABLE borrow_details (
    id SERIAL PRIMARY KEY,
    ticket_id INT NOT NULL, 
    book_id INT NOT NULL,
    actual_return_date DATE, -- Ngày trả thực tế ( có thể sớm hoặc trễ hơn due date để tính tiền phạt )
    fine_amount DECIMAL(12, 2) DEFAULT 0.00, 
    status VARCHAR(50) DEFAULT 'BORROWING' CHECK (status IN ('BORROWING', 'RETURNED', 'LOST')),
    CONSTRAINT fk_ticket FOREIGN KEY (ticket_id) REFERENCES borrow_tickets(id) ON DELETE CASCADE,
    CONSTRAINT fk_book_detail FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);