class test_bench_t;
  run_param_t run_param;
  extern function new();
  extern task run_test( virtual fifo_if sif);
  extern function test_base_t get_testcase();
  extern task run(run_param_t run_param);
endclass

function test_bench_t::new();
  run_param = new();
endfunction

task test_bench_t::run_test( virtual fifo_if sif);
  run_param.testcase = get_testcase();
  run_param.set_if(sif);
  run(run_param);
  $finish;
endtask

function test_base_t test_bench_t::get_testcase();
  int number;
  if($value$plusargs("TESTCASE=%0d", number))begin
    $display("TESTCASE is %0d ",number);
    case(number)
      0: get_testcase = test1_t::new();
      1: get_testcase = test2_t::new();
      default: $fatal(0,"TESTCASE is incorrect");
    endcase
  end else
    $fatal(0,"func::get_testcase...TESTCASE not found");
endfunction

task test_bench_t::run(run_param_t run_param);
  driver_t driver;
  collector_t collector;
  driver= new();
  collector = new();
  driver.setup_if (run_param.vif);
  collector.setup_if (run_param.vif);
  run_param.testcase.start();
  fork
    driver.run(run_param.testcase);
    collector.run();
  join_any  
endtask 