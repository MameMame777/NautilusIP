rtl    := ./rtl/SingleCLKFIFO.sv
verif  := ./verification/SingleCLKFIFO_tb.sv 
interface := ./rtl/interface.sv
exec   := run.x
opt    := --binary --trace

run: compile
	./obj_dir/$(exec)

compile:
	verilator $(opt) +incdir+ $(verif) $(rtl) $(interface) -o $(exec)

clean:
	\rm -rf obj_dir
	\rm -rf ./waveform.vcd 