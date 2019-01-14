require 'test_helper'
require 'nokogiri'

module NomadicCrawler
    class CurriculumParserTest < ActiveSupport::TestCase
        def setup
            course_info = {year: 2018, semester: 6, course_code: "002551", course_division: 1}
            cyberlecture_info = {year: 2018, semester: 6, course_code: "002060", course_division: 1}
            @curriculum_parser   = CurriculumParser.new(ENV['CURRICULUM_SITE_BASE'], **course_info)
            @cyberlecture_parser = CurriculumParser.new(ENV['CURRICULUM_SITE_BASE'], **cyberlecture_info)
        end

        test '생성자가 제대로 돌아감' do
            assert_equal @curriculum_parser.year,        2018
            assert_equal @curriculum_parser.semester,    6
            assert_equal @curriculum_parser.course_code, "002551"
        end

        test '강의 제목/강의실이 틀리지 않음' do 
            @curriculum_parser.request_for_course
            assert_equal @curriculum_parser.parsed_information[:title], "논리와사고"
            assert_equal @curriculum_parser.parsed_information[:classrooms], "C809"
        end        

        test '사이버강좌는 강의실이 없음' do
            @cyberlecture_parser.request_for_course
            assert_empty @cyberlecture_parser.parsed_information[:classrooms]
        end
    end
end