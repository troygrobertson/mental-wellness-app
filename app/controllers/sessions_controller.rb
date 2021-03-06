=begin
class SessionsController < ApplicationController
  before_filter :signed_in, only: [:destroy]
	def new
	end
	def create
		@user = User.find_by( email: params[:session][:email].downcase)
		if @user && @user.authenticate(params[:session][:password])
			sign_in @user
			if is_admin
				redirect_back_or admin_path(@user.profile_id)
			elsif is_doctor
				redirect_back_or doctor_path(@user.profile_id)
			elsif is_patient
				redirect_back_or patient_path(@user.profile_id,{info_type: "Personal"})
			end			
		else
			flash.now[:alert] = 'Invalid email/password combination'
			render 'new'
		end
	end
	
	def destroy
		sign_out
		redirect_to root_url
	end
    private
    def signed_in
      if current_user.nil?
        redirect_to root_url

      end

    end
end
=end
