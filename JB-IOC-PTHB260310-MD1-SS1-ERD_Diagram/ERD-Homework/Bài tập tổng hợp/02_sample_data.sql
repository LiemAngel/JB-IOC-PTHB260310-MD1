-- 1. Thêm Thể loại
INSERT INTO categories (name, description) VALUES 
('Lập trình', 'Sách kỹ thuật phần mềm'),
('Văn học', 'Truyện ngắn và tiểu thuyết');

-- 2. Thêm Tác giả
INSERT INTO authors (name, biography) VALUES 
('Robert C. Martin', 'Tác giả sách Clean Code'),
('Nguyễn Nhật Ánh', 'Nhà văn nổi tiếng Việt Nam');

-- 3. Thêm Sách 
INSERT INTO books (title, publish_year, stock_quantity, category_id) VALUES 
('Clean Code', 2008, 5, 1),
('Mắt Biếc', 1990, 3, 2);

-- 4. Thêm Thành viên
INSERT INTO members (full_name, phone, email) VALUES 
('Nguyễn Văn Anh', '0912345678', 'anhnv@gmail.com'),
('Lê Thị Bình', '0987654321', 'binhlt@gmail.com');

-- 5. Tạo Phiếu mượn
INSERT INTO borrow_tickets (member_id, due_date) VALUES 
(1, '2026-03-20'),
(2, '2026-03-15');

-- 6. Thêm Chi tiết mượn
INSERT INTO borrow_details (ticket_id, book_id, status) VALUES 
(1, 1, 'BORROWING'),
(2, 2, 'BORROWING');