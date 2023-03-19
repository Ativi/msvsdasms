module analog_async_up_down(
   input vref,
   output out,
   output Vin  // Declare Vin as an output port
);

wire RINGOSC_0_Vin;

RINGOSC_0 RINGOSC_0 (
   .Vin(RINGOSC_0_Vin)
);

ONEBITADC_0 ONEBITADC_0 (
  .Vin(RINGOSC_0_Vin),
  .vref(vref),
  .out(out)
);

sky130_fd_sc_hd__conb_1 _1_ (
  .LO(Vin)
);

endmodule

module RINGOSC_0 (
    output Vin
);

wire Vin_;
assign Vin = Vin_;

endmodule 

module ONEBITADC_0 (
     input Vin,
     input vref,
     output out
);

assign out = Vin > vref;

endmodule

