require 'sidekiq/web'

class SubdomainContraints
  def initialize(is_root)
    @is_root = is_root
  end

  def route_constraints_for_excluded_subdomain(request)
    SubdomainExcluded.list.include?(request.subdomain)
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
      resources :results, only: [:index, :show] do
        member do
          get 'user/:student_id', to: 'results#student_result'
        end
      end
      resources :quizzes do
        collection do
          get :pending
          get :today
          get :complete
        end
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
    resources :home do
      collection do
        get :daily_progress
      end
    end
  end
end
