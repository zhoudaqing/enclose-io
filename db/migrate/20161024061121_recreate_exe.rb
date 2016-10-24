class RecreateExe < ActiveRecord::Migration[5.0]
  def change
    create_table "executables", force: :cascade do |t|
      t.integer  "project_id",               null: false
      t.string   "name",                     null: false
      t.string   "version"
      t.integer  "phase",        default: 0, null: false
      t.integer  "kind",                     null: false
      t.string   "node_version"
      t.string   "file"
      t.integer  "file_size"
      t.datetime "done_at"
      t.datetime "created_at",               null: false
      t.datetime "updated_at",               null: false
    end
  end
end
