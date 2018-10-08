DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS budgets;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS merchants;


CREATE TABLE budgets(
  id SERIAL8 PRIMARY KEY,
  amount INT8
);

CREATE TABLE categories(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  total_spend INT8
);

CREATE TABLE merchants(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  total_spend INT8
);


CREATE TABLE transactions(
  id SERIAL8 PRIMARY KEY,
  item VARCHAR(255),
  price INT8,
  date_time VARCHAR(255),
  merchant_name INT8 REFERENCES merchants(id),
  category_name INT8 REFERENCES categories(id)
);

-- dont create any data here
