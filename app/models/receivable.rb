class Receivable < ActiveRecord::Base
  belongs_to :company
  belongs_to :customer
  belongs_to :receivable_category
  
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

  scope :not_deleted, -> { where("receivables.deleted_at IS NULL") }
  scope :company, ->(company) {where("receivables.company_id = ?", company)}
  scope :user, ->(user) {where("receivables.user_id = ?", user)}
  scope :customers, ->(text) { 
    if !text.empty?
      joins(:customer).where("customers.fullname LIKE ?", "%#{text}%")
    else
      includes(:customer)
    end
  }

  scope :status, ->(text) { 
    if !text.empty?
      where("receivables.status = ?", Receivable.statuses[text])
    end
  }  
end