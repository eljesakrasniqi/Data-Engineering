# Unity Tech Hub x Agilyti - Day 15 Practice

## Project Goal

The goal of this project is to create a relational database for a SaaS subscription system.

The database manages companies, users, plans, subscriptions, payments, and support tickets.

The project demonstrates:
- Database relationships
- Primary and foreign keys
- Constraints
- JOIN queries
- Business reports


## Business Scenario

A software company provides subscription plans to different companies.

Each company can have multiple users and subscriptions.
Users can create support tickets, while payments track company revenue.


## Tables Created

### Companies
Stores customer company information.

### Users
Stores users that belong to companies.

Relationship:
One company can have many users.


### Plans
Stores available subscription plans.

### Subscriptions
Connects companies with subscription plans and stores subscription status.


### Payments
Stores payment information and payment status.


### Support Tickets
Stores customer support requests created by users.


## Primary Keys

Each table has a primary key:

- company_id
- user_id
- plan_id
- subscription_id
- payment_id
- ticket_id

Primary keys uniquely identify each record and prevent duplicates.


## Foreign Keys

Foreign keys connect tables and protect relationships.

Examples:

- users.company_id → companies.company_id
- subscriptions.company_id → companies.company_id
- subscriptions.plan_id → plans.plan_id
- payments.subscription_id → subscriptions.subscription_id
- support_tickets.user_id → users.user_id


## Constraints Used

- PRIMARY KEY: Creates unique IDs.
- FOREIGN KEY: Maintains valid relationships.
- NOT NULL: Prevents missing required data.
- UNIQUE: Prevents duplicate emails.
- CHECK: Allows only valid statuses.
- AUTOINCREMENT: Generates IDs automatically.


## Invalid Data Examples

The database rejects:

- User without a company.
- Payment with invalid status.
- Duplicate email addresses.
- Subscription linked to a non-existing plan.


## Important JOIN Queries

Examples:

- Users with company names.
- Subscriptions with company and plan details.
- Payments with company revenue information.
- Companies without users using LEFT JOIN.
- Subscriptions without payments.


## Business Insights

Reports help managers understand:

- Total paid revenue.
- Revenue by company and plan.
- Number of active subscriptions.
- Customer support activity.
- Companies with payment problems.


## What I Can Explain Live

I can explain:

- Database structure and relationships.
- How primary keys and foreign keys work.
- Difference between INNER JOIN and LEFT JOIN.
- How SQL reports provide business insights.
- How constraints improve data quality.