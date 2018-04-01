$node_count = 0

class Edge
  attr_accessor :char, :before_node, :next_node

  def initialize char, before_node, next_node
    @char = char
    @before_node = before_node
    @next_node = next_node
  end
end

class Node
  attr_accessor :word, :is_root, :node_number
  def initialize
    @node_number = $node_count
    $node_count += 1
    @edge_map = {}
    @word = ""
    @failure_node = nil
    @is_root = false
  end

  def addEdge edge
    char = edge.char
    if @edge_map.has_key? char
      return
    end

    @edge_map[char] = edge
  end

  def getEdge char
    if @edge_map.has_key? char
      return @edge_map[char]
    end

    return nil;
  end

  def getEdges
    return @edge_map.values
  end

  def addFailureNode node
    @failure_node = node
  end

  def failureNode
    return @failure_node
  end

  def printWord
    # print @node_number, ": "
    # getEdges.each do |edge|
    #   print edge.char , ", "
    # end
    # number = @failure_node ? @failure_node.node_number : 0
    # print " failure: ", number
    # puts ""
    #
    if @word != ""
      puts @word
    end


    if @edge_map.empty?
      return
    end

    @edge_map.each_value do |edge|
      if edge.next_node
        edge.next_node.printWord
      end
    end
  end

  def printWord
    # print @node_number, ": "
    # getEdges.each do |edge|
    #   print edge.char , ", "
    # end
    # number = @failure_node ? @failure_node.node_number : 0
    # print " failure: ", number
    # puts ""
    if @word != ""
      puts @word
    end

    if @edge_map.empty?
      return
    end

    @edge_map.each_value do |edge|
      if edge.next_node
        edge.next_node.printWord
      end
    end
  end

  def printDebug
    print @node_number, ": "
    getEdges.each do |edge|
      print edge.char , ", "
    end
    number = @failure_node ? @failure_node.node_number : 0
    print " failure: ", number
    puts ""

    if @edge_map.empty?
      return
    end

    @edge_map.each_value do |edge|
      if edge.next_node
        edge.next_node.printDebug
      end
    end
  end
end

class AhoCorasick
  def initialize (*target_word_list)
    @root_node = Node.new
    @root_node.is_root = true
    target_word_list.each do |word|
      before_node = @root_node
      word.each_char do |character|
        # 前ノードが次の文字へのエッジを持っているか確認
        edge = before_node.getEdge(character)

        # 持っていればそのままそのノードへ、持っていなければノードとエッジを追加
        if edge != nil
          next_node = edge.next_node
        else
          next_node = Node.new
          edge = Edge.new character, before_node, next_node
          before_node.addEdge edge
        end

        before_node = next_node
      end

      # 1ワード分終わったのでノードに対象ワードを設定する
      before_node.word = word
    end
  end

  def bfsFailure
    queue = []
    # ひとまずrootから最初にたどる場所はrootを保存
    @root_node.getEdges.each do |edge|
      edge.next_node.addFailureNode @root_node
      queue << edge.next_node
    end

    while queue.length > 0
      node = queue.shift
      edge_list = node.getEdges

      # 葉ノードなら次へ
      if edge_list.empty?
        next
      end

      edge_list.each do |edge|
        failure_node = node.failureNode
        next_node = edge.next_node
        character = edge.char

        edge2 = nil
        while edge2 == nil
          edge2 = failure_node.getEdge character

          # 探索ノードがルートまで至れば成功失敗関わらず探索終了
          if failure_node.is_root
            break;
          end

          # edge2がnilの場合さらに次の失敗時リンクをたどる
          failure_node = failure_node.failureNode
        end

        # 探索失敗ならルートへリンク、そうでなければ探索結果を保存
        if edge2 == nil
          next_node.addFailureNode @root_node
        else
          next_node.addFailureNode edge2.next_node
        end
        queue << next_node
      end
    end
  end

  def PrintTri
    @root_node.printWord
  end

  def PrintDebug
    @root_node.printDebug
  end
end

ahoCorasick = AhoCorasick.new 'home', 'me', 'ome', 'megane', 'cache'
ahoCorasick.bfsFailure
ahoCorasick.PrintTri
ahoCorasick.PrintDebug