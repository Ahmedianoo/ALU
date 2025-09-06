module mul (
    input [2:0]  SAB,
    input [2:0]  SCD,
    output [4:0]  result,
    output zeroFlag,
    output negativeFlag
);

assign result[0] = SAB[0] & SCD[0];

integer AD;
assign AD = SAB[1] & SCD[0];
integer BC;
assign BC = SAB[0] & SCD[1];
assign result[1] = AD ^ BC ;

integer CA;
assign CA = SAB[1] & SCD[1];
assign result[2] = (AD & BC) ^ CA;

assign result[3] = ((AD & BC) & CA);

assign result[4] = ((SAB[2] ^ SCD[2]));

assign negativeFlag = ((SAB[2] ^ SCD[2]));

assign zeroFlag = (((SAB[0] == 0) && (SAB[1] == 0)) || ((SCD[0] == 0) && (SCD[1] == 0)));
    
endmodule
