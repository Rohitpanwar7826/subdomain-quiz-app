class BaseJob
  def perform_for_tenant(account_id)
    account =  Account.find(account_id)
    return if !account.present?
    Apartment::Tenant.switch(account.subdomain) do
      yield
    end
  end
end