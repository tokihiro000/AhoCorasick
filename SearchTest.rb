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

file_name_list.each do |file_name|
  ahoCorasick = AhoCorasick.new
  ahoCorasick.BuildFromFile file_name
  str_list.each do |str|
    str = str.chomp
    ahoCorasick.Search str
  end

  puts file_name
  average_searcht_time = ahoCorasick.GetAverageSearchTime
  print "平均検索時間:", average_searcht_time, "\n"
end
