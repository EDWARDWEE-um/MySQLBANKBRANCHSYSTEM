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
 de_currentbalance int, 
 cust_id int,
 foreign key(de_type) references deposit_details(de_type) on delete set null,
 foreign key(cust_id) references customer(cust_id) on delete set null
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
cust_id int,
foreign key(loan_type) references loan_details(loan_type) on delete set null,
foreign key(cust_id) references Customer(cust_id) on delete set null
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
inv_date datetime,
cust_id int,
foreign key(inv_type) references investment_details(inv_type) on delete set null,
foreign key(cust_id) references customer(cust_id) on delete set null
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
emp_phoneno varchar(20));

select * from employee;

## Insert data time
insert into customer_identity values('881110105641','Edwardo Wee','M',35,'8, Jalan Jasa Dua 25/27b,Taman Sri Muda,40400 Shah Alam,Selangor','Chinese','Buddhist','Malaysian');
insert into customer_identity values('950211085345','Nur Azrina Binti Nik Adam','F',22,'8, 21-1, Jalan SS 18/5b, Ss 18, 47500 Subang Jaya, Selangor','Malay','Islam','Malaysian');
insert into customer_identity values('001212025222','Siva A/L Muthu ','M',25,'15, Persiaran Mulia, Usj 14, 47630 Subang Jaya, Selangor','Indian','Hindu','Malaysian');

insert into customer_identity values('891023029645','Janice Chee','F',31,'No 23, Jalan Putra Permai 10/2d,Putra Heights,47650 Subang Jaya,Selangor','Chinese','Christian','Malaysian');
insert into customer_identity values('001214039652','Nur Hamzah Binti Khairul','F',20,'No 45, Jalan SS 22/15, Damansara Jaya, 47400 Petaling Jaya, Selangor','Malay','Islam','Malaysian');
insert into customer_identity values('790503111052','Michael Ganesh','M',41,'22, Jalan Bangsi 33/18,Taman Alam Indah,40400 Shah Alam,Selangor','Indian','Christian','Malaysian');
insert into customer_identity values('881011059635','Daniel Bin Lanang','M',32,'14, Jalan PJS 11/6,Bandar Sunway,47500 Petaling Jaya,Selangor','Malay','Islam','Malaysian');
insert into customer_identity values('851107080142','Yogarasa A/L Ashtikar','M',35,'31, Jalan PJS 9/6,Bandar Sunway,47500 Petaling Jaya,Selangor','Indian','Hindu','Malaysian');
insert into customer_identity values('990311063541','Ismad Bin Bandar','M',21,'45, Jalan Tpt 11,Taman Puchong Tekali,47150 Puchong,Selangor','Malay','Islam','Malaysian');
insert into customer_identity values('890428105042','Xing Gengxin','F',31,'14, Jalan PU 10/13b, Taman Puchong Utama, 47100 Puchong, Selangor','Chinese','Buddhist','Malaysian');
select * from customer_identity;


insert into customer values(1,'S',0,'Doctor','11111111',30000,'0122272833','edwardo@gmail.com','881110105641');
insert into customer values(2,'M',2,'Operator','22222222',2500,'0185272530','nurazrina@gmail.com','950211085345');
insert into customer values(3,'W',1,'IT Consultant','33333333',17500,'0173353138','siva123@gmail.com','001212025222');
insert into customer values(4,'S',0,'Civil servant','44444423',11000,'0123457789','janice78@gmail.com','891023029645');
insert into customer values(5,'S',0,'Student',null,null,'0134523677','hamzah99@yahoo.com','001214039652');
insert into customer values(6,'W',2,'Lawyer','66666555',13000,'0178944561','mganes@hotmail.com','790503111052');
insert into customer values(7,'M',1,'Civil servant','77777711',3500,'0154523589','laladaniel@yahoo.com','881011059635');
insert into customer values(8,'M',0,'Freelancer','88888883',7000,'0167845784','yogayoda@gmail.com','851107080142');
insert into customer values(9,'S',0,'Student',null,null,'0147985656','Ismadbb@hotmail.com','990311063541');
insert into customer values(10,'M',3,'Businessman','99999999',3400,'0132325644','xingxin55@yahoo.com','890428105042');

select * from customer;

insert into loan_details values('S',0.04);
insert into loan_details values('U',0.10);
select * from loan_details;

insert into loan_account values(1,'S','2020-11-11 11:59:33',5,20000,18000,1);
insert into loan_account values(2,'U','2019-08-23 12:00:33',3,10000,5000,2); 
insert into loan_account values(3,'S','2020-02-02 15:59:33',10,90000,80000,3);

