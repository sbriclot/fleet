# Clear tables
p "Clean database"
Documentation.delete_all
Reminder.delete_all
Invoice.delete_all
InvoiceType.delete_all
Shop.delete_all
Operation.delete_all
Maintenance.delete_all
MaintenancePlan.delete_all
VehicleFuel.delete_all
Refuel.delete_all
Vehicle.delete_all
Fuel.delete_all
User.delete_all

# Save date of the day
today = Date.today

# Insert static data
p "Insert static data :"
# 1. Fuels
p "- insert Fuels list..."
fuels = %w[SP95 SP98 E10 GPL Diesel Diesel\ Premium]
fuels.each do |fuel|
  Fuel.create(name: fuel)
end

# 2. Invoice_Types
p "- insert Invoice Types list..."
inv_types = %w[Achat Assurance Controle\ technique Entretien Pièces Réparation]
inv_types.each do |inv_type|
  InvoiceType.create(name: inv_type)
end

# Insert users data
p "Insert user's data :"
# Insert Shops
p "- insert shops..."
peugeot = Shop.new(
  name: "Peugeot Remerschen",
  address: "124 route du Vin L-5440 Remerschen",
  tel: "+3522360501",
  home_url: "www.peugeot.lu",
  booking_url: "https://services-store.peugeot.lu"
)
peugeot.save
afpneus = Shop.new(
  name: "AF Pneus",
  address: "6 rue des Ardennes B-6780 Messancy",
  tel: "+3263225851",
  home_url: "www.afpneus.com"
)
afpneus.save
bmw = Shop.new(
  name: "BMW Bilia-Emond",
  address: "184, Route de Thionville L-2610 Luxembourg",
  tel: "+352 49 19 41 - 1",
  home_url: "https://bilia-emond.bmw.lu/",
  booking_url: ""
)
bmw.save

# Insert Users
p "- insert a test user..."
jacky = User.new(
  email: "jacky@email.com",
  password: '123456',
  password_confirmation: '123456'
)
jacky.save

# Insert Vehicle
p "- insert a test car..."
car = Vehicle.new(
  brand: "Peugeot",
  model: "208 1.2 GT-Line",
  registration: "AB-123-CD",
  sn: "124578235689",
  tank_capacity: 50,
  actual_km: 87000,
  total_expenses: 25000,
  purchase_date: Date.new(2017, 7, 17),
  purchase_km: 0,
  user_id: jacky.id
)
car.save

# Insert Invoices
p "- insert invoices..."
Invoice.create(
  date: Date.new(2017, 7, 17),
  km: 0,
  invoice_ref: "123",
  invoice_type_id: InvoiceType.find_by(name: "Achat").id,
  price: 15000,
  vehicle_id: car.id,
  shop_id: peugeot.id
)
Invoice.create(
  date: Date.new(2017, 11, 20),
  km: 7700,
  invoice_ref: "2566.2017",
  invoice_type_id: InvoiceType.find_by(name: "Entretien").id,
  price: 600,
  remarks: "Pneus hiver",
  vehicle_id: car.id,
  shop_id: afpneus.id
)
Invoice.create(
  date: Date.new(2018, 6, 18),
  km: 25500,
  invoice_ref: "456",
  invoice_type_id: InvoiceType.find_by(name: "Entretien").id,
  price: 300,
  vehicle_id: car.id,
  shop_id: peugeot.id
)

# Insert Vehicle_Fuels
p "- insert 2 allowed fuels for the car..."
sp98 = Fuel.find_by(name: "SP98")
sp95 = Fuel.find_by(name: "SP95")
VehicleFuel.create(fuel_id: sp98.id, vehicle_id: car.id)
VehicleFuel.create(fuel_id: sp95.id, vehicle_id: car.id)

# Insert Refuels
p "- insert random refuels..."
refuel_date = Date.new(2017, 7, 17)
vf_list = [].append(sp98.id).append(sp95.id)
while refuel_date < today
  refuel_km = Random.new.rand(600..750)
  refuel_quantity = 50 - Random.new.rand(2..20)
  refuel_price = (refuel_quantity * Random.new.rand(1.10..1.35)).round(2)
  Refuel.create(
    date: refuel_date,
    km: refuel_km,
    quantity: refuel_quantity,
    price: refuel_price,
    fuel_id: vf_list.sample,
    vehicle_id: car.id
    )
  refuel_date += Random.new.rand(5..10)
end
p "    => #{Refuel.count} refuels were created"

# Insert Maintenance_Plans
p "- insert planned maintenances..."
plans = [
  {
    task: "Vidange",
    km: 25000,
    mt: 12
  },
  {
    task: "Bougies",
    km: 50000,
    mt: 24
  },
  {
    task: "Courroie",
    km: 120000,
    mt: 60
  }
]
plans.each do |plan|
  MaintenancePlan.create(
    task: plan[:task],
    interval_km: plan[:km],
    interval_months: plan[:mt],
    vehicle_id: car.id
  )
end

# Insert Maintenances / Operations
p "- insert maintenances / operations..."
p "  (with or without relation to a maintenance plan)"
year = 2017
km = 0
# 1. Oil services
3.times do
  year += 1
  km += 25000
  maintenance = Maintenance.new(
    date: Date.new(year, 6, 18),
    km: km,
    vehicle_id: car.id
  )
  maintenance.save
  details = km == 50000 ? "+ essuies-glace" : nil
  Operation.create(
    task: "Vidange",
    details: details,
    maintenance_id: maintenance.id,
    maintenance_plan_id: MaintenancePlan.find_by(task: "Vidange").id
  )
end

# 2. Swap roues été/hiver
year = 2017
month = 11
swap_date = Date.new(year, month, 1)
km = 0
while swap_date < today
  km += 12500
  maintenance = Maintenance.new(
  date: swap_date,
  km: km,
  vehicle_id: car.id
  )
  maintenance.save
  Operation.create(
    task: "Swap pneus",
    maintenance_id: maintenance.id
  )

  if month == 11
    year += 1
    month = 4
  else
    month = 11
  end
  swap_date = Date.new(year, month, 1)
end

# Insert Reminders
p "- insert reminders..."
Reminder.create(
  task: "Disques/plaquettes avant",
  creation_km: 80000,
  limit_km: 10000,
  vehicle_id: car.id
)
Reminder.create(
  task: "Pneus été avant HS",
  creation_km: 75000,
  limit_date: Date.new(2021, 4, 1),
  vehicle_id: car.id
)

# End of script
p "Seed completed"