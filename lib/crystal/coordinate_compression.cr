def compress(a)
  b = a.sort.uniq
  a.map do |a|
    b.bsearch_index do |b|
      a <= b
    end.not_nil!
  end
end
