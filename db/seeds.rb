# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'nokogiri'
require 'ferrum'

puts 'Scrap fontawesome Icons...'

base_url = "https://fontawesome.com/icons?d=gallery&c=alert,business,computers,users-people&m=free"
# p base_html_doc = Nokogiri::HTML(open(base_url).read)
# p base_html_doc.search('#results-icons')

browser = Ferrum::Browser.new()
browser.goto base_url
html_doc = Nokogiri.parse(browser.body)
results = html_doc.search('#results-icons')
base_icon_links = "https://fontawesome.com"
icons_number = Icon.all.length
results.search('ul > li > div > a').each do |icon_links|
  icon_link = base_icon_links + icon_links.attribute('href').value
  # icon_html_doc = Nokogiri::HTML(open(icon_link).read)
  browser.goto icon_link
  icon_html_doc = Nokogiri.parse(browser.body)
  code = icon_html_doc.search('#page-top > div.view.flex.flex-column.min-vh-100.db-pr > div.flex-grow-1.flex-shrink-0.flex-basis-auto > div > div.ph6-l > div > section > header > div.bn.bb-l.bw2.b--gray1.mb4.pb3-l.flex.flex-column.flex-row-xl.justify-between-xl.items-end-xl.lh-copy > ul.flex.flex-wrap.flex-row-ns.items-center-ns.list.pa0.ma0.mb2.mb0-xl.pb2.pb0-xl.bb.bb-0-xl.bw2.bw1-l.b--gray1 > li.order-9-l.mt2.mt0-l.mr2-l.order-5.w-100.w-auto-l.order-6-l.pt2.pt0-l.bt.bt-0-l.bw1.b--gray1 > code').text
  if Icon.where(code: code).empty?
    name = icon_link.split('/')[4].split('?').first
    family = icon_html_doc.search('#page-top > div.view.flex.flex-column.min-vh-100.db-pr > div.flex-grow-1.flex-shrink-0.flex-basis-auto > div > div.ph6-l > div > section > header > div.bn.bb-l.bw2.b--gray1.mb4.pb3-l.flex.flex-column.flex-row-xl.justify-between-xl.items-end-xl.lh-copy > ul.ma0.list.pa0.flex.flex-column.flex-wrap.flex-row-ns.items-center-ns > li.mb2.mb0-ns.mr2-ns.pb2.pb0-ns.bb.bb-0-ns.bw1.b--gray1 > a').text
    unless (name == '' || family == '' || code == '')
        Icon.create(name: name, family: family, code: code)
        icons_number += 1
        puts "#{icons_number} icons created"
    end
  end
end

puts 'DONE'
