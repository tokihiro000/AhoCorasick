require_relative './AhoCorasick.rb'

str_map = {}
while str_map.length < 1000
  if str_map.length % 1000 == 0
    puts str_map.length
  end
  str = (0...12).map{ ('A'..'Z').to_a[rand(26)] }.join
  str_map[str] = 0

  tmp_str_list1 = str.scan(/.{1,#{4}}/)
  tmp_str_list1.each do |tmp_str|
    str_map[tmp_str] = 0
  end

  tmp_str_list2 = str.scan(/.{1,#{6}}/)
  tmp_str_list2.each do |tmp_str|
    str_map[tmp_str] = 0
  end
end

str_list = str_map.keys
(str_list.length - 1000).times do |i|
  str_list.shift
end

file_name_list = [
  'alphabet_100000.txt',
  'alphabet_500000.txt',
  'alphabet_1000000.txt'
]

search_str_list = []
file_name_list.each do |file_name|
  File.open(file_name) do |file|
    file.each_line do |str|
      count += 1
      if count % 100000 == 0
        print "now_count: ", count, "\n"
      end
      str.chomp!
      search_str_list << str
    end
  end

  str_list.each do |str|
    if search_str_list.include? str
      puts str
    end
  end

  puts file_name
  print "平均検索時間:\n"
end
