class ApplicationController < ActionController::Base
  before_action :load_catagories
  before_action :configure_permitted_parameters, if: :devise_controller?

  # require 'pagy'
  # app/controllers/application_controller.rb
include Pagy::Backend
include Pagy::Frontend


  protected

  def configure_permitted_parameters
    # Permit profile_picture during sign_up and account_update
    devise_parameter_sanitizer.permit(:sign_up, keys: [:profile_picture])
    devise_parameter_sanitizer.permit(:account_update, keys: [:profile_picture])
  end

  private

  def load_catagories
    @catagories = Catagory.all
  end
end
