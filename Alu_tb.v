/*

! vlog *.v
! vsim Alu -c -do "run -all"
! vsim Alu -do "run -all"
! vsim Alu_tb -c -do "run -all"

*/
module Alu_tb;

    reg [2:0] A;
    reg [2:0] B;
    reg [1:0] choice;
    wire [4:0] C;
    wire zero;
    wire sign;
    wire div_by_zero;

    Alu UUT (
     .A(A),
     .B(B),
     .S(choice),
     .R(C),
     .SF(sign),
     .ZF(zero),
     .DZF(div_by_zero)
);
    integer s;
    integer a;
    integer b;
    reg [3:0] temp;
    reg [3:0] temp2;
    integer file_alu;
    initial begin
        file_alu = $fopen("./alu.txt","w");
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
            for (b = -3; b<= 3; b = b + 1 ) begin
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
                for (s = 0; s <= 2'b11; s = s + 1) begin
                    choice = s[1:0];
                    A = temp[2:0];
                    B = temp2[2:0];
                    #100;
                    #100;
                    case (choice)
                        2'b00: begin
                            $display("A =%b , B =%b, A+B= result=%b, signed flag=%b, zero flag=%b", A , B, C, sign, zero);
                            $fdisplay(file_alu,"A =%b , B =%b, A+B= result=%b, signed flag=%b, zero flag=%b", A , B, C, sign, zero);
                        end
                        2'b01: begin
                            $display("A =%b , B =%b, A-B= result=%b, signed flag=%b, zero flag=%b", A , B, C, sign, zero);
                            $fdisplay(file_alu,"A =%b , B =%b, A-B= result=%b, signed flag=%b, zero flag=%b", A , B, C, sign, zero);
                        end
                        2'b10: begin
                            $display("A =%b , B =%b, A*B= result=%b, signed flag=%b, zero flag=%b", A , B, C, sign, zero);
                            $fdisplay(file_alu,"A =%b , B =%b, A*B= result=%b, signed flag=%b, zero flag=%b", A , B, C, sign, zero);
                        end
                        2'b11: begin
                            $display("A =%b , B =%b, A%%B= result=%b, signed flag=%b, zero flag=%b, div_by_zero flag=%b", A , B, C, sign, zero, div_by_zero);
                            $fdisplay(file_alu,"A =%b , B =%b, A%%B= result=%b, signed flag=%b, zero flag=%b, div_by_zero flag=%b", A , B, C, sign, zero, div_by_zero);
                        end 
                        default:; 
                    endcase
                end
            end
        end
        $fclose(file_alu);
    end
endmodule
