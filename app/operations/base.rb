class Base
  class << self
    def perform_for_tenant(subdomain)
      Apartment::Tenant.switch(subdomain) do
        yield
      end
    end
  end
end