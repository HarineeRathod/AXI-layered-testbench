class ei_axi_test;
  ei_axi_environment env;
  ei_axi_only_write write_only;
  ei_axi_only_read read_only;
  ei_axi_parallel_read_write parallel_read_write;
  ei_axi_sequential_read_write sequential_read_write;
  ei_axi_sequential_write_read sequential_write_read;
  
  string testname;
  virtual ei_axi_interface vif;
  
  function new(virtual ei_axi_interface vif);
    this.vif = vif;
    env = new(vif);
  endfunction
  
  task run();
     if($value$plusargs("testname=%s",testname))    
       	begin
          $display("%0s testname is selected",testname);
          $display("----------------------------------------------------");
          case(testname)
            "ei_axi_only_write":
            begin
              write_only = new(env.agent.gen2drv_w,env.agent.gen2drv_r,env.agent.e_w,env.agent.e_r);
              env.agent.gen = write_only;
            end
            
            "ei_axi_only_read":
            begin
              read_only = new(env.agent.gen2drv_w,env.agent.gen2drv_r,env.agent.e_w,env.agent.e_r);
              env.agent.gen = read_only;
            end
            
            "ei_axi_parallel_read_write":
            begin
              parallel_read_write = new(env.agent.gen2drv_w,env.agent.gen2drv_r,env.agent.e_w,env.agent.e_r);
              env.agent.gen = parallel_read_write;
            end
            
            "ei_axi_sequential_read_write":
            begin
              sequential_read_write = new(env.agent.gen2drv_w,env.agent.gen2drv_r,env.agent.e_w,env.agent.e_r);
              env.agent.gen = sequential_read_write;
            end
            
            "ei_axi_sequential_write_read":
            begin
              sequential_write_read = new(env.agent.gen2drv_w,env.agent.gen2drv_r,env.agent.e_w,env.agent.e_r);
              env.agent.gen = sequential_write_read;
            end
            
            default:
              $display("default");
          endcase
		end
    else
      $display("not take");

      env.run();

  endtask
endclass