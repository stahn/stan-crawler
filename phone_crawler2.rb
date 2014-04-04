#require 'open-uri'
#require 'nokogiri'
require 'google_drive'
require './stan_crawler'
#require "#{File.dirname(__FILE__)}/stan_crawler"

session = GoogleDrive.login("smagierski@gmail.com", "StCharles2012")

ws = session.spreadsheet_by_key("1mRd4dYBtsmKef031Fc1uZMP2Vkimks6cAiPXbnsGTNw").worksheets[0]

#ws.num_rows
for row in 2..129

  puts mobile = ws[row,1]
  
  result = case StanCrawler.is_android_ble?(mobile)
   when true then ws[row,5] = "yes"
   when false then ws[row,5] = "no"
  end
  
  ws.save()
  
end
