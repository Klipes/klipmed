class Site::HomeController < ApplicationController
  layout "site"
  before_action :authenticate_user!
    
  def index
  end
end
