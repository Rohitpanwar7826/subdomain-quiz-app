# rake tenant_record:create_tenant_record

namespace :tenant_record do
  desc 'Create tenant records'
  task create_tenant_record: :environment do
    puts "START tenant records processing at #{Time.now}"
    tenant_names = ['r-p-crane-service', 'demo-prs', 'apple', 'xyz']

    action_planes = [
      { name: "Base Plan", price: 405, no_students: "100" },
      { name: "Standard Plan", price: 805, no_students: "200" },
      { name: "Extream Plan", price: 1005, no_students: "300" },
      { name: "Pro Plan", price: 10000,  no_students: "unlimited", is_unlimited: true },
    ]

    users_email = ['rohitpawarmit@gmail.com', 'demo@gmail.com', 'example@gmail.com']

    roles = ['student', 'teacher']


    # Create subdomain records
    Apartment::Tenant.switch('public') do
      user_ids = create_user_accounts(users_email)
      create_action_plane(action_planes)
      create_subdomain_record(tenant_names, 0, user_ids)
      create_default_roles(roles)
      create_users()
    end
    puts "END tenant records processing at #{Time.now}"
  end

  private
  # perform for a tenant
    def perform_for_tenant(tenant='public')
      Apartment::Tenant.switch(tenant) do
        yield
      end
    end

    def create_user_accounts(users_email)
      perform_for_tenant do
        users_email.map do |email|
          user = AdminUser.find_by({ email: email})
          if !user.present?
            user = AdminUser.create({ email: email, password: '123456', password_confirmation: '123456' })
            user.skip_confirmation!
            user.save
          end
          user.id
        end
      end
    end

    def create_subdomain_record(tenants, index=0, user_ids)
      return if index >= tenants.length
      tenant = tenants[index]
      account = Account.find_by_subdomain(tenant)
      unless account.present?
        account = Account.create(name: tenant, subdomain: tenant, title: "title: #{tenant}", default_locale: 'en-US', admin_user_id: user_ids.shuffle.first, plan_id: Plan.send(['first', 'second', 'third', 'fourth'].shuffle.first).id)
        if account.persisted?
          puts "INFO:: ACCOUNT CREATED SUCCESFLY : Subdomain - #{account.subdomain}"
        else
          puts account.errors.full_messages.join(', ')
        end
      end
      create_subdomain_record(tenants, index+1, user_ids)
    end

    # action plan create
    def create_action_plane(planes, index=0)
      return if index >= planes.length
      perform_for_tenant do
        action_plan = Plan.find_by_price(planes[index][:price])
        unless action_plan.present?
          per_month = planes[index][:price]/12
          action_plan_copy = planes[index].deep_dup
          action_plan_copy[:per_month] = per_month
          Plan.create(action_plan_copy)
        end
      end
      create_action_plane(planes, index+1)
    end

    # create default roles
    def create_default_roles(roles)
      puts "INFO:: START #Roles CREATING"
      Account.all.each do |account|
        perform_for_tenant(account.subdomain) do
          puts "INFO:: START #Roles switching #{account.subdomain}"
          roles.each do |role|
            puts "INFO:: creating role: #{role}"
            Role.create(name: role)
          end
        end
      end
      puts "INFO:: END #Roles CREATING"
    end

    # create users
    def create_users
      puts "INFO:: START #Users CREATING"
      Account.all.each do |account|
        perform_for_tenant(account.subdomain) do
          puts "INFO:: START #Users switching #{account.subdomain}"
          user=Subdomain::User.new(first_name: 'Rohit', last_name: 'Singh', email: 'rohit@gmail.com', password: '123456', password_confirmation: '123456', branch: 'IT', year: 3)
          user.skip_confirmation!
          user.role_ids = [Role.find_by(name: 'teacher').id]
          user.save

          25.times do
            user=Subdomain::User.new(
              first_name: Faker::Name.name,
              last_name: 'Singh',
              email: Faker::Internet.email,
              year: rand(0..3),
              branch: rand(0..3),
              password: '123456',
              password_confirmation: '123456')
            user.skip_confirmation!
            user.role_ids = [Role.find_by(name: ['student', 'teacher'].shuffle.first).id]
            user.save
            puts "INFO:: created role - #{user.roles.pluck(:name).join(',')} user: #{user.inspect}"
          end
        end
      end
      puts "INFO:: END #Users CREATING"
    end
end
