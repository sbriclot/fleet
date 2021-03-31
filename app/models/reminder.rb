class Reminder < ApplicationRecord
  belongs_to :vehicle

  validate :date_cannot_be_in_the_future
  validates :task, presence: true
  validates :creation_km, presence: true, numericality: { greater_than: 0 }
  validates :limit_km, numericality: { greater_than: 0 }, allow_nil: true

  private

  def date_cannot_be_in_the_future
    return unless limit_date.present? && limit_date.strftime < Date.today.strftime

    errors.add(:limit_date, "Un rappel ne peut avoir une date limite déjà passée")
  end
end
