class environment extends uvm_env;
    `uvm_component_utils(environment)
    function new(string name = "enviroment", uvm_component parent = null);
        super.new(name, parent);

    endfunction

    agent age;
    my_scoreboard sco;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        age = agent::type_id::create("age", this);
        sco = my_scoreboard::type_id::create("sco", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        age.moni.mon_analysis_port.connect(sco.m_analysis_imp);

    endfunction
endclass
