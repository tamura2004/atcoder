require "spec"
require "crystal/abc258"
include Abc258

describe Abc258::F do
  it "usage" do
    f = F.new(100i64, 10i64)

    f.pos(40 + 30.i).should eq P::Other
    f.pos(100 + 30.i).should eq P::Tate
    f.pos(40 + 100.i).should eq P::Yoko
    f.pos(100 + 100.i).should eq P::Cross
    f.pos(0 + 0.i).should eq P::Cross
    f.pos(10 + 0.i).should eq P::Yoko

    z = 40 + 30.i
    f.street(z, D::Up).should eq 40 + 100.i
    f.street(z, D::Down).should eq 40 + 0.i
    f.street(z, D::Right).should eq 100 + 30.i
    f.street(z, D::Left).should eq 0 + 30.i

    z = 100 + 30.i
    f.street(z, D::Up).should eq 100 + 100.i
    f.street(z, D::Down).should eq 100 + 0.i
    f.street(z, D::Right).should eq 100 + 30.i
    f.street(z, D::Left).should eq 100 + 30.i

    f.streets(40 + 30.i).should eq [
      {40 + 100.i, 700},
      {40 + 0.i, 300},
      {100 + 30.i, 600},
      {0 + 30.i, 400},
    ]

    f.streets(0 + 0.i).should eq [
      {0 + 0.i, 0},
    ]

    f.streets(10 + 0.i).should eq [
      {10 + 0.i, 0},
    ]

    f.crosses(40 + 100.i).should eq [
      {100 + 100.i, 60},
      {0 + 100.i, 40},
    ]

    f.crosses(100 + 10.i).should eq [
      {100 + 100.i, 90},
      {100 + 0.i, 10},
    ]

    f.crosses(10 + 10.i).should eq [] of {C, Int64}

    f.dist(40+40.i,50+50.i).should eq 200
    f.dist(40+40.i,150+50.i).should eq 1010
    f.dist_between_street(100+40.i,100+50.i).should eq 10
    f.dist(60+40.i,150+50.i).should eq 910
  end
end
