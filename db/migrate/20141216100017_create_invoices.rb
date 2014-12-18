class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.text :content
      t.float :amount
      t.references :user, index: true

      t.timestamps null: false
    end
    add_index :invoices, [:user_id, :created_at]
  end
end
