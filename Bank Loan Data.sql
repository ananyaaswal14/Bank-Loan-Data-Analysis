create database bank;
use bank;
create table finance1(
id	varchar (255),
member_id varchar (255),
loan_amnt varchar (255),
funded_amnt varchar (255),
funded_amnt_inv varchar (255),
term varchar (255),
int_rate varchar (255),
installment	double, 
grade varchar (10),	sub_grade varchar (10),	emp_title varchar (550), emp_length varchar (255),	home_ownership varchar (255),
annual_inc int,	verification_status varchar (255), issue_d date,
loan_status varchar (255),
pymnt_plan varchar (255), details varchar (5000), purpose varchar (500), title varchar (1000),	zip_code varchar (250),	addr_state varchar (255),	dti double);

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Finance_1.csv'
into table finance1
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;


select sum(loan_amnt), year(issue_d) as years from finance1
group by year(issue_d) order by year(issue_d);


create table finance2(
id int ,
delinq_2yrs int,
earliest_cr_line date,
inq_last_6mths int,
mths_since_last_delinq varchar (255),
mths_since_last_record	varchar (255),
open_acc int,	
pub_rec int,
revol_bal int,	
revol_util varchar (255),
total_acc int,	
initial_list_status varchar (255),
out_prncp varchar (255),	
out_prncp_inv int,	
total_pymnt	double,
total_pymnt_inv	double,
total_rec_prncp	double,
total_rec_int double,	
total_rec_late_fee int,	
recoveries int,	
collection_recovery_fee	int,
last_pymnt_d date,	
last_pymnt_amnt	double,
next_pymnt_d varchar (255),	
last_credit_pull_d date );



load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Finance_2.csv'
into table finance2
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;


#KPI 1

select sum(loan_amnt), year(issue_d) as years from finance1
group by year(issue_d) order by year(issue_d);

create table kpi2
select finance1.grade, finance1.sub_grade, finance_2.revol_bal
from finance1 inner join finance_2 
on finance1.id=finance_2.ï»¿id;

#KPI 2
select finance1.grade, finance1.sub_grade, sum(finance_2.revol_bal) 
from
group by grade,sub_grade
order by grade,sub_grade;

#KPI3
select 
finance1.verification_status, sum(finance_2.total_pymnt) as total 
from finance1 inner join finance_2
on finance1.id=finance_2.ï»¿id
group by finance1.verification_status;

#KPI4

select
 finance1.addr_state, finance_2.last_credit_pull_d,finance1.loan_status
from finance1 inner join finance_2
on finance1.id=finance_2.ï»¿id
group by finance1.addr_state,finance1.loan_status;


#KPI5


ALTER TABLE finance_2 MODIFY COLUMN last_pymnt_d date;

select finance1.home_ownership, finance_2.last_pymnt_d ,year(finance_2.last_pymnt_d)
from finance1 inner join finance_2
on finance1.id=finance_2.ï»¿id;










