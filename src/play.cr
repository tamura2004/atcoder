module PersistentStack
  class Node(T)
    getter val : T
    getter nex : Node(T)?

    def initialize(@val, @nex)
    end
  end

  class Stack(T)
    getter head : Node(T)?

    def initialize(@head = nil)
    end

    def top
      head.try &.val
    end

    def push(x)
      self.class.new(Node(T).new(x, head))
    end

    def pop
      self.class.new(head.try &.nex)
    end
  end
end

alias PStack = PersistentStack::Stack

st = PStack(Int32).new
st1 = st.push 1
st2 = st1.push 2
st3 = st2.pop

pp st1.top
pp st2.top
pp st3.top