insert into loan_account values(4,'S','2019-10-09 16:19:02',7,35000,5000,4);
insert into loan_account values(5,'S','2018-01-20 16:19:02',10,10000,3000,1);
insert into loan_account values(6,'S','2017-01-22 15:09:53',10,30000,5000,2);
insert into loan_account values(7,'U','2015-01-12 12:02:43',4,12000,8000,6);
insert into loan_account values(8,'S','2018-01-22 16:19:02',11,20000,1800,8);
insert into loan_account values(9,'S','2005-03-11 12:02:43',12,10000,5000,10);
insert into loan_account values(10,'S','2008-01-02 16:19:02',5,50000,7000,7);
select * from loan_account; 

insert into investment_details values('P',5,0.03);
insert into investment_details values('E',20,0.02);
insert into investment_details values('U',null,0.08);
select * from investment_details;

insert into investment_account values(1,'P',100000,'2019-01-12 13:02:07',1);
insert into investment_account values(2,'E',2000,'2018-01-12 16:04:50',9);
insert into investment_account values(3,'U',30000,'2016-01-12 10:57:31',3);
insert into investment_account values(4,'P',200000,'2020-07-02 13:02:17',4);
insert into investment_account values(5,'P',100000,'2019-01-12 13:02:07',2);
insert into investment_account values(6,'P',1000000,'2018-04-12 16:04:50',7);
insert into investment_account values(7,'U',50000,'2006-12-02 10:57:34',6);
insert into investment_account values(8,'P',300000,'2019-01-12 13:02:00',10);
insert into investment_account values(9,'E',3000,'2018-03-01 16:02:51',5);
insert into investment_account values(10,'E',5000,'2013-04-12 14:05:53',8);
select * from investment_account;

insert into deposit_details values('F',0.04);
insert into deposit_details values('S',0.01);
select * from deposit_details;

insert into deposit_account values(1,'S',30000,'2018-01-22 16:19:02',null,46000,1);
insert into deposit_account values(2,'S',2000,'2017-01-22 15:09:53',null,3000,2);
insert into deposit_account values(3,'F',10000,'2015-01-12 12:02:43','2025-01-12 12:02:43',12166,3);
insert into deposit_account values(4,'F',30000,'2017-01-12 11:20:34',"2027-01-12 11:20:34",33746,4);
insert into deposit_account values(5,'S',10000,'2018-01-22 16:19:02',null,3000,5);
insert into deposit_account values(6,'S',30500,'2017-01-22 15:09:53',null,40000,6);
insert into deposit_account values(7,'S',2500,'2019-10-09 16:19:02',null,7000,7);
insert into deposit_account values(8,'S',1300,'2017-01-22 15:09:53',null,2000,8);
insert into deposit_account values(9,'S',9060,'2018-01-22 16:19:02',null,8000,9);
insert into deposit_account values(10,'F',50000,'2015-03-11 12:02:43','2025-03-11 12:02:43',60833,10);
select * from deposit_account;

insert into transaction values(1,4000,'2020-11-11 11:59:33','Atm Withdrawal',1);
insert into transaction values(2,200,'2020-02-11 00:19:36','Instant Transfer',2);
insert into transaction values(3,30,'2020-12-12 10:59:40','Cash Deposit',2);
insert into transaction values(4,300,'2015-01-12 12:02:43','ATM Withdrawal',6);
insert into transaction values(5,50,'2017-01-22 15:09:53','ATM Withdrawal',6);
insert into transaction values(6,1000,'2018-01-22 16:19:02','Cash Deposit',6);
insert into transaction values(7,1300,'2019-10-09 16:19:02','Cash Deposit',5);
insert into transaction values(8,35,'2020-02-02 15:59:33','Instant Transfer',5);
insert into transaction values(9,2000,'2020-02-03 15:59:33','ATM Withdrawal',6);
insert into transaction values(10,1700,'2020-10-12 16:19:02','Cash Deposit',1);
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
insert into employee_identity values('881213129532','Minah Binti Ungu', 'F',32,'10-2, Jalan Putra Indah 9/2, Putra Heights, 47650 Subang Jaya, Selangor', 'Malay', 'Islam', 'Malaysian');
insert into employee_identity values('830721115245','Ayu Binti Sabtu', 'F',37,'7, Jalan PU 10/7a, Taman Puchong Utama, 47100 Puchong, Selangor', 'Malay', 'Islam', 'Malaysian');
insert into employee_identity values('920623034561','Raymond Ong', 'M',28,'11, Jalan Putra Permai 10/1r, Putra Heights, 47650 Subang Jaya, Selangor', 'Chinese', 'Christian', 'Malaysian');
insert into employee_identity values('910102059234','Shawqi Bin Irfaan', 'M',29,'23, Jalan Terentang 27/75, Taman Bunga Negara, 40400 Shah Alam, Selangor', 'Malay', 'Islam', 'Malaysian');
insert into employee_identity values('711016105465','Angelo Gupta', 'M',49,'35, 8, Jalan SS 21/16, Damansara Utama, 47400 Petaling Jaya, Selangor', 'Indian', 'Christian', 'Malaysian');
insert into employee_identity values('670809124512','Christine Fay', 'F',53,'Jalan SS 21/50, Damansara Utama, 47400 Petaling Jaya, Selangor', 'Chinese', 'Christian', 'Malaysian');
insert into employee_identity values('800901055181','Lumine Lee', 'F',40,'28, Jalan PU 10/11a, Taman Puchong Utama, 47100 Puchong, Selangor', 'Chinese', 'Christian', 'Malaysian');
select * from employee_identity;

