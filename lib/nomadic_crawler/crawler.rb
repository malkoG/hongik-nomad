require "selenium-webdriver"

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

        def get_latest_semester
            element = @driver.find_element tag_name: 'select'
            return element
        end
    end
end