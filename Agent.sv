class agent extends uvm_agent;

    `uvm_component_utils(agent)
    
    function new(string name="agent", uvm_component parent=null);
        super.new(name, parent);
    endfunction


    uvm_sequencer #(item) seq;
    driver dri;
    monitor mon;

    virtual function void build_phase(uvm_phase phase);

        super.build_phase(phase);
        seq = uvm_sequencer #(item)::type_id::create("seq", this);
        dri = driver::type_id::create("dri", this);
        mon = monitor::type_id::create("mon", this);


    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        dri.seq_item_port.connect(seq.seq_item_export);

    endfunction