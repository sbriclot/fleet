class Shop < ApplicationRecord
  before_save :format_url

  has_many :invoices

  validates :name, presence: true
  validates :tel, format: { with: /\A\z|\A\+?\d+\z/, message: "Utiliser des chiffres seulement SVP (préfixe + autorisé pour les numéros internationaux)" }
  validates :home_url, :booking_url, format: { with: /\A\z|\A(http|www).+\.{1}.+\z/, message: "URL invalide"}

  private
  def format_url
    p self
    if self.home_url.length > 0
      unless home_url[/\Ahttp:\/\//] || home_url[/\Ahttps:\/\//]
        self.home_url = "http://#{home_url}"
      end
    end
    if self.booking_url.length > 0
      unless booking_url[/\Ahttp:\/\//] || booking_url[/\Ahttps:\/\//]
        self.booking_url = "http://#{booking_url}"
      end
    end
  end
end
