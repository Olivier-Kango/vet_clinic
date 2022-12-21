-- Create patients table
CREATE TABLE patients (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(100),
  date_of_birth DATE
);

-- Create medical histories table
CREATE TABLE medical_histories (
  id BIGSERIAL PRIMARY KEY,
  admitted_at TIMESTAMP,
  patient_id INT,
  status VARCHAR(150),
  CONSTRAINT fk_patients
  FOREIGN KEY (patient_id)
  REFERENCES patients(id)
);

-- Create invoices table
CREATE TABLE invoices (
  id BIGSERIAL PRIMARY KEY,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT,
  CONSTRAINT fk_medical_histories
  FOREIGN KEY (medical_history_id)
  REFERENCES medical_histories(id)
);

-- Create treatements table
CREATE TABLE treatments (
  id BIGSERIAL PRIMARY KEY,
  type VARCHAR(100),
  name VARCHAR(100)
);

-- Create invoices_items table
CREATE TABLE invoices_items (
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
  unit_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoice_id INT,
  treatment_id INT,
  CONSTRAINT fk_invoices
  FOREIGN KEY (invoice_id)
  REFERENCES invoices(id),
  CONSTRAINT fk_treatments
  FOREIGN KEY (treatment_id)
  REFERENCES treatements(id)
);