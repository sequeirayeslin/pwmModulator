
module pwmModulator (
    input [15:0] data,
    input [5:0] bit_length,
    input data_ready,
    input clk,
    output reg out,
    output reg send_data
);

    reg [15:0] data_buffer = 0;
    reg [15:0] counter=0;
    reg [15:0] max_counter_value=16'hffff;
    
    always @(posedge clk) begin

        if (counter==0)
        begin
            send_data = 1;
            wait (data_ready) data_buffer = data;
            send_data = 0;
            max_counter_value = 2**bit_length-1;
        end

        out = data_buffer>counter;
        counter = counter + 1;
        if (counter>max_counter_value) counter = 0;

    end

endmodule