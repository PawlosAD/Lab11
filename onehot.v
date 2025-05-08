// This is a sequential staet machine thats implemented with one hot encoding where onle one state bit is 1 at any given time and others remain 0.
// The state encoding using 5 D flip flops with one per state. The initial active state is state[0] (A) with Default = 1;, and others start at 0.
module onehot(
    input w, // Control input that's used to determine state transitions.
    input clk, // Clock input that triggers state transitoins on rising edge
    input reset, // Forces machine to initial state immediately
    output z, // Output signal that indicates when state C or E would be active.
    output [4:0] activeState // One hot encoded vector that shows currently active state.
);
    wire [4:0] state_next; // Next state values that's based on current state and the input w
    wire [4:0] state; // Current state values that's from D flip flops.

    // Instantiate five D flip flops for states A-E
    // Each flip flop latches its corresponding bit from state_next on clk's rising edge or resets to Default on reset
    dff A_ff(.D(state_next[0]), .clk(clk), .rst(reset), .Default(1'b1), .Q(state[0])); // The initial state A = 1.
    dff B_ff(.D(state_next[1]), .clk(clk), .rst(reset), .Default(1'b0), .Q(state[1]));
    dff C_ff(.D(state_next[2]), .clk(clk), .rst(reset), .Default(1'b0), .Q(state[2]));
    dff D_ff(.D(state_next[3]), .clk(clk), .rst(reset), .Default(1'b0), .Q(state[3]));
    dff E_ff(.D(state_next[4]), .clk(clk), .rst(reset), .Default(1'b0), .Q(state[4]));

    assign state_next[0] = 1'b0; // State A never reactivates directly after initialiation.

    // Move to state B if-
    //    - Currently in State A and w = 0
    //    - Currently in State D and w = 0
    //    - Currently in State E and w = 0
    assign state_next[1] = (state[0] & ~w) |
                           (state[3] & ~w) |
                           (state[4] & ~w);
    // Move to state C if-
    //    - Currently in State B and w = 0
    //    - Stay in state C if w = 0
    assign state_next[2] = (state[1] & ~w) |
                           (state[2] & ~w);

    // Move to staet D if-
    //    - Currently in State A, B, or C and w = 1
    assign state_next[3] = (state[0] & w) |
                           (state[1] & w) |
                           (state[2] & w);

    // Move to staet E if-
    //    - Currently in State D or E and w = 1
    assign state_next[4] = (state[3] & w) |
                           (state[4] & w);

    // output z that's asserted when state C(state[2] or state E (state[4]) is active
    assign z = state[2] | state[4];

    // Output activeState that mirrors current state vector
    assign activeState = state;
endmodule
