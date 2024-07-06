# frozen_string_literal: true

Given("I'm at the login page") do
  visit 'https://cav.receita.fazenda.gov.br/autenticacao/login'
  find('#login-dados-certificado > p:nth-child(2) > input[type=image]').click
end

When('I log in with my credentials') do
  fill_in 'accountId', with: ENV['GOV_USERNAME']
  find('#enter-account-id').click
  fill_in 'password', with: ENV['GOV_PASSWORD']
  find('#submit-button').click
  visit 'https://www3.cav.receita.fazenda.gov.br/carneleao/pagamentos'
  visit 'https://www3.cav.receita.fazenda.gov.br/carneleao/rendimentos'
  # Parse PDF to get pagamentos
  # Parse PDF to get rendimentos
  # Get PTAX rate from statement date
  # Convert values
  # Fill pagamentos
  # Fill rendimentos
  # Count how many were filled
  # See if it matches the pagamentos
  # See if it matches the rendimentos
end
