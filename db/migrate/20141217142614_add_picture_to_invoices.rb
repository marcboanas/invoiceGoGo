class AddPictureToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :picture, :string
  end
end
