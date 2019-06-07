require "icon_scraper"

starting_url = "https://www2.bmcc.nsw.gov.au/DATracking/Pages/XC.Track/SearchApplication.aspx"

agent = Mechanize.new

doc = agent.get(starting_url)
form = doc.forms.first
button = form.button_with(value: "I Agree")
raise "Can't find agree button" if button.nil?
doc = form.submit(button)

IconScraper.rest_xml(starting_url, "d=last14days&k=LodgementDate&o=xml", false, agent)
