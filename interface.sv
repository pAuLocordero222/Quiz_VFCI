interface dut_if(input bit clk);
	logic reset;
	logic in;
	logic out;

	clocking cb @(posedge clk);
		default input #1step output #3ns;
			input out;
			output in;
	endclocking	
endinterface

class item extends uvm_sequence_item;
	`uvm_object_utils(item)
	rand bit in;
	bit out;

	function new(string name = "item ")
		super.new(name);
	endfunction
//a
	constraint c1 {in dist {0:/20, 1:/80};}
endclass
