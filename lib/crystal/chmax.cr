macro chmax(target, other)
  ({{target}}) = ({{other}}) if ({{target}}) < ({{other}})
end

macro chmin(target, other)
  ({{target}}) = ({{other}}) if ({{target}}) > ({{other}})
end
