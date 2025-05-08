// 3 bit FSM with synchronous reset that takes a single bit input(w), a clock signal(clk), and a synchronous reset signal(reset).
// FSM transitions between 8 possible states, so 3 bits, based on w and current state.
// Outputs current state(3 bits) as State and an output signal z based on state dependent logic.
module binary(
    input w, // single bit input signal
    input clk, // clock input for synchronous operations
    input reset, // synchronous reset signal (active high)
    output z, // Output signal that's driven by state conditions
    output [2:0] State // 3 bit output representing current state
);
    wire [2:0] Next; // internal wire that holds next state values computed combinationally.

    // Instantiate 3 d flip flops with one per state bit with synchronous reset and a default reset value of 0.
    dff ff0(.D(Next[0]), .clk(clk), .rst(reset), .Default(1'b0), .Q(State[0]));
    dff ff1(.D(Next[1]), .clk(clk), .rst(reset), .Default(1'b0), .Q(State[1]));
    dff ff2(.D(Next[2]), .clk(clk), .rst(reset), .Default(1'b0), .Q(State[2]));

    /*
    * Combinational logic for Next State- Next[0]
    * Computes next value for State[0] based on:
    *    -current state values such as: (State[2], State[1], State[0]
    *    - input w
    */
    assign Next[0] = (~State[2] & ~State[1] & ~State[0] & ~w) |
                     (~State[2] & ~State[1] & ~State[0] & w)  |
                     (~State[2] & State[1] & ~State[0] & w)  |
                     (~State[2] & ~State[1] & State[0] & w) |
                     (State[2] & ~State[1] & ~State[0] & ~w) |
                     (~State[2] & State[1] & State[0] & ~w);

    /*
    * Combinational logic for Next State- Next[1]
    * Computes next value for State[1] with similar logic conditions
    */
    assign Next[1] = (~State[2] & ~State[1] & State[0] & ~w) |
                     (~State[2] & State[1] & ~State[0] & ~w) |
                     (~State[2] & ~State[1] & ~State[0] & w) |
                     (~State[2] & ~State[1] & State[0] & w) |
                     (~State[2] & State[1] & ~State[0] & w);
    
   /* 
   * Combinational logic for Next State - Next[2]
   * Computes next values for State[2] with transition rules.
   */
    assign Next[2] = (~State[2] & State[1] & State[0] & w) |
                     (State[2] & ~State[1] & ~State[0] & w);

    /*
    * Output logic for z
    * Generates output z based on specific combinations of state bits
    *     When the State is 010: (State[2] = 0, State[1] = 1, State[0] = 0)
    *     When the State is 100: (State[2] = 1, State[1] = 0, State[0] = 0)
    */
    assign z = (~State[2] & State[1] & ~State[0]) |
               (State[2] & ~State[1] & ~State[0]);
endmodule
