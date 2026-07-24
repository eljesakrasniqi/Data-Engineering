# Data Quality Notes

## What does each table represent in the business?

- **companies** – Stores information about companies using the SaaS platform.
- **users** – Stores users who belong to a company.
- **plans** – Stores available subscription plans.
- **subscriptions** – Connects companies with subscription plans.
- **payments** – Stores payments made for subscriptions.
- **support_tickets** – Stores support requests created by users.

---

## Which column should be the primary key in each table?

- companies → company_id
- users → user_id
- plans → plan_id
- subscriptions → subscription_id
- payments → payment_id
- support_tickets → ticket_id

---

## Which columns should be foreign keys?

- users.company_id → companies.company_id
- subscriptions.company_id → companies.company_id
- subscriptions.plan_id → plans.plan_id
- payments.subscription_id → subscriptions.subscription_id
- support_tickets.user_id → users.user_id

---

## Which fields must be NOT NULL?

- Company name
- User name
- User email
- Company ID in users
- Plan name
- Plan price
- Company ID in subscriptions
- Plan ID in subscriptions
- Subscription ID in payments
- Payment amount
- User ID in support_tickets
- Ticket title
- Ticket status

---

## Which values should be protected with CHECK constraints?

- Plan price must be greater than 0.
- Payment amount must be greater than 0.
- Subscription status should only allow values like:
  - Active
  - Cancelled
  - Expired
- Ticket status should only allow values like:
  - Open
  - In Progress
  - Closed

---

## Which relationships are one-to-many?

- One company → Many users
- One company → Many subscriptions
- One plan → Many subscriptions
- One subscription → Many payments
- One user → Many support tickets

---

## Which relationship uses a bridge table?

The **subscriptions** table acts as a bridge table between **companies** and **plans**, because one company can subscribe to different plans and one plan can be used by many companies.

---

## What kind of invalid data should the database reject?

- Missing required values (NOT NULL fields).
- Negative or zero prices.
- Negative or zero payment amounts.
- Invalid foreign key values.
- Duplicate primary keys.
- Invalid subscription status.
- Invalid ticket status.
- Users assigned to companies that do not exist.
- Payments linked to subscriptions that do not exist.
- Support tickets linked to users that do not exist.