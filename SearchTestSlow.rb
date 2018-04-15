require_relative './split_str.rb'

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
  count = 0
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

  search_str_list.sort!
  search_time = 0
  str_list.each do |str|
    set = GetStrSet str
    set.each do |search_str|
      t1 = Time.new
      # 愚直線形
      # search_str_list.each do |s|
      #   if s == search_str
      #     break
      #   end
      # end

      # 実装見た感じ多分線形
      # search_str_list.include? search_str

      # 2分探索
      search_str_list.bsearch { |s| search_str <=> s }

      t2 = Time.new
      time = (t2.usec - t1.usec)
      time =  0 > time ? 0 : time
      search_time += time
    end
  end

  puts file_name
  print "平均検索時間:",  (search_time / 1000), "μs\n"
end
