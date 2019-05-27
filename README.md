# OSI 560Z Utility Package (Modified)
Modified driver and utility package for the OSI 560Z processor lab board.



## Summary
This is a utility and driver package for the OSI 560Z processor lab board. It provides: 
1. Utility routines for working with the board and its attached bus
2. A Z80 IO instruction handler
3. An Intersil 6100 IOT instruction handler.

The package is based on Ohio Scientific's official "example" driver/utility package. This source branch has been modified by me, and has several distinct changes.
### Utility package changes:
* Many routines changed for ease of readability and flexibility
* Utility routines rewritten to be independent from OS-65D
* **#** - (Open record): Modified to use spacebar to open next record
* **G** - (Start Z80 or 6100 execution): Modified to enter single-step mode if trace flag ('T' command) is set
* **R** - (Single-stepping run): Modified to provide trace of Z80 and 6100 execution. Syntax changed to R[I,Z][####]. Entering I traces 6100 execution. Entering Z traces Z80 execution.
* **N** - (New utilities): N[M]: Set MOS bus as master and set upper address bits to %000
### Z80 IO driver changes:
* Support for optional "auxiliary" ACIA
* If the trace flag is set, the driver package checks if the Z80 is requesting an IO device and returns if it is not.
* IO device '0' provides terminal I/O. A character can be requested from the terminal with `IN 0`. Likewise, a character can be written to the terminal via `OUT 0`. The 6502 does the ACIA status flag checking and resumes the Z80's execution as soon as the operation is fullfilled.
### Intersil 6100 driver changes:
* Support for optional "auxiliary" ACIA
* Many routiens re-written to be more readable

This list is incomplete. Due to the code growing as I debugged the hardware, there are probably many other changes that I made and have forgotten about.

## Requirements
* CC65
* SRecord

## Instructions
1. In all three assembly files, modify the `BASE` and `BLOC` defines to match your 560Z's address
2. In the 6100 and Z80 driver assembly files, select which ACIA you would like to use for terminal I/O. By default the base 502 ACIA at $FC00 is used.
3. Run `make` to assemble the package and generate an Intel HEX file. By default, the package is assembled at memory location $0400
4. Transfer the binary over to the OSI system via an Intel HEX loader and start execution at address $0400

## Reference Material
* [560Z Manual With Utility Package Instructions](http://osi.marks-lab.com/boards/schematics/OSI560Zfull.pdf)
* [Original Driver Package Assembly Listing](http://www.osiweb.org/manuals/560Z_software_listing.pdf)
