// Name: Qusay Taradeh, ID Num.1212508, Instructor Name: Elias Khalil, Section Num.3

`timescale 1ns/1ns

/*
Testbench of ALU module to test that built sucessfully
	in this test we test all operation codes on 2 numbers
	a and b which are signed number
*/
module test_alu;
	reg [5:0]opcode;
	reg signed [31:0] a, b;
	wire signed [31:0] result;
	
	alu u1(.opcode(opcode), .a(a), .b(b), .result(result));
	
	initial begin					   
		a = -5;
		b = 6;								  
		
		#10 opcode = 1;		// a + b operation
		#10 $display("A = %d, B = %d, Opcode = %d, Result = %d", a, b, opcode, result);
		
		#10 opcode = 6;		// a - b operation 
		#10 $display("A = %d, B = %d, Opcode = %d, Result = %d", a, b, opcode, result);	
		
		#10 opcode = 13;	// |a| operation
		#10 $display("A = %d, B = %d, Opcode = %d, Result = %d", a, b, opcode, result);
		
		#10 opcode = 8;		// -a operation
		#10 $display("A = %d, B = %d, Opcode = %d, Result = %d", a, b, opcode, result);
		
		#10 opcode = 7;		// maximum operation
		#10 $display("A = %d, B = %d, Opcode = %d, Result = %d", a, b, opcode, result);
		
		#10 opcode = 4;		// minimum operation
		#10 $display("A = %d, B = %d, Opcode = %d, Result = %d", a, b, opcode, result);
		
		#10 opcode = 11;	// average operation
		#10 $display("A = %d, B = %d, Opcode = %d, Result = %d", a, b, opcode, result);
		
		#10 opcode = 15;	// not a operation
		#10 $display("A = %b, Not A = %b", a, result);
		
		#10 opcode = 3;		// OR operation
		#10 $display("A = %b, B = %b, A OR B = %b", a, b, result);
		
		#10 opcode = 5;		// AND operation
		#10 $display("A = %b, B = %b, A AND B = %b", a, b, result);
		
		#10 opcode = 2;		// XOR operation
		#10 $display("A = %b, B = %b, A XOR B = %b", a, b, result);
		
		$finish;
	end
endmodule

/*
Testbench of register file
*/
module tb_reg_file;

  reg clk;
  reg valid_opcode;
  reg [4:0] addr1, addr2, addr3;
  reg signed [31:0] in;
  wire signed [31:0] out1, out2;

  // Instantiate the reg_file module
  reg_file uut (
    .clk(clk),
    .valid_opcode(valid_opcode),
    .addr1(addr1),
    .addr2(addr2),
    .addr3(addr3),
    .in(in),
    .out1(out1),
    .out2(out2)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    clk = 0;
    valid_opcode = 1;
    addr1 = 3; // Choose any valid address for addr1
    addr2 = 8;
    addr3 = 8; // Set addr3 to the same value as addr2
    in = 32'hF1234567; // Input data to be written
    
    // Apply stimulus
    #10 valid_opcode = 0; // Disable operation
    #20 $display("addr1 = %h, addr2 = %h, addr3 = %h, out1 = location[%d] = %h, out2 = location[%d] = %h", addr1, addr2, addr3, addr1, out1, addr2, out2);
    
    valid_opcode = 1;	// Enable to show new value stored in location addressed by addr2

    // Apply stimulus
    #10 valid_opcode = 0; // Disable operation

    // Monitor results
    #20 $display("addr1 = %h, addr2 = %h, addr3 = %h, out1 = location[%d] = %h, out2 = location[%d] = %h", addr1, addr2, addr3, addr1, out1, addr2, out2);

    #30 $finish; // Finish simulation after a certain time
  end

endmodule

/*
Testbench of simple microprocessor
*/
module tp_mp;
	reg clk;							// clock
	reg signed [31:0] location [0:31];	// 32 location each one 32-bit to store the values in it start from index 0
	reg [5:0] opcodes [0:10];			// opcodes that ALU can do them
	reg [31:0] instructions [0:25];		// array of instructions
	reg [31:0] instruction;				// instruction given from the array
	reg signed [31:0] result;			// result of microprocessor	
	reg signed [31:0] expected_result;	// expected result of microprocessor
	integer i = 0;						// index of stored instructions
	integer size; 						// size: last index of last instruction
	
	// instantiate microprocessor
	mp_top mp( .clk(clk) , .instruction(instruction) , .result(result) ); 
	
	// Clock generation
  	initial begin
		  clk = 0;
		  forever #5 clk = ~clk;
	  end
	  
	initial begin
		// initialize the values stored in register file
		location[0] = 32'h0;
		location[1] = 32'h1F06;
		location[2] = 32'h33A8;
		location[3] = 32'h3C66;
		location[4] = 32'h1F5A;
		location[5] = 32'hE6C;
		location[6] = 32'h269A;
		location[7] = 32'h2038;
		location[8] = 32'hD68;
		location[9] = 32'hB2;
		location[10] = 32'h94A;
		location[11] = 32'h206E;
		location[12] = 32'h250;
		location[13] = 32'h1D08;
		location[14] = 32'h294C;
		location[15] = 32'h1DFC;
		location[16] = 32'h4D6;
		location[17] = 32'h3E88;
		location[18] = 32'h97A;
		location[19] = 32'h2E9A;
		location[20] = 32'h1A44;
		location[21] = 32'h31F6;
		location[22] = 32'h12EA;
		location[23] = 32'h1BC4;
		location[24] = 32'h1898;
		location[25] = 32'hCFA;
		location[26] = 32'h2A60;
		location[27] = 32'h396A;
		location[28] = 32'h3FFA;
		location[29] = 32'h3C60;
		location[30] = 32'h4EC;
		location[31] = 32'h0;
		
		// initialize valid opcodes
		opcodes[0] = 6'h1;
		opcodes[1] = 6'h6;
		opcodes[2] = 6'hD;
		opcodes[3] = 6'h8;
		opcodes[4] = 6'h7;
		opcodes[5] = 6'h4;
		opcodes[6] = 6'hB;
		opcodes[7] = 6'hF;
		opcodes[8] = 6'h3;
		opcodes[9] = 6'h5;
		opcodes[10] = 6'h2;
		
		
		// initialize array of instructions
		instructions[0] = 32'h001F1041;
		instructions[1] = 32'h001FF886;	
		instructions[2] = 32'h000E03CD;
		instructions[3] = 32'h001300C8;
		instructions[4] = 32'h001910C7;
		instructions[5] = 32'h001C1884;
		instructions[6] = 32'h0000F28B;
		instructions[7] = 32'h0016008F;
		instructions[8] = 32'h001F1F43;
		instructions[9] = 32'h001A9C45;
		instructions[10] = 32'h00120642;
		
		size = 10;
		/*	 
		operation addr3, addr1, addr2
		add r31, r1, r2
		sub r31, r2, r31
		abs r14, r15
		neg r19, r3
		max r25, r3, r2
		min r28, r2, r3
		avg r0, r10, r30
		not r22, r2
		or r31, r29, r3
		and r26, r17, r19
		xor r18, r25, r0
		*/

	end
	
	always @(posedge clk) begin
		// on positive edge							   
		if(i == size+1)
			$finish;
			
		instruction = instructions[i];
		expected_result = calculate(location[instruction[10:6]], location[instruction[15:11]], instruction[5:0], opcodes);
		
		$display("================================(%0d)================================", i+1);
		$display("Instruction: 0x%h \nopcode = %0d, a = location[%0d] = %0d, b = location[%0d] = %0d", instruction, instruction[5:0], instruction[10:6], location[instruction[10:6]], instruction[15:11], location[instruction[15:11]]);
		
		#25 check(expected_result, result);		// after two clock cycles the result obtained from micro. then check if it is correct or not
		location[instruction[20:16]] = expected_result;
		i = i + 1;
	end
	
	function signed [31:0] calculate;		// as functionality of ALU just for verification
		input signed [31:0] a, b;
		input [5:0] opcode;
		input [5:0] opcodes[0:10];

		case(opcode)  
			/* Addition operation	*/
			opcodes[0]:
				return a + b;
			
			/* Subtraction operation */
			opcodes[1]:
				return a - b;
			
			/* Absolute value of input 'a' operation */
			opcodes[2]:
				if ( a < 0 )	// if 'a' is negative then change it positive by multiplying it with "-1"
					return (-1) * a;
				else			// else if not negative then the result equals 'a' whatever positive or zero
					return a;
			
			/* Negate the value of 'a' operation */
			opcodes[3]:
				return (-1) * a;	// just multiplying it with minus one whatever positive, negative or zero
			
			/* Maximum of 'a' and 'b' operation */
			opcodes[4]:
				if ( a > b )		// if 'a' greater than 'b', then result is 'a'
					return a;
				else if ( b > a )	// if the opposite then result is 'b'
					return b;
				else				// if 'a' equals 'b' then result anyone of them, I chose 'a'
					return a;
			
			/* Minimum of 'a' and 'b' operation */
			opcodes[5]:
				if ( a < b )		// if 'a' less than 'b', then result is 'a'
					return a;
				else if ( b < a )	// if the opposite then result is 'b'
					return b;
				else				// if 'a' equals 'b' then result anyone of them, I chose 'a'
					return a;
			
			/* Average value of 'a' and 'b' operation */
			opcodes[6]:
				return (a + b) / 2;
			
			/* invert all bits of 'a' (bit-wise NOT) operation */
			opcodes[7]:
				return ~a;		// Inverting all bits of 'a' then set the result of that to output 'result'
			
			/* bit-wise OR between 'a' and 'b' operation */
			opcodes[8]: 
				return a | b;		// ORing all bits of 'a' and 'b' then set the result of that to output 'result'
			
			/* bit-wise AND between 'a' and 'b' operation */
			opcodes[9]:
				return a & b;		// ANDing all bits of 'a' and 'b' then set the result of that to output 'result'
			
			/* bit-wise XOR between 'a' and 'b' operation */
			opcodes[10]:
				return a ^ b;		// XORing all bits of 'a' and 'b' then set the result of that to output 'result'
			
		endcase	
		
	endfunction	
	
	task check;
		input signed [31:0] expected_result;
		input signed [31:0] result;
		
		if(expected_result == result) begin
			$display("Result: %0d, Expected Result: %0d", result, expected_result);
			$display("\t\t==> Pass<==");
			$display("====================================================================");
			end
		else begin		
			$display("Result: %0d, Expected Result: %0d", result, expected_result);
			$display("\t\t==> Fail <==");
			$display("====================================================================");													 
			end
		
	endtask
	
endmodule

/*
Arithmetic And Logic Unit (ALU) of CPU module which is one of two main modules,
it is processing each process releated on operation code (opcode) provided
and calculate result of that.

*/
module alu (opcode, a, b, result );
	input [5:0] opcode; 				// operation code
	input signed [31:0] a, b; 			// numbers given to apply operation
	output reg signed [31:0] result;	// result of operation
	
	// defining parameters that represent the operation related on opcode entered to ALU
	// "names of parameters depends on operations"
	parameter ADD = 6'h1, SUB = 6'h6, ABS_A = 6'hD, NEG_A = 6'h8, MAX = 6'h7, MIN = 6'h4;
	parameter AVG = 6'hB, NOT_A = 6'hF, OR = 6'h3, AND = 6'h5, XOR = 6'h2;
	
	always @(opcode) begin
		case(opcode)  
			/* Addition operation	*/
			ADD:
				result = a + b;
			
			/* Subtraction operation */
			SUB:
				result = a - b;
			
			/* Absolute value of input 'a' operation */
			ABS_A:
				if ( a < 0 )	// if 'a' is negative then change it positive by multiplying it with "-1"
					result = (-1) * a;
				else			// else if not negative then the result equals 'a' whatever positive or zero
					result = a;
			
			/* Negate the value of 'a' operation */
			NEG_A: 
				result = (-1) * a;	// just multiplying it with minus one whatever positive, negative or zero
			
			/* Maximum of 'a' and 'b' operation */
			MAX:
				if ( a > b )		// if 'a' greater than 'b', then result is 'a'
					result = a;
				else if ( b > a )	// if the opposite then result is 'b'
					result = b;
				else				// if 'a' equals 'b' then result anyone of them, I chose 'a'
					result = a;
			
			/* Minimum of 'a' and 'b' operation */
			MIN:
				if ( a < b )		// if 'a' less than 'b', then result is 'a'
					result = a;
				else if ( b < a )	// if the opposite then result is 'b'
					result = b;
				else				// if 'a' equals 'b' then result anyone of them, I chose 'a'
					result = a;
			
			/* Average value of 'a' and 'b' operation */
			AVG:
				result = (a + b) / 2;
			
			/* invert all bits of 'a' (bit-wise NOT) operation */
			NOT_A:
				result = ~a;		// Inverting all bits of 'a' then set the result of that to output 'result'
			
			/* bit-wise OR between 'a' and 'b' operation */
			OR: 
				result = a | b;		// ORing all bits of 'a' and 'b' then set the result of that to output 'result'
			
			/* bit-wise AND between 'a' and 'b' operation */
			AND:
				result = a & b;		// ANDing all bits of 'a' and 'b' then set the result of that to output 'result'
			
			/* bit-wise XOR between 'a' and 'b' operation */
			XOR:
				result = a ^ b;		// XORing all bits of 'a' and 'b' then set the result of that to output 'result'
			
			/* No opcode: to do nothing keep result unchange */
			default: begin
				end
		endcase
	end
			
endmodule

/*
The register file module
It is very small fast RAM

Output 1 "out1" produces the item within the register file that is address by Address 1 "addr1".
Similarly Output 2 "out2" produces the item within the register file that is address by Address 2 "addr2".
Input "in" is used to supply a value that is written into the location addressed by Address 3 "addr3".

*/

module reg_file (clk, valid_opcode, addr1, addr2, addr3, in , out1, out2);
	input clk;									// clock cycle
	input valid_opcode;							// to check validity of operation code as "Enable" for the register file
	input [4:0] addr1, addr2, addr3;			// Addresses numbers 
	input signed [31:0] in; 					// input data to be written
	output reg signed [31:0] out1, out2;		// output 1 and output 2 data
	reg signed [31:0] location [0:31];			// 32 location each one 32-bit to store the values in it start from index 0
	
	/* Initializing contents of the register file */
	initial begin
		location[0] = 32'h0;
		location[1] = 32'h1F06;
		location[2] = 32'h33A8;
		location[3] = 32'h3C66;
		location[4] = 32'h1F5A;
		location[5] = 32'hE6C;
		location[6] = 32'h269A;
		location[7] = 32'h2038;
		location[8] = 32'hD68;
		location[9] = 32'hB2;
		location[10] = 32'h94A;
		location[11] = 32'h206E;
		location[12] = 32'h250;
		location[13] = 32'h1D08;
		location[14] = 32'h294C;
		location[15] = 32'h1DFC;
		location[16] = 32'h4D6;
		location[17] = 32'h3E88;
		location[18] = 32'h97A;
		location[19] = 32'h2E9A;
		location[20] = 32'h1A44;
		location[21] = 32'h31F6;
		location[22] = 32'h12EA;
		location[23] = 32'h1BC4;
		location[24] = 32'h1898;
		location[25] = 32'hCFA;
		location[26] = 32'h2A60;
		location[27] = 32'h396A;
		location[28] = 32'h3FFA;
		location[29] = 32'h3C60;
		location[30] = 32'h4EC;
		location[31] = 32'h0;
	end
	
	always @(posedge clk) begin
		
		if ( valid_opcode ) begin		// if opcode is valid
			out1 <= location[addr1];	// load value of address addr1 given to output out1
			out2 <= location[addr2];	// load value of address addr2 given to output out2
			location[addr3] <= in;		// store given value "in" in location of given address addr3
		end
		
	end
	
	
endmodule

/*
Microprocessor module which contain ALU and Register file build above
connect them and execute given instructions
*/
module mp_top (clk, instruction , result);
	input clk;							// clock for synchronization
	input [31:0] instruction; 			// instruction that contain opcode and addresses
	output reg signed [31:0] result;	// result of execution the given instruction
	reg [5:0] alu_opcode;				// opcode to be passed to ALU
	reg [5:0] opcode;					// operation code extracted from instruction
	reg valid_opcode;					// to check validity of operation code as "Enable" for the register file
	reg [4:0] addr1, addr2, addr3;		// Addresses numbers 
	reg signed [31:0] out1, out2;		// output 1 and output 2 data from register file
	
	// make instance from register file and passing parameters "inputs" and "outputs"
	reg_file register_file (.clk(clk), .valid_opcode(valid_opcode), .addr1(addr1), .addr2(addr2), .addr3(addr3), .in(result), .out1(out1), .out2(out2));
	
	// make instance from ALU component and passing parameters "inputs" and "outputs"
	alu alu_component (.opcode(alu_opcode), .a(out1), .b(out2), .result(result));
	
	// make instance of delay
	buffer buff (.clk(clk), .in(opcode), .out(alu_opcode));
	
	always @(posedge clk) begin
		opcode = instruction[5:0];	
		if(opcode > 0 && opcode < 9 )	// to check if given opcode is one of valid opcodes
			valid_opcode = 1;			
		else if(opcode == 11 || opcode == 13 || opcode == 15)
			valid_opcode = 1;
		else
			valid_opcode = 0;

		if(valid_opcode) begin	// Enabling the Register File
			addr1 = instruction[10:6];		// get second 5-bit for address 1
			addr2 = instruction[15:11];		// get third 5-bit for address 2
			addr3 = instruction[20:16];		// get fourth 5-bit for address 3
		end

	end
	
endmodule

/* buffer as D-Flip Flop to make delay on opcode */
module buffer(clk, in, out);
	input clk;
	input [5:0] in;
	output reg [5:0] out;
	
	always @(posedge clk)
		out <= in;
	
endmodule
