CREATE TABLE customers (
id SERIAL PRIMARY KEY,
name VARCHAR(100) NOT NULL,
car_model VARCHAR(50) NOT NULL,
next_revision_date DATE NOT NULL
);

CREATE TABLE appointments (
id SERIAL PRIMARY KEY,
customer_id INT REFERENCES customers(id),
schedule_date TIMESTAMP NOT NULL,
status VARCHAR(20) NOT NULL
);

CREATE TABLE leads (
id SERIAL PRIMARY KEY,
customer_id INT REFERENCES customers(id),
created_at TIMESTAMP NOT NULL
);

INSERT INTO customers (name, car_model, next_revision_date) VALUES ('Ugo', 'HB20', '2026-05-01');

INSERT INTO appointments (customer_id, schedule_date, status) 
VALUES (1, '2026-05-15 14:30:00', 'AGENDADO');

INSERT INTO customers (name, car_model, next_revision_date) VALUES ('Igor', 'CRETA', '2026-05-08');
