class Payable < ActiveRecord::Base
  belongs_to :company
  belongs_to :supplier
  belongs_to :payable_category
  
  monetize :amount_cents, :as => "amount"

  enum status: {:open => 0, :paid => 1}
 
  def get_html_status
    if self.open?
      '<i class="fa fa-circle invoiceOpen"></i>'    
    else
      '<i class="fa fa-circle invoicePaid"></i>'
    end
  end

  def self.status_attributes_for_select
    statuses.map do |status, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.statuses.#{status}"), status]
    end
  end

  default_scope { where("payables.deleted_at IS NULL") }
  scope :company, ->(company) {where("payables.company_id = ?", company)}
  scope :suppliers, ->(text) { 
    if !text.empty?
      joins(:supplier).where("suppliers.trade_name LIKE ?", "%#{text}%")
    else
      includes(:supplier)
    end
  }

  scope :status, ->(text) { 
    if !text.empty?
      where("payables.status = ?", Payable.statuses[text])
    end
  }  

end