module ApplicationHelper
  $CTRL_LIST = { documentations: 'Ce document',
    invoices: 'Cette facture',
    maintenance_plans: 'Ce plan de maintenance',
    maintenances: 'Cette maintenance',
    operations: 'Cette opération',
    reminders: 'Ce rappel',
    shops: 'Ce magasin',
    vehicles: 'Ce véhicule'
  }

  def rnf_prefix(ctrl)
    $CTRL_LIST[ctrl.to_sym]
  end
end
