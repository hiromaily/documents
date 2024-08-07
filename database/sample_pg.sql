
CREATE TABLE patient_families (
    id UUID NOT NULL PRIMARY KEY,
    hospital_id INTEGER NOT NULL,
    zip_code VARCHAR(10),
    prefecture VARCHAR(50),
    city VARCHAR(50),
    town VARCHAR(50),
    address VARCHAR(255),
    email VARCHAR(255),
    is_valid BOOLEAN DEFAULT true,
    last_login_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE patient_users (
    id UUID NOT NULL PRIMARY KEY,
    family_id UUID NOT NULL,
    last_name VARCHAR(50),
    first_name VARCHAR(50),
    gender VARCHAR(10),
    birthday DATE,
    relationship VARCHAR(50),
    insurance_card_image BYTEA,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (family_id) REFERENCES patient_families(id)
);

CREATE TABLE pharmacies (
    id UUID NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    branch_name VARCHAR(100),
    zip_code VARCHAR(10),
    prefecture VARCHAR(50),
    city VARCHAR(50),
    town VARCHAR(50),
    address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE hospital_users (
    id UUID NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    branch_name VARCHAR(100),
    email VARCHAR(255) NOT NULL,
    tel VARCHAR(15),
    zip_code VARCHAR(10),
    prefecture VARCHAR(50),
    city VARCHAR(50),
    town VARCHAR(50),
    address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE hospital_doctors (
    id UUID NOT NULL PRIMARY KEY,
    hospital_id UUID NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (hospital_id) REFERENCES hospital_users(id)
);

-- First, create the enum type for request_status
CREATE TYPE request_status_enum AS ENUM ('pending', 'in_progress', 'completed', 'cancelled');

-- Then, create the requests table
CREATE TABLE requests (
    id UUID NOT NULL PRIMARY KEY,
    patient_user_id UUID NOT NULL,
    request_status request_status_enum NOT NULL,
    symptom_list TEXT[] NOT NULL,
    symptom_details TEXT,
    date_list DATE[] NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_user_id) REFERENCES patient_users(id)
);
