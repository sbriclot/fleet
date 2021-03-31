class Invoice < ApplicationRecord
  belongs_to :invoice_type
  belongs_to :vehicle
  belongs_to :shop
  has_many_attached :docs

  validates :invoice_ref, presence: true, uniqueness: true
  validates :date, presence: true
  validate :invoice_date_cannot_be_in_the_future
  validates :km, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :invoice_type_id, presence: true
  validates :shop_id, presence: true

  def invoice_date_cannot_be_in_the_future
    return unless date.present? && date.strftime > Date.today.strftime

    errors.add(:date, "Une facture ne peut être créée dans le futur")
  end
end
