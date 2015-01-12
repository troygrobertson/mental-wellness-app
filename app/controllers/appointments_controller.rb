class AppointmentsController < ApplicationController
  def new
	  @user = current_user
	  @appointment = Appointment.new
	  
  end

  def create
	@appointment =Appointment.new(appointment_params)	
	if @appointment.save
		
		@message = Message.new(:appointment_id => @appointment.id, :user_id => current_user.id, :message => current_user.name+" Started appointment")
		if @message.save
			flash[:success]="Successfully created appointment"
		else 
			flash[:failure]="Failed to create appointment"
		
		end
			
		redirect_to appointments_path
	else
		render 'new'
	end
		
  end

  def index
	@appointments = current_user.appointments

  end
def update
		if(params[:appointment][:func] == "destroy")
			Appointment.find(params[:appointment][:appointment_id]).destroy
			flash[:success]="Destroyed appointment"
			redirect_to appointments_path
		elsif(params[:appointment][:func] == "create")
			redirect_to new_message_path({appointment_id:params[:appointment][:appointment_id]})
		end
end
  
  def show
	@appointment=Appointment.find(params[:id])
  end

  
  private
  def appointment_params
	
	
	params.require(:appointment).permit(:name, :description)
	
  end
	def message_params
		params.require(:message).permit!
	end
end