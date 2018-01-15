class Weather < ActiveRecord::Base
  def show

    url = "https://search.daum.net/search?w=tot&DA=Z8T&q=%EA%B0%95%EB%82%A8%EA%B5%AC%20%EB%82%A0%EC%94%A8&rtmaxcoll=Z8T"
    weather_html = RestClient.get(url)
    doc = Nokogiri::HTML(weather_html)
    weather=Array.new
    weather_return=Array.new
    doc.css('tr.type_temp td').each do |w| #ul의 lst클래스에 들어있는 li태그
    weather << w.css('span.ico_ws').text + " - " +w.css('span')[1].text+w.css('span.screen_out').text

    end
    #
    for i in (0..7)
    weather_return << "#{i*3}"+"시 - "+ weather[i]
    # weather_return[i] = "#{i*3}"+"시 - "+ weather[i]
    end
    return weather_return
    # return weather
  end
end
