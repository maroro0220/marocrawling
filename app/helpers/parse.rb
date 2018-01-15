module Parse
  class Movie
    def show
      url = "http://movie.naver.com/movie/running/current.nhn?view=list&tab=normal&order=reserve"
      movie_html = RestClient.get(url)
      doc = Nokogiri::HTML(movie_html)
      movie_list=Array.new
      mrank=Array.new
      img_url=Array.new
      movie_hash=Hash.new
      doc.css('ul.lst_detail_t1 li').each do |movie| #ul의 lst클래스에 들어있는 li태그
      movie_title = movie.css('dt a').text
      movie_list << movie_title
      movie_hash[movie_title] = {
      :star => movie.css('dl.info_star span.num').text,
      :url => movie.css('div.thumb img').attribute('src').to_s
      }
      end
      sample_movie = movie_list
      for i in (0..2)
      mrank << sample_movie[i] +" - "+ movie_hash[sample_movie[i]][:star]
      img_url << movie_hash[sample_movie[i]][:url]
      end
      return [mrank, img_url]
    end
  end

  class Music
    def show_melon
      url = "http://www.melon.com/chart/index.htm"
      music_html = RestClient.get(url)
      doc = Nokogiri::HTML(music_html)
      music_list=Array.new
      music_hash=Hash.new
      mu=Array.new
      mi=Array.new
      doc.css('div.service_list_song.type02.d_song_list tbody tr#lst50').each do |music| #ul의 lst클래스에 들어있는 li태그
      mu << music.css('span.rank').text+ "위: " + music.css('div.ellipsis.rank01 a').text.strip + "  - " + music.css('div.ellipsis.rank02 span.checkEllipsis a').text.strip
      mi << music.css('div.wrap a.image_typeAll img').attribute('src').to_s
      end
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
    end
  end
  class Weather
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
          weather_return<< "#{i*3}"+"시 - "+ weather[i]
          # weather_return[i] = "#{i*3}"+"시 - "+ weather[i]
          end
          return weather_return
              # return weather
    end
  end
  class WiseSaying
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



end
