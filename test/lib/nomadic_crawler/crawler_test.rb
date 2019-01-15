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

        test 'Check if Successfully parsed' do
            @crawler.fill_in_the_form

            result = @crawler.parse_abstruse_link "javascript:gocn4001(1,2,'A101',0)"
            assert_equal result[:p_campus], 1
            assert_equal result[:p_gubun], 2
            assert_equal result[:p_dept], "A101"
            assert_equal result[:p_grade], 0
        end        

        test 'Get Latest Semester' do
            @crawler.fill_in_the_form

            courses = @crawler.request_latest_semester_curriculum
            assert_not_empty courses
        end

        test '강의 목록을 제대로 긁어왔는지 검사' do
            semester_info = {
                p_yy: 2018,
                p_hakgi: 6,
                p_campus: 1,
                p_gubun: 1,
                p_dept: "0001",
                p_grade: 16,
                p_abeek: 1,
                p_2014: "on",
                p_2016: 2016
            }

            assert_equal @crawler.crawl_courses_list(semester_info).size, 3
        end
    end
end