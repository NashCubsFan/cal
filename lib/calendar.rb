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
    end
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
			str << week.join('') + "\n"
		end
		str
  end
end