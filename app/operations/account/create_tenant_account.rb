
class Account::CreateTenantAccount
  class << self
    def call(account_ref_id)
      process(account_ref_id)
    end

    def process(account_ref_id)
      account = find_account(account_ref_id)
      return if account.nil?
      create_tenant_schema(account.subdomain) if account.present?
    end

    def find_account(ac_id)
      Account.find_by({ id: ac_id })
    end

    def create_tenant_schema(subdomain)
      Apartment::Tenant.create(subdomain)
    end
  end
end