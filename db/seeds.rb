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
require 'faker'

puts 'STARTING SEEDING'
puts ""

puts 'Destroy all datas ... '
Campaign.destroy_all
Survey.destroy_all
Axe.destroy_all
Answer.destroy_all
Group.destroy_all
Message.destroy_all
ChatroomUser.destroy_all
Chatroom.destroy_all
User.destroy_all
puts 'Data destroyed'

puts "-----------------------"

pwd = 'aaaaaa'

puts "Create the admin Chrystelle..."
admin = User.create(first_name: "Chrystelle", last_name: "Gaujard", email: 'cg@twi.com', password: pwd, admin: true)

puts "-----------------------"

puts 'Create the groups...'
url = "https://france.makesense.org/media/etudiants-projets-sociaux-start-up/"
doc = Nokogiri::HTML(open(url).read)

titles = []
doc.search('h4').first(5).each do |title|
  titles << title.text.split('– ').last.split(':').first.strip
end

texts = []
doc.search('p').drop(1).first(5).each do |descr|
  texts << descr.text
end

main_start = Date.today
main_end = Date.today + 90

for i in 0..4
  start_d = i < 2 ? main_start : Date.today - (0..6).to_a.sample * 30
  end_d = i < 2 ? main_end + 90 : Date.today + (0..6).to_a.sample * 30
  group = Group.create(name: titles[i], description: texts[i], user: admin, start_date: start_d, end_date: end_d)
  puts "create users for the group #{group.name}..."
  for j in 0..5 do
    role = j.zero? ? 'R' : 'M'
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    user = User.create(first_name: first_name, last_name: last_name, email: "#{first_name}.#{last_name}@twi.com", password: pwd)
    UserGroup.create(user: user, group: group, role: role)
  end
end

puts "-----------------------"

puts 'create survey...'
survey = Survey.create(title: "Dynamique d'équipe", description: "Analyse de la dynamique des équipes EWP", user: admin)
questions = []

puts "Create the axes, questions and propositions..."
axes_titles_icons = {"Climat" => '<i class="fas fa-thermometer-half"></i>',
                     "Apports des membres" => '<i class="fas fa-gift"></i>',
                     "Résultats collectifs" => '<i class="fas fa-poll-h"></i>',
                     "Organisation du travail" => '<i class="fas fa-sitemap"></i>',
                     "Communication" => '<i class="fas fa-bullhorn"></i>',
                     "Encouragement à l'expression" => '<i class="fas fa-volume-up"></i>',
                     "Entraide" => '<i class="fas fa-hands-helping"></i>'}
questions = ["Le climat du groupe est ouvert, l’atmosphère est détendue ?",
             "Le groupe exploite bien les apports de ses membres /expertise ?",
             "La production des résultats est réellement un effort collectif ?",
             "Le travail en groupe est productif et efficace pour chacun ?",
             "Le groupe aide ses membres à communiquer de manière efficace ?",
             "Le groupe veille à ce que chacun ait l’occasion de s’exprimer librement et de façon opportune ?",
             "Les membres du groupe s’aident et s’encouragent mutuellement ?"]
propositions = ["Non, pas du tout.",
                "Oui, mais très peu.",
                "Oui, parfois.",
                "Oui, en majeure partie.",
                "Oui, presque tout le temps.",
                "Oui, toujours."]
q_num = 0
axes_titles_icons.each do |title, icon|
  axe = Axe.create(user: admin, title: title, description: "Une description pour l'axe #{title}", icon: icon)
  question = Question.create(survey: survey, title: questions[q_num], axe: axe, coef: 1)
  for i in 0..5
    Proposition.create(title: propositions[i], value: i, question: question)
  end
  q_num += 1
end

puts "-----------------------"

puts "create campaign (and group_campaign) for the 2 firsts groups"
campaign = Campaign.create(title: 'Campagne principale', survey: survey, start_date: main_start, end_date: main_end - 45)
Group.all.first(2).each do |group|
  GroupCampaign.create(campaign: campaign, group: group)
  puts "you can test answers with #{group.users[1].email} from the group #{group.name}"
end

puts ""
puts "SUCCESS"




# FONTAWESOM ICONS SCRAPPING

# puts 'Scrap fontawesome Icons...'

# base_url = "https://fontawesome.com/icons?d=gallery&c=alert,business,computers,users-people&m=free"

# browser = Ferrum::Browser.new()
# browser.goto base_url
# html_doc = Nokogiri.parse(browser.body)
# results = html_doc.search('#results-icons')
# base_icon_links = "https://fontawesome.com"
# icons_number = Icon.all.length
# results.search('ul > li > div > a').each do |icon_links|
#   icon_link = base_icon_links + icon_links.attribute('href').value
#   # icon_html_doc = Nokogiri::HTML(open(icon_link).read)
#   browser.goto icon_link
#   icon_html_doc = Nokogiri.parse(browser.body)
#   code = icon_html_doc.search('#page-top > div.view.flex.flex-column.min-vh-100.db-pr > div.flex-grow-1.flex-shrink-0.flex-basis-auto > div > div.ph6-l > div > section > header > div.bn.bb-l.bw2.b--gray1.mb4.pb3-l.flex.flex-column.flex-row-xl.justify-between-xl.items-end-xl.lh-copy > ul.flex.flex-wrap.flex-row-ns.items-center-ns.list.pa0.ma0.mb2.mb0-xl.pb2.pb0-xl.bb.bb-0-xl.bw2.bw1-l.b--gray1 > li.order-9-l.mt2.mt0-l.mr2-l.order-5.w-100.w-auto-l.order-6-l.pt2.pt0-l.bt.bt-0-l.bw1.b--gray1 > code').text
#   if Icon.where(code: code).empty?
#     name = icon_link.split('/')[4].split('?').first
#     family = icon_html_doc.search('#page-top > div.view.flex.flex-column.min-vh-100.db-pr > div.flex-grow-1.flex-shrink-0.flex-basis-auto > div > div.ph6-l > div > section > header > div.bn.bb-l.bw2.b--gray1.mb4.pb3-l.flex.flex-column.flex-row-xl.justify-between-xl.items-end-xl.lh-copy > ul.ma0.list.pa0.flex.flex-column.flex-wrap.flex-row-ns.items-center-ns > li.mb2.mb0-ns.mr2-ns.pb2.pb0-ns.bb.bb-0-ns.bw1.b--gray1 > a').text
#     unless (name == '' || family == '' || code == '')
#         Icon.create(name: name, family: family, code: code)
#         icons_number += 1
#         puts "#{icons_number} icons created"
#     end
#   end
# end

# puts 'DONE'
