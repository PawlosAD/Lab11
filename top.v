// Top level module that integrates one hot and binary encoded state machine modules
module top(
    input sw, // control input(w) shared between both FSMs
    input btnC, // clock input
    input btnU, // Asynchronous reset input
    output [9:0] led // 10 bit output vector mapped to LEDs
);
   
    onehot oneHotFSM(
        .w(sw),
        .clk(btnC),
        .reset(btnU),
        .z(led[0]),
        .activeState(led[6:2]) // Active state bits from onehot FSM(5 bit one hot state)
    );
   
    binary binaryFSM(
        .w(sw),
        .clk(btnC),
        .reset(btnU),
        .z(led[1]),
        .State(led[9:7]) // State bits from binary FSM
    );
endmodule