insert into employee values(1,'Manager','690101103333','M',2,'44444444','khai_shian','123456','Bachelor of Computer Science, UM','0122234588');
insert into employee values(2,'Teller','730529104736','M',3,'55555555','khairul_niz','123457','Bachelor of Economics, USM','0172234472');
insert into employee values(3,'Customer Service','801120042371','M',1,'66666666','nathan_da','123458','Bachelor of Accounting, UUM','0193184721');
insert into employee values(4,'Teller','881213129532','M',3,'77777777','minah_un','123584','Bachelor of Computer Science, UM','0164954585');
insert into employee values(5,'Teller','830721115245','M',2,'88888888','ayu_sab','123417','Bachelor of Finance, USM','012459489');
insert into employee values(6,'Teller','920623034561','M',2,'99999999','ray_ong','122378','Bachelor of Accounting, UKM','0134589448');
insert into employee values(7,'Customer Service','910102059234','S',0,'11111122','shaw_ir','123259','Bachelor of Accounting, UUM','0172595948');
insert into employee values(8,'Teller','711016105465','M',2,'22222211','ange_gup','123256','Bachelor of IT, UM','0164589415');
insert into employee values(9,'Customer Service','670809124512','M',0,'33333344','chris_f','123748','Bachelor of Economics, USM','0175294895');
insert into employee values(10,'Customer Service','800901055181','W',1,'19999999','lumi_lee','123489','Bachelor of Accounting, UPM','0135482979');
select * from employee;









## Names of employees, age, sex , their roles ,salary ,and stays in subang jaya 
select emp_name,emp_icno, emp_age , emp_sex, emp_position, emp_salary
from employee 
inner join employee_identity using(emp_icno) 
inner join employee_job using(emp_position) 
where emp_address like '%Subang Jaya%'; 


## Calculation of interest rates
# Create new columns called years and total
# Filter out Fixed Account only
# Join both deposit_account and deposit_details
select  * , timestampdiff(year, de_opendate, de_closedate) as years, round((de_initialamount * power((de_interest + 1),timestampdiff(year, de_opendate, de_closedate)))) as total  
from deposit_account 
inner join 
deposit_details using(de_type)
where deposit_account.de_type = 'F' ;

## Transaction Calculation 
# If atm withdrawal, instant transfer, atm withdrawal ,current - trans amount
# Else, current + trans amount 
drop temporary table totalv2;
create temporary table totalv2
select de_id, trans_id, trans_date,trans_type, sum(
case 
  when trans_type = "ATM Withdrawal" then - trans_amount
  when trans_type = "Instant Transfer" then - trans_amount
  when trans_type = "Cash Deposit" then  + trans_amount
  else null
end) as net_trans 
from transaction
inner join deposit_account using(de_id)
group by de_id
order by de_id, trans_date;

select de_id, trans_id, trans_date, de_currentbalance, net_trans, sum(de_currentbalance + net_trans) as new_amount from deposit_account
inner join totalv2 using(de_id)
group by trans_id
;

select * from transaction;
## Calculate the avg age, avg income and total income of customers based on race in the bank
select cust_ethnicity ,round(avg (cust_age)) ,avg(cust_income) , sum(cust_income)
from customer 
left join 
customer_identity
using(cust_icno) group by cust_ethnicity; 

## Calculate the current investment growth
select * ,
timestampdiff(year, inv_date , current_timestamp() ) as current_duration , 
round(inv_amount * power(inv_growth+1,timestampdiff(year, inv_date , current_timestamp() ))) as current_amount, 
round(inv_amount * power((1+inv_growth),inv_duration)) as  final_duration
from investment_account 
inner join 
investment_details using(inv_type);


    


