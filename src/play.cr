s = "33325252533325252525333"

s.scan(/(25)+/) do |md|
  pp md[0]?
end