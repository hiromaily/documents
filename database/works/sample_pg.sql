
CREATE TABLE patient_families (
    id UUID NOT NULL PRIMARY KEY,
    zip_code VARCHAR(7) NOT NULL,
    prefecture VARCHAR(10) NOT NULL,
    city VARCHAR(50) NOT NULL,
    town VARCHAR(50) NOT NULL,
    address VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    is_valid BOOLEAN DEFAULT true,
    last_login_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
COMMENT ON TABLE patient_families IS '患者会員家族テーブル';
COMMENT ON COLUMN patient_families.id IS '患者会員族ID';
COMMENT ON COLUMN patient_families.zip_code IS '住所 郵便番号';
COMMENT ON COLUMN patient_families.prefecture IS '住所 都道府県';
COMMENT ON COLUMN patient_families.city IS '住所 市/区';
COMMENT ON COLUMN patient_families.town IS '住所 町名・番地';
COMMENT ON COLUMN patient_families.address IS '住所 建物名';
COMMENT ON COLUMN patient_families.email IS 'Emailアドレス';
COMMENT ON COLUMN patient_families.is_valid IS '有効フラグ, 0: 仮登録中, 1: 登録完了';
COMMENT ON COLUMN patient_families.last_login_at IS '最終ログイン日時';
COMMENT ON COLUMN patient_families.created_at IS '作成日時';
COMMENT ON COLUMN patient_families.updated_at IS '更新日時';


CREATE TABLE patient_users (
    id UUID NOT NULL PRIMARY KEY,
    family_id UUID NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    gender CHAR(2) CHECK (gender IN ('男', '女')),
    birthday DATE NOT NULL,
    insurance_card_image_path VARCHAR(50),
    medical_treatment_card_image VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (family_id) REFERENCES patient_families(id)
);
COMMENT ON TABLE patient_users IS '患者会員個人テーブル';
COMMENT ON COLUMN patient_users.id IS '患者会員個人ID';
COMMENT ON COLUMN patient_users.family_id IS '患者会員家族ID';
COMMENT ON COLUMN patient_users.last_name IS '氏名 性';
COMMENT ON COLUMN patient_users.first_name IS '氏名 名';
COMMENT ON COLUMN patient_users.gender IS '性別';
COMMENT ON COLUMN patient_users.birthday IS '生年月日';
COMMENT ON COLUMN patient_users.insurance_card_image_path IS '保険証ファイルパス';
COMMENT ON COLUMN patient_users.medical_treatment_card_image IS '医療証ファイルパス';
COMMENT ON COLUMN patient_users.created_at IS '作成日時';
COMMENT ON COLUMN patient_users.updated_at IS '更新日時';


CREATE TABLE pharmacies (
    id UUID NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    branch_name VARCHAR(100),
    zip_code VARCHAR(7) NOT NULL,
    prefecture VARCHAR(10) NOT NULL,
    city VARCHAR(50) NOT NULL,
    town VARCHAR(50) NOT NULL,
    address VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
COMMENT ON TABLE pharmacies IS '薬局テーブル';
COMMENT ON COLUMN pharmacies.id IS '薬局ID';
COMMENT ON COLUMN pharmacies.name IS '薬局名';
COMMENT ON COLUMN pharmacies.branch_name IS '薬局 支店名';
COMMENT ON COLUMN pharmacies.zip_code IS '住所 郵便番号';
COMMENT ON COLUMN pharmacies.prefecture IS '住所 都道府県';
COMMENT ON COLUMN pharmacies.city IS '住所 市/区';
COMMENT ON COLUMN pharmacies.town IS '住所 町名・番地';
COMMENT ON COLUMN pharmacies.address IS '住所 建物名';
COMMENT ON COLUMN pharmacies.created_at IS '作成日時';
COMMENT ON COLUMN pharmacies.updated_at IS '更新日時';


CREATE TABLE hospital_users (
    id UUID NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    branch_name VARCHAR(100),
    email VARCHAR(255) NOT NULL,
    tel VARCHAR(11),
    zip_code VARCHAR(7) NOT NULL,
    prefecture VARCHAR(10) NOT NULL,
    city VARCHAR(50) NOT NULL,
    town VARCHAR(50) NOT NULL,
    address VARCHAR(255) NOT NULL,
    last_login_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
COMMENT ON TABLE hospital_users IS '病院会員テーブル';
COMMENT ON COLUMN hospital_users.id IS '病院会員ID';
COMMENT ON COLUMN hospital_users.name IS '病院名';
COMMENT ON COLUMN hospital_users.branch_name IS '病院支店名';
COMMENT ON COLUMN hospital_users.zip_code IS '住所 郵便番号';
COMMENT ON COLUMN hospital_users.prefecture IS '住所 都道府県';
COMMENT ON COLUMN hospital_users.city IS '住所 市/区';
COMMENT ON COLUMN hospital_users.town IS '住所 町名・番地';
COMMENT ON COLUMN hospital_users.address IS '住所 建物名';
COMMENT ON COLUMN hospital_users.email IS 'Email';
COMMENT ON COLUMN hospital_users.tel IS '電話番号';
COMMENT ON COLUMN hospital_users.last_login_at IS '最終ログイン日時';
COMMENT ON COLUMN hospital_users.created_at IS '作成日時';
COMMENT ON COLUMN hospital_users.updated_at IS '更新日時';


CREATE TABLE hospital_doctors (
    id UUID NOT NULL PRIMARY KEY,
    hospital_id UUID NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (hospital_id) REFERENCES hospital_users(id)
);
COMMENT ON TABLE hospital_doctors IS '医師テーブル';
COMMENT ON COLUMN hospital_doctors.id IS '医師ID';
COMMENT ON COLUMN hospital_doctors.hospital_id IS '所属する病院会員ID';
COMMENT ON COLUMN hospital_doctors.name IS '医師名';
COMMENT ON COLUMN hospital_doctors.email IS 'Email';
COMMENT ON COLUMN hospital_doctors.created_at IS '作成日時';
COMMENT ON COLUMN hospital_doctors.updated_at IS '更新日時';


-- First, create the enum type
CREATE TYPE request_status_enum AS ENUM ('診療仮予約', '診療確定', '診療キャンセル', '診療終了', '請求済み', '支払い完了');
CREATE TYPE sumptom_enum AS ENUM ('発熱', '喉の痛み', '頭痛', '吐き気', '腹痛', '下痢', '鼻水', 'その他');

-- Then, create the requests table
CREATE TABLE requests (
    id UUID NOT NULL PRIMARY KEY,
    patient_user_id UUID NOT NULL,
    hospital_id UUID,
    request_status request_status_enum NOT NULL,
    symptom_list sumptom_enum[] NOT NULL,
    symptom_details TEXT,
    expected_date_list TIMESTAMP[],
    fixed_date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_user_id) REFERENCES patient_users(id),
    FOREIGN KEY (hospital_id) REFERENCES hospital_users(id)
);
COMMENT ON TABLE requests IS '予約リクエストテーブル';
COMMENT ON COLUMN requests.id IS 'リクエストID';
COMMENT ON COLUMN requests.patient_user_id IS '該当の患者会員個人ID';
COMMENT ON COLUMN requests.hospital_id IS '受診する病院会員ID';
COMMENT ON COLUMN requests.request_status IS 'リクエストステータス';
COMMENT ON COLUMN requests.symptom_list IS '症状リスト';
COMMENT ON COLUMN requests.symptom_details IS '症状詳細リスト';
COMMENT ON COLUMN requests.expected_date_list IS '予約希望日リスト';
COMMENT ON COLUMN requests.fixed_date IS '確定日時';
COMMENT ON COLUMN requests.created_at IS '作成日時';
COMMENT ON COLUMN requests.updated_at IS '更新日時';

