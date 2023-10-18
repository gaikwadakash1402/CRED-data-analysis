use cred;

-- ---    EASY PROBLEM STATEMENTS   ------- 
-- 1. **Easy - Users List:**
--    Retrieve a list of all users along with their first names, last names, and email addresses.
select firstname,lastname,email from users;

-- 2. **Easy - Account Balances:**
--    Display the account numbers and current balances of all credit card accounts.
select cardnumber, balance from creditcards;

-- 3. **Easy - Transaction Count:**
--    Calculate and display the total number of transactions in the system.
select sum(transactionID) as total_transactions from transactions;

-- 4. **Easy - High Balance Users:**
--    List the first names and last names of users who have a credit card balance greater than 10000.
SELECT firstname, lastname
FROM users
WHERE userid IN (SELECT userid FROM creditcards WHERE balance > 10000);

-- 5. **Easy - Transaction Types:**
--    Show a distinct list of transaction types (e.g., Purchase, Withdrawal) from the Transactions table.
select distinct(transactiontype) from transactions;

-- 6. **Easy - User Addresses:**
--    Retrieve the first name, last name, and address of users who live in Delhi.
select firstname,lastname , address from users where address like '%delhi%';

-- 7. **Easy - Oldest Card Expiry:**
--    Find the user with the credit card that is expiring soonest and display their name and email.
select users.firstname , users.email from users join creditcards on users.userid = creditcards.userid
where creditcards.expirydate = (select min(expirydate) from creditcards);

-- 8. **Easy - Payment Amounts:**
--    List the amounts of payments made by users.
select sum(paymentid) as amount_of_payments from payments;

-- 9. **Easy - Available Credit:**
--    Calculate and display the available credit for each credit card (credit limit - balance).
select cardid,cardnumber,(creditlimit - balance) as available_credits from creditcards;

-- 10. **Easy - Transaction Timestamps:**
--     Retrieve the timestamps of the latest three transactions.
select timestamp  from transactions order by timestamp desc limit 3;

-- 11. **Easy - User Count:**
--     Count the total number of users in the Users table.
select count(userid) as total_users from users;

-- 12. **Easy - Card Count:**
--     Count the total number of credit cards in the system.
select count(cardid) total_credit_cards from creditcards;

-- 13. **Easy - Payment Dates:**
--     List the payment dates of payments made by users.
select u.userid, u.firstname, p.paymentdate from users u join payments p;

-- 14. **Easy - User Email:**
--     Retrieve the email addresses of all users.
select userid , email from users;

-- 15. **Easy - Card Expiry Dates:**
--     Display the expiry dates of all credit cards.
select cardid, expirydate from creditcards;


--    _______ MODERATE PROBLEM STATEMENT______

-- 1. **Moderate - Total Balance:**
--    Calculate and display the total balance of all credit card accounts combined.
SELECT SUM(Balance) as TotalBalance FROM creditcards;

-- 2. **Moderate - Recent Transactions:**
--    Retrieve the details of the last five transactions, including sender/receiver, amount, and type.
SELECT TransactionID, CardID, Amount, TransactionType FROM Transactions
ORDER BY Amount LIMIT 5;

-- 3. **Moderate - Average Transaction Amount:**
--    Calculate and display the average amount of all transactions.
SELECT AVG(Amount) AS AVGTransaction FROM Transactions;

-- 4. **Moderate - User Transaction Count:**
--    List the names of users along with the number of transactions they've made.
SELECT u.FirstName, u.LastName, COUNT(t.TransactionID) AS TransactionCount
FROM Users u
LEFT JOIN Transactions t ON u.UserID = t.CardID
GROUP BY u.FirstName, u.LastName;

-- 5. **Moderate - Highest Credit Limit:**
--    Find and display the user with the highest credit limit and their credit limit value.
SELECT u.FirstName, u.LastName, c.CreditLimit FROM Users u 
JOIN CreditCards c ON u.UserID = c.UserID
WHERE CreditLimit = (SELECT MAX(CreditLimit) FROM CreditCards);

