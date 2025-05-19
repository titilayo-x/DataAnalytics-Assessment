SELECT p.id plan_id,
		p.owner_id,
		p.description type,
		MAX(s.transaction_date) last_transaction_date,
		DATEDIFF(CURDATE(), MAX(s.transaction_date)) inactivity_days
FROM plans_plan p
LEFT JOIN savings_savingsaccount s on p.id = s.plan_id
WHERE p.is_deleted = 0
GROUP BY p.id
HAVING DATEDIFF(CURDATE(), MAX(s.transaction_date)) > 365
;