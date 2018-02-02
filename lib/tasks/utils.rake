namespace :utils do

  desc "Setup Development"
  task setup: :environment do
    puts "Setup initiated"
    puts "rake db:drop... #{%x(rake db:drop)}"
    puts "rake db:create... #{%x(rake db:create)}"
    puts "rake db:migrate... #{%x(rake db:migrate VERBOSE=false)}"
    puts "rake db:seed... #{%x(rake db:seed)}"

    puts "==============================================================================================="
    puts "rake utils:generate_companies..." 
    puts"#{%x(rake utils:generate_companies)}"
    puts "rake utils:generate_users..."
    puts"#{%x(rake utils:generate_users)}"
    puts "rake utils:generate_receivable_categories..."
    puts"#{%x(rake utils:generate_receivable_categories)}"
    puts "rake utils:generate_payable_categories..."
    puts"#{%x(rake utils:generate_payable_categories)}"
    puts "rake utils:generate_covenants..."
    puts"#{%x(rake utils:generate_covenants)}"
    puts "rake utils:generate_customers..."
    puts"#{%x(rake utils:generate_customers)}"
    puts "rake utils:generate_suppliers..."
    puts"#{%x(rake utils:generate_suppliers)}"
    puts "rake utils:generate_professionals..."
    puts"#{%x(rake utils:generate_professionals)}"
    puts "rake utils:generate_receivables..." 
    puts"#{%x(rake utils:generate_receivables)}"
    puts "rake utils:generate_payables..."
    puts"#{%x(rake utils:generate_payables)}"
    puts "rake utils:generate_schedules..."
    puts"#{%x(rake utils:generate_schedules)}"
    puts "==============================================================================================="
    puts "Setup finished!"
  end

  desc "Generate Company Data"
  task generate_companies: :environment do
    Faker::Config.locale = 'pt-BR'

    (1..30).each do |i|
      Company.create!(
        company_name: Faker::Company.name,
        trade_name: Faker::Company.name,
        address1: Faker::Address.street_name,
        address2: Faker::Address.secondary_address,
        neighborhood: Faker::Address.community,
        number: Faker::Address.building_number,
        city: Faker::Address.city,
        state: [:SP, :RJ, :PR, :MG].sample,
        zip: Faker::Address.zip_code,
        email: Faker::Internet.email, 
        phone: Faker::PhoneNumber.cell_phone,
      )
    end    
    puts "companies created"
  end 

  desc "Generate User Data"
  task generate_users: :environment do
    #usuário "teste" do sistema
    User.create(
      email: "user@user.com", 
      password: "123456", 
      password_confirmation: "123456", 
      company_id: 1, 
      role: 0)

    UserAddress.create!(
      address1: Faker::Address.street_name,
      address2: Faker::Address.secondary_address,
      neighborhood: Faker::Address.community,
      number: Faker::Address.building_number,
      city: Faker::Address.city,
      state: [:SP, :RJ, :PR, :MG].sample,
      zip: Faker::Address.zip_code,
      user_id: 1
    )    
      
    (1..30).each do |i|    
      #usuário administrador
      User.create!(
        email: Faker::Internet.email, 
        name: Faker::Name.name,
        password: "123456",
        password_confirmation: "123456",
        company_id: i,
        role: 0,
        user_type: rand(0..1)
      )
    
      (1..4).each do |j|
        User.create!(
          email: Faker::Internet.email, 
          name: Faker::Name.name,
          password: "123456",
          password_confirmation: "123456",
          company_id: i,
          role: 1,
          user_type: rand(0..1)
        )
      end
    end  
    puts "Users Created" 
    
    (1..150).each do |i|
      UserAddress.create!(
        address1: Faker::Address.street_name,
        address2: Faker::Address.secondary_address,
        neighborhood: Faker::Address.community,
        number: Faker::Address.building_number,
        city: Faker::Address.city,
        state: [:SP, :RJ, :PR, :MG].sample,
        zip: Faker::Address.zip_code,
        user_id: i
      )    
    end   
    puts "Users Adrresses created" 
  end
  
  desc "Generate Receivable Categories Data"
  task generate_receivable_categories: :environment do
    (1..30).each do |i|
      (1..5).each do |j|
        ReceivableCategory.create!(
          description: Faker::Commerce.department,
          company_id: i
        )
      end        
    end
    puts "Receivable Categories Created"
  end

  desc "Generate Payable Categories Data"
  task generate_payable_categories: :environment do
    (1..30).each do |i|
      (1..5).each do |j|
        PayableCategory.create!(
          description: Faker::Commerce.department,
          company_id: i
        )
      end     
    end 
    puts "Payable Categories Created"    
  end

  desc "Generate Covenant Data"
  task generate_covenants: :environment do
    (1..30).each do |i|
      #crio o convênio particular default para todas as empresas
      Covenant.create!(
        description: "Particular",
        company_id: i,
      )

      (1..4).each do |j|
        Covenant.create!(
          description: Faker::Commerce.department,
          company_id: i,
        )
      end     
    end
    puts "Covenants Created"
  end

  desc "Generate Customer Data"
  task generate_customers: :environment do
    (1..30).each do |i|
      (1..50).each do |j|
        Customer.create!(
          fullname: Faker::Name.name,
          email: Faker::Internet.email, 
          phone: Faker::PhoneNumber.cell_phone,
          company_id: i,
        )
      end
    end 
    puts "Customers Created"

    
    (1..1500).each do |i|
      CustomerAddress.create!(
        address1: Faker::Address.street_name,
        address2: Faker::Address.secondary_address,
        neighborhood: Faker::Address.community,
        number: Faker::Address.building_number,
        city: Faker::Address.city,
        state: [:SP, :RJ, :PR, :MG].sample,
        zip: Faker::Address.zip_code,
        customer_id: i
      )    
    end   
    puts "Customers Addresses Created" 
  end

  desc "Generate Supplier Data"
  task generate_suppliers: :environment do
    (1..30).each do |i|    
      (1..50).each do |j|
        Supplier.create!(
          supplier_name: Faker::Company.name,
          trade_name: Faker::Company.name,
          email: Faker::Internet.email, 
          phone: Faker::PhoneNumber.cell_phone,
          company_id: i,
        )
      end
    end 
    puts "Suppliers Created"
   

    (1..1500).each do |i|
      SupplierAddress.create!(
        address1: Faker::Address.street_name,
        address2: Faker::Address.secondary_address,
        neighborhood: Faker::Address.community,
        number: Faker::Address.building_number,
        city: Faker::Address.city,
        state: [:SP, :RJ, :PR, :MG].sample,
        zip: Faker::Address.zip_code,
        supplier_id: i
      )    
    end 
    puts "Suppliers Addresses Created"
  end
  
  desc "Generate Professional Data"
  task generate_professionals: :environment do
    puts "Professionals"
    (1..30).each do |i|
      (1..5).each do |j|
        Professional.create!(
          fullname: Faker::Name.name,
          email: Faker::Internet.email, 
          phone: Faker::PhoneNumber.cell_phone,
          company_id: i,
        )
      end
    end
    puts "Professionals created"
    
    puts "Professionals Addresses"
    (1..150).each do |i|
      ProfessionalAddress.create!(
        address1: Faker::Address.street_name,
        address2: Faker::Address.secondary_address,
        neighborhood: Faker::Address.community,
        number: Faker::Address.building_number,
        city: Faker::Address.city,
        state: [:SP, :RJ, :PR, :MG].sample,
        zip: Faker::Address.zip_code,
        professional_id: i
      )    
    end 
    puts "Professionals Addresses created"
    
    puts "Professionals Covenants"    
    Professional.all.each do |professional|
      #Adiciono o convênio "Particular" para todos os profissionais
      ProfessionalCovenant.create(
        professional_id: professional.id,
        covenant_id: Covenant.where("company_id = ? and description = ?", professional.company_id, "Particular").first.id
      )
    
      Random.rand(1..2).times do |i|
        ProfessionalCovenant.create(
          professional_id: professional.id,
          covenant_id: Covenant.where("company_id = ?", professional.company_id).all.sample.id
        )
      end
    end
    puts "Professionals Covenants created"

    puts "Professionals Reservations"
    Professional.all.each do |professional|
      Random.rand(1..2).times do |i|      
          _month = Random.rand(1..2)
        if _month == 2
          _day = Random.rand(1..28)
        else
          _day = Random.rand(1..30)
        end

        _hour = Random.rand(8..18)
        _minute = [0, 30].sample
        
        _date = DateTime.new(Date.today.year, _month, _day, _hour, _minute, 0)      

        ProfessionalReservation.create(
          company_id: professional.company_id,
          professional_id: professional.id,
          user_id: User.where("company_id = ?", professional.company_id).all.sample.id, 
          title: Faker::Lorem.sentence,
          start: _date,
          end: _date + 120.minutes
        )   
      end    
    end
    puts "Professional Reservations created"
  end

  desc "Generate Receivable Data"
  task generate_receivables: :environment do
    (1..30).each do |i|
      (1..100).each do |j|
        Receivable.create!(
          company_id: i,
          customer_id: Customer.where("company_id = ?", i).all.sample.id,
          receivable_category_id: ReceivableCategory.where("company_id = ?", i).all.sample.id,
          due_date: Date.today + Random.rand(15),
          amount: "#{Random.rand(500)},#{Random.rand(99)}",
          description: Faker::Lorem.sentence,
          status: rand(0..1),
        )
      end    
    end
    puts "Receivables Created"
  end

  desc "Generate Payable Data"
  task generate_payables: :environment do
    (1..30).each do |i|    
      (1..100).each do |j|      
        Payable.create!(
          company_id: i,
          supplier_id: Supplier.where("company_id = ?", i).all.sample.id,
          payable_category_id:  PayableCategory.where("company_id = ?", i).all.sample.id,
          due_date: Date.today + Random.rand(15),
          amount: "#{Random.rand(500)},#{Random.rand(99)}",
          description: Faker::Lorem.sentence,
          status: rand(0..1),      
        )
      end    
    end
    puts "Payables Created"
  end
  
  desc "Generate Schedule Data"
  task generate_schedules: :environment do
    (1..30).each do |i|
      (1..200).each do |j|  
        _month = Random.rand(1..2)
        if _month == 2
          _day = Random.rand(1..28)
        else
          _day = Random.rand(1..30)
        end

        _hour = Random.rand(8..18)
        _minute = [0, 30].sample
        
        _date = DateTime.new(Date.today.year, _month, _day, _hour, _minute, 0)

        _customer = Customer.where("company_id = ?", i).all.sample 
        _professional = Professional.where("company_id = ?", i).includes(:covenants).all.sample

        Schedule.create!(
          company_id: i,
          customer_id: _customer.id,
          professional_id: _professional.id,
          covenant_id: _professional.covenants.all.sample.id,
          user_id: User.where("company_id = ?", i).all.sample.id,
          title: _customer.fullname,
          start: _date,  
          end: _date + 30.minutes
        )
      end
    end 
    puts "Schedules Created"  
  end
end
