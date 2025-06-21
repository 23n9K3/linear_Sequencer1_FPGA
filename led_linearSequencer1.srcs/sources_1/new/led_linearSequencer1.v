`timescale 1ns / 1ps
//��led��0.25�룬��0.5�룬��0.75�룬��1��ѭ����˸
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
//    parameter TIME_UNIT=1000;//Ϊ�˷���ͳһ�޸ı���
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
//    else if(counter==12500*TIME_UNIT)//���������˷����������ȼ���õ�ֵ����ռ��FPGA��·��Դ����
//        Led<=1'b0;
//    else if(counter==37500*TIME_UNIT)
//        Led<=1'b1;
//    else if(counter==75_000*TIME_UNIT)
//        Led<=1'b0;
        
   //advanced version1:��2.5s�ֳ�10��0.25s���� 
    reg [26:0]counter0;
    parameter MCNT=12500_000;//0.25s
    always@(posedge Clk or negedge Rset_n)
    if(!Rset_n)
        counter0<=0;
    else if(counter0==MCNT-1)
        counter0<=0;
    else
        counter0<=counter0+1'b1;    
    
    reg[3:0] counter1;//10��С������Ҫ4��bit��ʾ
    always@(posedge Clk or negedge Rset_n)
    if(!Rset_n)
        counter1<=0;
    else if(counter0==MCNT-1)begin//��ס��counter0
        if(counter1==9)
            counter1<=0;
        else
            counter1<=counter1+1'b1;
    end
    else
        counter1<=counter1;      
    
   //����38������������counter1�Ĳ�ͬ״̬���ƶ�Led��״̬ 
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
            default:Led<=Led;//��Ϊcounter1λ����4�����10��15�����˵����ô���
        endcase
    end    

endmodule
