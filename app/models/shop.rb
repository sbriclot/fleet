class Shop < ApplicationRecord
  before_save :check_url
  before_validation :format_tel

  has_many :invoices

  validates :name, presence: true
  validates :tel, format: { with: /\A\z|\A\+?\d+\z/, message: "Chiffres uniquement SVP (préfixe + autorisé)" }
  validates :home_url, :booking_url, format: { with: /\A\z|\A(http|www).+\.{1}.+\z/, message: "URL invalide" }

  private

  def check_url
    format_url("home_url")
    format_url("booking_url")
  end

  def format_url(arg)
    url = self[arg]
    return if url.nil? || url.empty?

    self[arg] = "http://#{url}" unless url[%r{\Ahttp://}] || url[%r{\Ahttps://}]
  end

  def format_tel
    self.tel = tel.gsub(/[^0-9+]/, "")
  end
end
