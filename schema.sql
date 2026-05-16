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

INSERT INTO customers (name, car_model, next_revision_date)
SELECT 
    'Cliente ' || i, 
    CASE 
        WHEN i % 3 = 0 THEN 'TUCSON' 
        WHEN i % 2 = 0 THEN 'HB20' 
        ELSE 'CRETA' 
    END, 
    '2026-05-15'
FROM generate_series(3, 302) as i;

INSERT INTO appointments (customer_id, schedule_date, status)
SELECT i, NOW() + INTERVAL '5 days', 'ABERTO' 
FROM generate_series(3, 52) as i;

INSERT INTO appointments (customer_id, schedule_date, status)
SELECT i, NOW() - INTERVAL '30 days', 'CONCLUIDO' 
FROM generate_series(53, 102) as i;

INSERT INTO leads (customer_id, created_at)
SELECT i, NOW() 
FROM generate_series(103, 152) as i;