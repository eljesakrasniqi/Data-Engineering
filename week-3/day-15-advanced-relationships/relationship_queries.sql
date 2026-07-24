-- Part 5 - Create relationship_queries.sql

--1. Show users together with their company name.
SELECT 
   users.full_name AS user_name,
   companies.company_name
FROM users
JOIN companies ON users.company_id = companies.company_id;

--2. Show subscriptions together with company name and plan name.
SELECT
   subscriptions.subscription_id,
   companies.company_name,
   plans.plan_name
FROM subscriptions
JOIN companies ON subscriptions.company_id = companies.company_id
JOIN plans ON subscriptions.plan_id = plans.plan_id;

--3. Show payments together with company name, plan name and subscription status.
SELECT
   payments.payment_id,
   companies.company_name,
   plans.plan_name,
   subscriptions.status
FROM payments
JOIN subscriptions ON payments.subscription_id = subscriptions.subscription_id
JOIN companies ON subscriptions.company_id = companies.company_id
JOIN plans ON subscriptions.plan_id = plans.plan_id;

--4. Show support tickets together with user name, user email and company name.
SELECT 
   support_tickets.ticket_id,
   users.full_name as user_name,
   users.email,
   companies.company_name
FROM support_tickets
JOIN users ON support_tickets.user_id = users.user_id
JOIN companies ON users.company_id = companies.company_id;

--5. Show all companies and their users using LEFT JOIN.
SELECT
    companies.company_name,
    users.full_name,
    users.email
FROM companies
LEFT JOIN users ON companies.company_id = users.company_id;

--Show companies that currently have no users
SELECT
    companies.company_name
FROM companies
LEFT JOIN users ON companies.company_id = users.company_id
WHERE users.user_id IS NULL;

--7. Show users that have not opened any support tickets
SELECT
    users.full_name,
    users.email
FROM users
LEFT JOIN support_tickets ON users.user_id = support_tickets.user_id
WHERE support_tickets.ticket_id IS NULL;

-- 8. Show subscriptions that have no payments yet
SELECT
    subscriptions.subscription_id,
    companies.company_name,
    plans.plan_name
FROM subscriptions
JOIN companies ON subscriptions.company_id = companies.company_id
JOIN plans ON subscriptions.plan_id = plans.plan_id
LEFT JOIN payments ON subscriptions.subscription_id = payments.subscription_id
WHERE payments.payment_id IS NULL;

-- 9. Show active subscriptions with pending or failed payments.
SELECT
    companies.company_name,
    plans.plan_name,
    subscriptions.status AS subscription_status,
    payments.payment_status,
    payments.amount
FROM subscriptions
JOIN companies ON subscriptions.company_id = companies.company_id
JOIN plans ON subscriptions.plan_id = plans.plan_id
JOIN payments ON subscriptions.subscription_id = payments.subscription_id
WHERE subscriptions.status = 'active'
AND payments.payment_status IN ('pending', 'failed');