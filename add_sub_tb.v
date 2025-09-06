/* 

! vlog *.v

! vsim add_sub_tb -c -do "run -all"

*/

module add_sub_tb;

    reg [2:0] A;
    reg [2:0] B;
    reg ctrl;
    wire [3:0] C;
    wire zero;
    wire sign;

    add_sub UUT (
    .A(A),
    .B(B),
    .C(C),
    .sign(sign),
    .zero(zero),
    .ctrl(ctrl)
);
    integer a = 0;
    integer b = 0;
    integer c = 0;
    integer i;
    integer j;
    integer file_writing_add;
    integer file_writing_sub;
    reg [3:0] temp;
    reg [3:0] temp2;
    initial begin
        file_writing_add = $fopen("./add.txt", "w");
        file_writing_sub = $fopen("./sub.txt", "w");
        for (c = 0; c <= 1; c = c + 1  ) begin
            ctrl = c[1:0];
            if (ctrl == 1'b1) begin
                for (a = -3; a <= 3; a = a + 1 ) begin
                    #100
                    case (a[2:0]) 
                    3'b101 : begin 
                        temp[0] = a[0];
                        temp[1] = ~a[1];
                        temp[2] = a[2];
                    end
                    3'b111 : begin 
                        temp[0] = a[0];
                        temp[1] = ~a[1];
                        temp[2] = a[2];
                    end
                    default: begin
                        temp = a[2:0];
                    end 
                    endcase
                    for (b = -3; b <= 3 ; b = b + 1 ) begin
                        #100
                        case (b[2:0]) 
                        3'b101 : begin 
                            temp2[0] = b[0];
                            temp2[1] = ~b[1];
                            temp2[2] = b[2];
                        end
                        3'b111 : begin 
                            temp2[0] = b[0];
                            temp2[1] = ~b[1];
                            temp2[2] = b[2];
                        end
                        default: begin
                            temp2 = b[2:0];
                        end 
                        endcase
                        A = temp[2:0];
                        B = temp2[2:0];
                        #100;
                        #100;
                        if ((zero == !(C[0] | C[1] | C[2])) & (sign == C[3])) begin
                            $fdisplay(file_writing_sub, "Pass A =%b , B =%b, A-B= result=%b, signed flag=%b, zero flag=%b", A , B, C, sign, zero);
                        end else begin
                            $fdisplay(file_writing_sub, "Fail A =%b , B =%b, A-B= result=%b, signed flag=%b, zero flag=%b", A , B, C, sign, zero);
                        end
                    end
                end
            end
            else begin
                for (a = -3; a <= 3; a = a + 1 ) begin
                    #100
                    case (a[2:0]) 
                    3'b101 : begin 
                        temp[0] = a[0];
                        temp[1] = ~a[1];
                        temp[2] = a[2];
                    end
                    3'b111 : begin 
                        temp[0] = a[0];
                        temp[1] = ~a[1];
                        temp[2] = a[2];
                    end
                    default: begin
                        temp = a[2:0];
                    end 
                    endcase
                    for (b = -3; b <= 3 ; b = b + 1 ) begin
                        #100
                        case (b[2:0]) 
                        3'b101 : begin 
                            temp2[0] = b[0];
                            temp2[1] = ~b[1];
                            temp2[2] = b[2];
                        end
                        3'b111 : begin 
                            temp2[0] = b[0];
                            temp2[1] = ~b[1];
                            temp2[2] = b[2];
                        end
                        default: begin
                            temp2 = b[2:0];
                        end 
                        endcase
                        A = temp[2:0];
                        B = temp2[2:0];
                        #100;
                        #100;
                        if ((zero == !(C[0] | C[1] | C[2])) & (sign == C[3])) begin
                            $fdisplay(file_writing_add, "Pass A =%b , B =%b, A+B= result=%b, signed flag=%b, zero flag=%b", A , B, C, sign, zero);
                        end else begin
                            $fdisplay(file_writing_add, "Fail A =%b , B =%b, A+B= result=%b, signed flag=%b, zero flag=%b", A , B, C, sign, zero);
                        end
                    end 
                end
            end
        end
        $fclose(file_writing_add);
        $fclose(file_writing_sub);
        $finish();
    end
endmodule