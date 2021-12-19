require "yaml"

class PivotWithValue
  attr_accessor :col_keys, :row_cols_values, :no_label

  def initialize(col_keys, row_cols_values, no_label = "−")
    @col_keys = col_keys
    @row_cols_values = row_cols_values
    @no_label = no_label
  end

  def create
    row_cols_values.inject([]) do |rows, (row_key, cols_values)|
      rows << col_keys.inject([]) do |row, col_key|
        row << (cols_values[col_key] || no_label)
      end
    end
  end
end

col_keys = %w(a b c d e f)
row_cols_values = YAML.load <<EOS
A:
  b: 1
  c: 2
B:
  e: 1
  f: 2
C:
  f: 1
  b: 2
EOS

pp row_cols_values
pp PivotWithValue.new(col_keys, row_cols_values).create
