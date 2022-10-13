class my_monitor extends uvm_monitor;
	`uvm_component_utils(my_monitor)

	function new(string name="my monitor", uvm_component parent =null);
		super.new(name, parent);
	endfunction
	
	virtual dut_if vif;
	`uvm_analysis_port #(Item) mon_analysis_port;

	virtual function void build (uvm_phase phase);
		super.build_phase (phase);

		mon_analysis_port = new("mon_analysis_port", this);

		if (!uvm_config_db #(virtual if_name) :: get (this, "", "dut_if", vif)) begin
			`uvm_error (get_type_name (),  "DUT interface not found")
		end
	endfunction

	virtual task run_phase (uvm_phase phase);
		super.run_phase(phase)
		forever begin
			@(vif.cb);
				if(vif.reset) begin
					Item item = Item::type_id::create("item");
					item.in = vif.in;
					item.out = vif.cb.out;
					mon_analysis_port.write(item);
					`uvm_info("MON", $sformatf("SAW item %s", item.convert2str()), UVM_HIGH)
				end		
		end
	endtask
endclass
