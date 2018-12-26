require "selenium-webdriver"
require "nokogiri"
require "scanf"

module NomadicCrawler
  class Crawler
    attr_reader :target_size
    attr_accessor :driver

    def initialize(target_site)
      @target_site = target_site

      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')
      @driver = Selenium::WebDriver.for :chrome, options: options
      
      @driver.navigate.to @target_site
    end

    def fill_in_the_form
      select_tag = Selenium::WebDriver::Support::Select.new(@driver.find_element tag_name: 'select')
      select_tag.select_by(:index, 0)
      year, semester = select_tag.selected_options[0].property(:value).scanf "%4d%1d"

      checkbox    = @driver.find_element id: "input", name: "p_y2016"
      checkbox.click
      
      radio_xpath  = '//*[@id="select_abeek"]/tbody/tr[2]/td/form/input[4]'
      radio_button = @driver.find_element xpath: radio_xpath
      radio_button.click

      return [year, semester]
    end

    def request_latest_semester_curriculum
      year, semester = fill_in_the_form
      
      submit_xpath = '//*[@id="select_abeek"]/tbody/tr[2]/td/form/input[7]'
      submit_button = @driver.find_element xpath: submit_xpath
      submit_button.click

      sleep(3)

      element = @driver.find_element id: 'table_seoul'



      return element
    end
  end
end