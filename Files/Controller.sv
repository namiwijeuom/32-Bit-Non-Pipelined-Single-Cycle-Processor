// The Controller module which is responsible for decoding the control signals 
// required for the execution of MIPS instructions.

module Controller(

// Inputs:
//op (6 bits): Represents the opcode of the instruction being executed.
//funct (6 bits): Represent the function code, which is typically used for R-type instructions in MIPS.
//zero: This signal may be used to indicate whether the result of an ALU operation is zero or not. 
	input logic [5:0] op, funct,
	input logic zero,
	
//Outputs:
//memtoreg: Indicates whether the result of an operation should be written back to memory (typically used in load instructions).
//memwrite: Indicates whether the memory should be written to (typically used in store instructions).
//pcsrc: Control the source of the next program counter value. It is used for branching instructions.
//alusrc: Controls the source of the ALU operands.
//regdst: Indicates which destination register should be written to.
//regwrite: Indicates whether a write operation should be performed on the register file.
//jump: Indicates whether the instruction is a jump instruction.
//alucontrol (4 bits): Control the operation of the Arithmetic Logic Unit (ALU).
	output logic memtoreg, memwrite,
	output logic pcsrc, 
	output logic [1:0]alusrc,
	output logic regdst, regwrite,
	output logic jump,jr,
	output logic ne,
	output logic half,
	output logic b,
	output logic [3:0] alucontrol,
	output logic lbu, link);

	logic [3:0] aluop;

	logic branch;

	MainDecoder 	md(op,funct, memtoreg, memwrite, branch,alusrc, regdst, regwrite, jump,jr,ne, half, b, aluop, lbu, link);
	ALUDecoder 		ad(funct, aluop, alucontrol);
	
	logic  bne_rc;
	assign bne_rc = ne ^ zero ;
	assign pcsrc = branch & zero;
	
endmodule 