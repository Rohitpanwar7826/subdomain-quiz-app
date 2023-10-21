class Account < ApplicationRecord
  validates :subdomain, presence: true, uniqueness: { case_sensitive: false }, length: {maximum: 30}
  validates :name, presence: true, length: {maximum: 50}
  validates :title, presence: false, length: {maximum: 100}

  # associations
  belongs_to :plan
  belongs_to :admin_user

  # callbacks
  after_create :perfrom_tenant_account


  def perfrom_tenant_account
    Account::CreateTenantAccount.call(id)
  end
end
