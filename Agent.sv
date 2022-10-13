class agent extends uvm_agent;

    `uvm_component_utils(agent)
    
    function new(string name="agent", uvm_component parent=null);
        super.new(name, parent);
    endfunction


    uvm_sequencer #(Item) sq;
    my_driver dri;
    my_monitor moni;

    virtual function void build_phase(uvm_phase phase);

        super.build_phase(phase);
        sq = uvm_sequencer #(Item)::type_id::create("sq", this);
        dri = my_driver::type_id::create("dri", this);
        moni = my_monitor::type_id::create("moni", this);


    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        dri.seq_item_port.connect(sq.seq_item_export);

    endfunction

endclass
