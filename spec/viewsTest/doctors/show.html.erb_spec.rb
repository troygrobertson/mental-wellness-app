require 'spec_helper'

describe 'doctors\edit.html.erb', type: :view do
	it 'displays detrails correctly'do
		@user= create(:patient)
		render :template => 'doctors/edit.html.erb'
	end
end 
