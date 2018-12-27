require "selenium-webdriver"
require "nokogiri"
require "scanf"

module NomadicCrawler
  class Crawler
    SLEEP_TIME=3

    attr_reader :target_site
    attr_accessor :driver, :year, :semester

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

      checkbox_xpath = '//*[@id="select_abeek"]/tbody/tr[2]/td/form/input[2]'
      checkbox    = @driver.find_element xpath: checkbox_xpath
      checkbox.click
      sleep(SLEEP_TIME)

      radio_xpath  = '//*[@id="select_abeek"]/tbody/tr[2]/td/form/input[4]'
      radio_button = @driver.find_element xpath: radio_xpath
      radio_button.click
      sleep(SLEEP_TIME)

      @year = year
      @semester = semester
    end

    def crawl_courses_list(course_list_url)
      courses_list = []
      # Curriculum Parser

      return courses_list
    end

    def parse_abstruse_link(text)
      campus, category, department, grade = text.scanf "javascript:gocn4001(%d,%d,'%[^']',%d)"
      return {
        year: @year,
        semester: @semester,
        campus: campus,
        category: category,
        department: department,
        grade: grade,
        is_abeek: 1,
        p_2014: "on",
        p_2016: 2016
      }
    end

    def request_latest_semester_curriculum
      submit_xpath = '//*[@id="select_abeek"]/tbody/tr[2]/td/form/input[7]'
      submit_button = @driver.find_element xpath: submit_xpath
      submit_button.click

      sleep(SLEEP_TIME)

      element = @driver.find_element id: 'table_seoul'
      html_doc = Nokogiri.HTML(@driver.page_source)
      html_doc.css("#table_seoul > tbody > tr > td > a").map do |html|
        parse_abstruse_link html.attr('href')
      end

      course_category_urls = []
      courses_list = []
      course_category_urls.each do |course_url|
        crawled_list = crawl_courses_list(course_url)
        courses_list = [*courses_list, *crawled_list]
      end

      return element
    end


  end
end