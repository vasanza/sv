# SystemVerilog

## Use Qemu open-source emulator (but performance is not able to measure)
- Here are the steps to emulate a Xilinx FPGA on QEMU in Linux using Docker to simplify the QEMU configurations:
### 1. Install Docker
Ensure Docker is installed on your system. If it isn't, you can install it using the following commands:
**sh**
``` {r global_options, include = FALSE}
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce
sudo usermod -aG docker ${USER}
```
Log out and back in to apply the group changes.
### 2. Create a Dockerfile
Create a Dockerfile to set up the environment for QEMU and Xilinx FPGA emulation. Here’s an example Dockerfile:
**Dockerfile**
``` {r global_options, include = FALSE}
# Use an official Ubuntu as a parent image
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    libtool \
    libglib2.0-dev \
    libpixman-1-dev \
    zlib1g-dev \
    wget \
    qemu-system-arm

# Clone QEMU repository
RUN git clone https://github.com/qemu/qemu.git /qemu

# Configure and build QEMU
WORKDIR /qemu
RUN ./configure --target-list=arm-softmmu && make -j$(nproc)

# Add entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
```
### 3. Create an Entrypoint Script
Create an entrypoint script (entrypoint.sh) to run QEMU with the necessary parameters:
**sh**
``` {r global_options, include = FALSE}
#!/bin/bash

# Example command to run QEMU
exec /qemu/build/qemu-system-arm -M xilinx-zynq-a9 -kernel /zImage -dtb /devicetree.dtb -sd /rootfs.ext3 -serial mon:stdio -net nic -net user "$@"
```
### 4. Build the Docker Image
Build the Docker image using the Dockerfile:
**sh**
``` {r global_options, include = FALSE}docker build -t qemu-xilinx .
docker build -t qemu-xilinx .
```
### 5. Prepare the Necessary Files

Ensure you have the kernel image (zImage), device tree blob (devicetree.dtb), and root filesystem image (rootfs.ext3). Place these files in a directory.
### 6. Run the Docker Container
Run the Docker container with the appropriate volume mounts:
**sh**
``` {r global_options, include = FALSE}docker build -t qemu-xilinx .
docker run --rm -it \
    -v /path/to/zImage:/zImage \
    -v /path/to/devicetree.dtb:/devicetree.dtb \
    -v /path/to/rootfs.ext3:/rootfs.ext3 \
    qemu-xilinx
```
### Example Steps Summary
Here’s a summary of the steps you might use, tailored to a Xilinx Zynq setup:
**Install Docker (sh)**
``` {r global_options, include = FALSE}docker build -t qemu-xilinx .
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce
sudo usermod -aG docker ${USER}
# Log out and log back in
```
**Create Dockerfile**
``` {r global_options, include = FALSE}docker build -t qemu-xilinx .
FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    libtool \
    libglib2.0-dev \
    libpixman-1-dev \
    zlib1g-dev \
    wget \
    qemu-system-arm
RUN git clone https://github.com/qemu/qemu.git /qemu
WORKDIR /qemu
RUN ./configure --target-list=arm-softmmu && make -j$(nproc)
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
```
**Create entrypoint script (sh)**
``` {r global_options, include = FALSE}docker build -t qemu-xilinx .
#!/bin/bash
exec /qemu/build/qemu-system-arm -M xilinx-zynq-a9 -kernel /zImage -dtb /devicetree.dtb -sd /rootfs.ext3 -serial mon:stdio -net nic -net user "$@"
```
**Build Docker image (sh)**
``` {r global_options, include = FALSE}docker build -t qemu-xilinx .
#!/bin/bash
docker build -t qemu-xilinx .
```
**Run Docker container (sh)**
``` {r global_options, include = FALSE}docker build -t qemu-xilinx .
docker run --rm -it \
    -v /path/to/zImage:/zImage \
    -v /path/to/devicetree.dtb:/devicetree.dtb \
    -v /path/to/rootfs.ext3:/rootfs.ext3 \
    qemu-xilinx
```
### Notes

- Ensure you have the correct paths to zImage, devicetree.dtb, and rootfs.ext3 when running the Docker container.
- Modify the Dockerfile and entrypoint script as necessary to fit your specific requirements and setup.
- Docker simplifies the setup and ensures a consistent environment for QEMU and FPGA emulation.
    
---
## UART

![image](https://github.com/vasanza/sv/assets/62295761/efee71cc-1dc9-4abb-8146-d4b73f88297c)

#### Schematic

![image](https://github.com/vasanza/sv/assets/62295761/f49547a4-9e1d-4ce7-8977-ab27646f5415)


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
