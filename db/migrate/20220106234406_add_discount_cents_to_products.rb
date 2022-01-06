class AddDiscountCentsToProducts < ActiveRecord::Migration
  def change
    # adds column into products table, name_of_column, data_type
    add_column :products, :sale_percent_off, :integer
  end
end
