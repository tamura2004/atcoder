require "spec"
require "crystal/modint9"

describe ModInt do
  it "+" do
    (1.to_m + 2).should eq 3
    (Int64::MAX.to_m + Int64::MAX).should eq 932051908
  end
  
  it "-" do
    (3.to_m - 2).should eq 1
    (3.to_m - 4).should eq (MOD - 1)
    (Int64::MIN.to_m - Int64::MAX).should eq 66192444
  end
  
  it "*" do
    (Int64::MAX.to_m * Int64::MAX).should eq 141082460
  end
  
  it "//" do
    (56.to_m // 7).should eq 8
    (Int64::MAX.to_m // Int64::MAX).should eq 1
  end
  
  it "**" do
    (2.to_m ** 0).should eq 1
    (2.to_m ** 1000).should eq 23226277
    (2.to_m ** 1000000000).should eq 851104391
    (2.to_m ** Int64::MAX).should eq 649870436
  end

end
