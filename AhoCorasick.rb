require 'json'

$node_count = 0

class Edge
  attr_accessor :char, :before_node, :next_node

  def initialize char, before_node, next_node
    @char = char
    @before_node = before_node
    @next_node = next_node
  end

  def toHash
    data = {
      'char' => @char,
      'before_node' => @before_node.node_number,
      'next_node' => @next_node.node_number
    }

    return data
  end
end

class Node
  attr_accessor :word, :is_root, :node_number
  def initialize node_count
    @node_number = node_count
    @edge_map = {}
    @word = ""
    @failure_node = nil
    @is_root = false
  end

  def toHash
    tmp_hash = {}
    @edge_map.each do |key, value|
      tmp_hash[key] = value.toHash
    end

    data = {
      "id" => @node_number,
      "word" => @word,
      "edge" => tmp_hash,
      "is_root" => @is_root,
      "failure_node" => @failure_node ? @failure_node.node_number : 0
    }

    return data
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
  def initialize
    @root_node = Node.new $node_count
    $node_count += 1
    @root_node.is_root = true
  end

private
  def createTrie word
    before_node = @root_node
    word.each_char do |character|
      # 前ノードが次の文字へのエッジを持っているか確認
      edge = before_node.getEdge(character)

      # 持っていればそのままそのノードへ、持っていなければノードとエッジを追加
      if edge != nil
        next_node = edge.next_node
      else
        next_node = Node.new $node_count
        $node_count += 1
        edge = Edge.new character, before_node, next_node
        before_node.addEdge edge
      end

      before_node = next_node
    end

    # 1ワード分終わったのでノードに対象ワードを設定する
    before_node.word = word
  end

  def createFailure
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

public
  def Build(*target_word_list)
    target_word_list.each do |word|
      createTrie word
    end

    createFailure
  end

  def PrintTri
    @root_node.printWord
  end

  def PrintDebug
    @root_node.printDebug
  end

  def Save
    hash = {}
    hash[@root_node.node_number] = @root_node.toHash

    queue = @root_node.getEdges
    while queue.length > 0
      edge = queue.shift
      node = edge.next_node
      hash[node.node_number] = node.toHash
      node.getEdges.each do |next_edge|
        queue << next_edge
      end
    end

    # str = JSON.pretty_generate(hash)
    open('./text.json', 'w') do |io|
      JSON.dump(hash, io)
    end
  end

  def Load
    json_data = open('./text.json') do |io|
      JSON.load(io)
    end

    json_data["0"]["edge"].each do |char, value|
      next_node = Node.new value["next_node"]
      edge = Edge.new char, @root_node, next_node
      @root_node.addEdge edge
    end

    json_data.delete("0")

    json_data.each do |node_number, value|
      # node = Node.new
      # value["edge"].each do |char, value|
      #   edge = Edge.new char,
      # end

      puts node_number
      p value
    end
  end
end

ahoCorasick = AhoCorasick.new
ahoCorasick.Build 'home', 'me', 'ome', 'megane', 'cache'
ahoCorasick.PrintTri
ahoCorasick.Save
ahoCorasick.Load
