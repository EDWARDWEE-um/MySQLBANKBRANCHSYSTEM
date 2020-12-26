USE bankbranchsystem;
# Customer Identity
drop table customer_identity;
drop table customer;

create table customer_identity(
cust_icno varchar(12) primary key,
cust_name varchar(40),
cust_sex varchar(1),
cust_age int,
cust_address varchar(60),
cust_ethnicity varchar(10), # M C I O 
cust_religion varchar(10),
cust_nationality varchar(20)  
);

# Customer
create table customer (
cust_id int primary key,
cust_maritalstatus varchar(1),
cust_dependentno int,
cust_occupation varchar(20),
cust_epfno varchar(8),  ## pls take note on actual no
cust_income int,
cust_phoneno varchar(20),
cust_email varchar(20),
cust_icno varchar(12),
foreign key(cust_icno) references customer_identity(cust_icno) on delete cascade
);
## Deposit Details
create table deposit_details(
de_type varchar(1) primary key, ## C F
de_interest float
);

## Deposit
 create table deposit_account(
 de_id int primary key,
 de_type varchar(1), ## fk
 de_initialamount int,
 de_opendate datetime,
 de_closedate datetime,
 de_currentbalance int, # fk maybe need to relate xsaction? < reminder 
 foreign key(de_type) references deposit_details(de_type) on delete set null
);
 ## Transaction
create table transaction(
trans_id int primary key,
trans_amount int,
trans_date datetime,
trans_type varchar(20),
de_id int ## have to add fk de_id
);

describe deposit_amount;

## Loan Details 
create table loan_details(
 loan_type varchar(1) primary key,
 loan_interest float
);

## Loan Account
create table loan_account(
loan_id int primary key,
loan_type varchar(1), #fk
loan_date datetime,
loan_duration int,
loan_amount int,
loan_balance int,
foreign key(loan_type) references loan_details(loan_type) on delete set null
); 

## Investment Details
create table investment_details(
inv_type varchar(1) primary key,
inv_duration int,
inv_interest float,
inv_growth float
);

## Investment Account
create table investment_account(
inv_id int primary key,
inv_type varchar(1), ##fk
inv_amount int, 
inv datetime,
foreign key(inv_type) references investment_details(inv_type) on delete set null
);



# Employee Indentity
create table employee_identity(
emp_icno varchar(12) primary key,
emp_name varchar(40),
emp_sex varchar(1),
emp_age int,
emp_address varchar(40),
emp_ethnicity varchar(10),
emp_religion varchar(10),
emp_nationality varchar(20)  
);

## Employee Job
create table employee_job(
emp_position varchar(20) primary key,
emp_salary int
);

## Employee 
create table employee(
emp_id int primary key,
emp_position varchar(20), ##fk
emp_icno varchar(12), ##fk
emp_maritalstatus varchar(1),
emp_dependent int,
emp_epfno varchar(8),
emp_username varchar(20),
emp_password varchar(12),
emp_education varchar(100),
emp_phoneno varchar(20),
emp_supervisorid int,
br_id int);

## Branch 
create table branch(
br_id int primary key,
br_location varchar(100),
mng_id int,
foreign key (mng_id) references employee(emp_id) on delete set null
);

alter table employee
add foreign key (emp_supervisorid) references employee(emp_id) on delete set null;
