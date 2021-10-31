require "spec"
require "crystal/tenkaich2014/d/problem"
include Tenkaich2014::D

describe Tenkaich2014::D::Problem do
  it "usage" do
    pp Problem.new(10).solve
  end
end
