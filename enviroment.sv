class enviroment extends uvm_env;
    `uvm_component_utils(env)
    function new(string name = "enviroment", uvm_component parent = null);
        super.new(name, parent);

    endfunction

    agent age;
    scoreboard sco;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        age = agent::type_id::create("age", this);
        sco = scoreboard::type_id::create("sco", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        age.mon.mon_analysis_port.connect(sco.mon_analysis_imp);

    endfunction
endclass
