require "crystal/avl_tree"

st = AVLTree(Int64).new
mini = AVLTree(Int64).new

q = gets.to_s.to_i64
q.times do |count|
  cmd, x = gets.to_s.split.map(&.to_i64) + [0_i64]
  case cmd
  when 1
    if st.includes?(x)
      mini << 0_i64
    else
      left = st.lower(x, eq: false)
      right = st.upper(x, eq: false)
      case {left, right}
      when {Nil, Nil}
      when {Nil, Int64}
        mini << (right ^ x)
      when {Int64, Nil}
        mini << (left ^ x)
      when {Int64, Int64}
        mini.delete right ^ left
        mini << (right ^ x)
        mini << (left ^ x)
      end
    end
    st << x
  when 2
    st.delete x
    if st.includes?(x)
      mini.delete 0_i64
    else
      left = st.lower(x, eq: false)
      right = st.upper(x, eq: false)
      case {left, right}
      when {Nil, Nil}
      when {Nil, Int64}
        mini.delete right ^ x
      when {Int64, Nil}
        mini.delete left ^ x
      when {Int64, Int64}
        mini << (right ^ left)
        mini.delete right ^ x
        mini.delete left ^ x
      end
    end
  when 3
    puts mini.min
  end
  # pp "---"
  # pp! count
  # pp! st
  # pp! mini
end
