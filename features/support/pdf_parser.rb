# frozen_string_literal: true

require 'pdf-reader'

def extract_data_from_pdf(pdf_path)
  reader = PDF::Reader.new(pdf_path)
  text = reader.pages.map(&:text).join("\n")
  transactions = parse_transaction_details(text)
  statement_period = parse_statement_period(reader.page(1).text)

  { transactions: transactions, statement_period: statement_period }
end

def parse_transaction_details(text)
  transactions = []
  text = remove_line_breaks_from_category(text)

  text.each_line do |line|
    next if line.include? 'SYMBOL'

    if line.include?('Cash Dividend') || line.include?('Non-Qualified Div') || line.include?('NRA Tax')
      columns = line.strip.split(/\s{2,}/)
      transactions << columns
    end
  end

  transactions
end

def parse_statement_period(text)
  date_regex = /\b(January|February|March|April|May|June|July|August|September|October|November|December)\s\d{1,2}-\d{1,2},\s\d{4}\b/
  match_data = text.match(date_regex)
  match_data[0] if match_data
end

def remove_line_breaks_from_category(text)
  text.gsub("NRA Tax\n", 'NRA Tax')
      .gsub("Cash Dividend\n", 'Cash Dividend')
      .gsub("Non-Qualified Div\n", 'Non-Qualified Div')
end
