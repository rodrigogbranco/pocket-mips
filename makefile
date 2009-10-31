all:
	rm -rf e~${PROGRAM_GHDL}.o e~tb${PROGRAM_GHDL}.o ${PROGRAM_GHDL}.o tb${PROGRAM_GHDL}.o ${PROGRAM_GHDL} tb${PROGRAM_GHDL} work-PROGRAM_GHDL93.cf ${PROGRAM_GHDL}.vcd
	ghdl -a ${PROGRAM_GHDL}.vhd
	ghdl -e ${PROGRAM_GHDL}
	ghdl -a tb${PROGRAM_GHDL}.vhd
	ghdl -e tb${PROGRAM_GHDL}
	ghdl -r tb${PROGRAM_GHDL} --vcd=${PROGRAM_GHDL}.vcd
	rm -rf e~${PROGRAM_GHDL}.o e~tb${PROGRAM_GHDL}.o tb${PROGRAM_GHDL}.o ${PROGRAM_GHDL} tb${PROGRAM_GHDL} work-PROGRAM_GHDL93.cf

