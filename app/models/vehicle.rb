class Vehicle < ApplicationRecord
  belongs_to :user
  has_many :documentations
  has_many :invoices
  has_many :maintenances
  has_many :maintenance_plans
  has_many :refuels
  has_many :reminders
  has_many :vehicle_fuels
  has_one_attached :photo

  validates :sale_km, numericality: { greater_than: :purchase_km }, allow_nil: true
  validate :sale_date_after_purchase_date
  validate :sale_date_cannot_be_in_the_future

  private

  def sale_date_after_purchase_date
    return if sale_date.blank? || purchase_date.blank?

    errors.add(:sale_date, " ne peut pas être inférieure à la date d'achat") if sale_date < purchase_date
  end

  def sale_date_cannot_be_in_the_future
    return unless sale_date.present? && sale_date.strftime > Date.today.strftime

    errors.add(:sale_date, " ne peut pas être dans le futur")
  end
end
