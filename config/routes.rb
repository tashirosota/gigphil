# == Route Map
#
#                                Prefix Verb   URI Pattern                                                                              Controller#Action
#                                       GET    /sitemap.xml(.:format)                                                                   redirect(301, https://gigphil.s3-ap-northeast-1.amazonaws.com/sitemap.xml.gz)
#                                  root GET    /                                                                                        indies_wiki/home#show
#                              searcher GET    /searcher(.:format)                                                                      searcher#show
#                                result GET    /result(.:format)                                                                        results#index
#                                    TT GET    /TT(.:format)                                                                            time_tables#new
#                         statics_terms GET    /statics/terms(.:format)                                                                 statics#terms
#                       statics_privacy GET    /statics/privacy(.:format)                                                               statics#privacy
#                         session_index POST   /session(.:format)                                                                       session#create
#                               session DELETE /session/:id(.:format)                                                                   session#destroy
#                              sessions DELETE /sessions(.:format)                                                                      sessions#destroy
#                 auth_twitter_callback GET    /auth/twitter/callback(.:format)                                                         sessions#create
#                      share_time_table GET    /time_tables/:uuid/share(.:format)                                                       time_tables#share
#                       copy_time_table POST   /time_tables/:uuid/copy(.:format)                                                        time_tables#copy
#                    export_time_tables POST   /time_tables/export(.:format)                                                            time_tables#export_as_pdf
#                           time_tables GET    /time_tables(.:format)                                                                   time_tables#index
#                                       POST   /time_tables(.:format)                                                                   time_tables#create
#                        new_time_table GET    /time_tables/new(.:format)                                                               time_tables#new
#                       edit_time_table GET    /time_tables/:uuid/edit(.:format)                                                        time_tables#edit
#                            time_table GET    /time_tables/:uuid(.:format)                                                             time_tables#show
#                                       PATCH  /time_tables/:uuid(.:format)                                                             time_tables#update
#                                       PUT    /time_tables/:uuid(.:format)                                                             time_tables#update
#                                       DELETE /time_tables/:uuid(.:format)                                                             time_tables#destroy
#                      indies_wiki_root GET    /indies_wiki(.:format)                                                                   indies_wiki/home#show
#     indies_wiki_artist_forum_comments GET    /indies_wiki/artists/:artist_id/forum/comments(.:format)                                 indies_wiki/comments#index
#                                       POST   /indies_wiki/artists/:artist_id/forum/comments(.:format)                                 indies_wiki/comments#create
#  new_indies_wiki_artist_forum_comment GET    /indies_wiki/artists/:artist_id/forum/comments/new(.:format)                             indies_wiki/comments#new
# edit_indies_wiki_artist_forum_comment GET    /indies_wiki/artists/:artist_id/forum/comments/:id/edit(.:format)                        indies_wiki/comments#edit
#      indies_wiki_artist_forum_comment GET    /indies_wiki/artists/:artist_id/forum/comments/:id(.:format)                             indies_wiki/comments#show
#                                       PATCH  /indies_wiki/artists/:artist_id/forum/comments/:id(.:format)                             indies_wiki/comments#update
#                                       PUT    /indies_wiki/artists/:artist_id/forum/comments/:id(.:format)                             indies_wiki/comments#update
#                                       DELETE /indies_wiki/artists/:artist_id/forum/comments/:id(.:format)                             indies_wiki/comments#destroy
#              indies_wiki_artist_forum POST   /indies_wiki/artists/:artist_id/forum(.:format)                                          indies_wiki/forums#create
#             indies_wiki_artist_sounds GET    /indies_wiki/artists/:artist_id/sounds(.:format)                                         indies_wiki/sounds#index
#                                       POST   /indies_wiki/artists/:artist_id/sounds(.:format)                                         indies_wiki/sounds#create
#          new_indies_wiki_artist_sound GET    /indies_wiki/artists/:artist_id/sounds/new(.:format)                                     indies_wiki/sounds#new
#         edit_indies_wiki_artist_sound GET    /indies_wiki/artists/:artist_id/sounds/:id/edit(.:format)                                indies_wiki/sounds#edit
#              indies_wiki_artist_sound GET    /indies_wiki/artists/:artist_id/sounds/:id(.:format)                                     indies_wiki/sounds#show
#                                       PATCH  /indies_wiki/artists/:artist_id/sounds/:id(.:format)                                     indies_wiki/sounds#update
#                                       PUT    /indies_wiki/artists/:artist_id/sounds/:id(.:format)                                     indies_wiki/sounds#update
#                                       DELETE /indies_wiki/artists/:artist_id/sounds/:id(.:format)                                     indies_wiki/sounds#destroy
#             indies_wiki_artist_events GET    /indies_wiki/artists/:artist_id/events(.:format)                                         indies_wiki/events#index
#          indies_wiki_artist_histories GET    /indies_wiki/artists/:artist_id/histories(.:format)                                      indies_wiki/histories#index
#                   indies_wiki_artists GET    /indies_wiki/artists(.:format)                                                           indies_wiki/artists#index
#                                       POST   /indies_wiki/artists(.:format)                                                           indies_wiki/artists#create
#                new_indies_wiki_artist GET    /indies_wiki/artists/new(.:format)                                                       indies_wiki/artists#new
#               edit_indies_wiki_artist GET    /indies_wiki/artists/:id/edit(.:format)                                                  indies_wiki/artists#edit
#                    indies_wiki_artist GET    /indies_wiki/artists/:id(.:format)                                                       indies_wiki/artists#show
#                                       PATCH  /indies_wiki/artists/:id(.:format)                                                       indies_wiki/artists#update
#                                       PUT    /indies_wiki/artists/:id(.:format)                                                       indies_wiki/artists#update
#                                       DELETE /indies_wiki/artists/:id(.:format)                                                       indies_wiki/artists#destroy
#                     indies_wiki_areas GET    /indies_wiki/areas(.:format)                                                             indies_wiki/areas#index
#                      indies_wiki_tags GET    /indies_wiki/tags(.:format)                                                              indies_wiki/tags#index
#                                       POST   /indies_wiki/tags(.:format)                                                              indies_wiki/tags#create
#                   new_indies_wiki_tag GET    /indies_wiki/tags/new(.:format)                                                          indies_wiki/tags#new
#                  edit_indies_wiki_tag GET    /indies_wiki/tags/:id/edit(.:format)                                                     indies_wiki/tags#edit
#                       indies_wiki_tag GET    /indies_wiki/tags/:id(.:format)                                                          indies_wiki/tags#show
#                                       PATCH  /indies_wiki/tags/:id(.:format)                                                          indies_wiki/tags#update
#                                       PUT    /indies_wiki/tags/:id(.:format)                                                          indies_wiki/tags#update
#                                       DELETE /indies_wiki/tags/:id(.:format)                                                          indies_wiki/tags#destroy
#                 indies_wiki_favorites GET    /indies_wiki/favorites(.:format)                                                         indies_wiki/favorites#index
#                                       POST   /indies_wiki/favorites(.:format)                                                         indies_wiki/favorites#create
#                  indies_wiki_favorite DELETE /indies_wiki/favorites/:id(.:format)                                                     indies_wiki/favorites#destroy
#                     online_lives_root GET    /online_lives(.:format)                                                                  online_lives#home
#                     home_online_lives GET    /online_lives/home(.:format)                                                             online_lives#home
#                          online_lives GET    /online_lives(.:format)                                                                  online_lives#index
#                                       POST   /online_lives(.:format)                                                                  online_lives#create
#                       new_online_life GET    /online_lives/new(.:format)                                                              online_lives#new
#                      edit_online_life GET    /online_lives/:id/edit(.:format)                                                         online_lives#edit
#                           online_life GET    /online_lives/:id(.:format)                                                              online_lives#show
#                                       PATCH  /online_lives/:id(.:format)                                                              online_lives#update
#                                       PUT    /online_lives/:id(.:format)                                                              online_lives#update
#                                       DELETE /online_lives/:id(.:format)                                                              online_lives#destroy
#                              api_user POST   /api/user(.:format)                                                                      api/users#create {:format=>:json}
#                           api_session PUT    /api/session(.:format)                                                                   api/session#update {:format=>:json}
#                        api_home_today GET    /api/home/today(.:format)                                                                api/home/today#index {:format=>:json}
#                     api_home_tomorrow GET    /api/home/tomorrow(.:format)                                                             api/home/tomorrow#index {:format=>:json}
#         rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                  action_mailbox/ingresses/mandrill/inbound_emails#create
#         rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                  action_mailbox/ingresses/postmark/inbound_emails#create
#            rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                     action_mailbox/ingresses/relay/inbound_emails#create
#         rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                  action_mailbox/ingresses/sendgrid/inbound_emails#create
#          rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                              action_mailbox/ingresses/mailgun/inbound_emails#create
#        rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#index
#                                       POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#create
#     new_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/new(.:format)                             rails/conductor/action_mailbox/inbound_emails#new
#    edit_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id/edit(.:format)                        rails/conductor/action_mailbox/inbound_emails#edit
#         rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#show
#                                       PATCH  /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       PUT    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       DELETE /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#destroy
# rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                      rails/conductor/action_mailbox/reroutes#create
#                    rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#             rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#                    rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#             update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#                  rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  get '/sitemap', to: redirect("https://s3-ap-northeast-1.amazonaws.com/#{ENV['S3_BUCKET_NAME']}/sitemap.xml.gz")
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'indies_wiki/home#show'
  get 'searcher', to: 'searcher#show'
  get 'result', to: 'results#index' 
  get 'TT', to: 'time_tables#new' 

  # 利用規約
  get 'statics/terms', to: 'statics#terms'
  get 'statics/privacy', to: 'statics#privacy'

  # セッション
  resources :session, only: %i(create destroy)
  delete '/sessions', to: 'sessions#destroy'
  get '/auth/twitter/callback', to: 'sessions#create'
  post '/auth/twitter', to: 'sessions#create'

  # タイムテーブル機能
  resources :time_tables, param: :uuid do
    member do 
      get 'share', to: 'time_tables#share'
      post 'copy', to: 'time_tables#copy'
    end
    collection { post 'export', to: 'time_tables#export_as_pdf' }
  end

  # インディーズwiki
  namespace :indies_wiki do
    root 'home#show'
    resources :artists do
      resource :forum, only: :create do
        resources :comments
      end
      resources :sounds
      resources :events, only: :index
      resources :histories, only: :index
    end
    get 'areas', to: 'areas#index'
    resources :tags
    resources :favorites, only: [:index, :create, :destroy]
  end

  # オンラインライブ
  resources :online_lives do
    collection do 
      get :home
    end
  end

  # API
  namespace :api, defaults: { format: :json } do
    resource :user, only: %i(create)
    put 'session', to: 'session#update'
    namespace :home do
      get 'today', to: 'today#index'
      get 'tomorrow', to: 'tomorrow#index'
    end
  end
end
