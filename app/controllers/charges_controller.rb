class ChargesController < ApplicationController

	def new
		@stripe_btn_data = {
			key: "#{Rails.configuration.stripe[:publishable_key]}",
			description: "Blocipedia Premium Package - #{current_user.email}",
			amount: 1000
		}
	end

	# Creates a Stripe Customer object, for associating
  # with the charge
	def create
		customer = Stripe::Customer.create(
			email: current_user.email,
			card: params[:stripeToken]
		)

		charge = Stripe::Charge.create(
			customer: customer.id, # Note -- this is NOT the user_id in your app
			amount: 1000,
			description: "Blocipedia Premium Package - #{current_user.email}",
			currency: 'usd'
		)

		flash[:notice] = "Thanks for your purchase, you now have access to create and view private topics!"
		redirect_to wikis_path

		if charge["paid"] == true then current_user.update_attribute(:role, "premium") end
		# Stripe will send back CardErrors, with friendly messages
	  # when something goes wrong.
	  # This `rescue block` catches and displays those errors.
  	rescue Stripe::CardError => e 
  		flash[:error] = e.message 
  		redirect_to new_charge_path
	end
end
