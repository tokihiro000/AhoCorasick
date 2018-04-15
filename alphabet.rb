str_map = {}
while str_map.length < 500000
  if str_map.length % 10000 == 0
    puts str_map.length
  end
  str = (0...8).map{ ('A'..'Z').to_a[rand(26)] }.join
  str_map[str] = 0

  tmp_str_list1 = str.scan(/.{1,#{2}}/)
  tmp_str_list1.each do |tmp_str|
    str_map[tmp_str] = 0
  end

  tmp_str_list2 = str.scan(/.{1,#{4}}/)
  tmp_str_list2.each do |tmp_str|
    str_map[tmp_str] = 0
  end
end

str_list = str_map.keys
File.open("alphabet_500000.txt", "w") do |text|
  str_list.each do |str|
    text.puts(str)
  end
end
