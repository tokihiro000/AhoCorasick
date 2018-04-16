require 'set'

def GetExistStr count, file_name
  search_str_list = []
  File.open(file_name) do |file|
    file.each_line do |str|
      str.chomp!
      search_str_list << str
      if search_str_list.length >= count
        break
      end
    end
  end

  return search_str_list
end

def GetRandomStr count, str_length
  str_map = {}
  short_length = str_length / 2
  more_short_length = str_length / 3
  div_ten_count = count / 10
  while str_map.length < count
    if str_map.length % div_ten_count == 0
      puts str_map.length
    end

    str = (0...str_length).map{ ('A'..'Z').to_a[rand(26)] }.join
    str_map[str] = 0

    tmp_str_list1 = str.scan(/.{1,#{more_short_length}}/)
    tmp_str_list1.each do |tmp_str|
      str_map[tmp_str] = 0
    end

    tmp_str_list2 = str.scan(/.{1,#{short_length}}/)
    tmp_str_list2.each do |tmp_str|
      str_map[tmp_str] = 0
    end
  end

  str_list = str_map.keys
  (str_list.length - count).times do |i|
    str_list.shift
  end

  return str_list
end

def GetStrSet const_str
  str = const_str.dup
  set = Set.new
  length = str.length - 1
  while str.length > 0
    length = str.length
    length.times do |i|
      str.scan(/.{1,#{i + 1}}/).each do |s|
        set.add s
      end
    end
    str[0] = ''
  end

  return set
end

if $0 == __FILE__
  set = GetStrSet "abcdefghijklmn"
  list = set.to_a
  list.sort!
  list.each do |str|
    puts str
  end

  str_list = GetRandomStr 100, 12
  p str_list
end
