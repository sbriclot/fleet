class Invoice < ApplicationRecord
  belongs_to :invoice_type
  belongs_to :vehicle
  belongs_to :shop
  has_many_attached :docs

  validates :date, presence: true
  validates :km, presence: { message: 'Veuillez renseigner à quel kilométrage cette facture a été réalisée' },
                 numericality: {  greater_than: 0,
                                  message: 'Un véhicule ne peux avoir un kilométrage négatif ou égal à 0' }
  validates :price, presence: { message: 'Veuillez renseigner un prix' },
                    numericality: { greater_than: 0, message: 'Un prix ne peux être négatif ou égal à 0' }
  validates :invoice_type_id, presence: { message: "Veuillez selectionner un type d'opération relatif à cette facture" }
  validates :invoice_ref, presence: { message: 'Veuillez renseigner la référence de cette facture' },
                          uniqueness: { message: 'Cette référence existe déjà dans notre base de données' }
  validates :shop_id, presence: { message: 'Cette facture doit être liée à un garage existant' }
end
