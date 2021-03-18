macro make_array(i, *xs)
  Array.new({{i}}) do
    {% if xs.size >= 2 %}
      Array.new({{xs[0]}}) do
    {% end %}
        {{ xs[1] }}
    {% if xs.size >= 2 %}
      end
    {% end %}
  end
end

a = make_array(3,4,5)
pp! a