-- 6. **Moderate - Account With Most Transactions:**
--    Identify the credit card with the most transactions and display its card number.
SELECT  c.CardNumber, COUNT(t.TransactionID) AS TransactionCount
FROM CreditCards c
LEFT JOIN Transactions t ON c.CardNumber = t.Cardid
GROUP BY c.CardNumber
ORDER BY TransactionCount
LIMIT 1;

-- 7. **Moderate - Users with Overdue Payments:**
--    Retrieve a list of users who have payments due today or earlier.
SELECT DISTINCT u.FirstName, u.LastName, p.PaymentDate
FROM Users u
INNER JOIN CreditCards c ON u.UserID = c.UserID
INNER JOIN Payments p ON c.CardID = p.CardID
WHERE p.PaymentDate <= CURDATE();

-- 8. **Moderate - Card Expiry by Year:**
--    Count and display how many credit cards will expire in each year.
SELECT YEAR(ExpiryDate) AS ExpiryYear, COUNT(*) AS CardCount
FROM CreditCards
GROUP BY ExpiryYear
ORDER BY ExpiryYear;

-- 9. **Moderate - User Balances:**
--    List the users along with the sum of their credit card balances.
SELECT u.FirstName, u.LastName, SUM(c.Balance) AS TotalBalance
FROM Users u
INNER JOIN CreditCards c ON u.UserID = c.UserID
GROUP BY u.FirstName, u.LastName;

-- 10. **Moderate - Transaction Type Distribution:**
--     Display the distribution of transaction types (e.g., percentage of purchases, withdrawals).
SELECT TransactionType, COUNT(*) AS TransactionCount,
       COUNT(*) * 100 / (SELECT COUNT(*) FROM Transactions) AS Percentage
FROM Transactions
GROUP BY TransactionType;

-- 11. **Moderate - Highest Transaction Amount:**
--     Find the highest transaction amount and display the transaction details.
SELECT Amount FROM Transactions 
    WHERE Amount = (SELECT MAX(Amount) FROM transactions);
    
-- 12. **Moderate - Expensive Transactions:**
--     Retrieve transactions with amounts greater than 1000 and display user names and transaction amounts.
SELECT Amount FROM transactions
WHERE Amount > 1000;

/* Add new column 'BirthDate' to Users table and insert Values*/

ALTER TABLE Users
ADD Birthdate DATE;

UPDATE Users
SET Birthdate = '1990-05-15' WHERE UserID = 1;

UPDATE Users
SET Birthdate = '1985-08-20' WHERE UserID = 2;

UPDATE Users
SET Birthdate = '1992-03-10' WHERE UserID = 3;

UPDATE Users
SET Birthdate = '1978-11-25' WHERE UserID = 4;

UPDATE Users
SET Birthdate = '1995-06-02' WHERE UserID = 5;

UPDATE Users
SET Birthdate = '1987-09-14' WHERE UserID = 6;

UPDATE Users
SET Birthdate = '1998-02-18' WHERE UserID = 7;

UPDATE Users
SET Birthdate = '1982-04-30' WHERE UserID = 8;

UPDATE Users
SET Birthdate = '1991-07-08' WHERE UserID = 9;

UPDATE Users
SET Birthdate = '1975-12-12' WHERE UserID = 10;

SELECT * FROM Users;

-- 13. **Moderate - Oldest User:**
--     Find the oldest user (based on date of birth) and display their name and birthdate.
SELECT FirstName, LastName, Birthdate
FROM Users
ORDER BY Birthdate ASC
LIMIT 1;

-- 14. **Moderate - Payment Distribution:**
--     Display the distribution of payment amounts (e.g., number of payments between certain ranges).
 SELECT CASE
        WHEN Amount >= 0 AND Amount < 200 THEN '0-199'
        WHEN Amount >= 200 AND Amount < 400 THEN '100-399'
        WHEN Amount >= 400 AND Amount < 600 THEN '400-600'
        ELSE '700 and above'
    END AS PaymentRange,
    COUNT(*) AS PaymentCount
FROM Payments
GROUP BY PaymentRange;

-- 15. **Moderate - Card Usage Frequency:**
--     Calculate the average number of transactions per card and display it.
SELECT AVG(CardID) AS AverageTransactionsPerCard
FROM (
    SELECT CardID, COUNT(*) AS TransactionCount
    FROM Transactions
    GROUP BY CardID
) AS TransactionCounts;


