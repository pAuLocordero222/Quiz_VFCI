class test extends uvm_test;
    `uvm_component_utils(test)
    function new(string name = "test", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    environment  e0;
    virtual dut_if vif;
    bit[3:0] patt=4'b1011;
    my_sequence seq;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        e0= environment::type_id::create("e0", this);

       
        uvm_config_db#(virtual dut_if)::set(this, "e0.age.*","dut_if", vif);
        uvm_config_db#(bit[3:0])::set(this, "*", "ref_pattern", patt);

        seq=my_sequence::type_id::create("seq");
        seq.randomize();
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        apply_reset();
        seq.start(e0.age.sq);
        #200
        phase.drop_objection(this);
    endtask

    virtual task apply_reset();
        vif.reset<=0;
        vif.in<=0;
        repeat(5)@(posedge vif.clk);
        vif.reset<=1;
        repeat(10)@(posedge vif.clk);
    endtask
endclass

class test1 extends test;
    `uvm_component_utils(test1)
    function new(string name="test1", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
    	patt = 4'b1011;
	super.build_phase(phase);
	seq.randomize() with { num inside {[300:500]};};
    endfunction

endclass
