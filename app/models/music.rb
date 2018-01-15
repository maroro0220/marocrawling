class Music < ActiveRecord::Base
  def show_melon
    url = "http://www.melon.com/chart/index.htm"
    music_html = RestClient.get(url)
    doc = Nokogiri::HTML(music_html)
    music_list=Array.new
    music_hash=Hash.new
    mu=Array.new
    mi=Array.new
    doc.css('div.service_list_song.type02.d_song_list tbody tr#lst50').each do |music| #ul의 lst클래스에 들어있는 li태그
    mu << music.css('span.rank').text+ "위: " + music.css('div.ellipsis.rank01 a').text.strip + "  - " + music.css('div.ellipsis.rank02 a').text.strip
    mi << music.css('div.wrap a.image_typeAll img').attribute('src').to_s
    end
    # puts "melon"
    # for i in (0..2)
    # music_rank = mu[i]
    # music_img=mi[i]
    # puts music_rank
    # end
      return [mu, mi]
  end
  def show_bugs
    url = "https://music.bugs.co.kr/chart/track/realtime/total?wl_ref=M_contents_03_01"
    music_html = RestClient.get(url)
    doc = Nokogiri::HTML(music_html)
    mu2=Array.new
    mi2=Array.new

    doc.css('table.list.trackList.byChart tbody tr').each do |music2| #ul의 lst클래스에 들어있는 li태그
    mu2 << music2.css('div.ranking strong').text.strip+ "위: " + music2.css('p.title a').text.strip + "  - " + music2.css('p.artist a').text.strip
    mi2 << music2.css('a.thumbnail img').attribute('src').to_s
    end
        return [mu2, mi2]
    # p "bugs"
    # for i in (0..2)
    # music_rank = mu2[i]
    # music_img=mi2[i]
    # puts music_rank
    # end
   end
   def show_genie
    url = "http://www.genie.co.kr/chart/top100"
    music_html = RestClient.get(url)
    doc = Nokogiri::HTML(music_html)
    mu3=Array.new
    mi3=Array.new
    doc.css('table.list-wrap tr.list').each do |music3| #ul의 lst클래스에 들어있는 li태그
    mu3 << music3.css('td.number').text.strip[0]+ "위: " + music3.css('td.info a.title.ellipsis').text.strip + "  - " + music3.css('td.info a.artist.ellipsis').text.strip
    mi3 << music3.css('a.cover img').attribute('src').to_s
  end
  return [mu3, mi3]
    # p "genie"
    # for i in (0..2)
    # music_rank = mu3[i]
    # music_img=mi3[i]
    # puts music_rank
    # end
  end
  end
end
