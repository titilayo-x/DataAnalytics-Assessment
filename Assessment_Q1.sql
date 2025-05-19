WITH savings AS (
	SELECT a.owner_id,
			COUNT(distinct a.id) savings_count,
			SUM(b.confirmed_amount) total_savings
	FROM plans_plan a
	JOIN savings_savingsaccount b ON a.id = b.plan_id
	WHERE is_regular_savings = 1
	AND is_deleted =  0
	GROUP BY a.owner_id 
	HAVING sum(b.confirmed_amount) > 0
),
investment AS (
	SELECT a.owner_id,
			COUNT(DISTINCT a.id) investment_count,
			SUM(b.confirmed_amount) total_investment
	FROM plans_plan a
	JOIN savings_savingsaccount b ON a.id = b.plan_id
	WHERE is_a_fund = 1
	AND is_deleted =  0
	GROUP BY a.owner_id 
	HAVING sum(b.confirmed_amount) > 0
)
SELECT a.id owner_id, 
		CONCAT(first_name, ' ', last_name) name,
		savings_count,
		investment_count,
		total_savings + total_investment total_deposits
FROM users_customuser a
JOIN savings b ON a.id = b.owner_id
JOIN investment c ON a.id = c.owner_id
ORDER BY total_deposits DESC;
