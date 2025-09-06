/*

! vlog *.v

! vsim add_sub -c -do "run -all"

! vsim add_sub -c -do "run -all"

! vsim add_sub_tb -c -do "run -all"

*/

module add_sub (
    input [2:0] A,
    input [2:0] B,
    input ctrl,
    output reg [3:0] C,
    output reg sign,
    output reg zero
);  
    reg [2:0] temporary;
    always @(*) begin
        if (ctrl == 1'b1) begin // subtraction
                temporary[2] = !B[2];
                temporary[1] = B[1];
                temporary[0] = B[0];
            if (A[2] ^ temporary[2] == 0) begin
                C = A + temporary;
                C[3] = A[2];
            end
            else begin
                if (A[2] == 1) begin
                    C = ~(A) + (temporary);
                end
                else begin
                    C = (A) + ~(temporary);
                end
                if (C[2] == 1'b1) begin
                    C = C + 1'b1;
                    C[2] = 1'b0;
                    C[3] = 1'b1;
                end
                else begin
                    C = ~(C);
                    C[2] = 1'b0;
                    C[3] = 1'b1;
                end
            end
        end
        else begin //addition
           if (A[2] ^ B[2] == 0) begin
            C = A + B;
            C[3] = A[2];
        end
        else begin
            if (A[2] == 1) begin
                C = ~(A) + (B);
            end
            else begin
                C = (A) + ~(B);
            end
            if (C[2] == 1'b1) begin
                C = C + 1'b1;
                C[2] = 1'b0;
                C[3] = 1'b0;
            end
            else begin
                C = ~(C);
                C[2] = 1'b0;
                C[3] = 1'b1;
            end
        end 
        end
        assign zero = !(C[0] | C[1] | C[2]);
        if (zero == 1'b1) begin
            sign = 1'b0;
            C[3] = 1'b0;
        end
        else begin
            sign = C[3];
        end
    end
endmodule