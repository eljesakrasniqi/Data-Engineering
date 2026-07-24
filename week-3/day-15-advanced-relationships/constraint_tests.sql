-- Part 4 - Create constraint_tests.sql

--Insert a user with a company_id that does not exist. (It should fail because company_id 777 does not exist)
INSERT INTO users (company_id, full_name, email, role, is_active) VALUES
(777, 'Arta Krasniqi', 'eljesa@gmail.com', 'Admin', 1);

--Insert a subscription with a plan_id that does not exist. (It should fail because plan_id 777 does not exist)
INSERT INTO subscriptions (company_id, plan_id, start_date, status) VALUES
(1, 777, '2026-01-10', 'active');

--Insert a duplicate user email. (It should fail because email is unique)
INSERT INTO users (company_id, full_name, email, role, is_active) VALUES
(1, 'Arta Krasniqi', 'arta@technova.com', 'Admin', 1);

--Insert a plan with a negative monthly_price. (It should fail because monthly_price should be greater than 0)
INSERT INTO plans (plan_name, monthly_price, max_users) VALUES
('Basic', -10, 10);

--Insert a payment with amount = 0 or negative amount. (It should fail because amount should be greater than 0)
INSERT INTO payments (subscription_id, payment_date, amount, payment_status) VALUES
(1, '2026-01-10', 0, 'paid');

--Insert a support ticket with an invalid priority (It should fail because priority needs to be: 'low', 'medium', 'high')
INSERT INTO support_tickets (user_id, issue_type, priority, status, created_date) VALUES
(1, 'Login', 'invalid', 'open', '2026-06-01');

--Insert a subscription with an invalid status. (It should fail because priority needs to be: 'active', 'paused', 'cancelled')
INSERT INTO subscriptions (company_id, plan_id, start_date, status) VALUES
(1, 2, '2026-01-10', 'invalid');

--Insert a payment with an invalid payment_status. (It should fail because priority needs to be: 'paid', 'pending', 'failed')
INSERT INTO payments (subscription_id, payment_date, amount, payment_status) VALUES
(1, '2026-01-10', 59.99, 'invalid');