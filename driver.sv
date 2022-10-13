 class my_driver extends uvm_driver#(Item); 
 `uvm_component_utils(my_driver)
 
 function new(string name="my driver", uvm_component parent=null);
         super.new(name, parent);
  endfunction
 
  virtual dut_if vif;
 
  virtual function void build_phase (uvm_phase phase);
         super.build_phase(phase);
         if (!uvm_config_db#(virtual dut_if)::get(this,"","dut_vif",vif))               
		`uvm_fatal("DRV","Error no se encontro dut_if")


  endfunction

  virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin
			Item m_item;
			`uvm_info("DRV", $sformatf("wait for item from sequencer"), UVM_HIGH)
			seq_item_port.get_next_item(m_item);
			drive_item(m_item);
			seq_item_port.item_done();
		end
  endtask

virtual task drive_item(Item m_item);
	@(vif.cb)
		vif.cb.in <= m_item.in;
endtask
endclass	

