namespace :utils do
  def generate_random_phone
    "(14)#{['','',9,9,9,9,9].sample}#{Random.rand(1000..9999)}-#{Random.rand(1000..9999)}"
  end

  def generate_random_date
    _month = Random.rand(Date.today.month..Date.today.month + 1)
    if _month == 2
      _day = Random.rand(1..28)
    else
      _day = Random.rand(1..30)
    end

    _hour = Random.rand(8..18)
    _minute = [0, 30].sample
    
    _date = DateTime.new(Date.today.year, _month, _day, _hour, _minute, 0)
  end

  desc "Setup Development"
  task setup: :environment do
    puts "Setup initiated"
    puts "rake db:drop... #{%x(rake db:drop)}"
    puts "rake db:create... #{%x(rake db:create)}"
    puts "rake db:migrate... #{%x(rake db:migrate VERBOSE=false)}"
    puts "rake db:seed... #{%x(rake db:seed)}"

    puts "==============================================================================================="
    puts "rake utils:generate_companies..." 
    puts "#{%x(rake utils:generate_companies)}"
    puts "rake utils:generate_covenants..."
    puts "#{%x(rake utils:generate_covenants)}"
    puts "rake utils:generate_payment_methods..."
    puts "#{%x(rake utils:generate_payment_methods)}"
    puts "rake utils:generate_users..."
    puts "#{%x(rake utils:generate_users)}"
    puts "rake utils:generate_receivable_categories..."
    puts "#{%x(rake utils:generate_receivable_categories)}"
    puts "rake utils:generate_payable_categories..."
    puts "#{%x(rake utils:generate_payable_categories)}"
    puts "rake utils:generate_customers..."
    puts "#{%x(rake utils:generate_customers)}"
    puts "rake utils:generate_suppliers..."
    puts "#{%x(rake utils:generate_suppliers)}"
    puts "rake utils:generate_receivables..." 
    puts "#{%x(rake utils:generate_receivables)}"
    puts "rake utils:generate_payables..."
    puts "#{%x(rake utils:generate_payables)}"
    puts "rake utils:generate_schedules..."
    puts "#{%x(rake utils:generate_schedules)}"
    puts "==============================================================================================="
    puts "Setup finished!"
  end

  desc "Generate Company Data"
  task generate_companies: :environment do
    Faker::Config.locale = 'pt-BR'

    Company.transaction do
      (1..30).each do |i|
        company = Company.new(company_name: Faker::Company.name, 
                              trade_name: Faker::Company.name, 
                              email: Faker::Internet.email, 
                              phone: generate_random_phone,
                              company_type: 1,
                              identifier: CNPJ.generate(true))
        company.save!
      end
    end
    puts "companies created"

    CompanyAddress.transaction do
      (1..30).each do |i|
        company_address =  CompanyAddress.new(address1:     Faker::Address.street_name,
                                               address2:     Faker::Address.secondary_address,
                                               neighborhood: Faker::Address.community,
                                               number:       Faker::Address.building_number,
                                               city:         Faker::Address.city,
                                               state:        [:SP, :RJ, :PR, :MG].sample,
                                               zip:          Faker::Address.zip_code,
                                               company_id:   i
        )    
        company_address.save!
      end
    end
    puts "Company Addresses Created" 
  end 

  desc "Generate Covenant Data"
  task generate_covenants: :environment do
    Covenant.transaction do
      (1..30).each do |i|
        covenants =  ["PARTICULAR", "UNIMED", "COOPUS", "SÃO LUCAS", "AMEPLAN", "AMIL", "SOMPO"]
        for item in covenants do
          covenant = Covenant.new(
            description: item,
            company_id:  i,
          )
          covenant.save!
        end 
      end
    end
    puts "Covenants Created"
  end
  
  desc "Generate User Data"
  task generate_users: :environment do
    User.transaction do
      #usuário "teste" do sistema
      user = User.new(
        email:                 "user@user.com", 
        name:                  Faker::Name.name,
        password:              "123456",
        password_confirmation: "123456",
        company_id:            1,
        role:                  0,
        user_type:             rand(0..1)
      )
      user.save!

      #usuários aleatórios
      (1..30).each do |i|    
        #usuário administrador
        user = User.new(
          email:                 Faker::Internet.email, 
          name:                  Faker::Name.name,
          password:              "123456",
          password_confirmation: "123456",
          company_id:            i,
          role:                  0,
          user_type:             rand(0..1)
        )
        user.save!
      
        (1..4).each do |j|
          user = User.new(
            email:                 Faker::Internet.email, 
            name:                  Faker::Name.name,
            password:              "123456",
            password_confirmation: "123456",
            company_id:            i,
            role:                  1,
            user_type:             rand(0..1)
          )
          user.save!
        end
      end 
    end 
    puts "Users Created" 
    
    UserAddress.transaction do
      user_address = UserAddress.new(
        address1:     Faker::Address.street_name,
        address2:     Faker::Address.secondary_address,
        neighborhood: Faker::Address.community,
        number:       Faker::Address.building_number,
        city:         Faker::Address.city,
        state:        [:SP, :RJ, :PR, :MG].sample,
        zip:          Faker::Address.zip_code,
        user_id:      1
      )
      user_address.save!    

      (1..150).each do |i|
        user_address = UserAddress.new(
          address1:     Faker::Address.street_name,
          address2:     Faker::Address.secondary_address,
          neighborhood: Faker::Address.community,
          number:       Faker::Address.building_number,
          city:         Faker::Address.city,
          state:        [:SP, :RJ, :PR, :MG].sample,
          zip:          Faker::Address.zip_code,
          user_id:      i
        )
      user_address.save!    
      end   
    end
    puts "Users Addresses created" 
  

    UserConfiguration.transaction do
      (1..151).each do |i|
        user_configuration = UserConfiguration.new(
          user_id: i,
          monday_schedule:    true,
          tuesday_schedule:   true,
          wednesday_schedule: true,
          thursday_schedule:  true,
          friday_schedule:    true,
          saturday_schedule:  false,
          sunday_schedule:    false,
          start_hour:         Time.parse('2007-01-31 08:00:00'),
          end_hour:           Time.parse('2007-01-31 18:00:00')       
          ) 
        user_configuration.save!   
      end  
    end; 
    puts "Users Configuration created" 

    UserCovenant.transaction do
      User.all.each do |user|
        _covenants = Covenant.where("company_id = ?", user.company_id).order(:id)

        #Adiciono o convênio "Particular" para todos os profissionais
        user_covenant = UserCovenant.new(
          user_id: user.id,
          covenant_id: _covenants.first.id
        )
        user_covenant.save!

        Random.rand(1..2).times do |i|
          user_covenant = UserCovenant.new(
            user_id: user.id,
            covenant_id: _covenants.select {|f| f.description != "PARTICULAR"}.sample.id
          )
          user_covenant.save!
        end
      end
    end
    puts "User Covenants created"
  end
  
  desc "Generate Receivable Categories Data"
  task generate_receivable_categories: :environment do
    ReceivableCategory.transaction do
      (1..30).each do |i|
        (1..5).each do |j|
          receivable_category = ReceivableCategory.new(
            description: Faker::Commerce.department,
            company_id:  i
          )
          receivable_category.save!
        end        
      end
    end
    puts "Receivable Categories Created"
  end

  desc "Generate Payable Categories Data"
  task generate_payable_categories: :environment do
    PayableCategory.transaction do
      (1..30).each do |i|
        (1..5).each do |j|
          payable_category = PayableCategory.create!(
            description: Faker::Commerce.department,
            company_id:  i
          )
          payable_category.save!
        end     
      end 
    end
    puts "Payable Categories Created"    
  end

  desc "Generate Customer Data"
  task generate_customers: :environment do
    Customer.transaction do
      (1..30).each do |i|
        (1..50).each do |j|
          customer = Customer.new(
            fullname:   Faker::Name.name,
            email:      Faker::Internet.email, 
            phone:      generate_random_phone,
            identifier: CPF.generate(true),
            company_id: i,
          )
          customer.save!
        end
      end 
    end
    puts "Customers Created"

    
    CustomerAddress.transaction do
      (1..1500).each do |i|
        customer_address = CustomerAddress.new(
          address1:     Faker::Address.street_name,
          address2:     Faker::Address.secondary_address,
          neighborhood: Faker::Address.community,
          number:       Faker::Address.building_number,
          city:         Faker::Address.city,
          state:        [:SP, :RJ, :PR, :MG].sample,
          zip:          Faker::Address.zip_code,
          customer_id:  i
        )    
        customer_address.save!
      end 
    end  
    puts "Customers Addresses Created" 
  end

  desc "Generate Supplier Data"
  task generate_suppliers: :environment do
    Supplier.transaction do
      (1..30).each do |i|    
        (1..50).each do |j|
          supplier = Supplier.new(
            supplier_name: Faker::Company.name,
            trade_name:    Faker::Company.name,
            email:         Faker::Internet.email, 
            phone:         generate_random_phone,
            supplier_type: 1,
            identifier:    CNPJ.generate(true),
            company_id:    i,
          )
          supplier.save!
        end
      end 
    end
    puts "Suppliers Created"
   
    SupplierAddress.transaction do
      (1..1500).each do |i|
        supplier_address = SupplierAddress.create!(
          address1:     Faker::Address.street_name,
          address2:     Faker::Address.secondary_address,
          neighborhood: Faker::Address.community,
          number:       Faker::Address.building_number,
          city:         Faker::Address.city,
          state:        [:SP, :RJ, :PR, :MG].sample,
          zip:          Faker::Address.zip_code,
          supplier_id:  i
        ) 
        supplier_address.save!   
      end 
    end
    puts "Suppliers Addresses Created"
  end

  desc "Generate Receivable Data"
  task generate_receivables: :environment do
    Receivable.transaction do
      (1..30).each do |i|
        _customers = Customer.where("company_id = ?", i).all
        _receivable_category = ReceivableCategory.where("company_id = ?", i).all
    
        (1..100).each do |j|
          receivable = Receivable.new(
            company_id:             i,
            customer_id:            _customers.sample.id,
            receivable_category_id: _receivable_category.sample.id,
            due_date:               generate_random_date,
            amount:                 "#{Random.rand(500)},#{Random.rand(99)}",
            installment:            "01/01",
            description:            Faker::Lorem.sentence,
            status:                 rand(0..1),
          )
          receivable.save!
        end    
      end
    end
    puts "Receivables Created"
  end

  desc "Generate Payable Data"
  task generate_payables: :environment do
    Payable.transaction do
      (1..30).each do |i|    
        _suppliers = Supplier.where("company_id = ?", i).all
        _payable_category = PayableCategory.where("company_id = ?", i).all
        (1..100).each do |j|      
          payable = Payable.create!(
            company_id:          i,
            supplier_id:         _suppliers.sample.id,
            payable_category_id: _payable_category.sample.id,
            due_date:            generate_random_date,
            amount:              "#{Random.rand(500)},#{Random.rand(99)}",
            installment:         "01/01",
            description:         Faker::Lorem.sentence,
            status:              rand(0..1),      
          )
          payable.save!
        end    
      end
    end
    puts "Payables Created"
  end
  
  desc "Generate Schedule Data"
  task generate_schedules: :environment do
    Schedule.transaction do
      (1..30).each do |i|
        _customers =  Customer.where("company_id = ?", i).all
        _users = User.where("company_id = ?", i)
        _userCovenants = UserCovenant.all

        (1..200).each do |j|  
          _date = generate_random_date
          _customer = _customers.sample
          _user = _users.sample
          _schedule_type = Random.rand(0..2)

          _new_customer_phone = ""
          _new_customer_name = ""

          if _schedule_type == Schedule.schedule_types[:initial]
            _new_customer_phone = generate_random_phone
            _new_customer_name  = Faker::Name.name

            schedule = Schedule.new(
              company_id:         i,
              user_id:            _user.id,
              covenant_id:        _userCovenants.select {|f| f.user_id == _user.id}.sample.id,
              schedule_type:      _schedule_type,
              new_customer_name:  _new_customer_name,
              new_customer_phone: _new_customer_phone,
              title:              _new_customer_name,
              start:              _date,  
              end:                _date + 30.minutes
            )
            schedule.save!
          else
            schedule = Schedule.new(
            company_id:         i,
            customer_id:        _customer.id,  
            user_id:            _user.id,
            covenant_id:        _userCovenants.select {|f| f.user_id == _user.id}.sample.id,
            schedule_type:      _schedule_type,
            title:              _customer.fullname,
            start:              _date,  
            end:                _date + 30.minutes
          )
          schedule.save!
          end
        end
      end 
    end
    puts "Schedules Created"  
  end

  desc "Generate Payment_Method Data"
  task generate_payment_methods: :environment do
    PaymentMethod.transaction do
      (1..30).each do |i|
        payment_methods = ['Dinheiro','Cheque','Cartão Visa Débito','Cartão Visa Crédito','PayPal']
        for item in payment_methods do
          payment_method = PaymentMethod.new(
            description: item,
            company_id:  i
          )
          payment_method.save!
        end
      end 
    end
    puts "Payment Methods Created"    
  end  
end
