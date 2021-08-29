enum State
  ZERO
  EDGE
  FREE
end

State.each do |state|
  pp state
  pp state == State::ZERO
  pp state.value
end

