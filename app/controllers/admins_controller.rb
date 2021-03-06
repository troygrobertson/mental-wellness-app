class AdminsController < ApplicationController
	#performs a before action, in other words it will run the script defined at the start method-> :signed_in_admin
	#this will then run before every POST action that exists after -> :new, :create, :index, :edit, :update
	before_action :signed_in_director, only: [:new, :create]
	#before_action :signed_in_admin, only: [:index]
#	before_action :correct_user, only: [:show]
	before_action :signed_in, only: [:show, :edit, :update, :new,:create]#,:index]
    before_action :protect_admin_edit, only: [:edit,:update]
#	before_action :is_current_user, only: [:edit, :update]
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	def show
		@admin = Admin.find(params[:id]) 
		@user = @admin.user
	end
	#def index
	
	#puts all of the admins into a browsable list
	#the list has a default length of 30 entries per page 
	#uses will_paginate in the view to put the page bar in

=begin      if defined? params[:search]
		unless is_director
			@admins = User.where('name LIKE ? and profile_type = ?',"%#{params[:search]}%",params[:user_type]).order("name ASC").paginate(page: params[:page])
		else
			if params[:user_type] != Patient	
			@admins = User.where('name LIKE ? and profile_type = ?',"%#{params[:search]}%",params[:user_type]).order("name ASC").paginate(page: params[:page])
			else
				flash[:notice] = "You do not have permission to view patients"
				render 'index'
			end
		end
=end	end
	#end
	def new
		#creates temp variables for the new form to use for the views
		@admin =Admin.new
		@user = User.new
	end
	def create
		#creates the admin based on the allowed admin parameters
		@admin =Admin.new(admin_params)
		#creates a user and attaches it to the admin with the user parameter restrictions required
		@admin.director =false
        #tries to save the admin to the database
        if  @admin.save

		  @user = @admin.build_user(user_params)
            if @user.save 
            InstitutionMembership.create(:institution => current_user.institutions.first, :memberable => @user)
              
              Activity.create(:user => current_user,:trackable => @admin,:action => "Created Admin")
			#flashes a success message for the admin
			flash[:notice] = "Admin save successfully."
			#redirects to the newly created admins' page
			redirect_to edit_user_path(@user)
            else
              @admin.delete
              flash[:alert]="problem creating an admin."
              render "new"
            end
		else
			#reloads the new page so that the forms can have the correct information
            flash[:alert]="problem creating admin."
			render 'new'
		end
	end
	def edit
		#finds the user that is defined in the param hash and finds that user
		@admin = Admin.find(params[:id])
		#using the profile found above will then get the user of that admin aka the email, username, etc
		@user = @admin.user
		@pools = Pool.all

	end
	def update
	  @admin = Admin.find(params[:id])
	  @user = @admin.user
        if @user.valid_password?(params[:user][:old_password])
          #passes the attributes from the form to the admin_params function
          #if(params[:user][:email].match(VALID_EMAIL_REGEX))
            if defined?(params[:user][:password]) || defined?(params[:user][:password_confirmation])
              if (params[:user][:password] != params[:user][:password_confirmation])
                flash[:alert]="Password and Password Confirmation must match"
                render 'edit'
              else
                @admin.update_attributes(admin_params)
                if params[:user][:password_confirmation] != ""
                  #passes the attributes from the form to the user_params function
                  @user.update_attributes(user_params)
                  Activity.create(:user => current_user, :trackable => @admin,:action => "Updated Profile")
                else
                  values = {:name => params[:user][:name], :password_confirmation => params[:user][:old_password], :email => params[:user][:email], :password => params[:user][:old_password]}
                  if @user.update_attributes(values) #&& @admin.update_attributes(admin_params)  
                    Activity.create(:user => current_user, :trackable => @admin,:action => "Updated Admin")
                  end
                                  
                end
                flash[:notice]="successfully updated your profile."
                redirect_to @admin
              end
            else
              @admin.update_attributes(admin_params)
#passes the attributes from the form to the user_params function
              @user.update_attributes(user_params)
              flash[:notice]="successfully updated your profile."
              redirect_to @admin
            end
          #else
          #  flash[:alert]="Please enter a valid email"
          #  render 'edit'
          #end
        else
          flash[:alert]="Old password is not correct"
          render 'edit'
        end
	end
	def get
		@admin = User.where(params[:name])
	end
	private
	#params
	#used to specify which attributes of the model should be accepted
		def user_params
			params.require(:user).permit(:name, :email, :password,:password_confirmation)
	
        end
		def admin_params

		end
		#before filters
		#functions called at the start of various actions. to see which is called by what function check first few lines of this code with before_action
		def signed_in
			unless signed_in?#checks if the user is currently signed in, the function is housed in the sessions helper for in depth analysis
				store_location
				redirect_to signin_url, notice: "Please sign in."
			end
		end
		#checks if the currently signed in user is an admin
		def signed_in_admin
		
            unless is_admin #checks if the currently logged in user is an Admin
				store_location
				redirect_to signin_url, notice: "You do not have permission to do that."
			end
		end
		def signed_in_director
				unless is_director #checks if the currently logged in user is an Admin

                  flash[:alert]="you do not have permission to create an admin."
                  redirect_to go_to_home
				end
		end
		
		#checks that the user that is logged in matches the id of the user that is in the params hash matches that which is currently logged in
		def correct_user
			#checks params hash for the user id storing that user into a variable
			@user = User.find(params[:id])
			#compares that user created above to the currently logged in user
			unless current_user?(@user) ||  is_admin?(current_user) #|| is_doctor?(current_user)
				redirect_to(root_url) 
			end
		end
		def is_current_user
			@user = User.find(params[:id])
			unless current_user?(@user)
				redirect_to(root_url)
			end
		end
        def protect_admin_edit
          @admin = Admin.find(params[:id])
          if current_user.profile_id != @admin.id
            if @admin.director
              flash[:alert]="You do not have the permission to edit this director." 
            else
              flash[:alert]="You do not have the permission to edit this admin." 
            end

         redirect_to go_to_home 

          end
        end
end
