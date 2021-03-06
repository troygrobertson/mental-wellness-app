require 'spec_helper.rb'
require 'faker'

describe PatientsController, type: :controller do
	before(:each) do
		@admin = FactoryGirl.create(:userAdmin)
		controller.current_user = @admin
		@patient = FactoryGirl.create(:userPatient)
	end 

	it "show patient as admin" do
		show_action()
		check
	end
	
	it "redirect_show_patient, as admin"do
		show_action()
		expect(response).to be_success
	end	
	
	it "show patient as director" do
		@admin.profile.director = true
		show_action()
		check
	end
	
	it "redirect_show_patient, as director"do
		@admin.profile.director = true		
		show_action()
		expect(response).to be_success
	end

	it "new_patient as admin" do
		new_action()
		expect(response).to be_success
	end

	it "create_patient as admin"do
		expect{create_action()}.to change(Patient, :count).by(1)
	end
	
	it "new_patient as director" do
		@admin.profile.director = true
		new_action()
		expect(response).to be_success
	end

	it "create_patient as director"do
		@admin.profile.director = true
		expect{create_action()}.to change(Patient, :count).by(1)
	end

	
	it "create_patient_flash admin" do
		create_action()
		expect(flash[:notice]).to eq("successfully added patient")
	end
	
	it "create_patient_redirection admin" do
		create_action()
		expect(response).to redirect_to :action => :edit, :id => 2
	end
	
	it "create_patient_flash director" do
		@admin.profile.director = true
		create_action()
		expect(flash[:notice]).to eq("successfully added patient")
	end
	
	it "create_patient_redirection director" do
		@admin.profile.director = true		
		create_action()
		expect(response).to redirect_to :action => :edit, :id => 2
	end

#requires further testing with pool privilges 
	it "edit_patient as admin" do
		edit_action()
		expect(response).to be_success
	end

	it "edit_patient as director" do
		@admin.profile.director = true
		edit_action()
		expect(response).to be_success
	end
=begin
test this with the privileges
	it "update_patient as admin" do
		puts @admin.user.name
		update_action()
		expect(response).to be_success
	end
=end
private 
	def check
		assert_equal @patient.profile, assigns(:patient)
	end

	def show_action	
		get :show, {'id' => @patient.profile.id}, {'user_id' => @admin.id}
	end

	def new_action
		get :new
	end
	
	def create_action
		get :create, patient: attributes_for(:patient), user: attributes_for(:user) 
	end
	
	def edit_action
		get :edit, id: @patient.profile.id
	end
	
	def update_action
		get :update, 'patient' => { :func => "addPool"}, user: attributes_for(:user), 'id' => @patient.profile.id

	end
end
