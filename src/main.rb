class Node
  attr_reader :value, :nex

  def initialize(value, nex)
    @value = value
    @nex = nex
  end
end

class Stack
  attr_reader :head

  def initialize(head = nil)
    @head = head
  end

  def top
    head.value
  end

  def push(x)
    Stack.new(Node.new(x, head))
  end

  def pop
    Stack.new(head.nex)
  end
end

st = Stack.new
st1 = st.push 1
st2 = st1.push 2
st3 = st2.pop

pp st1.top
pp st2.top
pp st3.top
