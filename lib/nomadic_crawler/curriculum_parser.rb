require "nokogiri"

module NomadicCrawler
  class CurriculumParser
    attr_accessor :year, :semester, :course_code, :course_division, :is_vacation, :parsed_information

    def initialize(**options)
      @year               = options[:year]
      @semester           = options[:semester]
      @course_code        = options[:course_code]
      @course_division    = options[:course_division]
      @is_vacation        = false
      @parsed_information = nil

      query  = { yy: @year, hakgi: @semester, haksu: @course_code, bunban: @course_division }.to_query
      @source = "#{ENV['CURRICULUM_SITE_BASE']}?#{query}"
    end

    def request_for_course
      @is_vacation = @semester > 2
      doc = Nokogiri.HTML(open(@source))
      
      @parsed_information = parse_syllabus(doc)
    end

    protected
      def parse_syllabus(doc)
        title      = doc.xpath("/html/body/table[1]/tr[2]/td[2]/text()[1]").text.strip
        instructor = doc.xpath("/html/body/table[1]/tr[5]/td[2]").text.strip
        classrooms = doc.xpath("/html/body/table[1]/tr[4]/td[4]").text.strip
        schedule   = doc.xpath("/html/body/table[1]/tr[3]/td[6]").text.strip

        return { 
          title: title, 
          course_code: @course_code,
          is_vacation: @is_vacation, 
          classrooms: classrooms, 
          instructor: instructor, 
          schedule: schedule
        } 
      end
  end
end