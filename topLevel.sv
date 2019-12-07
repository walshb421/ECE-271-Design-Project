/*

	Top-level module for the design project

*/

module topLevel
		(input clock50MHz,
		 input NESDataYellow,
		 input [9:0] ADCdata,
                 input outputSwitch,
		 output audioOut,
		 output vgaHsync, vgaVsync,
		 output [3:0] vgaOutRed, vgaOutGreen, vgaOutBlue
                 output [6:0] Seg0, Seg1, Seg2, Seg3, Seg4, Seg5);
		 
	clockDivBy2 clockDiv1 (
		.clock50MHz(clock50MHz),
		.outClock(clock25MHz)
	);

	NesReader NesReader1 (
		.dataYellow(NESDataYellow),
		.clock(clock50MHz),
		.reset_n(),
		.latchOrange(),
		.clockRed(clock25MHz),
		.up(NESUp),
		.down(NESDown),
		.left(NESLeft),
		.right(NESRight),
		.start(NESStart),
		.select(NESSelect),
		.a(NESA),
		.b(NESB)
	);

	vgaOutput vgaOutput1 (
		.clock50MHz(clock50MHz),
		.inReset(NESStart | outputSwitch),
		.inRed(NESUp),
		.inGreen(NESLeft),
		.inBlue(NESRight),
		.hSync(vgaVsync),
		.vSync(vgaHsync),
		.outRed(vgaOutRed),
		.outGreen(vgaOutGreen),
		.outBlue(vgaOutBlue)
	);

        clock_driver clock (
                .clk_50MHz(clock50MHz),
                .reset(NESSelect),
                .en(outputSwitch),
                .start(NESStart),
                .up(NESUp),
                .down(NESDown),
                .right(NESRight),
                .left(NESLeft)
        );

	periodTime SqTop(
		.clk(clock50MHz),
		.data(ADCdata),
		.q(AudioPin)
	);


endmodule