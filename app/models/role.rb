class Role < ApplicationRecord
  has_and_belongs_to_many :subdomain_users, :join_table => :subdomain_users_roles
  
  belongs_to :resource,
             :polymorphic => true,
             :optional => true
  

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  validates :name, presence: true, uniqueness: true
  

  scopify
end
