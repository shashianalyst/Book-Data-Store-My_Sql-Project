DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- 1) Retrieve all books in the "Fiction" genre:
select * from books
where genre = 'Fiction';

-- 2) Find books published after the year 1950:
select * from books
where Published_Year > 1950;

-- 3) List all customers from the Canada:
select * from customers
where country='Canada';

-- 4) Show orders placed in November 2023 with customer Name:
select orders.Order_Date, customers.Name, customers.city
from orders join customers
on orders.Customer_ID = customers.Customer_ID
where Order_Date between '2023-11-01' And '2023-11-30';

-- 5) Retrieve the total stock of books available:
select sum(stock) from books;

-- 6) Find the details of the most expensive book:
select * from books
order by Price desc limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
select * from orders
where Quantity>1;

-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders 
WHERE total_amount>20;

-- 9) List all genres available in the Books table:
select distinct genre from books;

-- 10) Find the book with the lowest stock:
select * from books
order by Stock limit 1;

-- 11) Calculate the total revenue generated from all orders:
select sum(Total_Amount) as Total_revenue from orders;

-- Advance Questions : 
-- 1) Retrieve the total number of books sold for each genre:
Select books.genre, sum(orders.quantity)
from orders join books
on orders.Book_ID = books.Book_ID
group by Genre;

-- 2) Find the average price of books in the "Fantasy" genre:
select avg(price) from books
where genre = 'Fantasy';

-- 3) List customers who have placed at least 2 orders:
select orders.Customer_ID, customers.Name, count(orders.order_id) as order_count
from orders join customers
on orders.Customer_ID = customers.Customer_ID
group by orders.Customer_ID
having count(Order_ID)>=2;

-- 4) Find the most frequently ordered book:
select orders.Book_ID, books.title, count(order_id) as order_count
from orders join books
on orders.Book_ID = books.Book_ID
group by Book_ID
order by order_count desc limit 5;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select * from books
where Genre = 'Fantasy'
order by Price desc limit 3;

-- 6) Retrieve the total quantity of books sold by each author:
select books.Author, sum(orders.Quantity) as Total_book_sold
from books join orders
on books.Book_ID = orders.Order_ID
group by books.Author;

-- 7) List the cities where customers who spent over $30 are located:
select distinct customers.City, orders.Total_Amount
from customers join orders
on customers.Customer_ID = orders.Customer_ID
where orders.Total_Amount > 30;

-- 8) Find the customer who spent the most on orders
select customers.Customer_ID, customers.Name, sum(orders.Total_Amount) As Total_Spent
from customers join orders
on customers.Customer_ID = orders.Customer_ID
group by customers.Customer_ID, customers.Name
order by Total_spent desc limit 5;

