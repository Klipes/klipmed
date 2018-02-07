class Schedule < ActiveRecord::Base
  belongs_to :company
  belongs_to :user
  belongs_to :customer

  enum schedule_type: [:initial, :normal, :return]  

  def self.schedule_type_attributes_for_select
    schedule_types.map do |schedule_type, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.schedule_type.#{schedule_type}"), schedule_type]
    end
  end
end
