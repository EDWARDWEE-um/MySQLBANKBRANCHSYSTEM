USE bankbranchsystem;
# Customer Identity

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
alter table customer_identity modify column cust_address varchar(200);

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

alter table transaction add foreign key(de_id) references deposit_account(de_id) on delete set null;

describe transaction;

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
alter table investment_details drop column inv_interest;

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
alter table employee_identity modify column emp_address varchar(200);
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
alter table employee drop column br_id;
alter table employee
add foreign key (emp_supervisorid) references employee(emp_id) on delete set null;

## Insert data time
insert into customer_identity values('881110105641','Edwardo Wee','M',35,'8, Jalan Jasa Dua 25/27b,Taman Sri Muda,40400 Shah Alam,Selangor','Chinese','Buddhist','Malaysian');
insert into customer_identity values('950211085345','Nur Azrina Bin Nik Adam','F',22,'8, 21-1, Jalan SS 18/5b, Ss 18, 47500 Subang Jaya, Selangor','Malay','Islam','Malaysian');
insert into customer_identity values('001212025222','Siva A/L Muthu ','M',25,'15, Persiaran Mulia, Usj 14, 47630 Subang Jaya, Selangor','Indian','Hindu','Malaysian');
select * from customer_identity;

insert into customer values(1,'S',0,'Doctor','11111111',30000,'0122272833','edwardo@gmail.com','881110105641');
insert into customer values(2,'M',2,'Operator','22222222',2500,'0185272530','nurazrina@gmail.com','950211085345');
insert into customer values(3,'W',1,'IT Consultant','33333333',17500,'0173353138','siva123@gmail.com','001212025222');
select * from customer;

insert into loan_details values('S',0.04);
insert into loan_details values('U',0.10);
select * from loan_details;

insert into loan_account values(1,'S','2020-11-11 11:59:33',5,20000,18000);
insert into loan_account values(2,'U','2019-08-23 12:00:33',3,10000,5000); 
insert into loan_account values(3,'S','2020-02-02 15:59:33',10,90000,80000);  
select * from loan_account; 

insert into investment_details values('P',5,0.03);
insert into investment_details values('E',20,0.02);
insert into investment_details values('U',1,0.08);
select * from investment_details;

insert into investment_account values(1,'P',100000,'2019-01-12 13:02:07');
insert into investment_account values(2,'E',2000,'2018-01-12 16:04:50');
insert into investment_account values(3,'U',30000,'2016-01-12 10:57:31');
select * from investment_account;

insert into deposit_details values('F',0.04);
insert into deposit_details values('S',0.01);
select * from deposit_details;

insert into deposit_account values(1,'S',30000,'2018-01-22 16:19:02',null,46000);
insert into deposit_account values(2,'S',2000,'2017-01-22 15:09:53',null,3000);
insert into deposit_account values(3,'F',10000,'2015-01-12 12:02:43','2025-01-12 12:02:43',12166);
select * from deposit_account;

insert into transaction values(1,4000,'2020-11-11 11:59:33','Atm Withdrawal',1);
insert into transaction values(2,30,'2020-12-12 10:59:40','Cash Deposit',2);
insert into transaction values(3,200,'2020-02-11 00:19:36','Instant Transfer',3);
select * from transaction;

insert into employee_job values('Manager',10000);
insert into employee_job values('Teller',2000);
insert into employee_job values('Customer Service',3000);
update employee_job set emp_position = 'Customer Service'
where emp_position = 'Customer Services' ;
select * from employee_job;

insert into employee_identity values('690101103333','Chow Khai Shian', 'M',51,'31-59, Jalan USJ 14/1b, 47630 Subang Jaya, Selangor', 'Chinese', 'Buddhist', 'Malaysian');
insert into employee_identity values('730529104736','Khairul Nizam Bin Nasir', 'M',47,'28, Jalan USJ 4/6e, 47600 Subang Jaya, Selangor', 'Malay', 'Islam', 'Malaysian');
insert into employee_identity values('801120042371','Nathan Daniel Muthu', 'M',40,'35, Jalan Pinggiran USJ 1/6, Taman Pinggiran Usj, 47600 Subang Jaya, Selangor', 'Indian', 'Christian', 'Malaysian');
select * from employee_identity;

insert into employee values(1,'Manager','690101103333','M',2,'44444444','khai_shian','123456','Bachelor of Computer Science, UM','0122234588',null);
insert into employee values(2,'Teller','730529104736','M',3,'55555555','khairul_niz','123457','Bachelor of Economics, USM','0172234472',1);
insert into employee values(3,'Customer Service','801120042371','M',1,'66666666','nathan_da','123458','Bachelor of Accounting, UUM','0193184721',1);
select * from employee;
