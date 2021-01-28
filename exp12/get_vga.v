module get_vga(input [9:0] h_addr, input [9:0] v_addr, input [7:0] cur_ascii,
output reg [23:0] vga_data, input start, input [3:0] gamefont);//获得游戏中字符的VGA信号

reg [11:0] vga_font [4095:0];//存储256个ASCII字符对应的字模信息

wire [3:0] h_font;  		//9
wire [3:0] v_font; 	   //16
wire [6:0] h_ascii;
wire [4:0] v_ascii;
wire [11:0] fontline;
wire [11:0] font_addr;

parameter maxline=30;

assign h_ascii=h_addr/9;
assign v_ascii=v_addr/16;
assign h_font=h_addr%9;
assign v_font=(start && (h_ascii >= 20))? (gamefont):(v_addr % 16);
assign font_addr=(cur_ascii<<4)+v_font;
assign fontline=vga_font[font_addr];

initial
begin
$readmemh("vga_font.txt", vga_font, 0, 4095);
end

always @(*)
begin
	if(fontline[h_font]!=0 && h_ascii<70 && v_ascii<maxline)
	begin
		if(h_addr<180) 
		begin
			vga_data=24'hFFFFFF;
		end
		else
		begin
		case(cur_ascii)//A-Z
			8'h41:		vga_data=24'h00BFFF;
			8'h42:		vga_data=24'hCD5C5C;
			8'h43:		vga_data=24'h00FF7F;	
			8'h44:		vga_data=24'hEEAD0E;
			8'h45:		vga_data=24'hFFA500;
			8'h46:		vga_data=24'hFF69b4;
			8'h56:		vga_data=24'h4A708B;
			8'h57:		vga_data=24'hFFE4E1;
			8'h58:		vga_data=24'h76EE00;
			8'h59:		vga_data=24'h008B8B;
			8'h5a:		vga_data=24'hFF1493;
			8'h47:		vga_data=24'h00FFFF;
			8'h48:		vga_data=24'h76EEC6;
			8'h49:		vga_data=24'h9B30FF;
			8'h4a:		vga_data=24'h4876FF;
			8'h4b:		vga_data=24'h00CD66;
			8'h4c:		vga_data=24'h63B8FF;
			8'h4d:		vga_data=24'hA0522D;
			8'h4e:		vga_data=24'h4F94CD;
			8'h4f:		vga_data=24'h8B0000;
			8'h50:		vga_data=24'h87CEFF;
			8'h51:		vga_data=24'h009ACD;
			8'h52:		vga_data=24'h00B2EE;
			8'h53:		vga_data=24'h7EC0EE;
			8'h54:		vga_data=24'h6CA6CD;
			8'h55:		vga_data=24'h5CACEE;
			default :vga_data=24'hFFFFFF;
		endcase
		end
	end

	else
		vga_data=24'h000000; //黑色
end

endmodule
