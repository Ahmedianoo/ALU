module rem(
    input [2:0]NumA,
    input  [2:0]NumB,
    output [3:0]Res,
    output zerF,
    output negF,
    output DZF
);
//assign 
assign DZF = ~(NumB[0]|NumB[1]);
assign Res[0]=NumA[0]&NumB[1]&((~NumA[1])|~NumB[0]); // first num in output
assign Res[1]=NumA[1]&(~NumA[0])&NumB[0]&NumB[1]; // second num in output
assign Res[2]=0;
assign Res[3]=NumA[2];
assign negF=NumA[2];
assign zerF=~((NumA[1]&(~NumA[0])&NumB[0]&NumB[1])|(NumA[0]&NumB[1]&((~NumA[1])|~NumB[0])));

endmodule
