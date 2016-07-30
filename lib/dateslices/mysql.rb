module Dateslices
  module Mysql

    def self.time_filter(column, field, format=nil)
      case field
        when :hour_of_day
          "(EXTRACT(HOUR from #{column}))"
        when :day_of_week
          "(DAYOFWEEK(#{column}) - 1)"
        when :day_of_month
          "DAYOFMONTH(#{column})"
        when :month_of_year
          "MONTH(#{column})"
        when :second
          format ||= '%Y-%m-%d %H:%i:%S UTC'
          "DATE_FORMAT(#{column}, '#{format}')"
        when :minute
          format ||= '%Y-%m-%d %H:%i:00 UTC'
          "DATE_FORMAT(#{column}, '#{format}')"
        when :hour
          format ||= '%Y-%m-%d %H:00:00 UTC'
          "DATE_FORMAT(#{column}, '#{format}')"
        when :day
          format ||= '%Y-%m-%d 00:00:00 UTC'
          "DATE_FORMAT(#{column}, '#{format}')"
        when :month
          format ||= '%Y-%m-01 00:00:00 UTC'
          "DATE_FORMAT(#{column}, '#{format}')"
        when :year
          format ||= '%Y-01-01 00:00:00 UTC'
          "DATE_FORMAT(#{column}, '#{format}')"
        when :week # Sigh...
          format ||= '%Y-%m-%d 00:00:00 UTC'
          "DATE_FORMAT( date_sub( created_at, interval ((weekday( created_at ) + 1)%7) day ), '#{format}')"
        else
          throw "Unknown time filter #{field}"
      end
    end

  end
end
