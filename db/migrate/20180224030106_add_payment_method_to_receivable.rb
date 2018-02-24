class AddPaymentMethodToReceivable < ActiveRecord::Migration
  def change
    add_reference :receivables, :payment_method, index: true, foreign_key: true
  end
end
