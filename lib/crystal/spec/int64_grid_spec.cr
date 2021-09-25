require "spec"
require "crystal/int64_grid"

describe Int64Grid do
  it "usage" do
    gr = Int64Grid.new(4,4)
    gr.debug gr.v_fill(gr.dot[0][1])
    gr.debug gr.left[1]
    g = gr.from_2d_array([[1,0,0,0],[0,1,1,1],[0,0,1,1],[0,1,0,1]])
    gr.debug g
    gr.debug gr.move_up(2, g)
    gr.debug gr.move_down(2, g)
    gr.debug gr.move_left(2, g)
    gr.debug gr.move_right(2, g)
    # gr.debug gr.move_up(2, g)
    # gr.debug gr.rot90(g)
    # gr.debug gr.top[1]
    # gr.debug gr.right[1]
    # gr.debug gr.bottom[1]
  end
end
