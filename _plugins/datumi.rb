require 'date'

module Jekyll
module SolskoLeto
    def solsko_leto(datum)
        if datum.mon >= 8 then
            leto = datum.year
        else
            leto = (datum.year - 1)
        end
        return leto.to_s[2..-1] + "_" + (leto + 1).to_s[2..-1]
    end

    def solsko_leto_polno(datum)
        if datum.mon >= 8 then
            leto = datum.year
        else
            leto = (datum.year - 1)
        end
        return leto.to_s + " / " + (leto + 1).to_s
    end

    def trenutno_solsko_leto(x)
        solsko_leto(Time.now)
    end

    def trenutno_solsko_leto_polno(x)
        solsko_leto_polno(Time.now)
    end
end

class SolskoLetoGenerator
    include SolskoLeto
end

module FiltriranjeDatumov
    def samo_pretekli_dogodki(posts)
        # prirejeno po https://stackoverflow.com/questions/60886745/liquid-filter-by-date-jekyll
        now = DateTime.now
        today = DateTime.new(now.year, now.month, now.day, 0, 0, 0, now.zone)
    
        posts.select do |post|
            postedOn = post.data['datum'].to_datetime
            if postedOn < today
                post
            end
        end
    end

    def samo_dogodki_v_letosnjem_solskem_letu(posts)
        # prirejeno po https://stackoverflow.com/questions/60886745/liquid-filter-by-date-jekyll
        sl = SolskoLetoGenerator.new
        posts.select do |post|
            if sl.solsko_leto(post.data['datum'].to_datetime) == sl.trenutno_solsko_leto("")
                post
            end
        end
    end
end
end
  
Liquid::Template.register_filter(Jekyll::SolskoLeto)
Liquid::Template.register_filter(Jekyll::FiltriranjeDatumov)