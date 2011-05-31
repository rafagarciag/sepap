class ActiveRecord::ConnectionAdapters::Column

def self.string_to_date(string)
    return string unless string.is_a?(String)

    begin
        return DateTime.strptime(string, ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS[:default])
    rescue
        date_array = ParseDate.parsedate(string)
        # treat 0000-00-00 as nil
        Date.new(date_array[0], date_array[1], date_array[2]) rescue nil
    end
end

def self.string_to_time(string)
    return string unless string.is_a?(String)

    begin
    if dt=Date._strptime(string,ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS[:default])
        return Time.mktime(*dt.values_at(:year, :mon, :mday, :hour, :min, :sec, :zone, :wday))
    else
        raise "Bad format"
    end
    rescue
        time_hash = Date._parse(string)
        time_hash[:sec_fraction] = microseconds(time_hash)
        time_array = time_hash.values_at(:year, :mon, :mday, :hour, :min, :sec, :sec_fraction)
        # treat 0000-00-00 00:00:00 as nil
        Time.send(ActiveRecord::Base.default_timezone, *time_array) rescue DateTime.new(*time_array[0..5]) rescue nil
    end
end

end

