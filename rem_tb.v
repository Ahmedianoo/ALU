module rem_tb;
    
    reg [1:0] MagNum1;
    reg SignNum1;
    reg [1:0]MagNum2;
    reg SignNum2;
    reg [2:0]MagOut_Res;
    reg SignOut_Res;
   
    reg [2:0] Num1;
    reg [2:0] Num2;
    wire [3:0] Out_Res;
    wire negF;
    wire zerF;
    wire divzero;
    rem DUT(
        .NumA(Num1),
        .NumB(Num2),
        .Res(Out_Res),
        .negF(negF),
        .zerF(zerF),
        .DZF(divzero)
    );
    integer file;
    integer numa;
    integer numb;
    reg [1:0] variable;
    initial begin         
      file = $fopen("./rem.txt","w");                              //signbit=0-> numa & numb +ve , signbit=1 -> numa -ve
        for(numa=-3;numa<4;numa=numa+1)begin            //signbit=2 -> numb -ve, signbit=3 -> numa & numb -ve
            for(numb=-3;numb<4;numb=numb+1)begin 
              if(numa<0 && numb<0)begin
                    assign Num1=~numa+3'b101;
                    assign Num2=~numb+3'b101;
               end
               else if(numa<0 && numb>0)begin
                    assign Num1=~numa+3'b101;
                    assign Num2=numb;
               end
               else if(numa>0 && numb<0)begin
                    assign Num1=numa;
                    assign Num2=~numb+3'b101;
               end
               else if (numa>0 && numb>0)begin
                    assign Num1=numa;
                    assign Num2=numb;
               end
                #100
                // $display("Num1 = %b, Num2 = %b ",Num1,Num2);
                  assign MagNum1=Num1;
                // $display("%b",MagNum1);
                  assign MagNum2=Num2;
                //  $display("%b",MagNum2);
                  assign SignNum1=Num1[2];
                // $display("%b",SignNum1);
                  assign SignNum2=Num2[2];
                //  $display("%b",SignNum2);
                  assign MagOut_Res=Out_Res;
                // $display("%b",MagOut_Res);
                  assign SignOut_Res=Out_Res[3];
                //  $display("%b",SignOut_Res);

                // $display("%0b mod %0b = %0b ---- %0b%b mod %0b%b = %0b%b", Num1,Num2,Out_Res,SignNum1,MagNum1,SignNum2,MagNum2,SignOut_Res,MagOut_Res);
                assign variable= MagNum1%MagNum2;
                if(MagNum1%MagNum2==MagOut_Res && SignOut_Res==(SignNum1&&~divzero&&negF) && zerF==~(variable[0]|variable[1]))begin
                    $fdisplay(file,"Pass A =%b , B =%b, A%%B= result=%b, signed flag=%b, zero flag=%b, div_by_zero flag=%b",Num1, Num2, Out_Res, negF, zerF ,divzero);
                end
                else if(divzero)begin
                    $fdisplay(file,"Pass A =%b , B =%b, A%%B= result=%b, signed flag=%b, zero flag=%b, div_by_zero flag=%b",Num1, Num2, Out_Res, negF, zerF ,divzero);
                end
                else begin
                    $fdisplay(file,"Faillledd");
                end 
            end
        end
        $fclose(file);
    $finish();
end
endmodule