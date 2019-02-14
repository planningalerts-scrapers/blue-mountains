# require 'scraperwiki'
require 'mechanize'

require File.dirname(__FILE__) + '/lib_icon_rest_xml/scraper'

starting_url = "https://www2.bmcc.nsw.gov.au/DATracking/Pages/XC.Track/SearchApplication.aspx"

case ENV['MORPH_PERIOD']
  when 'lastmonth'
  	period = "lastmonth"
  when 'thismonth'
  	period = "thismonth"
  when
    period = "thisweek"
  else
    period = "last14days"

end
puts "Getting data in `" + period + "`, changable via MORPH_PERIOD environment"

agent = Mechanize.new

doc = agent.get(starting_url)
form = doc.forms.first
button = form.button_with(value: "I Agree")
raise "Can't find agree button" if button.nil?
doc = form.submit(button)

scrape_icon_rest_xml(starting_url, "d=" + period + "&k=LodgementDate&o=xml", false, agent)
