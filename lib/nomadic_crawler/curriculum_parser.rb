require "selenium-webdriver"
require "nokogiri"
require "scanf"

module NomadicCrawler
  class CurriculumParser
    def initialize(**options)
      @curriculum_site = ENV['CURRICULUM_SITE_BASE']
      
    end
  end
end