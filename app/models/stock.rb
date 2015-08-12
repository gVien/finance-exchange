# require "yahoofinance"
# require 'pp'

class Stock < ActiveRecord::Base
	has_many :comments
  validates :symbol, uniqueness: true

	# my code from phase 0
	def self.separate_comma(num)
    # 1. Convert the number to string and then array and reverse it
    return num.to_s if num.to_s.length<4
    num = num.to_s.reverse.split("")

    # 2. Define a new number string concatenate the comma separator
    new_num = ""

    # 3. Iterate over the number
    num.each_with_index do |substr,index|
        new_num << if index % 3 == 0 && index != 0
          "," + substr
          else
            substr
          end
    end
    return new_num.reverse
  end

  def self.parse_yahoo_finance(sym)
    mechanize = Mechanize.new
    url = "http://finance.yahoo.com/q?s=" + sym
    page = mechanize.get(url)
  end

  # A quick reference to the Yahoo Finance news for the stock symbol
  # to get link, perform another search with anchor element
  # example: get_yahoo_finance_news_for("yhoo").search("a")["href"] which returns an array of anchors
  # the anchor arrays accepts the following attributes
  # ["href"] => href link
  # .inner_text => The Title of the news article, cmd is same as innerHTML
  # ["data-ylk"] => which is the news source

  # The complete .inner_text of `get_yahoo_finance_news_for(sym)` returns title, source, and date
  def self.get_yahoo_finance_news_for(sym)
    parse_yahoo_finance(sym).search("#yfi_headlines .bd li").map {|data| data}
  end

  def self.get_yahoo_finance_news_anchor_for(sym)
    news_source_arr = []
    get_yahoo_finance_news_for(sym).each_with_index do |li, i|
      p li#[i].search("a").first
      # news_source_arr << [anchor["href"], anchor.inner_text]
    end
    news_source_arr
  end

  def self.get_yahoo_finance_news
  end

  def self.complete_news_url(sym)
  end
  def self.parseGoogleFinance(sym)
  end
end

# stock = Stock.new
# pp q = stock.data("GOOG", 15)
# p q.first.symbol.kind_of? String
# p Stock.plot("NEW",45)
# require "mechanize"
# p Stock.get_yahoo_finance_news_for("goog")