--    ________ Advanced Problem Statements:

-- 1. **Advanced - Credit Utilization:**
--    Calculate and display the credit utilization ratio (total balance / total credit limit) for each user.
SELECT CardID, CreditLimit, Balance, 
(Balance/CreditLimit * 100) as CardUtilization 
FROM creditcards;

-- 2. **Advanced - Frequent Transactors:**
--    List users who have made more than 10 transactions and display their names along with the transaction count.
SELECT u.FirstName, u.LastName, COUNT(c.CardID) AS TransactionCount 
FROM Users u JOIN CreditCards c ON u.userid = c.userid
GROUP BY c.CardID 
ORDER BY TransactionCount;

-- 3. **Advanced - Highest Payment Amount:**
--    Find the user who made the highest payment and display their name and the payment amount.
SELECT u.FirstName, u.LastName, t.Amount FROM Users u
JOIN transactions t on u.userid = t.TransactionID
ORDER BY t.Amount DESC LIMIT 3;

-- 4. **Advanced - Average Payment Delay:**
--    Calculate the average delay between the due date and the actual payment date for bill payments
SELECT AVG(DATEDIFF(PaymentDate, CURRENT_DATE())) AS AverageDelay
FROM Payments
WHERE PaymentDate > CURRENT_Date();

-- 5. **Advanced - Largest Transaction Difference:**
--    Identify the transaction with the largest difference between the sender's balance before and after the transaction.
SELECT u.FirstName, u.LastName,
 LEAD(t.Amount, 1) OVER(ORDER BY Amount DESC) AS SecondHighestTransaction
 FROM Users u 
 JOIN Transactions t ON u.userid = t.TransactionID;
 
 -- 6. **Advanced - Fraudulent Transactions:**
--    Detect any transactions where the transaction amount exceeds the credit card's available balance.
SELECT t.TransactionID, t.CardID, t.Amount, c.Balance AS AvailableBalance
FROM Transactions t
JOIN CreditCards c ON t.CardID = c.CardID
WHERE t.Amount > c.Balance;

-- 7. **Advanced - Most Common Transaction Type:**
--    Determine the most common transaction type across all transactions and display it
SELECT TransactionType, COUNT(*) AS TransactionCount
FROM Transactions
GROUP BY TransactionType
ORDER BY TransactionCount DESC LIMIT 1;

-- 8. **Advanced - Payment Trend Analysis:**
--    Analyze the trend of payments over the last 6 months and display the total payment amounts for each month.
 SELECT YEAR(PaymentDate) AS PaymentYear, 
    MONTH(PaymentDate) AS PaymentMonth, 
    SUM(Amount) AS TotalPaymentAmount
FROM Payments
WHERE PaymentDate >= DATE_SUB(CURRENT_DATE(), INTERVAL 6 MONTH)
GROUP BY PaymentYear, PaymentMonth
ORDER BY PaymentYear, PaymentMonth;

-- 9 . **Advanced - Total Payment Amount:**
--    Calculate the total amount paid by all users and display it.
SELECT SUM(Amount) AS TotalAmountPaid
FROM Payments;

-- 10. **Advanced - Active Users:**
--     Identify users who have made transactions in the last 30 days and display their names.
SELECT u.FirstName, u.LastName, t.TimeStamp
FROM Users u
JOIN Transactions t 
ON u.UserID = t.TransactionID
WHERE t.TimeStamp > DATE_SUB(current_date(), INTERVAL 30 DAY);

-- 11. **Advanced - Average Age:**
--     Calculate the average age of all users based on their birthdates.
SELECT AVG(TIMESTAMPDIFF(YEAR, Birthdate, CURDATE())) AS AverageAge
FROM Users;

-- 12. **Advanced - Frequent Withdrawal Users:**
--     List users who have made more than 5 withdrawals and display their names along with the withdrawal count.
SELECT u.FirstName, u.LastName, COUNT(*) AS WithdrawalCount
FROM Users u
INNER JOIN Transactions t ON u.UserID = t.TransactionID
WHERE t.TransactionType = 'Withdrawal'
GROUP BY u.FirstName, u.LastName
HAVING WithdrawalCount > 0;


































