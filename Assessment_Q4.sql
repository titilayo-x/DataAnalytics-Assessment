WITH tran_summary AS (
	SELECT A.id,
			A.first_name,
			A.last_name,
			COUNT(savings_id) Total_transactions,
	AVG(amount * 0.001) avg_profit_per_transaction,
	TIMESTAMPDIFF(MONTH, a.date_joined, CURDATE()) tenure
	FROM users_customuser A
	LEFT JOIN savings_savingsaccount C ON A.id = C.owner_id
	GROUP BY id, date_joined
)
	SELECT C.id customer_id,
			CONCAT(C.first_name, ' ', C.last_name) name,
			C.tenure tenure_months,
			C.Total_transactions total_transactions,
			((C.Total_transactions / tenure) * 12 * avg_profit_per_transaction) estimated_CLV
		FROM tran_summary C
		ORDER BY estimated_CLV DESC;