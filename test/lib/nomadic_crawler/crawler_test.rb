require 'test_helper'

module NomadicCrawler
    class CrawlerTest < ActiveSupport::TestCase
        def setup
            @crawler = Crawler.new(ENV['TARGET_SITE'])
        end

        test 'Get Latest Semester' do
            element = @crawler.get_latest_semester
            assert_equal element.tag_name, 'select'
        end
    end
end