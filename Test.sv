class test extends uvm_test;
    `uvm_component_utils(test)
    function new(string name = "test", uvm_component=null);
        super.new(name, parent);
    endfunction

    env  e0;
    vitual dut_if vif;
    bit[3:0] patt=4'b1011;
    my_sequence seq;

    virtual function void build_phase(uvm_phase phase);
        super.build(phase);
        e0= env::type_id::create("e0", this);

        if (!uvm_config_db#db(virtual dut_if)::get(this,"", "dut_if", vif))
            'uvm_fatal("test", "Did not get vif")
        uvm_config_db#(virtual dut_if)::set(this, "e0.age.*","dut_if", vif)
        uvm_config_db#(bit[3:0])::set(this, "*", "ref_pattern", patt);

        seq=my_sequence::type_id::create("seq");
        seq.randomize
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        apply_reset();
        seq.start(e0.age.sco);
        #200
        phase.drop_objection(this);
    endtask

    virtual task reset();
        vif.reset<=0;
        vif.in<=0;
        repeat(5)@(posedge vif.clk);
        vif.rese<=1;
        repeat(10)@(posedge vif.clk)
    endtask
endclass