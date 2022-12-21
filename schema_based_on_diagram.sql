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

-- Create (join-table between medical_histories and treatments) medical_treatments table.
CREATE TABLE medicals_treatments(
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
  treatment_id INT,
  medical_history_id INT,
  PRIMARY KEY (id),
  CONSTRAINT fk_treatments
    FOREIGN KEY (treatment_id)
      REFERENCES treatments(id),
  CONSTRAINT fk_medical_histories
    FOREIGN KEY (medical_history_id)
      REFERENCES medical_histories(id)
);

-- FK Indexes
CREATE INDEX medical_histories_patient_id ON medical_histories(patient_id);
CREATE INDEX invoices_medical_history_id ON invoices(medical_history_id);
CREATE INDEX invoices_items_invoiced_id ON invoices(invoiced_id);
CREATE INDEX invoices_items_treatment_id ON treatments(treatment_id);
CREATE INDEX medicals_treatments_treatment_id ON treatments(treatment_id);
CREATE INDEX medicals_treatments_medical_history_id ON medical_histories(medical_history_id);

