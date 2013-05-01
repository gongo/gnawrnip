step 'I am on the :path' do |path|
  visit path
end

step 'I should see :text' do |text|
  expect(page).to have_content(text)
end

step 'type :text to :field' do |text, field|
  fill_in field, with: text
end

step 'click :button' do |button|
  click_button button
end
