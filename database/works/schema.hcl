table "hospital_doctors" {
  schema  = schema.public
  comment = "医師テーブル"
  column "id" {
    null    = false
    type    = uuid
    comment = "医師ID"
  }
  column "hospital_id" {
    null    = false
    type    = uuid
    comment = "所属する病院会員ID"
  }
  column "name" {
    null    = false
    type    = character_varying(100)
    comment = "医師名"
  }
  column "email" {
    null    = false
    type    = character_varying(255)
    comment = "Email"
  }
  column "created_at" {
    null    = true
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
    comment = "作成日時"
  }
  column "updated_at" {
    null    = true
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
    comment = "更新日時"
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "hospital_doctors_hospital_id_fkey" {
    columns     = [column.hospital_id]
    ref_columns = [table.hospital_users.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "hospital_users" {
  schema  = schema.public
  comment = "病院会員テーブル"
  column "id" {
    null    = false
    type    = uuid
    comment = "病院会員ID"
  }
  column "name" {
    null    = false
    type    = character_varying(100)
    comment = "病院名"
  }
  column "branch_name" {
    null    = true
    type    = character_varying(100)
    comment = "病院支店名"
  }
  column "email" {
    null    = false
    type    = character_varying(255)
    comment = "Email"
  }
  column "tel" {
    null    = true
    type    = character_varying(11)
    comment = "電話番号"
  }
  column "zip_code" {
    null    = false
    type    = character_varying(7)
    comment = "住所 郵便番号"
  }
  column "prefecture" {
    null    = false
    type    = character_varying(10)
    comment = "住所 都道府県"
  }
  column "city" {
    null    = false
    type    = character_varying(50)
    comment = "住所 市/区"
  }
  column "town" {
    null    = false
    type    = character_varying(50)
    comment = "住所 町名・番地"
  }
  column "address" {
    null    = false
    type    = character_varying(255)
    comment = "住所 建物名"
  }
  column "last_login_at" {
    null    = true
    type    = timestamp
    comment = "最終ログイン日時"
  }
  column "created_at" {
    null    = true
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
    comment = "作成日時"
  }
  column "updated_at" {
    null    = true
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
    comment = "更新日時"
  }
  primary_key {
    columns = [column.id]
  }
}
table "patient_families" {
  schema  = schema.public
  comment = "患者会員家族テーブル"
  column "id" {
    null    = false
    type    = uuid
    comment = "患者会員族ID"
  }
  column "zip_code" {
    null    = false
    type    = character_varying(7)
    comment = "住所 郵便番号"
  }
  column "prefecture" {
    null    = false
    type    = character_varying(10)
    comment = "住所 都道府県"
  }
  column "city" {
    null    = false
    type    = character_varying(50)
    comment = "住所 市/区"
  }
  column "town" {
    null    = false
    type    = character_varying(50)
    comment = "住所 町名・番地"
  }
  column "address" {
    null    = false
    type    = character_varying(255)
    comment = "住所 建物名"
  }
  column "email" {
    null    = false
    type    = character_varying(255)
    comment = "Emailアドレス"
  }
  column "is_valid" {
    null    = true
    type    = boolean
    default = true
    comment = "有効フラグ, 0: 仮登録中, 1: 登録完了"
  }
  column "last_login_at" {
    null    = true
    type    = timestamp
    comment = "最終ログイン日時"
  }
  column "created_at" {
    null    = true
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
    comment = "作成日時"
  }
  column "updated_at" {
    null    = true
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
    comment = "更新日時"
  }
  primary_key {
    columns = [column.id]
  }
}
table "patient_users" {
  schema  = schema.public
  comment = "患者会員個人テーブル"
  column "id" {
    null    = false
    type    = uuid
    comment = "患者会員個人ID"
  }
  column "family_id" {
    null    = false
    type    = uuid
    comment = "患者会員家族ID"
  }
  column "last_name" {
    null    = false
    type    = character_varying(50)
    comment = "氏名 性"
  }
  column "first_name" {
    null    = false
    type    = character_varying(50)
    comment = "氏名 名"
  }
  column "gender" {
    null    = true
    type    = character(2)
    comment = "性別"
  }
  column "birthday" {
    null    = false
    type    = date
    comment = "生年月日"
  }
  column "insurance_card_image_path" {
    null    = true
    type    = character_varying(50)
    comment = "保険証ファイルパス"
  }
  column "medical_treatment_card_image" {
    null    = true
    type    = character_varying(50)
    comment = "医療証ファイルパス"
  }
  column "created_at" {
    null    = true
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
    comment = "作成日時"
  }
  column "updated_at" {
    null    = true
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
    comment = "更新日時"
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "patient_users_family_id_fkey" {
    columns     = [column.family_id]
    ref_columns = [table.patient_families.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  check "patient_users_gender_check" {
    expr = "(gender = ANY (ARRAY['男'::bpchar, '女'::bpchar]))"
  }
}
table "pharmacies" {
  schema  = schema.public
  comment = "薬局テーブル"
  column "id" {
    null    = false
    type    = uuid
    comment = "薬局ID"
  }
  column "name" {
    null    = false
    type    = character_varying(100)
    comment = "薬局名"
  }
  column "branch_name" {
    null    = true
    type    = character_varying(100)
    comment = "薬局 支店名"
  }
  column "zip_code" {
    null    = false
    type    = character_varying(7)
    comment = "住所 郵便番号"
  }
  column "prefecture" {
    null    = false
    type    = character_varying(10)
    comment = "住所 都道府県"
  }
  column "city" {
    null    = false
    type    = character_varying(50)
    comment = "住所 市/区"
  }
  column "town" {
    null    = false
    type    = character_varying(50)
    comment = "住所 町名・番地"
  }
  column "address" {
    null    = false
    type    = character_varying(255)
    comment = "住所 建物名"
  }
  column "created_at" {
    null    = true
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
    comment = "作成日時"
  }
  column "updated_at" {
    null    = true
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
    comment = "更新日時"
  }
  primary_key {
    columns = [column.id]
  }
}
table "requests" {
  schema  = schema.public
  comment = "予約リクエストテーブル"
  column "id" {
    null    = false
    type    = uuid
    comment = "リクエストID"
  }
  column "patient_user_id" {
    null    = false
    type    = uuid
    comment = "該当の患者会員個人ID"
  }
  column "hospital_id" {
    null    = true
    type    = uuid
    comment = "受診する病院会員ID"
  }
  column "request_status" {
    null    = false
    type    = enum.request_status_enum
    comment = "リクエストステータス"
  }
  column "symptom_list" {
    null    = false
    type    = sql("public.sumptom_enum[]")
    comment = "症状リスト"
  }
  column "symptom_details" {
    null    = true
    type    = text
    comment = "症状詳細リスト"
  }
  column "expected_date_list" {
    null    = true
    type    = sql("timestamp without time zone[]")
    comment = "予約希望日リスト"
  }
  column "fixed_date" {
    null    = true
    type    = timestamp
    comment = "確定日時"
  }
  column "created_at" {
    null    = true
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
    comment = "作成日時"
  }
  column "updated_at" {
    null    = true
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
    comment = "更新日時"
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "requests_hospital_id_fkey" {
    columns     = [column.hospital_id]
    ref_columns = [table.hospital_users.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "requests_patient_user_id_fkey" {
    columns     = [column.patient_user_id]
    ref_columns = [table.patient_users.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
enum "request_status_enum" {
  schema = schema.public
  values = ["診療仮予約", "診療確定", "診療キャンセル", "診療終了", "請求済み", "支払い完了"]
}
enum "sumptom_enum" {
  schema = schema.public
  values = ["発熱", "喉の痛み", "頭痛", "吐き気", "腹痛", "下痢", "鼻水", "その他"]
}
schema "public" {
  comment = "standard public schema"
}
