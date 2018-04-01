class Edge
  attr_accessor :char, :before_node, :next_node

  def initialize char, before_node, next_node
    @char = char
    @before_node = before_node
    @next_node = next_node
  end
end

class Node
  attr_accessor :word
  def initialize
    @edge_map = {}
    @word = ""
  end

  def setWord word
    @word = word
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

  def printWord
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
end

class TriTree
  def initialize (*target_word_list)
    @root_node = Node.new
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
      before_node.setWord word
    end
  end

  def PrintTri
    @root_node.printWord
  end
end
# node = Node.new

tri = TriTree.new 'ho', 'home', 'hogehoge', 'moge', 'fuga'
tri.PrintTri
