class SubscriptionsController < ApplicationController
  def new
    # Display the subscription form
  end

  def create
    subscription_type = params[:subscription_type]
    price_id = get_price_id(subscription_type)

    # Check if price_id is valid
    if price_id.nil? || price_id.empty?
      flash[:alert] = "Subscription type invalid or Price ID not found."
      redirect_to new_subscription_path and return
    end

    # Create a customer in Stripe
    customer = Stripe::Customer.create({
                                         email: params[:email],
                                         source: params[:stripeToken]  # Token from frontend
                                       })

    # Create a subscription for the customer in Stripe
    subscription = Stripe::Subscription.create({
                                                 customer: customer.id,
                                                 items: [{ price: price_id }],
                                                 expand: ['latest_invoice.payment_intent']
                                               })

    # Save Stripe customer ID and subscription ID in the User model
    current_user.update(
      stripe_customer_id: customer.id,
      subscription_id: subscription.id,
      subscription_status: subscription.status
    )

    flash[:notice] = "#{subscription_type} subscription successful!"
    redirect_to root_path
  rescue Stripe::InvalidRequestError => e
    flash[:alert] = "Error creating subscription: #{e.message}"
    redirect_to new_subscription_path
  end

  private

  def get_price_id(subscription_type)
    case subscription_type
    when "Weekly"
      Rails.application.credentials.stripe[:weekly_price_id]  # Make sure this ID is correct
    when "Monthly"
      Rails.application.credentials.stripe[:monthly_price_id]  # Make sure this ID is correct
    when "Yearly"
      Rails.application.credentials.stripe[:yearly_price_id]  # Make sure this ID is correct
    else
      nil
    end
  end
end
