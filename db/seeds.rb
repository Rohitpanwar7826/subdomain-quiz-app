

tenant_names = ['r-p-crane-service', 'demo-prs', 'malwa', 'acro']

action_planes = [
  { name: "Base Plan", price: 405, no_students: "100" },
  { name: "Base Plus Plan", price: 805, no_students: "200" },
  { name: "Extream Plan", price: 1005, no_students: "300" },
  { name: "Pro Plan", price: 10000,  no_students: "unlimited", is_unlimited: true },
]

# perform for a tenant
def perform_for_tenant(tenant='public')
  Apartment::Tenant.switch(tenant) do
    yield
  end
end

# Create subdomain records
def create_subdomain_record(tenants, index=0)
  return if index >= tenants.length
  tenant = tenants[index]
  account = Account.find_by_subdomain(tenant)
  unless account.present?
    Account.create(name: tenant, subdomain: tenant, title: "title: #{tenant}", default_locale: 'en-US', plan_id: Plan.send(['first', 'second', 'third', 'fourth'].shuffle.first).id)
  end
  create_subdomain_record(tenants, index+1)
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


# =========================== calling methods to create records =======================
Apartment::Tenant.switch('public') do
  create_action_plane(action_planes)
  create_subdomain_record(tenant_names)
end