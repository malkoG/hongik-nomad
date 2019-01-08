require 'test_helper'
require 'nokogiri'

module NomadicCrawler
    class CurriculumParserTest < ActiveSupport::TestCase
        def setup
            course_info = {year: 2018, semester: 6, course_code: "002551", course_division: 1}
            @curriculum_parser  = CurriculumParser.new(ENV['CURRICULUM_SITE_BASE'], **course_info)
        end

        test 'constructor correctly works' do
            assert_equal @curriculum_parser.year,        2018
            assert_equal @curriculum_parser.semester,    6
            assert_equal @curriculum_parser.course_code, "002551"
        end

        test 'title is correct' do 
            @curriculum_parser.request_for_course
            assert_equal @curriculum_parser.parsed_information[:title], "논리와사고"
            assert_equal @curriculum_parser.parsed_information[:classrooms], "C809"
        end        
    end
end