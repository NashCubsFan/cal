require Comparable
class Calendar

attr_accessor :year
attr_accessor :month
attr_accessor :dayname

  def initialize(year, month, dayname)
  	@year = year
  	@month = month
  	@dayname = dayname
  end

  def zeller
    march_offset = (month +1)*26/10

  def month_end_day
  	end_day = [nil,31,days_in_feb,31,30,31,30,31,31,30,31,30,31 ]
  	end_day[@month]
  end

  def day_array
    day_array = []
    1.upto(month_end_day) {|i| day_array.push(i.to_s + " ")}
    day_array[0..8].each {|j| j.insert(0," ")}
    day_array.unshift("   ", "   ", "   ", "   ", "   ", "   ") if month_start_day == 0 
    (month_start_day - 1).times {|i| day_array.unshift("   ")}
    day_array
	end

	def week_array
  	week_array = [] 
    week_array = day_array.each_slice(7).to_a
    week_array
	end

  def print_month
  	puts "#{month_name} #{@year}".center(20)
  	puts "Su Mo Tu We Th Fr Sa".center(20)
		week_array[0].each {|i| print i}
  end


  