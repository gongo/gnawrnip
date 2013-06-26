step 'I am on the :path' do |path|
  visit path
end

step 'I should see :text' do |text|
  expect(page).to have_content(text)
end

step 'I should not see :text' do |text|
  expect(page).not_to have_content(text)
end

step 'type :text to :field' do |text, field|
  fill_in field, with: text
end

step 'typed :field with :text' do |field, text|
  expect(page).to have_field(field, with: text)
end

step 'click :button' do |button|
  click_button button
end

step ':text confirm is :choice' do |text, choice|
  dialog = page.driver.browser.switch_to.alert
  expect(dialog.text).to eq text

  choice == 'ok' ? dialog.accept : dialog.dismiss
end
