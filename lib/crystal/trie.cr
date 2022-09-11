# トライ木
#
class Trie(T)
  A = 27

  # 文字ごとのノード
  class Node(T)
    getter size : Int32                  # 文字列の個数
    getter val : T?                      # 文字のID（終端チェック兼ねる）
    getter ch : StaticArray(Node(T)?, A) # 子ノードへのリンク

    def initialize
      @ch = StaticArray(Node(T)?, A).new(nil)
      @size = 0
      @val = nil.as(T?)
    end

    # 文字列sの接尾辞（長さi）に値vを代入
    def []=(s, i, v)
      @size += 1
      i.zero? && (@val = v) && return

      c = ordnum s[-i]
      now = (ch[c] = ch[c] || Node(T).new)
      now[s, i - 1] = v
    end

    # 文字列sの値vを取得
    def [](s, i)
      i.zero? && return @val

      c = ordnum s[-i]
      ch[c].try &.[s, i - 1]
    end

    # 文字列が含まれるか
    def includes?(s, i)
      i.zero? && return !!val

      c = ordnum s[-i]
      ch[c].try &.includes?(s, i - 1)
    end

    # 接頭辞が一致する文字列数
    def count(s, i)
      i.zero? && return size

      c = ordnum s[-i]
      ch[c].try &.count(s, i - 1)
    end

    # 登録文字列の削除
    def delete(s, i)
      @size -= 1
      i.zero? && (tmp = @val; @val = nil; return tmp)

      c = ordnum s[-i]
      ch[c].try &.delete(s, i - 1)
    end

    # 文字の番号 'a' := 0
    @[AlwaysInline]
    def ordnum(c : Char)
      c.ord - 'a'.ord
    end
  end

  getter root : Node(T)

  def initialize
    @root = Node(T).new
  end

  # 値の設定
  def []=(s, v)
    root[s, s.size] = v
  end

  # 文字列の追加（値は1i64）
  def add(s)
    root[s, s.size] = 1_i64
  end

  # 値の取得
  def [](s)
    root[s, s.size]
  end

  # 文字列が含まれるか
  def includes?(s)
    root.includes?(s, s.size)
  end

  # 接頭辞がsに一致する個数
  def count(s)
    root.count(s, s.size)
  end

  # 文字列を削除
  def delete(s)
    return nil if root[s, s.size].nil?

    root.delete(s, s.size)
  end
end
