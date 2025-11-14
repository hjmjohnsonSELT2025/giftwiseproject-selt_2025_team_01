When('I go to the recipients page') do
  visit '/recipients'
end

Given('I am on the recipients page') do
  visit '/recipients'
end

Given('a recipient exists with name {string} for user {string}') do |name, email|
  user = User.find_by!(email: email)
  Recipient.create!(user: user, name: name)
end

When('I click "Delete" for recipient {string}') do |name|
  within(:xpath, "//li[.//strong[contains(normalize-space(.), '#{name}')]]") do
    click_link 'Delete'
  end
end
