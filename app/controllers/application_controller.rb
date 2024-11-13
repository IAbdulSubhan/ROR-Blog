class ApplicationController < ActionController::Base
  before_action :load_catagories
  before_action :configure_permitted_parameters, if: :devise_controller?

  # require 'pagy'
  # app/controllers/application_controller.rb
include Pagy::Backend
include Pagy::Frontend

  # before_action :check_subscription_status



  protected

  def configure_permitted_parameters
    # Permit profile_picture during sign_up and account_update
    devise_parameter_sanitizer.permit(:sign_up, keys: [:profile_picture])
    devise_parameter_sanitizer.permit(:account_update, keys: [:profile_picture])
  end

  private

  def check_subscription_status
    if user_signed_in? && current_user.subscription_status.blank?
      flash[:alert] = "Please subscribe first to access this content."
      redirect_to new_subscription_path # Redirect to subscription page
    end
  end
  def load_catagories
    @catagories = Catagory.all
  end
end
