require 'nokogiri'
require 'open-uri'
require 'httparty'
require 'yaml'
require 'selenium-webdriver'
require 'watir'

tickers = YAML.load_file('tickers.yml')['Tickers']
puts tickers

closing_prices = []

@browser = Watir::Browser.new :chrome
@browser.goto 'https://finance.yahoo.com/'

tickers.each do |ticker|
	@browser.input(xpath: '//input[@aria-label="Search" and @name="p"]')
			  .wait_until_present(timeout: 30)
			  .send_keys ticker
	@browser.button(id: 'search-button')
				  .wait_until_present(timeout: 30)
	        .click
	price = @browser.span(xpath: '//*[@id="quote-header-info"]/div[3]/div/div/span')
									 .wait_until_present(timeout: 30)
									 .text
	closing_prices.push(price)
end

closing_prices.each { |e| puts e  }


	# https://finance.yahoo.com/quote/BAC?p=BAC&.tsrc=fin-srch
	# puts "https://finance.yahoo.com/quote/#{ticker}?p=#{ticker}&.tsrc=fin-srch"
	# @resp = HTTParty.get("https://finance.yahoo.com/quote/#{ticker}?p=#{ticker}&.tsrc=fin-srch")
	# @doc = Nokogiri::HTML(@resp.body)
	# puts @doc
	# puts '*************************************************************************'
	# ticker_price = @doc.xpath("//div[@id='app']//span")
	# puts ticker_price
	# @driver = Selenium::WebDriver.for :chrome
	# @driver.navigate.to 'https://finance.yahoo.com/'