require 'sidekiq/web'

class SubdomainContraints
  def initialize(is_root)
    @is_root = is_root
  end

  def route_constraints_for_excluded_subdomain(request)
    Rails.application.credentials.tenant_excluded_subdomain.include?(request.subdomain)
  end

  def is_validate_url(request)
    request.subdomain.present? && route_constraints_for_excluded_subdomain(request)
  end

  def matches?(request)
    @is_root ?
      is_validate_url(request) :
      !is_validate_url(request)
  end
end

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount Sidekiq::Web, at: '/admin/sidekiq', mount_point: '/admin/sidekiq', as: :sidekiq_admin

  constraints(SubdomainContraints.new(true)) do
    devise_for :admin_users
    resources :plans, only: [:show, :create]
    root 'welcome#index'
  end
  
  constraints(SubdomainContraints.new(false)) do
    root 'home#index', as: :subdomain_root
    
    scope module: :subdomain do
      resources :quizzes do
        get 'question/partial', to: 'questions#question_partial'
        resources :questions, only: [:create, :new]
      end
      resources :enroll_students
      resources :exams, only: [:show] do
        post "/base_line_assessment", to: "exams#base_line_assessment", as: :base_line_assessment
        post "/:question_id", to: "exams#create", as: :create
        post "/:question_id/final_assessment", to: "exams#final_assessment", as: :final_assessment
      end
    end

    devise_for :users, class_name: "Subdomain::User", controllers: {
      :registrations => 'subdomain/users/registrations', 
      :sessions => "subdomain/users/sessions"
    }
    get 'home', to: 'home#index'
  end
end
