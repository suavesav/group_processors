`include "ALU_if.vh"

module ALU
  import cpu_types_pkg::*;
   (
    ALU_if.rf aluif
    );

   always_comb
     begin
	casez (aluif.ALUOP)
	  ALU_SLL:                     //Logical shift Left
	    begin
	       aluif.Output_Port = aluif.Port_A << aluif.Port_B;
               aluif.Zero = logic'(aluif.Output_Port == 32'd0);
	       aluif.Overflow = 0;
	       aluif.Negative = aluif.Output_Port[31];
	    end
	  ALU_SRL:                     //Logical shift Right
	    begin
	       aluif.Output_Port = aluif.Port_A >> aluif.Port_B;
	       aluif.Zero = logic'(aluif.Output_Port == 32'd0);
	       aluif.Overflow = 0;
	       aluif.Negative = aluif.Output_Port[31];
	    end
	  ALU_ADD:                     //Signed ADD
	    begin
	       aluif.Output_Port = signed'(aluif.Port_A) + signed'(aluif.Port_B);
	       aluif.Zero = logic'(aluif.Output_Port == 32'd0);
	       aluif.Overflow = (!aluif.Port_A[31]) & (!aluif.Port_B[31]) & aluif.Output_Port[31];
	       aluif.Negative = aluif.Output_Port[31];
	    end
	  ALU_SUB:                     //Signed SUBTRACT
	    begin
	       aluif.Output_Port = signed'(aluif.Port_A) - signed'(aluif.Port_B);
	       aluif.Zero = logic'(aluif.Output_Port == 32'd0);
	       aluif.Overflow = (!aluif.Port_A[31]) & aluif.Port_B[31] & (!aluif.Output_Port[31]);
	       aluif.Negative = aluif.Output_Port[31];
	    end
	  ALU_AND:                     //Logical AND
	    begin
	       aluif.Output_Port = aluif.Port_A & aluif.Port_B;
	       aluif.Zero = logic'(aluif.Output_Port == 32'd0);
	       aluif.Overflow = 0;
	       aluif.Negative = aluif.Output_Port[31];
	    end
	  ALU_OR:                     //Logical OR
	    begin
	       aluif.Output_Port = aluif.Port_A | aluif.Port_B;
	       aluif.Zero = logic'(aluif.Output_Port == 32'd0);
	       aluif.Overflow = 0;
	       aluif.Negative = aluif.Output_Port[31];
	    end
	  ALU_XOR:                     //Logical XOR
	    begin
	       aluif.Output_Port = aluif.Port_A ^ aluif.Port_B;
	       aluif.Zero = logic'(aluif.Output_Port == 32'd0);
	       aluif.Overflow = 0;
	       aluif.Negative = aluif.Output_Port[31];
	    end
	  ALU_NOR:                     //Logical NOR
	    begin
	       aluif.Output_Port = ~(aluif.Port_A | aluif.Port_B);
	       aluif.Zero = logic'(aluif.Output_Port == 32'd0);
	       aluif.Overflow = 0;
	       aluif.Negative = aluif.Output_Port[31];
	    end
	  ALU_SLT:                     //Less than SIGNED
	    begin
	       aluif.Output_Port = {31'b0,signed'(aluif.Port_A) < signed'(aluif.Port_B)};
	       aluif.Zero = logic'(aluif.Output_Port == 32'd0);
	       aluif.Overflow = 0;
	       aluif.Negative = aluif.Output_Port[31];
	    end
	  ALU_SLTU:                     //Less than UNSIGNED
	    begin
	       aluif.Output_Port = {31'b0,aluif.Port_A < aluif.Port_B};
	       aluif.Zero = logic'(aluif.Output_Port == 32'd0);
	       aluif.Overflow = 0;
	       aluif.Negative = 0;
	    end
	  default:
	    begin
	       aluif.Output_Port = 0;
	       aluif.Zero = 0;
	       aluif.Overflow = 0;
	       aluif.Negative = 0;
	    end
	endcase // casez (aluif.ALUOP)

     end // always_comb

endmodule // ALU
