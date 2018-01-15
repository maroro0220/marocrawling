class Movie < ActiveRecord::Base
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
