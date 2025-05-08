// Parameterizable D flip flop module with synchronous clocking and asynchronous reset behavior
module dff(
    input D, // Data input that'll be latched on rising edge of clk
    input clk, // Clock input that triggers data capture on rising edge
    input rst, // Asynchronous reset that sets Q to default immediately on rising edge
    input Default, // Default value for Q at reset and initialiation
    output reg Q // Output register hodling current state
);

    // Initialie Q to Default when module's first instantiated
    initial begin
        Q = Default;
    end

    // Always block that's sensitive to rising edge of either clk or rst
    always @(posedge clk or posedge rst) begin
        if (rst)
            Q <= Default; // Asynchronous reset(set Q to default immediately on reset).
        else
            Q <= D; // Caputre D on rising edge of clk otherwise.
    end
endmodule
