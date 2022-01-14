#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      tds[0].text.tidy
    end

    def position
      # TODO: set the 'as of' as the start date
      tds[1].text.tidy.gsub(/ \(?as of.*/, '')
    end

    private

    def tds
      noko.css('td')
    end
  end

  class Members
    def member_container
      noko.xpath('//table[1]//tr[td]')
    end
  end
end

file = Pathname.new 'official.html'
puts EveryPoliticianScraper::FileData.new(file).csv if file.exist? && !file.empty?
