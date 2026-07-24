--Part 6 - Create business_reports.sql

--10. Total paid revenue from payments where payment_status = paid
SELECT
    SUM(payments.amount) AS total_paid_revenue
FROM payments
WHERE payments.payment_status = 'paid';

--11. Paid revenue by company
SELECT
    companies.company_name,
    SUM(payments.amount) AS paid_revenue
FROM companies
JOIN subscriptions ON companies.company_id = subscriptions.company_id
JOIN payments ON subscriptions.subscription_id = payments.subscription_id
WHERE payments.payment_status = 'paid'
GROUP BY companies.company_name;

--12. Paid revenue by plan
SELECT
    plans.plan_name,
    SUM(payments.amount) AS paid_revenue
FROM plans
JOIN subscriptions ON plans.plan_id = subscriptions.plan_id
JOIN payments ON subscriptions.subscription_id = payments.subscription_id
WHERE payments.payment_status = 'paid'
GROUP BY plans.plan_name;

-- 13. Number of active subscriptions by plan
SELECT
    plans.plan_name,
    COUNT(subscriptions.subscription_id) AS active_subscriptions
FROM plans
JOIN subscriptions ON plans.plan_id = subscriptions.plan_id
WHERE subscriptions.status = 'active'
GROUP BY plans.plan_name;

-- 14. Number of users by company
SELECT
    companies.company_name,
    COUNT(users.user_id) AS total_users
FROM companies
LEFT JOIN users ON companies.company_id = users.company_id
GROUP BY companies.company_name;

--15. Support tickets by company
SELECT
    companies.company_name,
    COUNT(support_tickets.ticket_id) AS total_tickets
FROM companies
JOIN users ON companies.company_id = users.company_id
JOIN support_tickets ON users.user_id = support_tickets.user_id
GROUP BY companies.company_name;

-- 16. Open support tickets by priority
SELECT
    support_tickets.priority,
    COUNT(support_tickets.ticket_id) AS open_tickets
FROM support_tickets
WHERE support_tickets.status = 'open'
GROUP BY support_tickets.priority;

-- 17. Companies with active subscriptions but unpaid/pending payments
SELECT
    companies.company_name,
    subscriptions.status AS subscription_status,
    payments.payment_status
FROM companies
JOIN subscriptions ON companies.company_id = subscriptions.company_id
JOIN payments ON subscriptions.subscription_id = payments.subscription_id
WHERE subscriptions.status = 'active'
AND payments.payment_status IN ('unpaid', 'pending');

-- 18. Top 5 companies by paid revenue
SELECT
    companies.company_name,
    SUM(payments.amount) AS paid_revenue
FROM companies
JOIN subscriptions ON companies.company_id = subscriptions.company_id
JOIN payments ON subscriptions.subscription_id = payments.subscription_id
WHERE payments.payment_status = 'paid'
GROUP BY companies.company_name
ORDER BY paid_revenue DESC
LIMIT 5;

-- 19. Average payment amount by plan
SELECT
    plans.plan_name,
    AVG(payments.amount) AS average_payment_amount
FROM plans
JOIN subscriptions ON plans.plan_id = subscriptions.plan_id
JOIN payments ON subscriptions.subscription_id = payments.subscription_id
WHERE payments.payment_status = 'paid'
GROUP BY plans.plan_name;

-- 20. Companies with the highest number of support tickets
SELECT
    companies.company_name,
    COUNT(support_tickets.ticket_id) AS total_tickets
FROM companies
JOIN users ON companies.company_id = users.company_id
JOIN support_tickets ON users.user_id = support_tickets.user_id
GROUP BY companies.company_name
ORDER BY total_tickets DESC;

--21. A final executive summary query combining company, plan, revenue and ticket count.
SELECT
    companies.company_name,
    plans.plan_name,
    SUM(payments.amount) AS total_revenue,
    COUNT(support_tickets.ticket_id) AS total_tickets
FROM companies
JOIN subscriptions ON companies.company_id = subscriptions.company_id
JOIN plans ON subscriptions.plan_id = plans.plan_id
LEFT JOIN payments ON subscriptions.subscription_id = payments.subscription_id
LEFT JOIN users ON companies.company_id = users.company_id
LEFT JOIN support_tickets ON users.user_id = support_tickets.user_id
WHERE payments.payment_status = 'paid'
GROUP BY
    companies.company_name,
    plans.plan_name;