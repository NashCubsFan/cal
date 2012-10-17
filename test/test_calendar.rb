require 'test/unit'
require 'calendar'

class CalendarTest < Test::Unit::TestCase
  def test_01_days_in_march
    cal = Calendar.new 3, 2012
    assert_equal(31, cal.month_end_day)
  end

  def test_02_days_in_july
    cal = Calendar.new 7, 2012
    assert_equal(31, cal.month_end_day)
  end

  def test_03a_days_in_january
    cal = Calendar.new 1, 2012
    assert_equal(31, cal.month_end_day)
  end

  def test_03b_days_in_april
    cal = Calendar.new 4, 1996
    assert_equal(30, cal.month_end_day)
  end

  def test_04_day_name
    weekday = 1
    cal = Calendar.new 1, 2012
    assert_equal(cal.week_day_names[weekday], "Sunday")
  end

  def test_05a_month_start_day_of_january_2012_should_be_sunday
    cal = Calendar.new 1, 2012
    assert_equal(1, cal.month_start_day)
  end

  def test_05b_month_start_day_of_march_1996_should_be_friday
    cal = Calendar.new 3, 1996
    assert_equal(6, cal.month_start_day)
  end

  def test_05c_month_start_day_of_december_2027_should_be_wednesday
    cal = Calendar.new 12, 2027
    assert_equal(4, cal.month_start_day)
  end

  def test_06a_day_array_days_of_january_2012_should_be_strings_as_expected
    cal = Calendar.new 1, 2012
    assert_equal(31, cal.day_array.length)
    cal.day_array.each_with_index do |day, i|
      assert_match(/^( |\d)\d $/, day)
    end
  end

  def test_06b_day_array_days_of_april_1996_should_be_strings_as_expected
    cal = Calendar.new 4, 1996
    assert_equal(30, cal.day_array.length)
    cal.day_array.each_with_index do |day, i|
      assert_match(/^( |\d)\d $/, day)
    end
  end

  def test_06b_day_array_days_of_december_2027_should_be_strings_as_expected
    cal = Calendar.new 12, 2027
    assert_equal(31, cal.day_array.length)
    cal.day_array.each_with_index do |day, i|
      assert_match(/^( |\d)\d $/, day)
    end
  end

  def test_07a_padded_day_array_should_not_be_prepended_with_any_entries_if_the_month_starts_on_a_sunday
    cal = Calendar.new 1, 2012
    assert_equal(" 1 ", cal.padded_day_array.first)
  end

  def test_07b_padded_day_array_should_be_prepended_with_5_blank_entries_if_the_month_starts_on_a_friday
    cal = Calendar.new 3, 1996
    5.times do |i|
      assert_equal("   ", cal.padded_day_array[i])
    end
    assert_equal(" 1 ", cal.padded_day_array[5])
  end

  def test_07c_padded_day_array_should_be_prepended_with_3_blank_entries_if_the_month_starts_on_a_wednesday
    cal = Calendar.new 12, 2027
    3.times do |i|
      assert_equal("   ", cal.padded_day_array[i])
    end
    assert_equal(" 1 ", cal.padded_day_array[3])
  end

  def test_08a_week_array_should_have_the_length_of_the_number_of_specified_month_and_year
    cal1 = Calendar.new 1, 2012
    assert_equal(5, cal1.week_array.length)
    cal2 = Calendar.new 3, 1996
    assert_equal(6, cal2.week_array.length)
    cal3 = Calendar.new 2, 2026
    assert_equal(4, cal3.week_array.length)
  end

  def test_09a_header_should_match_textual_name_of_month_and_year
    cal1 = Calendar.new 1, 2012
    assert_match(/January 2012/, cal1.header)
    assert_match(/\n$/, cal1.header)
    cal2 = Calendar.new 3, 1996
    assert_match(/March 1996/, cal2.header)
    assert_match(/\n$/, cal2.header)
    cal3 = Calendar.new 2, 2026
    assert_match(/February 2026/, cal3.header)
    assert_match(/\n$/, cal3.header)
  end
  
  def test_10a_dow_header_should_be_a_list_of_abbreviated_days_of_the_week
    cal1 = Calendar.new 1, 2012
    assert_match(/Su Mo Tu We Th Fr Sa\n/, cal1.dow_header)
    cal2 = Calendar.new 3, 1996
    assert_match(/Su Mo Tu We Th Fr Sa\n/, cal2.dow_header)
    cal3 = Calendar.new 2, 2026
    assert_match(/Su Mo Tu We Th Fr Sa\n/, cal3.dow_header)
  end

  def test_11a_print_month_should_return_a_string_representing_the_entire_month
    cal1 = Calendar.new 1, 2012
    cal1_string =
      "    January 2012    \n" +
      "Su Mo Tu We Th Fr Sa\n" +
      " 1  2  3  4  5  6  7 \n" +
      " 8  9 10 11 12 13 14 \n" +
      "15 16 17 18 19 20 21 \n" +
      "22 23 24 25 26 27 28 \n" +
      "29 30 31 \n"
    assert_equal(cal1_string, cal1.to_s)
    cal2 = Calendar.new 2, 2012
    cal2_string =
      "   February 2012    \n" +
      "Su Mo Tu We Th Fr Sa\n" +
      "          1  2  3  4 \n" +
      " 5  6  7  8  9 10 11 \n" +
      "12 13 14 15 16 17 18 \n" +
      "19 20 21 22 23 24 25 \n" +
      "26 27 28 29 \n"
    assert_equal(cal2_string, cal2.to_s)
    cal3 = Calendar.new 2, 2011
    cal3_string =
      "   February 2011    \n" +
      "Su Mo Tu We Th Fr Sa\n" +
      "       1  2  3  4  5 \n" +
      " 6  7  8  9 10 11 12 \n" +
      "13 14 15 16 17 18 19 \n" +
      "20 21 22 23 24 25 26 \n" +
      "27 28 \n"
    assert_equal(cal3_string, cal3.to_s)
    cal4 = Calendar.new 12, 2027
    cal4_string =
      "   December 2027    \n" +
      "Su Mo Tu We Th Fr Sa\n" +
      "          1  2  3  4 \n" +
      " 5  6  7  8  9 10 11 \n" +
      "12 13 14 15 16 17 18 \n" +
      "19 20 21 22 23 24 25 \n" +
      "26 27 28 29 30 31 \n"
    assert_equal(cal4_string, cal4.to_s)
  end
end
