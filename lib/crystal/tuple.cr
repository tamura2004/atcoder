struct Tuple
  {% for op in %w(+ - * //) %}
    def {{op.id}}(other : Tuple)
      \{% begin %}
        Tuple.new(
          \{% for i in 0...@type.size %}
            self[\{{i}}] {{op.id}} other[\{{i}}],
          \{% end %}
        )
      \{% end %}
    end
  {% end %}
end