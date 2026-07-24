-- Companies
INSERT INTO companies (company_name, city, industry) VALUES
('TechNova', 'Prishtina', 'Technology'),
('GreenSoft', 'Prizren', 'Software'),
('HealthPlus', 'Peja', 'Healthcare'),
('EduSmart', 'Gjilan', 'Education'),
('RetailPro', 'Mitrovica', 'Retail');

-- Plans
INSERT INTO plans (plan_name, monthly_price, max_users) VALUES
('Basic', 29.99, 10),
('Pro', 59.99, 50),
('Enterprise', 129.99, 500);

-- Users
INSERT INTO users (company_id, full_name, email, role, is_active) VALUES
(1, 'Arta Krasniqi', 'arta@technova.com', 'Admin', 1),
(1, 'Blend Gashi', 'blend@technova.com', 'Developer', 1),
(1, 'Sara Berisha', 'sara@technova.com', 'Manager', 1),

(2, 'Luan Hoxha', 'luan@greensoft.com', 'Admin', 1),
(2, 'Diona Kelmendi', 'diona@greensoft.com', 'Support', 1),
(2, 'Erion Shala', 'erion@greensoft.com', 'Developer', 0),

(3, 'Ariana Rama', 'ariana@healthplus.com', 'Admin', 1),
(3, 'Fisnik Berisha', 'fisnik@healthplus.com', 'Support', 1),

(4, 'Besa Gashi', 'besa@edusmart.com', 'Admin', 1),
(4, 'Leon Dervishi', 'leon@edusmart.com', 'Teacher', 1),

(5, 'Mira Rexha', 'mira@retailpro.com', 'Admin', 1),
(5, 'Albin Hyseni', 'albin@retailpro.com', 'Sales', 1);

-- Subscriptions
INSERT INTO subscriptions (company_id, plan_id, start_date, status) VALUES
(1, 2, '2026-01-10', 'active'),
(2, 3, '2026-02-15', 'active'),
(3, 1, '2026-03-01', 'paused'),
(4, 2, '2026-03-20', 'cancelled'),
(5, 1, '2026-04-05', 'active'),
(1, 3, '2026-05-10', 'cancelled');

-- Payments
INSERT INTO payments (subscription_id, payment_date, amount, payment_status) VALUES
(1, '2026-01-10', 59.99, 'paid'),
(1, '2026-02-10', 59.99, 'paid'),
(1, '2026-03-10', 59.99, 'pending'),

(2, '2026-02-15', 129.99, 'paid'),
(2, '2026-03-15', 129.99, 'paid'),
(2, '2026-04-15', 129.99, 'failed'),

(3, '2026-03-01', 29.99, 'paid'),
(3, '2026-04-01', 29.99, 'pending'),

(4, '2026-03-20', 59.99, 'failed'),

(5, '2026-04-05', 29.99, 'paid'),
(5, '2026-05-05', 29.99, 'pending'),

(6, '2026-05-10', 129.99, 'paid');

-- Support Tickets
INSERT INTO support_tickets (user_id, issue_type, priority, status, created_date) VALUES
(1, 'Login', 'high', 'open', '2026-06-01'),
(1, 'Billing', 'medium', 'closed', '2026-06-05'),

(2, 'API Error', 'high', 'in_progress', '2026-06-03'),

(3, 'Performance', 'medium', 'closed', '2026-06-08'),

(4, 'Password Reset', 'low', 'closed', '2026-06-09'),
(4, 'Billing', 'high', 'open', '2026-06-10'),

(5, 'Dashboard Bug', 'medium', 'in_progress', '2026-06-12'),

(6, 'Login', 'low', 'closed', '2026-06-13'),

(7, 'API Error', 'high', 'open', '2026-06-14'),
(7, 'Performance', 'medium', 'in_progress', '2026-06-15'),

(8, 'Billing', 'low', 'closed', '2026-06-16'),

(9, 'Password Reset', 'medium', 'open', '2026-06-18');