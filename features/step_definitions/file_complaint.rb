# frozen_string_literal: true

Given('I am on the complaint filing page') do
  visit '/etica/kpmgtreinamento/denunciations/new'
end

When('I enter valid complaint details') do
  select 'Fraude → Desvio de recursos', from: 'denunciation[category_id]'
  select 'Sede', from: 'denunciation[location_id]'
  select 'Comunidade', from: 'denunciation[correlation_id]'
  editor = find(:css, 'trix-editor')
  page.execute_script("arguments[0].editor.insertString('Texto a ser inserido')", editor.native)
  find('#new_denunciation > div > div > div:nth-child(3) > div.field.form-group > label > span').click
end

Then('I should file a complaint successfully') do
  page.execute_script('window.scrollBy(0,1000)')
  sleep 20
  click_button 'Enviar relato'
  expect(page).to have_content 'Obrigado pelo envio do seu relato!'
end
