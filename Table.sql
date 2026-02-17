Create Database Clothing_Store;
Use Clothing_Store;

--- 1.Category Table
Create Table categories(
category_id Int Primary Key,
category_name Varchar(50)
);
Insert Into categories Values
(1, 'Winter Wear'),
(2, 'Ethnic Wear'),
(3, 'Sportswear'),
(4, 'Formal Wear'),
(5, 'Innerwear');


--- 2. Products Table
Create Table Products(
product_id int Primary Key,
product_name Varchar(50),
category_id int, foreign key (category_id) References categories(category_id),
brand varchar(50),
size varchar(50),
color varchar(50),
price int
);
Insert into Products Values
(111, 'Hoodie', 1, 'Roadster', 'L', 'Grey', 1899),
(112, 'Jacket', 1, 'Puma', 'M', 'Black', 3499),
(113, 'Saree', 2, 'Manyavar', 'Free', 'Pink', 4999),
(114, 'Kurta Set', 2, 'Biba', 'M', 'Blue', 2999),
(115, 'Track Pants', 3, 'Nike', 'L', 'Black', 1799),
(116, 'Sports T-Shirt', 3, 'Adidas', 'M', 'White', 1299),
(117, 'Blazer', 4, 'Raymond', 'L', 'Navy', 5999),
(118, 'Formal Shirt', 4, 'Peter England', 'M', 'White', 1599),
(119, 'Vest', 5, 'Jockey', 'M', 'Grey', 499),
(120, 'Briefs', 5, 'Lux', 'L', 'White', 399);


--- 3.stores
Create Table Stores(
store_id int Primary Key,
store_name varchar(50),
city varchar(50)
);
Insert into Stores Values 
(6, 'Urban Wear', 'Pune'),
(7, 'City Fashion', 'Chennai'),
(8, 'Mega Style', 'Hyderabad');


--- 4. inventory
Create Table Inventory(
inventory_id int Primary Key,
store_id int, Foreign Key(store_id) References Stores(store_id),
product_id int, Foreign Key(product_id) References Products(product_id),
stock_quantity int
);
Insert into Inventory Values
(11, 6, 111, 20),
(12, 6, 112, 15),
(13, 6, 113, 10),
(14, 7, 114, 25),
(15, 7, 115, 18),
(16, 7, 116, 12),
(17, 8, 117, 8),
(18, 8, 118, 30),
(19, 8, 119, 40),
(20, 8, 120, 35);


--- 5. customers
Create Table Customer(
customer_id int Primary Key,
customer_name varchar(50),
phone varchar(100),
gender varchar(50),
city varchar(50)
);
insert into Customer Values
(9, 'Rohit Gupta', '9991112222', 'Male', 'Pune'),
(10, 'Sneha Patil', '8881112222', 'Female', 'Pune'),
(11, 'Vikas Rao', '7771112222', 'Male', 'Chennai'),
(12, 'Meena Iyer', '6661112222', 'Female', 'Chennai'),
(13, 'Arjun Malhotra', '5551112222', 'Male', 'Hyderabad'),
(14, 'Kavita Nair', '4441112222', 'Female', 'Hyderabad'),
(15, 'Nitin Jain', '3331112222', 'Male', 'Delhi'),
(16, 'Simran Kaur', '2221112222', 'Female', 'Delhi'),
(17, 'Suresh Patel', '1111112222', 'Male', 'Ahmedabad'),
(18, 'Rina Shah', '1111113333', 'Female', 'Ahmedabad'),
(19, 'Akash Verma', '1212121212', 'Male', 'Jaipur'),
(20, 'Neetu Singh', '2323232323', 'Female', 'Jaipur'),
(21, 'Manish Yadav', '3434343434', 'Male', 'Noida'),
(22, 'Pallavi Joshi', '4545454545', 'Female', 'Noida');


--- 6. orders
Create Table Orders(
order_id int Primary Key,
customer_id int, Foreign Key(customer_id) references Customer(customer_id),
store_id int, Foreign Key (store_id) References Stores(store_id),
order_date date,
order_status varchar(50)
);
insert into orders Values
(1007, 9, 6, '2025-02-10', 'Completed'),
(1008, 10, 6, '2025-02-11', 'Completed'),
(1009, 11, 7, '2025-02-12', 'Completed'),
(1010, 12, 7, '2025-02-13', 'Pending'),
(1011, 13, 8, '2025-02-14', 'Completed'),
(1012, 14, 8, '2025-02-15', 'Completed'),
(1013, 15, 6, '2025-02-16', 'Completed'),
(1014, 16, 7, '2025-02-17', 'Completed'),
(1015, 17, 8, '2025-02-18', 'Completed'),
(1016, 18, 6, '2025-02-19', 'Completed'),
(1017, 19, 6, '2025-02-20', 'Completed'),
(1018, 20, 7, '2025-02-21', 'Pending'),
(1019, 21, 6, '2025-02-22', 'Completed'),
(1020, 22, 7, '2025-02-23', 'Completed');


--- 7. order_items
Create table Order_items(
order_item_id int Primary Key,
order_id int, Foreign Key(order_id) References Orders(order_id),
product_id int, Foreign Key(product_id) References Products(product_id),
quantity int,
unit_price int
);
insert into Order_items Values
(9, 1007, 111, 1, 1899),
(10, 1008, 112, 1, 3499),
(11, 1009, 114, 2, 2999),
(12, 1010, 115, 1, 1799),
(13, 1011, 117, 1, 5999),
(14, 1012, 118, 2, 1599),
(15, 1013, 111, 1, 799),
(16, 1014, 114, 1, 2499),
(17, 1015, 117, 1, 2999),
(18, 1016, 113, 1, 4999),
(19, 1017, 116, 2, 1299),
(20, 1018, 120, 3, 399),
(21, 1019, 112, 1, 1999),
(22, 1020, 113, 1, 1499);


--- 8. payments
Create table Payments(
payment_id int Primary Key,
order_id int, Foreign Key(order_id) References Orders(order_id),
payment_method varchar(50),
amount int,
payment_date date 
);
insert into Payments Values
(6, 1007, 'Card', 1899, '2025-02-10'),
(7, 1008, 'UPI', 3499, '2025-02-11'),
(8, 1009, 'Cash', 5998, '2025-02-12'),
(9, 1011, 'Card', 5999, '2025-02-14'),
(10, 1012, 'UPI', 3198, '2025-02-15'),
(11, 1013, 'UPI', 799, '2025-02-16'),
(12, 1014, 'Card', 2499, '2025-02-17'),
(13, 1015, 'UPI', 2999, '2025-02-18'),
(14, 1016, 'Cash', 4999, '2025-02-19'),
(15, 1017, 'UPI', 2598, '2025-02-20'),
(16, 1019, 'Card', 1999, '2025-02-22'),
(17, 1020, 'UPI', 1499, '2025-02-23');


