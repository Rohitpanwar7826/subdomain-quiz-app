class Current < ActiveSupport::CurrentAttributes
  attribute :account_record
  attribute :current_apartment
  attribute :account_id
  attribute :user



  def current_tenant_name
    Apartment::Tenant.current
  end

  def is_public_schema
    current_tenant_name == "public"
  end

  def account
    return nil if is_public_schema

    return account_record if account_record.try(:subdomain) == current_tenant_name
    
    account = Account.find_by_subdomain(current_tenant_name)

    self.account_record = account
    self.current_apartment = current_tenant_name
    self.account_record
  end

  def account_id
    account.present? ? account.id : nil
  end

  def user
    current_user || current_admin_user
  end
end