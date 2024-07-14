# frozen_string_literal: true

require_relative('../support/pdf_parser')
require 'uri'
require 'net/http'
require 'capybara'

Given("I'm at the login page") do
  visit 'https://cav.receita.fazenda.gov.br/autenticacao/login'
  find('#login-dados-certificado > p:nth-child(2) > input[type=image]').click
end

When('I log in with my credentials') do
  sleep 120
end

And('I prepare the transactions details data') do
  pdf_data = extract_data_from_pdf('/workspaces/tax-automation/tmp/statement.pdf')
  split_statement_period = pdf_data[:statement_period].split(' ')
  ptax_date = Date.parse("#{split_statement_period.first} 15th, #{split_statement_period.last}") << 1
  ptax_buy_rate = fetch_ptax_rate(ptax_date)
  @transactions = pdf_data[:transactions]
  clean_and_convert_amount(@transactions)
  add_missing_dates(@transactions)
  complement_date_with_year(@transactions, ptax_date.year)
  convert_using_ptax(@transactions, ptax_buy_rate)
end

Then('I fill in the payment information') do
  cookies = load_cookies('/workspaces/tax-automation/tmp/cookie.json')
  add_cookies(cookies)
  visit 'https://www3.cav.receita.fazenda.gov.br/carneleao/pagamentos'
  @transactions.select { |transaction| transaction[2] == 'NRA Tax' }.each do |tax|
    # Fill pagamentos
  end
end

And('I fill in the dividend information') do
  visit 'https://www3.cav.receita.fazenda.gov.br/carneleao/rendimentos'
  @transactions.reject { |transaction| transaction[2] == 'NRA Tax' }.each do |tax|
    # Fill rendimentos
  end
end

Then('All transactions are inputted into the system') do
  taxes_count = @transactions.select { |transaction| transaction[2] == 'NRA Tax' }.size
  dividends_count = @transactions.reject { |transaction| transaction[2] == 'NRA Tax' }.size
  # Check if all taxes were inputted into the system
  # Check if all dividends were inputted into the system
end

def fetch_ptax_rate(date)
  ptax_buy_rate = nil
  while ptax_buy_rate.nil?
    url = URI("https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata/CotacaoDolarDia(dataCotacao=@dataCotacao)?@dataCotacao='#{date.strftime('%m-%d-%Y')}'&$top=100&$format=json")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)

    ptax_buy_rate = JSON.parse(response.body)['value'][0]['cotacaoCompra']
    date -= 1
  end
rescue StandardError => e
  puts e
  nil
end

def clean_and_convert_amount(transactions)
  transactions.each do |transaction|
    transaction[-1] = transaction[-1].gsub(/[()]/, '').to_f
  end
end

def add_missing_dates(transactions)
  last_date = nil

  transactions.each do |transaction|
    if transaction[0] =~ %r{\d{2}/\d{2}}
      last_date = transaction[0]
    else
      transaction.unshift(last_date)
    end
  end
end

def complement_date_with_year(transactions, year)
  transactions.each do |transaction|
    transaction[0] = "#{transaction[0]}/#{year}"
  end
end

def convert_using_ptax(transactions, ptax_buy_rate)
  return if ptax_buy_rate.nil?

  transactions.each do |transaction|
    transaction[-1] = transaction[-1] * ptax_buy_rate
  end
end
