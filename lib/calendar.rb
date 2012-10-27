class Calendar
	attr_reader :month
	attr_reader :year

  def initialize(month, year)
		@month = month
		@year = year
  end

  def week_day_names
  	["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
  end

  def month_name
  	month_list = [nil,"January","February","March","April","May","June","July","August","September","October","November","December"]
  	month_list[month]
  end

  def month_start_day
  	if @month == 1 || @month == 2
      year = @year - 1
      month = @month + 12
    else 
      month = @month
      year = @year
    end
  	day_of_month = 1
    march_offset = ((month + 1) * 26/10).floor
    leap_year_offset = (year/4).floor + 6*(year/100).floor + (year/400).floor     
  	day_of_week = (day_of_month + march_offset + year + leap_year_offset).modulo(7)
  end

  def is_leap_year?
    if @year % 400 == 0
      return true
    elsif @year % 100 == 0      
      return false
    elsif @year % 4 == 0
      return true
    else  
      return false
    end
  end

  def days_in_feb
  	if is_leap_year?
  		return 29
  	else
  		return 28
  	end
  end

  def month_end_day
  	end_day = [nil,31,days_in_feb,31,30,31,30,31,31,30,31,30,31 ]
  	end_day[@month]
  end

  def day_array
    days = []
    month_end_day.times do |i|
    	days << sprintf("%2d ", i + 1)
    en
    days
	end

	def padded_day_array
		pda = day_array
		(month_start_day - 1).times do |i|
			pda.unshift "   "
		end
		pda
	end

	def week_array
    padded_day_array.each_slice(7).to_a
	end

	def header
		"#{month_name} #{@year}".center(20) + "\n"
	end

	def dow_header
		"Su Mo Tu We Th Fr Sa\n"
	end

  def to_s
  	str = ""
  	str << header
  	str << dow_header
		week_array.each do |week|
			str << week.join(' ') + "\n"
		end
		str
  end

end

Shoes.app :title => " 2012 Calendar", :width =>510, :height =>400, do
 flow :width => 510, :margin => 10 do
      %w(Jan Feb Mar Apr May June July Aug Sept Oct Nov Dec).each do |btn|
        button btn, :width => 150, :height => 80 do
          method = case btn
            when 'Jan'; alert Calendar.new(1,2012)
            when 'Feb'; alert Calendar.new(2,1012)
            when 'Mar'; alert Calendar.new(3,2012)
            when 'Apr'; alert Calendar.new(4,2012)
            when 'May'; alert Calendar.new(5,2012)
            when 'June'; alert Calendar.new(6,2012)
            when 'July'; alert Calendar.new(7,2012)
            when 'Aug'; alert Calendar.new(8,2012)
            when 'Sept'; alert Calendar.new(9,2012)
            when 'Oct'; alert Calendar.new(10,2012)
            when 'Nov'; alert Calendar.new(11,2012)
            when 'Dec'; alert Calendar.new(12,2012)
          end
        end
    end
  end
end
end


