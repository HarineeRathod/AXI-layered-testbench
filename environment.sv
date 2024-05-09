class ei_axi_environment;
  ei_axi_agent agent;
  ei_axi_scoreboard sco;
  ei_axi_config configs=new();
  
  virtual ei_axi_interface vif;
  mailbox mon2sco_w=new();
  mailbox mon2sco_r=new();
  event e_done_w, e_done_r;
  function new(virtual ei_axi_interface vif);
    this.vif = vif;
    
    agent = new(mon2sco_w, mon2sco_r, e_done_w, e_done_r, vif, configs);
    sco = new(mon2sco_w, mon2sco_r, e_done_w, e_done_r);
  endfunction
  task run();
    fork
      ei_axi_config::run();
      agent.run();
      sco.run();
    join
  endtask : run
  
endclass