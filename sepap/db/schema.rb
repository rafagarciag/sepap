# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110616205408) do

  create_table "attempts", :force => true do |t|
    t.integer  "numero_problema"
    t.string   "resultado"
    t.integer  "user_id"
    t.integer  "problem_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
    t.string   "lenguaje"
  end

  create_table "groups", :force => true do |t|
    t.string   "clave"
    t.string   "nombre"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "campus"
    t.string   "semestre"
    t.date     "fecha"
    t.string   "miembros"
  end

  create_table "problems", :force => true do |t|
    t.integer  "numero"
    t.string   "titulo"
    t.text     "descripcion"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "solution"
    t.string   "input"
    t.string   "output"
    t.integer  "tiempo"
    t.boolean  "modulo"
    t.string   "metodo"
    t.string   "input2"
    t.string   "input3"
    t.string   "output2"
    t.string   "output3"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "password_salt",                       :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nombre"
    t.string   "apellido"
    t.string   "matricula"
    t.boolean  "admin",                               :default => false
    t.boolean  "profesor",                            :default => false
    t.boolean  "estudiante",                          :default => true
    t.integer  "group_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
