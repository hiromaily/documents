
CREATE TABLE patient_families (
    id CHAR(36) NOT NULL PRIMARY KEY COMMENT '患者会員族ID',
    zip_code VARCHAR(7) NOT NULL COMMENT '住所 郵便番号',
    prefecture VARCHAR(10) NOT NULL COMMENT '住所 都道府県',
    city VARCHAR(50) NOT NULL COMMENT '住所 市/区',
    town VARCHAR(50) NOT NULL COMMENT '住所 町名・番地',
    address VARCHAR(255) NOT NULL COMMENT '住所 建物名',
    email VARCHAR(255) NOT NULL COMMENT 'Emailアドレス',
    is_valid BOOLEAN DEFAULT true COMMENT '有効フラグ, false: 仮登録中, true: 登録完了',
    last_login_at TIMESTAMP NULL COMMENT '最終ログイン日時',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時'
) COMMENT='患者会員家族テーブル';

CREATE TABLE patient_users (
    id CHAR(36) NOT NULL PRIMARY KEY COMMENT '患者会員個人ID',
    family_id CHAR(36) NOT NULL COMMENT '患者会員家族ID',
    last_name VARCHAR(50) NOT NULL COMMENT '氏名 性',
    first_name VARCHAR(50) NOT NULL COMMENT '氏名 名',
    gender ENUM('男', '女') NOT NULL COMMENT '性別',
    birthday DATE NOT NULL COMMENT '生年月日',
    insurance_card_image_path VARCHAR(50) NULL COMMENT '保険証ファイルパス',
    medical_treatment_card_image VARCHAR(50) NULL COMMENT '医療証ファイルパス',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
    FOREIGN KEY (family_id) REFERENCES patient_families(id)
) COMMENT='患者会員個人テーブル';

CREATE TABLE pharmacies (
    id CHAR(36) NOT NULL PRIMARY KEY COMMENT '薬局ID',
    name VARCHAR(100) NOT NULL COMMENT '薬局名',
    branch_name VARCHAR(100) NULL COMMENT '薬局 支店名',
    zip_code VARCHAR(7) NOT NULL COMMENT '住所 郵便番号',
    prefecture VARCHAR(10) NOT NULL COMMENT '住所 都道府県',
    city VARCHAR(50) NOT NULL COMMENT '住所 市/区',
    town VARCHAR(50) NOT NULL COMMENT '住所 町名・番地',
    address VARCHAR(255) NOT NULL COMMENT '住所 建物名',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時'
) COMMENT='薬局テーブル';

CREATE TABLE hospital_users (
    id CHAR(36) NOT NULL PRIMARY KEY COMMENT '病院会員ID',
    name VARCHAR(100) NOT NULL COMMENT '病院名',
    branch_name VARCHAR(100) NULL COMMENT '病院支店名',
    email VARCHAR(255) NOT NULL COMMENT 'Email',
    tel VARCHAR(11) NULL COMMENT '電話番号',
    zip_code VARCHAR(7) NOT NULL COMMENT '住所 郵便番号',
    prefecture VARCHAR(10) NOT NULL COMMENT '住所 都道府県',
    city VARCHAR(50) NOT NULL COMMENT '住所 市/区',
    town VARCHAR(50) NOT NULL COMMENT '住所 町名・番地',
    address VARCHAR(255) NOT NULL COMMENT '住所 建物名',
    last_login_at TIMESTAMP NULL COMMENT '最終ログイン日時',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時'
) COMMENT='病院会員テーブル';

CREATE TABLE hospital_doctors (
    id CHAR(36) NOT NULL PRIMARY KEY COMMENT '医師ID',
    hospital_id CHAR(36) NOT NULL COMMENT '所属する病院会員ID',
    name VARCHAR(100) NOT NULL COMMENT '医師名',
    email VARCHAR(255) NOT NULL COMMENT 'Email',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
    FOREIGN KEY (hospital_id) REFERENCES hospital_users(id)
) COMMENT='医師テーブル';

-- First, create the enum types as ENUMs in MySQL
CREATE TABLE request_status_enum (
    value ENUM('診療仮予約', '診療確定', '診療キャンセル', '診療終了', '請求済み', '支払い完了') NOT NULL
);

CREATE TABLE symptom_enum (
    value ENUM('発熱', '喉の痛み', '頭痛', '吐き気', '腹痛', '下痢', '鼻水', 'その他') NOT NULL
);

-- Then, create the requests table
CREATE TABLE requests (
    id CHAR(36) NOT NULL PRIMARY KEY COMMENT 'リクエストID',
    patient_user_id CHAR(36) NOT NULL COMMENT '該当の患者会員個人ID',
    hospital_id CHAR(36) NULL COMMENT '受診する病院会員ID',
    request_status ENUM('診療仮予約', '診療確定', '診療キャンセル', '診療終了', '請求済み', '支払い完了') NOT NULL COMMENT 'リクエストステータス',
    symptom_list JSON NOT NULL COMMENT '症状リスト',
    symptom_details TEXT NULL COMMENT '症状詳細リスト',
    expected_date_list JSON NULL COMMENT '予約希望日リスト',
    is_earliest_expected BOOLEAN DEFAULT false COMMENT '予約可能な最短日を希望',
    fixed_date TIMESTAMP NULL COMMENT '確定日時',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
    FOREIGN KEY (patient_user_id) REFERENCES patient_users(id),
    FOREIGN KEY (hospital_id) REFERENCES hospital_users(id)
) COMMENT='予約リクエストテーブル';