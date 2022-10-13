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
		`uvm_info("write", $sformat("Data received = 0x%0h", data), UVM_MEDIUM)
	endfunction

endclass

		
