require "calendar"

Shoes.app :title => "Calendar Inputs", :width =>500, :height =>500 do
    alert Calendar.new(@month,@year)
 end

