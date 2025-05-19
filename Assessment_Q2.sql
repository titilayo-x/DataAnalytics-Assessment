WITH monthly_transactions AS (
	SELECT owner_id, 
			date_format(s.transaction_date, '%Y-%m') transaction_date, 
			COUNT(*) transaction_count
	FROM savings_savingsaccount s 
	GROUP BY owner_id, date_format(s.transaction_date, '%Y-%m')
),
avg_transaction AS (
	SELECT owner_id, 
			AVG(transaction_count) average_transactions
	FROM monthly_transactions
	GROUP BY owner_id
),
frequency as (
	SELECT 
		CASE WHEN average_transactions >= 10 THEN 'High Frequency'
		WHEN average_transactions BETWEEN 3 AND 9 THEN 'Medium Frequency'
		ELSE 'Low Frequency'
		END AS frequency_category, 
			owner_id, 
			average_transactions
    FROM avg_transaction
    )
		SELECT frequency_category, 
				COUNT(owner_id) customer_count, 
				AVG(average_transactions) avg_transactions_per_month
		FROM frequency
		GROUP BY frequency_category;