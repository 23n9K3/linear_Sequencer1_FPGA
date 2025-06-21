`timescale 1ns / 1ps
//让led亮0.25秒，灭0.5秒，亮0.75秒，灭1秒循环闪烁
module led_linearSequencer1(
    Clk,
    Rset_n,
    Led
    );
    input Clk;
    input Rset_n;
    output reg Led;
    //reg[26:0]counter;
    
    //version1:
    //parameter MCNT=125_000_000;
//    parameter TIME_UNIT=1000;//为了仿真统一修改变量
//    always@(posedge Clk or negedge Rset_n)
//    if(!Rset_n)
//        counter<=0;
//    else if(counter==125_000*TIME_UNIT-1)
//        counter<=0;
//    else
//        counter<=counter+1'b1;    
    
//    always@(posedge Clk or negedge Rset_n)
//    if(!Rset_n)
//       Led<=1'b0;
//    else if(counter==0)
//        Led<=1'b1;
//    else if(counter==12500*TIME_UNIT)//两个常数乘法编译器会先计算得到值，不占用FPGA电路资源运算
//        Led<=1'b0;
//    else if(counter==37500*TIME_UNIT)
//        Led<=1'b1;
//    else if(counter==75_000*TIME_UNIT)
//        Led<=1'b0;
        
   //advanced version1:将2.5s分成10个0.25s周期 
    reg [26:0]counter0;
    parameter MCNT=12500_000;//0.25s
    always@(posedge Clk or negedge Rset_n)
    if(!Rset_n)
        counter0<=0;
    else if(counter0==MCNT-1)
        counter0<=0;
    else
        counter0<=counter0+1'b1;    
    
    reg[3:0] counter1;//10个小周期需要4个bit表示
    always@(posedge Clk or negedge Rset_n)
    if(!Rset_n)
        counter1<=0;
    else if(counter0==MCNT-1)begin//记住是counter0
        if(counter1==9)
            counter1<=0;
        else
            counter1<=counter1+1'b1;
    end
    else
        counter1<=counter1;      
    
   //类似38译码器，根据counter1的不同状态来制定Led的状态 
    always@(posedge Clk or negedge Rset_n)
    if(!Rset_n)
       Led<=1'b0;
    else begin
        case(counter1)      
            0:Led<=1'b1;
            1:Led<=1'b0;
            2:Led<=1'b0;
            3:Led<=1'b1;
            4:Led<=1'b1;
            5:Led<=1'b1;
            6:Led<=1'b0;
            7:Led<=1'b0;
            8:Led<=1'b0;
            9:Led<=1'b0;
            default:Led<=Led;//因为counter1位宽是4，情况10到15出现了但不用处理
        endcase
    end    

endmodule
