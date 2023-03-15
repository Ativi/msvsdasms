module analog_async_up_down(
      input vin,
      input vref,
      input VDD,
      output out
);

wire ring_osc_out;

// Instantiate the RingOsc_cap module
RingOsc_cap RingOsc_cap_inst(
        .out(ring_osc_out)
);

// Instantiate the adc module
adc onebitADC_test_inst(
      .vin(ring_osc_out),
      .vref(vref),
      .out(out)
);

endmodule

// Define the RingOsc_cap module
module RingOsc_cap (
        output out
);

endmodule

// Define the adc module
module adc (
      input vin,
      input vref,
      output out
);

endmodule

