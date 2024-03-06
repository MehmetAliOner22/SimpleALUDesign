module SekizbitALU_testbench;

    reg [7:0] A, B; // 8-bit geniþliðinde A ve B giriþ sinyalleri
    reg [1:0] ALUControl; // 2-bit ALU kontrol sinyali
    wire [6:0] Result; // 7-bit sonuç sinyali
    wire SignBit; // Ýþaret biti sinyali
    
    // SekizbitALU modülünün örneklemesi
    SekizbitALU u_alu(
        .A(A), // A giriþi
        .B(B), // B giriþi
        .ALUControl(ALUControl), // ALU kontrol sinyali
        .Result(Result), // Sonuç sinyali
        .SignBit(SignBit) // Ýþaret biti sinyali
    );

    // Test sinyalleri oluþturuluyor
    initial begin
        // Test 1: Toplama (ALUControl = 00)
        $display("Test 1: Toplama (ALUControl = 00)");
        A = 8'b10001010;
        B = 8'b00000100;
        ALUControl = 2'b00;
        #10; // Zaman adýmý
        
        // Test 2: Toplama (ALUControl = 00)
        $display("Test 2: Toplama (ALUControl = 00)");
        A = 8'b10110011;
        B = 8'b00101010;
        ALUControl = 2'b00;
        #10; // Zaman adýmý
        
        // Test 3: Çýkarma (ALUControl = 01)
        $display("Test 3: Çýkarma (ALUControl = 01)");
        A = 8'b11011010;
        B = 8'b00100101;
        ALUControl = 2'b01;
        #10; // Zaman adýmý
        
        // Test 4: Çýkarma (ALUControl = 01)
        $display("Test 4: Çýkarma (ALUControl = 01)");
        A = 8'b00110011;
        B = 8'b10101010;
        ALUControl = 2'b01;
        #10; // Zaman adýmý
        
        // Test 5: AND (ALUControl = 10)
        $display("Test 5: AND (ALUControl = 10)");
        A = 8'b11011010;
        B = 8'b00100101;
        ALUControl = 2'b10;
        #10; // Zaman adýmý
        
        // Test 6: AND (ALUControl = 10)
        $display("Test 6: AND (ALUControl = 10)");
        A = 8'b00110011;
        B = 8'b10101010;
        ALUControl = 2'b10;
        #10; // Zaman adýmý
        
        // Test 7: OR (ALUControl = 11)
        $display("Test 7: OR (ALUControl = 11)");
        A = 8'b11011010;
        B = 8'b00100101;
        ALUControl = 2'b11;
        #10; // Zaman adýmý
        
        // Test 8: OR (ALUControl = 11)
        $display("Test 8: OR (ALUControl = 11)");
        A = 8'b00110011;
        B = 8'b10101010;
        ALUControl = 2'b11;
        #10; // Zaman adýmý
        
        $finish; // Testleri sonlandýr
    end
endmodule