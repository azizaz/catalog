# coding: utf-8
require 'nokogiri'
require 'open-uri'
require 'sqlite3'
require 'geocoder'

puts "Get index page"
doc = Nokogiri::HTML(open('http://biz.kr.ua/#catalog'))

db = SQLite3::Database.new("../db/development.sqlite3")
rubrics = []

#drop existing content
db.execute("delete from rubrics")
db.execute("delete from items")

####
doc.search('div#block_catalog li>a').each do |link|
  db.execute("insert into rubrics (name, description) values (?, ?)", link.content.sub!(/\([0-9\/]*\)/, ""), link[:href])
  rubrics << {:id =>db.last_insert_row_id(), :url => link[:href], :title => link.content}
end

threads = []
timestamp = Time.now

rubrics.each do |rubric|
  puts "Fetch #{rubric[:url]}"
  threads << Thread.new(rubric) do |rubric|
	f = File.new("data/content.#{timestamp}", 'a')
    doc = Nokogiri::HTML(open(rubric[:url]))
	doc.search('div.company-all').each do |item|
	  name = item.search('b').first ? item.search('b').first.content : nil
	  description = item.search('div.services-text').first ? item.search('div.services-text').first.content : nil
	  address = item.search('div.address>span').first ? item.search('div.address>span').first.content : nil
	  phone = item.search('div.phone').first ? item.search('div.phone').first.content : nil
	  
	  if name != nil
		latitude = longitude = nil
		if address != nil	#try detect geo coordinates
		  latitude, longitude = Geocoder.coordinates("Украина, Кировоград, #{address}")
		end
		db.execute("insert into items (rubric_id, name, description, address, latitude, longitude) values (?, ?, ?, ?, ?, ?)", 
		           rubric[:id], name, "#{description}\n #{phone}", address, latitude, longitude)
		
		f.puts("-----------------------------------")
		f.puts(rubric[:url])
		f.puts("-----------------------------------")
		f.puts("#{name}|#{address}|#{phone}")
		f.puts()
		f.puts()
	  end
	end
    puts "Data stored from #{rubric[:url]}"
	f.close
  end
end
threads.each {|thr| thr.join }