class AppointmentsController < ApplicationController
  def new
	  @user = current_user
	  @appointment = Appointment.new
	  
  end

  def create
	@appointment =Appointment.new(appointment_params)	
	if @appointment.save
		
		
		@messageDoc = Message.new(:messageable_id => @appointment.id,:messageable_type => "Appointment", :user_id => current_user.id, :message => current_user.name+" Started appointment")
		@messageDoc.updated_at = DateTime.now
		if defined?(params[:appointment][:patient_id]) && params[:appointment][:patient_id]!= ""
		@patient = Patient.find(params[:appointment][:patient_id])
		@messagePat = Message.new(:messageable_id => @appointment.id,:messageable_type => "Appointment", :user_id => @patient.user.id, :message => current_user.name+" added to appointment")
		@messagePat.updated_at = DateTime.now
		end
		if defined?(@messagePat) 
			if @messageDoc.save && @messagePat.save
				flash[:notice]="Successfully created appointment"
			else 
				flash[:alert]="Failed to create appointment"
			end
		else
			if @messageDoc.save
				flash[:notice]="Successfully created appointment"
			else 
				flash[:alert]="Failed to create appointment"
			end
		end
		redirect_to appointments_path
	else
		render 'new'
	end
		
  end

  def index
	@messages = Message.where("messageable_type = ? and user_id = ? ",'Appointment', current_user.id).select(:messageable_id).distinct.all
  end
def update
		if(params[:appointment][:func] == "destroy")
			Appointment.find(params[:appointment][:appointment_id]).destroy
			flash[:notice]="Successfully destroyed appointment"
			redirect_to appointments_path
		elsif(params[:appointment][:func] == "create")
			redirect_to new_message_path({messageable_id: params[:appointment][:messageable_id], messageable_type: "Appointment"})
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