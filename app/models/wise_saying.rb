class WiseSaying < ActiveRecord::Base
  def show
    url = "https://search.naver.com/search.naver?where=nexearch&sm=tab_etc&mra=blMy&query=%EC%9D%B8%EC%83%9D%20%EB%AA%85%EC%96%B8"
    word_html = RestClient.get(url)
    doc = Nokogiri::HTML(word_html)
    w=Array.new
    ws=Hash.new
    doc.css('ul.wise_sy._wrap_content div.viewlst').each do |word| #ul의 lst클래스에 들어있는 li태그
      # w << word.css('p.lngkr').text + "  \n\n   -"+word.css('h4.blind').text+"-"
      w << word.css('p.lngkr').text
      ws[word.css('p.lngkr').text]="-"+word.css('h4.blind').text+"-"
    end
    said = w.sample(1)[0]
    return [said, ws]
  end
end
