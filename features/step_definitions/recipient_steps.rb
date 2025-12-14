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

Then('I should be on the recipient page for {string}') do |name|
  recipient = Recipient.find_by!(name: name)
  expect(page.current_path).to eq(recipient_path(recipient))
end
