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

retries = 0 

tickers.each do |ticker|
	@search = @browser.input(xpath: '//input[contains(@aria-label,"Search")]')
			  					  .wait_until_present(timeout: 30)
  @search.send_keys ticker
	@search_btn = @browser.button(id: 'search-button')
				  							.wait_until_present(timeout: 30)
  @search_btn.fire_event :onclick 

	price = @browser.span(xpath: '//*[@id="quote-header-info"]/div[3]/div/div/span')
									 .wait_until_present(timeout: 30)
									 .text
 	#######
 	hash = {}
 	hash[:symbol] = ticker
 	hash[:price] = price 
	closing_prices.push(hash)
	@browser.back
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