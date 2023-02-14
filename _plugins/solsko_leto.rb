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
end
  
Liquid::Template.register_filter(Jekyll::SolskoLeto)