# Go to the new gift idea form for a recipient in an event
Given('I am on the new gift ideas page for {string} in {string}') do |recipient_name, event_name|
  user = User.find_by!(email: 'user@example.com')
  event = Event.find_by!(name: event_name, user: user)
  recipient = Recipient.find_by!(name: recipient_name, user: user)

  EventRecipient.find_or_create_by!(event: event, recipient: recipient)
  visit new_event_recipient_gift_idea_path(event, recipient)
end

# View all gift ideas for a recipient in an event
When('I view the gift ideas page for {string} in {string}') do |recipient_name, event_name|
  user = User.find_by!(email: 'user@example.com')
  event = Event.find_by!(name: event_name, user: user)
  recipient = Recipient.find_by!(name: recipient_name, user: user)
  visit event_path(event)
end

# Pre-populate gift ideas for a recipient in an event
Given('{string} has the following gift ideas in {string}:') do |recipient_name, event_name, table|
  user = User.find_by!(email: 'user@example.com')
  event = Event.find_by!(name: event_name, user: user)
  recipient = Recipient.find_by!(name: recipient_name, user: user)
  event_recipient = EventRecipient.find_or_create_by!(event: event, recipient: recipient)

  table.hashes.each do |attrs|
    EventRecipientGiftIdea.create!(
      title: attrs['title'],
      notes: attrs['notes'],
      url: attrs['url'],
      event_recipient: event_recipient
    )
  end
end

# Click edit/delete for a gift idea inside the event view
When('I click {string} for {string} in {string}') do |action, gift_title, event_name|
  user = User.find_by!(email: 'user@example.com')
  event = Event.find_by!(name: event_name, user: user)
  gift = EventRecipientGiftIdea.joins(:event_recipient)
                               .where(event_recipients: { event_id: event.id })
                               .find_by!(title: gift_title)

  within("div[data-gift-id='#{gift.id}']") do
    click_link_or_button action
  end
end

# Create an event for the user
Given('I have an event named {string}') do |event_name|
  user = User.find_by!(email: 'user@example.com')
  Event.create!(name: event_name, user: user, date: Date.today)
end