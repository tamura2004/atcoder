macro rep(i, n, &block)
  {{i}} = 0
  while {{i}} < {{n}}
    {{block.body}}
    {{i}} += 1
  end
end

macro for(init, cond, inc, &block)
  {{init}}
  while {{cond}}
    {{block.body}}
    {{inc}}
  end
end