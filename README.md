# DataAnalytics-Assessment
Hello, please see my submission for the Data Analyst role assessment.

**Question 1**
The goal is to identify customers with both funded savings and investment accounts alongside their total deposits

Tables used
users_customuser
savings_savingsaccount
plans_plan

First I used the savings CTE to identify the accounts with savings accounts with the assumption that is_regular_savings = 1 means the customer has savings plan. The same thing was done to create a CTE for accounts with investment plans with the assumption is_a_fund = 1.
I also filtered for existing customers with is_deleted =  0. I grouped by the owner id and filtered with the ones that are funded with sum(b.confirmed_amount) > 0 in both categories
I then joined the user table with both CTEs to identify the customers with BOTH savings and investment plans.
I was going to incorporate the amount withdrawn but in banking, an account ever funded is regarded funded, hence my decision to use the confirmed_amount field only.
I then sorted with the total deposits, both savings and investment amounts.


**Question 2**
The aim is to segment customers according to how often they transact

Tables used 
users_customuser
savings_savingsaccount

I created a CTE to extract the number of times each customer transacts in every month.
Then I did an average of the count of transactions for every month for each customer. 
I then used a conditional statement 'CASE' to segment the customers and grouping the overall average of all customers by the frequency into High, Medium and Low.


**Question 3**
The ask here is to identify accounts that have been inactive for ver 365 days

Table used
plans_plan
savings_savingsaccount

First I joined the plans_id table to the savings_savingsaccount table with a left join to get the last transaction date for each account with MAX(s.transaction_date).
Then i applied a filter to select the ones over 365 days.
I also included the number of days the accounts last transacted.


**Question 4**
This is to estimate CLV based on account tenure and transaction volume

Tables used
users_customuser
savings_savingsaccount

First I created a table to extract the customers info from the user table and the corresponding number of transactions from inception, tenure in months and average profit per transaction by joining the user_customuser table with the savings_savingsaccount table.
I then concatenated the names and utilized the formula provided '(C.Total_transactions / tenure) * 12 * avg_profit_per_transaction)' to get the CLV.
I sorted by the estimated CLV with the hihgest first.


