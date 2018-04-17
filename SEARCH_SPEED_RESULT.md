alphabet_100000.txt
検索時間: 10875マイクロ秒,  検索回数1000
平均検索時間:10
alphabet_500000.txt
検索時間: 13764マイクロ秒,  検索回数1000
平均検索時間:13
alphabet_1000000.txt
検索時間: 13303マイクロ秒,  検索回数1000
平均検索時間:13

array.include?
now_count: 100000
alphabet_100000.txt
平均検索時間:116728μs

alphabet_500000.txt
平均検索時間: 560628μs

alphabet_1000000.txt
平均検索時間: 1111877μs

search_str_list.bsearch { |s| search_str <=> s }
now_count: 100000
alphabet_100000.txt
平均検索時間:59μs
alphabet_500000.txt
平均検索時間:72μs
alphabet_1000000.txt
平均検索時間:81μs

# 見つかるパターン
AhoCorasick
alphabet_100000.txt
検索時間: 7252マイクロ秒,  検索回数1000
平均検索時間:7
alphabet_500000.txt
検索時間: 7329マイクロ秒,  検索回数1000
平均検索時間:7
alphabet_1000000.txt
検索時間: 9104マイクロ秒,  検索回数1000
平均検索時間:9

search_str_list.bsearch { |s| search_str <=> s }
now_count: 100000
alphabet_100000.txt
平均検索時間: 27μs
alphabet_500000.txt
平均検索時間: 40μs
alphabet_1000000.txt
平均検索時間: 46μs

array.include?
alphabet_100000.txt
平均検索時間: 42090μs
alphabet_500000.txt
平均検索時間: 248756μs
alphabet_1000000.txt
平均検索時間: 515380μs

# 入力文字列が長いパターン
200文字
AhoCorasick
alphabet_100000.txt
検索時間: 66169マイクロ秒,  検索回数100
平均検索時間:661

alphabet_500000.txt
検索時間: 58888マイクロ秒,  検索回数100
平均検索時間:588

alphabet_1000000.txt
検索時間: 24606マイクロ秒,  検索回数100
平均検索時間:246

2分探索
alphabet_100000.txt
平均検索時間: 1256μs

alphabet_500000.txt
平均検索時間: 1400μs

alphabet_1000000.txt
平均検索時間: 1455μs
