
-- 1. Xem danh sách tất cả các cuốn sách có trong thư viện
SELECT title, publish_year, stock_quantity FROM books;

----------------------------------------------------------------

-- 2. Tìm các cuốn sách được xuất bản sau năm 2010
SELECT title, publish_year FROM books 
WHERE publish_year > 2010;

----------------------------------------------------------------

-- 3. Xem danh sách thành viên và sắp xếp theo tên từ A-Z
SELECT full_name, phone, email FROM members 
ORDER BY full_name ASC;

----------------------------------------------------------------

-- 4. Tìm các thành viên có trạng thái tài khoản đang bị khóa (LOCKED)
SELECT full_name, status FROM members 
WHERE status = 'LOCKED';

----------------------------------------------------------------

-- 5. Xem tất cả các phiếu mượn sách hiện có
-- (Xem lịch sử mượn trả cơ bản)
SELECT id, member_id, borrow_date, due_date FROM borrow_tickets;