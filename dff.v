module dff(
    input D,
    input clk,
    input rst,
    input Default,
    output reg Q
);

    initial begin
        Q = Default;
    end
   
    always @(posedge clk or posedge rst) begin
        if (rst)
            Q <= Default;
        else
            Q <= D;
    end
endmodule
