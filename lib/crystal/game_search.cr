# ゲーム木の探索
#
# 次の遷移先を選べないと負けのゲームにおいて
# 状態 root からの勝ち負けを判定する
class GameSearch(T)
  enum Result
    WIN
    LOSE
  end

  getter candidates : Proc(T, Array(T))
  getter memo : Hash(T, Result)

  # 初期化時のブロックで次の状態を返す関数を指定する
  def initialize(&candidates : T -> Array(T))
    @candidates = candidates
    @memo = Hash(T, Result).new
  end

  # 状態 root からの勝ち負けを判定する
  def solve(root)
    dfs(root)
  end
  
  # 探索結果をResult::WIN/LOSEで返す
  # .win? .lose?で判定することを想定
  def dfs(state : T) : Result
    if memo.has_key?(state)
      return memo[state]
    end

    # 遷移先に負けがあれば勝ち
    candidates.call(state).each do |candidate|
      if dfs(candidate) == Result::LOSE
        return memo[state] = Result::WIN
      end
    end
    # すべての遷移先に勝ちがあれば負け
    # (遷移先がなければ負け)
    return memo[state] = Result::LOSE
  end
end
