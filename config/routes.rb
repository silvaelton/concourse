Rails.application.routes.draw do

  
  root 'projects#index'
  
  devise_for :users

  resources :users
  resources :reports

  resources :projects,  path: 'concursos' do 
    resources :navs,            path: 'menus'
    resources :pages,           path: 'paginas'
    resources :subscribes,      path: 'gestao_inscricoes'
    resources :participations,  path: 'participacoes'

    resources :candidate_subscribes, path: 'inscricoes'
  end

  scope 'api' do 
    get '/projects',                    to: 'api#projects'
    get '/navs/:project_id',            to: 'api#navs'
    get '/page/:project_id/:page_id',   to: 'api#page'
  end
end
