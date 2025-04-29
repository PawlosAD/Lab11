module top(
    input sw,
    input btnC,
    input btnU,
    output [9:0] led
);
   
    onehot oneHotFSM(
        .w(sw),
        .clk(btnC),
        .reset(btnU),
        .z(led[0]),
        .activeState(led[6:2])
    );
   
    binary binaryFSM(
        .w(sw),
        .clk(btnC),
        .reset(btnU),
        .z(led[1]),
        .State(led[9:7])
    );
endmodule
