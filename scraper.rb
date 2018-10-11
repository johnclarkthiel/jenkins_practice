require 'nokogiri'
require 'open-uri'
require 'httparty'
require 'yaml'
require 'selenium-webdriver'
require 'watir'

puts 'Hello World!'
tickers = YAML.load_file('tickers.yml')['Tickers']
puts tickers

closing_prices = []

@browser = Watir::Browser.new :chrome
@browser.goto 'https://finance.yahoo.com/'
@search_box = @browser.input(xpath: '//input[@aria-label="Search" and @name="p"]')
											.wait_until_present(timeout: 60)
											.flash
@search_button = @browser.button(id: 'search-button')
												 .wait_until_present(timeout: 60)
												 .flash

tickers.each do |ticker|
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
	@search_box.send_keys ticker
	@search_button.click
	sleep 5
end