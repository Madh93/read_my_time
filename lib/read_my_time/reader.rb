module ReadMyTime
  module Reader

    def seconds_in_words(opts = {})
      seconds_int = self.to_i

      return '' if seconds_int <= 0

      # options by default
      opts[:skip_seconds] = false if opts[:skip_seconds].nil?

      unit_time_dividers.each_with_object([]) do |(unit_time, divider), s|

        if seconds_int > 0
          seconds_int, rest = seconds_int.divmod(divider)

          if rest.nonzero? && !(unit_time == :seconds && opts[:skip_seconds])
            word = I18n.t(unit_time.to_s, count: rest, scope: locale_prefix)
            s.unshift("#{rest} #{word}")
          end
        end
        s
      end.join(' ')

    end

    # Used to localize
    def locale_prefix
      'read_my_time'
    end

    def unit_time_dividers
      {
        seconds: 60,
        minutes: 60,
        hours:   24,
        days:    365
      }
    end

  end
end
