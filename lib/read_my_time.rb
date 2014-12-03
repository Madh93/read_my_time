class Numeric

  def seconds_in_words(opts = {})
    seconds_int = self.to_i

    return '' if seconds_int <= 0

    # options by default
    opts[:skip_seconds] = true if opts[:skip_seconds].nil?

    {
      seconds: 60,
        minutes: 60,
        hours:   24,
        days:    365
    }.inject([]) do |s, (unit_time, divider)|

      if seconds_int > 0
        seconds_int, rest = seconds_int.divmod(divider)

        if rest.nonzero? && !(unit_time == :seconds && opts[:skip_seconds])
          s.unshift("#{rest} #{unit_time}")
        end
      end
      s
    end.join(' ')

  end

end
