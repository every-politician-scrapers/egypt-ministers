#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

require 'open-uri/cached'

class OfficeholderList < OfficeholderListBase
  decorator RemoveReferences
  decorator UnspanAllTables
  decorator WikidataIdsDecorator::Links

  def header_column
    'Портрет'
  end

  class Officeholder < OfficeholderBase
    def columns
      %w[ordinal photo name _ start end].freeze
    end

    def tds
      noko.css('td,th')
    end

    def empty?
      noko.css('h2').count > 0
    end
  end
end

url = ARGV.first
puts EveryPoliticianScraper::ScraperData.new(url, klass: OfficeholderList).csv
