module Alu (
    input [2:0] A,
    input [2:0] B,
    input [1:0] S,
    output reg [4:0] R,
    output reg SF,
    output reg ZF,
    output reg DZF
);
    // A inputs
    wire [2:0] testa_add;
    wire [2:0] testa_sub;
    wire [2:0] testa_mul;
    wire [2:0] testa_rem;
    assign testa_add = A;
    assign testa_sub = A;
    assign testa_mul = A;
    assign testa_rem = A;
    wire [2:0] testb_add;
    wire [2:0] testb_sub;
    wire [2:0] testb_mul;
    wire [2:0] testb_rem;
    // B inputs
    assign testb_add = B;
    assign testb_sub = B;
    assign testb_mul = B;
    assign testb_rem = B;
    wire [3:0] add_output;
    wire [3:0] sub_output;
    wire [4:0] mul_output;
    wire [3:0] rem_output;
    // flags and controlunit
    wire sign_add;
    wire zero_add;
    wire sign_sub;
    wire zero_sub;
    wire sign_mul;
    wire zero_mul;
    wire sign_rem;
    wire zero_rem;
    wire ctrladd;
    wire ctrlsub;
    assign ctrladd = 1'b0;
    assign ctrlsub = 1'b1;
    wire division_byzero;

    add_sub Addition(.A(testa_add), .B(testb_add), .ctrl(ctrladd) ,.C(add_output), .sign(sign_add), .zero(zero_add));
    add_sub Subtraction(.A(testa_sub), .B(testb_sub), .ctrl(ctrlsub) ,.C(sub_output), .sign(sign_sub), .zero(zero_sub));
    mul multiplaction(.SAB(testa_mul), .SCD(testb_mul), .result(mul_output), .negativeFlag(sign_mul), .zeroFlag(zero_mul));
    rem remaider(.NumA(testa_rem), .NumB(testb_rem), .Res(rem_output) ,.DZF(division_byzero), .negF(sign_rem), .zerF(zero_rem));
    always @(*) begin
        case (S)
        2'b00: begin
            R[2:0] = add_output[2:0]; 
            R[3] = 1'b0;
            R[4] = add_output[3];
            SF = sign_add;
            ZF = zero_add;
            DZF = 1'b0;
        end
        2'b01: begin
            R[2:0] = sub_output[2:0]; 
            R[3] = 1'b0;
            R[4] = sub_output[3];
            SF = sign_sub;
            ZF = zero_sub;
            DZF = 1'b0;
        end
        2'b10: begin
            R[4:0] = mul_output[4:0];
            SF = sign_mul;
            ZF = zero_mul;
            DZF = 1'b0;
        end
        2'b11: begin
            R[2:0] = rem_output[2:0];
            R[3] = 1'b0;
            R[4] = rem_output[3];
            SF = sign_rem;
            ZF = zero_rem;
            DZF = division_byzero;
        end
        default: ;
    endcase    
    end
endmodule
