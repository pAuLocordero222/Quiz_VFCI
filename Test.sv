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
    endfunction

