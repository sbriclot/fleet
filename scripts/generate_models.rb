%x(rails g model Vehicle brand model registration sn tank_capacity:integer actual_km:integer total_expenses:float purchase_date:date purchase_km:integer sale_date:date sale_km:integer user:references)

%x(rails g model Shop name address:text tel home_url booking_url)

%x(rails g model InvoiceType type)

%x(rails g model Invoice date:date km:integer invoice_ref invoice_type:references remarks:text price:float vehicle:references shop:references)

%x(rails g model Fuel name)

%x(rails g model VehicleFuel fuel:references vehicle:references)

%x(rails g model Refuel date:date km:float quantity:float price:float fuel:references vehicle:references)

%x(rails g model MaintenancePlan task:text details:text interval_km:integer interval_months:integer vehicle:references)

%x(rails g model Maintenance date:date km:integer vehicle:references)

%x(rails g model Operation task:text details:text maintenance:references maintenance_plan:references)

%x(rails g model Reminder task creation_km:integer limit_km:integer limit_date:date vehicle:references)

%x(rails g model Documentation name doc_type path vehicle:references)
