-- create tables and dependencies
source tests/database/create_tables.sql
-- create views
source database/create_views.sql
-- insert data
source database/account_role_inserts.sql
source database/account_inserts.sql
source database/stock_inserts.sql
source database/order_inserts.sql
source database/order_execution_inserts.sql