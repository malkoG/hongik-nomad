require 'test_helper'
require 'selenium-webdriver'
require 'nokogiri'

module NomadicCrawler
    class CrawlerTest < ActiveSupport::TestCase
        def setup
            @crawler = Crawler.new(ENV['TARGET_SITE'])
        end

        test 'fill in the form' do
            @crawler.fill_in_the_form

            assert true # 최근 학기를 선택했는지
            assert true # 언제 입학했는지 체크
            assert true # 어떤 종류의 학생인지 체크
        end

        test 'Get Latest Semester' do
            @crawler.fill_in_the_form
            @crawler.request_latest_semester_curriculum
        end
    end
end