module mul_tb;
reg [2:0] in1;
reg [2:0] in2;
wire [4:0] out;
wire FlagZero;
wire FlagNegative;

mul Mul(
    .SAB(in1),
    .SCD(in2),
    .result(out),
    .zeroFlag(FlagZero),
    .negativeFlag(FlagNegative)
);

integer i;
integer j;
integer k;
reg zero;
reg [4:0] R; 
reg [2:0] temp;
integer file_writing;
initial begin
file_writing = $fopen("./mul.txt", "w");
for(i = -3; i <= 3; i = i + 1)begin

        case (i[2:0]) 
           3'b101 : begin 
            temp[0] = i[0];
            temp[1] = ~i[1];
            temp[2] = i[2];
           end
           3'b111 : begin 
            temp[0] = i[0];
            temp[1] = ~i[1];
            temp[2] = i[2];
           end
            default: temp = i[2:0];
        endcase
        in1 = temp[2:0];

        #100;

        for(j = -3; j <= 3; j = j + 1)begin

        case (j[2:0]) 
           3'b101 : begin 
            temp[0] = j[0];
            temp[1] = ~j[1];
            temp[2] = j[2];
           end
           3'b111 : begin 
            temp[0] = j[0];
            temp[1] = ~j[1];
            temp[2] = j[2];
           end
            default: temp = j[2:0];
        endcase
        in2 = temp[2:0];
        k[4:0] = i * j;
        k[4] = i[2] ^ j[2];
        case (k[4:0]) 
           5'b10000 : begin 
            R[0] = k[0];
            R[1] = k[1];
            R[2] = k[2];
            R[3] = k[3];
            R[4] = k[4];
            
           end
            5'b11010 : begin 
            R[0] = k[0];
            R[1] = k[1];
            R[2] = ~k[2];
            R[3] = ~k[3];
            R[4] = k[4];
            
           end
            5'b11011 : begin 
            R[0] = k[0];
            R[1] = ~k[1];
            R[2] = ~k[2];
            R[3] = ~k[3];
            R[4] = k[4];
            
           end
            5'b11100 : begin 
            R[0] = k[0];
            R[1] = k[1];
            R[2] = k[2];
            R[3] = ~k[3];
            R[4] = k[4];
            
           end
            5'b11101 : begin 
            R[0] = k[0];
            R[1] = ~k[1];
            R[2] = ~k[2];
            R[3] = ~k[3];
            R[4] = k[4];
            
           end           
            5'b11110 : begin 
            R[0] = k[0];
            R[1] = k[1];
            R[2] = ~k[2];
            R[3] = ~k[3];
            R[4] = k[4];
            
           end
           5'b10111 : begin 
            R[0] = k[0];
            R[1] = ~k[1];
            R[2] = ~k[2];
            R[3] = ~k[3];
            R[4] = k[4];
            
           end
           5'b11011 : begin 
            R[0] = k[0];
            R[1] = ~k[1];
            R[2] = ~k[2];
            R[3] = ~k[3];
            R[4] = k[4];
            
           end
            5'b11111 : begin 
            R[0] = k[0];
            R[1] = ~k[1];
            R[2] = ~k[2];
            R[3] = ~k[3];
            R[4] = k[4];
            
           end
            default: R = k[4:0];
        endcase
        #100;   
        zero = !(out[0] || out[1] || out[2] || out[3]);
        if((out == (R)) && (out[4] == FlagNegative) && (zero == FlagZero))begin
             $fdisplay(file_writing, "Pass A=%b , B=%b, A*B= result=%b, signed flag=%b, zero flag=%b  ", in1, in2, out, FlagZero, FlagNegative);
        end
        else begin
            $fdisplay(file_writing, "Fail A=%b , B=%b, A*B= result=%b, signed flag=%b, zero flag=%b ", in1, in2, out, FlagZero, FlagNegative);
        end
    end
end


$fclose(file_writing);
$finish();
end

endmodule