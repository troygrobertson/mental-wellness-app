Given(/^they edit themselves$/) do
  if current_user.profile_type == "Admin"
    @trackable=current_user.profile
    visit edit_admin_path(current_user.profile_id)
  elsif current_user.profile_type == "Doctor"
    @trackable=current_user.profile
    visit edit_doctor_path(current_user.profile_id)
  elsif current_user.profile_type == "Patient"
    @trackable=current_user.profile
    visit edit_patient_path(current_user.profile_id)
  end
end

When(/^they view themselves$/) do
  if current_user.profile_type == "Admin"
    @trackable=current_user.profile
    visit admin_path(current_user.profile_id)
  elsif current_user.profile_type == "Doctor"
    @trackable=current_user.profile
    visit doctor_path(current_user.profile_id)
  elsif current_user.profile_type == "Patient"
    @trackable=current_user.profile
    visit patient_path(current_user.profile_id)
  end
end
Then(/^they should be on their (?:profile |home(?:| ))page$/) do
  expect(page).to have_selector("img.gravatar")
end

Then(/^they should be on the edit user page$/) do
  edit_user_path(@trackable)
end


When(/^they add a pool$/) do
  click_button "Add to pool"
end
When(/^they remove a pool$/) do
  click_button "Remove from pool"
end
