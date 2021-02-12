class Maintenance < ApplicationRecord
  belongs_to :vehicle
  has_many :operations, dependent: :destroy

  validate :date_cannot_be_in_the_future
  validates :km, presence: true, numericality: { greater_than: 0 }

  private

  def date_cannot_be_in_the_future
    return unless date.present? && date.strftime > Date.today.strftime

    errors.add(:date, "Une maintenance ne peut être créée dans le futur")
  end
end
