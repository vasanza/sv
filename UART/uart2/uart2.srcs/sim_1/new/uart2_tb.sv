`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.07.2024 21:34:45
// Design Name: 
// Module Name: uart2_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module uart2_tb;

    // Parámetros de simulación
    parameter CLK_PERIOD = 20;  // Periodo del reloj en unidades de tiempo

    // Señales del test bench
    reg clk = 0;               // Señal de reloj
    reg reset = 1;             // Señal de reset (activo alto)
    reg rx = 1;                // Línea de recepción de datos seriales
    reg [7:0] tx_data = 8'h00; // Datos a transmitir (8 bits)
    reg tx_start = 0;          // Señal para iniciar la transmisión
    wire tx;                   // Línea de transmisión de datos seriales
    wire tx_busy;              // Señal que indica si la transmisión está en curso
    wire [7:0] rx_data;        // Datos recibidos (8 bits)
    wire rx_ready;             // Señal que indica si los datos han sido recibidos

    // Instancia del módulo UART bajo prueba
    uart2 dut (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .tx_data(tx_data),
        .tx_start(tx_start),
        .tx(tx),
        .tx_busy(tx_busy),
        .rx_data(rx_data),
        .rx_ready(rx_ready)
    );

    // Generación de reloj
    always #CLK_PERIOD clk = ~clk;

    // Inicialización del test bench
    initial begin
        // Reset inicial
        reset = 1;
        #100;  // Espera un tiempo
        reset = 0;
        
        // Simulación de transmisión
        tx_data = 8'h5A;  // Datos a transmitir
        tx_start = 1;     // Inicia la transmisión
        #100;             // Espera un tiempo
        tx_start = 0;     // Detiene la transmisión
        #1000;            // Espera un tiempo suficiente para la transmisión
        
        // Simulación de recepción (simplemente para demostración, deberías ajustar según necesidades)
        rx = 0;           // Inicia la recepción (bit de inicio)
        #100;             // Espera un tiempo
        rx = 1;           // Finaliza la recepción (bit de parada)
        
        // Finalización de la simulación
        $finish;
    end

endmodule