require 'open-uri'
require 'nokogiri'

module StanCrawler
  
  def StanCrawler.is_android_ble?(mobile)
    doc = Nokogiri::HTML(open("http://www.google.pl/search?q="+mobile.gsub(/ /,"%20")+"%20gsmarena",'User-Agent' => 'Ruby'))

    url = doc.css("#search a").first.attributes["href"].value
    url = url.gsub("/url?q=","")
    url = url.scan(/[a-zA-Z0-9\-\_\/\.:]*&/)[0].gsub(/&/,"")

    doc2 = Nokogiri::HTML(open(url))

    output = {}

    doc2.css("#specs-list tr").each {|w|

      begin
          spec = w.css(".ttl a").children.first.content

          case spec
          when "Bluetooth"
            # puts w.css(".nfo").children.first.content
            if w.css(".nfo").children.first.content.match(/Yes/) and w.css(".nfo").children.first.content.match(/4.0/)
              output['ble'] = "yes"
            else
              output['ble'] ="no"
            end
          when "OS"
            # puts w.css(".nfo").children.first.content
            if w.css(".nfo").children.first.content.match(/4.[3-4]/)
              output['iBeacons'] = "yes"
            else
              output['iBeacons'] = "no"
            end
          end
      rescue
        next
      end
    }
    
      if output["ble"]==="yes" and output['iBeacons']==="yes"
        return true
      elsif output.count===2
        return false
      else
        return nil
      
  end
    
end
end