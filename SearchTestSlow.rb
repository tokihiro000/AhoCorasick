require_relative './strutil.rb'

file_name_list = [
  'alphabet_100000.txt',
  'alphabet_500000.txt',
  'alphabet_1000000.txt'
]

search_str_list = []
file_name_list.each do |file_name|
  # ランダムな文字列生成
  # str_list = GetRandomStr 1000, 12
  # 見つかることが確定している文字列
  str_list = GetExistStr 1000, file_name

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
  print "平均検索時間: ",  (search_time / 1000), "μs\n"
end
