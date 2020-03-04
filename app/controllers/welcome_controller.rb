# Credit to https://stackoverflow.com/a/38406528
require 'rails/application_controller'

class WelcomeController < Rails::ApplicationController
  def index
    render file: Rails.root.join('public', 'index.html')
  end
end
