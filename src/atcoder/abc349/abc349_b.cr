s = gets.to_s.chars.tally
yesno s.values.tally.values.all?(&.== 2)