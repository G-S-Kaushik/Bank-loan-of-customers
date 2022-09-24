create database project2;
use project2;
alter table finance_2 rename column ï»¿id to id;
show tables;
select * from finance_1;
select * from finance_2;


# KPI -1 Year wise loan amount Stats
select issue_d as Year ,round(avg(loan_amnt),2) as Loan_amt from finance_1 where issue_d is not null group by issue_d order by (issue_d);


#KPI-2 Grade and sub grade wise revol_bal
select grade,sub_grade,round(avg(revol_bal),2) as Revol_Bal from finance_1 join finance_2 on finance_1.id=finance_2.id group by sub_grade order by (grade);


#KPI-3 Total Payment for Verified Status Vs Total Payment for Non Verified Status
select verification_status as VERIFICATION_STATUS,round(AVG(total_pymnt),2) AS TOTAL_PAYMENT from finance_2 join finance_1 on finance_2.id = finance_1.id group by verification_status ;


#KPI-4 State wise and last_credit_pull_d wise loan status
select addr_state, last_credit_pull_d, loan_status, count(loan_status) Count_loanStatus from finance_1 f1 inner join finance_2 f2 on (f1.id=f2.id)   group by addr_state,last_credit_pull_d, loan_status order by addr_state,last_credit_pull_d, loan_status;

#KPI-5 Home ownership Vs last payment date stats
SELECT home_ownership , last_pymnt_d, COUNT(home_ownership) from finance_2 f2 join finance_1 f1 on (f2.id = f1.id) where last_pymnt_d != (20) GROUP BY last_pymnt_d,home_ownership ORDER BY last_pymnt_d,home_ownership;



ALTER Table finance_1 add (tw int );
update finance_1 set tw=20;
update finance_1 set issue_d=(SUBSTRING_INDEX(finance_1.issue_d,'-',-1));
select concat (tw,issue_d) from finance_1; 
update finance_1 set issue_d=(concat (tw,issue_d));
alter table finance_1 drop column tw;



select * from finance_2;
ALTER Table finance_2 add (tw int );
update finance_2 set tw=20;
update finance_2 set last_credit_pull_d=(SUBSTRING_INDEX(finance_2.last_credit_pull_d,'-',-1));
update finance_2 set last_pymnt_d=(SUBSTRING_INDEX(finance_2.last_pymnt_d,'-',-1));
select concat (tw,last_credit_pull_d) from finance_2; 
update finance_2 set last_credit_pull_d=(concat (tw,last_credit_pull_d));
update finance_2 set last_pymnt_d=(concat (tw,last_pymnt_d));
alter table finance_2 drop column tw;