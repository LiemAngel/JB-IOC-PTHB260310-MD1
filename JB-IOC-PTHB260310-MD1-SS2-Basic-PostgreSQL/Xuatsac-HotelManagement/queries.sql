CREATE schema hotel;
-- 2. Bảng RoomTypes 
CREATE TABLE hotel.RoomTypes (
    room_type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE,
    price_per_night NUMERIC(10,2) NOT NULL CHECK (price_per_night > 0),
    max_capacity INT NOT NULL CHECK (max_capacity > 0)
);

-- 3. Bảng Rooms 
CREATE TABLE hotel.Rooms (
    room_id SERIAL PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    room_type_id INT NOT NULL,
    status VARCHAR(20) DEFAULT 'Available' CHECK (status IN ('Available', 'Occupied', 'Maintenance')),
    CONSTRAINT fk_room_type 
        FOREIGN KEY (room_type_id) 
        REFERENCES hotel.RoomTypes(room_type_id)
);

-- 4. Bảng Customers (Quản lý thông tin khách hàng)
CREATE TABLE hotel.Customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL
);

-- 5. Bảng Bookings (Quản lý đơn đặt phòng)
CREATE TABLE hotel.Bookings (
    booking_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'Pending' CHECK (status IN ('Pending', 'Confirmed', 'Cancelled')),
    CONSTRAINT fk_customer 
        FOREIGN KEY (customer_id) 
        REFERENCES hotel.Customers(customer_id),
    CONSTRAINT fk_room 
        FOREIGN KEY (room_id) 
        REFERENCES hotel.Rooms(room_id),
    CONSTRAINT check_dates CHECK (check_out > check_in) -- Ràng buộc logic ngày trả > ngày nhận
);

-- 6. Bảng Payments (Quản lý thanh toán)
CREATE TABLE hotel.Payments (
    payment_id SERIAL PRIMARY KEY,
    booking_id INT NOT NULL,
    amount NUMERIC(10,2) NOT NULL CHECK (amount >= 0),
    payment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    method VARCHAR(20) NOT NULL CHECK (method IN ('Credit Card', 'Cash', 'Bank Transfer')),
    CONSTRAINT fk_booking 
        FOREIGN KEY (booking_id) 
        REFERENCES hotel.Bookings(booking_id)
);