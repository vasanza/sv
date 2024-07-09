# sv
#UART

![image](https://github.com/vasanza/sv/assets/62295761/efee71cc-1dc9-4abb-8146-d4b73f88297c)


Overview of UART Protocol
UART is a hardware communication protocol that uses asynchronous serial communication with configurable speed. It is widely used for communication between microcontrollers and peripheral devices or computers. The UART protocol involves two main parts: the transmitter and the receiver.

Key Features
Asynchronous Communication: No need for a shared clock signal between the transmitter and receiver.
Baud Rate: Defines the speed of communication in bits per second (bps).
Data Frame: Typically consists of a start bit, 5-9 data bits, an optional parity bit, and 1 or 2 stop bits.
Error Detection: Optional parity bit for error checking.
Implementation Steps
Define Parameters:

Baud rate
Data bits
Stop bits
Parity (optional)
Module Declaration:
Create separate modules for the UART transmitter and receiver.

Clock Divider:
Generate a clock signal at the desired baud rate from the system clock.

UART Transmitter:

Idle State: Waits for data to be available for transmission.
Start Bit: A '0' bit indicating the start of a transmission.
Data Bits: Transmit data bits sequentially.
Parity Bit: Optionally transmit the parity bit.
Stop Bits: One or two '1' bits indicating the end of the transmission.
UART Receiver:

Idle State: Waits for the start bit.
Start Bit Detection: Detects the transition from '1' to '0'.
Data Bits Reception: Receives and stores data bits.
Parity Check: Optionally checks the parity bit for errors.
Stop Bit Verification: Verifies the presence of the stop bit(s).
Synchronization and Sampling:

Sample the incoming signal at the middle of each bit period to ensure stability.
