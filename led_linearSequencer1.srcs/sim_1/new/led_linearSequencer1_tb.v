`timescale 1ns/1ns

module led_linearSequencer1_tb();

    reg Clk;
    reg Rset_n;
    wire Led;
    
    led_linearSequencer1 led_linearSequencer1_inst(
    .Clk(Clk),
    .Rset_n(Rset_n),
    .Led(Led)
);
    //version1��
    //defparam led_linearSequencer1_inst.TIME_UNIT=1;
    
    //advanced version1:
    defparam led_linearSequencer1_inst.MCNT=12500;
    initial Clk=1;
    always #10 Clk=~Clk;//ÿ��ʱ10ns,��תClk�źţ���λȡ��)�պö�Ӧһ��ʱ������
    
    initial begin
        Rset_n=0;//�ȸ�λ��D���������������Ϊ0
        #201;//why201����Ϊ��200nsʱClk�պõ��������أ�����Rset_n��Clkͬʱ���������ص��²�֪��˭����Ч
        Rset_n=1;
        #200_000_000;
        $stop;
     end  
endmodule