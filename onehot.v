module onehot(
    input w,
    input clk,
    input reset,
    output z,
    output [4:0] activeState
);
    wire [4:0] state_next;
    wire [4:0] state;
   
    dff A_ff(.D(state_next[0]), .clk(clk), .rst(reset), .Default(1'b1), .Q(state[0]));
    dff B_ff(.D(state_next[1]), .clk(clk), .rst(reset), .Default(1'b0), .Q(state[1]));
    dff C_ff(.D(state_next[2]), .clk(clk), .rst(reset), .Default(1'b0), .Q(state[2]));
    dff D_ff(.D(state_next[3]), .clk(clk), .rst(reset), .Default(1'b0), .Q(state[3]));
    dff E_ff(.D(state_next[4]), .clk(clk), .rst(reset), .Default(1'b0), .Q(state[4]));
   
    assign state_next[0] = 1'b0;
   
    assign state_next[1] = (state[0] & ~w) |
                           (state[3] & ~w) |
                           (state[4] & ~w);
   
    assign state_next[2] = (state[1] & ~w) |
                           (state[2] & ~w);
   
    assign state_next[3] = (state[0] & w) |
                           (state[1] & w) |
                           (state[2] & w);
   
    assign state_next[4] = (state[3] & w) |
                           (state[4] & w);
   
    assign z = state[2] | state[4];
   
    assign activeState = state;
endmodule
