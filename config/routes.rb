Rails.application.routes.draw do

  
  root 'projects#index'
  
  devise_for :users
  
  resources :administrators, path: 'coordenadores'

  resources :reports

  resources :candidates do 
    collection do 
      get 'subscribes',         to: 'candidates#subscribes',     as: 'subscribes'
      get 'subscribe/:id',      to: 'candidates#show_subscribe', as: 'show_subscribe'
      get 'participations',     to: 'candidates#participations', as: 'participations'
      get 'generate_slip/:id',  to: 'candidates#bank_slip',      as: 'bank_slip'
    end
  end
  
  resources :projects,  path: 'concursos' do 
    resources :navs,    path: 'menus' do 
      get 'switch_up'
      get 'switch_down'
    end
    resources :pages,                   path: 'paginas'
    resources :project_subscribes,      path: 'gestao_inscricoes' do 
      resources :forms
    end
    resources :project_participations,  path: 'participacoes'
    resources :consults,                path: 'consultas' 
  end

  scope 'api' do 
    get '/projects',                    to: 'api#projects'
    get '/navs/:project_id',            to: 'api#navs'
    get '/page/:project_id/:page_id',   to: 'api#page'
  end
end
