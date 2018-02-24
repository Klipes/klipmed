class AddPaymentMethodToPayable < ActiveRecord::Migration
  def change
    add_reference :payables, :payment_method, index: true, foreign_key: true
  end
end
