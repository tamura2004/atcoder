require "crystal/priority_queue"

# 削除可能プライオリティキュー
# 注意！削除する値をチェックしていない
class DeletablePriorityQueue(T)
  getter pq : PriorityQueue(T) # ストアする値を管理
  getter dq : PriorityQueue(T) # 削除する値を管理

  delegate "<<", to: pq

  def self.lesser
    new { |a,b| a > b }
  end

  def self.greater
    new { |a,b| a < b }
  end

  def initialize(&block : T, T -> Bool)
    @pq = PriorityQueue(T).new(&block)
    @dq = PriorityQueue(T).new(&block)
  end

  def size
    pq.size - dq.size
  end

  def empty?
    pq.size == dq.size
  end

  def delete(v : T)
    dq << v
  end

  def pop : T
    clear
    pq.pop
  end
  
  def [](i)
    clear
    pq[i]
  end
  
  # 遅延削除
  private def clear
    while pq.size > 0 && dq.size > 0 && pq[0] == dq[0]
      pq.pop
      dq.pop
    end
  end
end

alias DPQ = DeletablePriorityQueue