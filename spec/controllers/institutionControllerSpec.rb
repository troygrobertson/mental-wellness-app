require 'spec_helper'

describe InstitutionsController, type: :controller do
=begin	let(:ins){FactoryGirl.create :institution}
	let(:patient){FactoryGirl.create :patient}
	let(:doctor){FactoryGirl.create :doctor}
	let(:admin){FactoryGril.create :admin}
	let(:director){FactoryGirl.create :director}
#show	
#anyone logged should be able to view the institution
	subject(:ins)
	
	it 'logged in patient' do
		sign_in @patient
	controller.current_user = @patient
		get :show, {'user_id'=> @patient.id}
		is_expected_to match @ins
	end


#edit
#only directors can edit

#update
#only directors can update

=end
end
