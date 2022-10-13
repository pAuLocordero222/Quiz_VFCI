class my_scoreboard extends uvm_scoreboard;
	`uvm_utils

	bit[3:0] ref_pattern;
	bit[3:0] act_pattern;
	bit	 exp_out;
	
	
	function new(string name = "my_scoreboard", uvm_component parent = null);
		super.new(name, parent);
	endfunction


	uvm_analysis_imp #(Item, my_scoreboard) item_export;

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		item_export=new ("item_export", this);
		if (!uvm_config_db#(bit[3:0])::get(this,"*", "ref_pattern", ref_pattern))
			`uvm_fatal("SCBD", "Did not get ref_pattern !")
	endfunction



	virtual function write (Item item);
		act_pattern=act_pattern <<1 | item.in;
		`uvm_info("SCBD", $sformatf("in=%0d out=%0d ref=0b%0b act=0b%0b", item.in, item.out, ref_pattern, act_pattern, act_pattern), UVM_LOW)

		if(item.out !=exp_out) begin
			`uvm_error("SCBD", $sformatf("ERROR ! out=%0d exp=%0d", item.out, exp_out))
		end 
		
		else begin
			`uvm_info("SCBD", $sformatf("PASS ! out=%0d exp=%0d", item.out, expt_out), UVM_HIGH)
		end 

		if (!(ref_pattern ^ act_pattern))begin
			`uvm_info("SCBD", $sformatf("Pattern found to match, next out should be 1")UVM_LOW)
			exp_out=1;
		end 
		
		else begin
			exp_out=0;
		end

	endfunction

endclass

		
