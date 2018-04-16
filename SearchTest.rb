require_relative './AhoCorasick.rb'
require_relative './strutil.rb'

file_name_list = [
  'alphabet_100000.txt',
  'alphabet_500000.txt',
  'alphabet_1000000.txt'
]


file_name_list.each do |file_name|
  # ランダムな文字列生成
  # str_list = GetRandomStr 1000, 12
  # 見つかることが確定している文字列
  str_list = GetExistStr 1000, file_name
  
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
