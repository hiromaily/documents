table "hospital_doctors" {
  schema = schema.public
  column "id" {
    null = false
    type = uuid
  }
  column "hospital_id" {
    null = false
    type = uuid
  }
  column "name" {
    null = false
    type = character_varying(100)
  }
  column "email" {
    null = false
    type = character_varying(255)
  }
  column "created_at" {
    null    = true
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
  }
  column "updated_at" {
    null    = true
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
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
  schema = schema.public
  column "id" {
    null = false
    type = uuid
  }
  column "name" {
    null = false
    type = character_varying(100)
  }
  column "branch_name" {
    null = true
    type = character_varying(100)
  }
  column "email" {
    null = false
    type = character_varying(255)
  }
  column "tel" {
    null = true
    type = character_varying(15)
  }
  column "zip_code" {
    null = true
    type = character_varying(10)
  }
  column "prefecture" {
    null = true
    type = character_varying(50)
  }
  column "city" {
    null = true
    type = character_varying(50)
  }
  column "town" {
    null = true
    type = character_varying(50)
  }
  column "address" {
    null = true
    type = character_varying(255)
  }
  column "created_at" {
    null    = true
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
  }
  column "updated_at" {
    null    = true
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
}
table "patient_families" {
  schema = schema.public
  column "id" {
    null = false
    type = uuid
  }
  column "hospital_id" {
    null = false
    type = integer
  }
  column "zip_code" {
    null = true
    type = character_varying(10)
  }
  column "prefecture" {
    null = true
    type = character_varying(50)
  }
  column "city" {
    null = true
    type = character_varying(50)
  }
  column "town" {
    null = true
    type = character_varying(50)
  }
  column "address" {
    null = true
    type = character_varying(255)
  }
  column "email" {
    null = true
    type = character_varying(255)
  }
  column "is_valid" {
    null    = true
    type    = boolean
    default = true
  }
  column "last_login_at" {
    null = true
    type = timestamp
  }
  column "created_at" {
    null    = true
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
  }
  column "updated_at" {
    null    = true
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
}
table "patient_users" {
  schema = schema.public
  column "id" {
    null = false
    type = uuid
  }
  column "family_id" {
    null = false
    type = uuid
  }
  column "last_name" {
    null = true
    type = character_varying(50)
  }
  column "first_name" {
    null = true
    type = character_varying(50)
  }
  column "gender" {
    null = true
    type = character_varying(10)
  }
  column "birthday" {
    null = true
    type = date
  }
  column "relationship" {
    null = true
    type = character_varying(50)
  }
  column "insurance_card_image" {
    null = true
    type = bytea
  }
  column "created_at" {
    null    = true
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
  }
  column "updated_at" {
    null    = true
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
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
}
table "pharmacies" {
  schema = schema.public
  column "id" {
    null = false
    type = uuid
  }
  column "name" {
    null = false
    type = character_varying(100)
  }
  column "branch_name" {
    null = true
    type = character_varying(100)
  }
  column "zip_code" {
    null = true
    type = character_varying(10)
  }
  column "prefecture" {
    null = true
    type = character_varying(50)
  }
  column "city" {
    null = true
    type = character_varying(50)
  }
  column "town" {
    null = true
    type = character_varying(50)
  }
  column "address" {
    null = true
    type = character_varying(255)
  }
  column "created_at" {
    null    = true
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
  }
  column "updated_at" {
    null    = true
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
}
table "requests" {
  schema = schema.public
  column "id" {
    null = false
    type = uuid
  }
  column "patient_user_id" {
    null = false
    type = uuid
  }
  column "request_status" {
    null = false
    type = enum.request_status_enum
  }
  column "symptom_list" {
    null = false
    type = sql("text[]")
  }
  column "symptom_details" {
    null = true
    type = text
  }
  column "date_list" {
    null = false
    type = sql("date[]")
  }
  column "created_at" {
    null    = true
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
  }
  column "updated_at" {
    null    = true
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
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
  values = ["pending", "in_progress", "completed", "cancelled"]
}
schema "public" {
  comment = "standard public schema"
}
