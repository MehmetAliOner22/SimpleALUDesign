module FourbitALU_tb;

    reg [3:0] A;  // 4-bit geniþliðinde A giriþi
    reg [3:0] B;  // 4-bit geniþliðinde B giriþi
    reg [1:0] ALUControl;  // 2-bit kontrol sinyali
    
    wire [2:0] Result;  // 3-bit geniþliðinde sonuç
    wire SignBit;  // Ýþaret biti
    wire OV;  // Taþma bayraðý (Overflow)
    wire CY;  // Taþýma bayraðý (Carry)
    wire NEG;  // Negatif bayraðý (Negatif)
    wire ZERO;  // Sýfýr bayraðý (Zero)

    // FourbitALU modülünün çaðrýlmasý
    FourbitALU uut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .Result(Result),
        .SignBit(SignBit),
        .OV(OV),
        .CY(CY),
        .NEG(NEG),
        .ZERO(ZERO)
    );
    
    // Simülasyon için giriþ sinyallerinin ayarlanmasý
    initial begin
        A = 4'b0101;
        B = 4'b0011;
        ALUControl = 2'b00;  // Toplama iþlemi
        #10;  // Zaman gecikmesi
        
        // Test 1: Toplama iþlemi (ALUControl = 00)
        $display("Test 1: Toplama (ALUControl = 00)");
        $display("A = %b, B = %b, ALUControl = %b, Result = %b, SignBit = %b, OV = %b, CY = %b, NEG = %b, ZERO = %b", A, B, ALUControl, Result, SignBit, OV, CY, NEG, ZERO);

        A = 4'b0010;
        B = 4'b0011;
        ALUControl = 2'b00;  // Toplama iþlemi
        #10;  // Zaman gecikmesi
        
        // Test 2: Toplama iþlemi (ALUControl = 00)
        $display("Test 2: Toplama (ALUControl = 00)");
        $display("A = %b, B = %b, ALUControl = %b, Result = %b, SignBit = %b, OV = %b, CY = %b, NEG = %b, ZERO = %b", A, B, ALUControl, Result, SignBit, OV, CY, NEG, ZERO);

        A = 4'b0101;
        B = 4'b0011;
        ALUControl = 2'b01;  // Çýkarma iþlemi
        #10;  // Zaman gecikmesi
        
        // Test 3: Çýkarma iþlemi (ALUControl = 01)
        $display("Test 3: Çýkarma (ALUControl = 01)");
        $display("A = %b, B = %b, ALUControl = %b, Result = %b, SignBit = %b, OV = %b, CY = %b, NEG = %b, ZERO = %b", A, B, ALUControl, Result, SignBit, OV, CY, NEG, ZERO);

        A = 4'b1000;
        B = 4'b1000;
        ALUControl = 2'b01;  // Çýkarma iþlemi
        #10;  // Zaman gecikmesi
        
        // Test 4: Çýkarma iþlemi (ALUControl = 01)
        $display("Test 4: Çýkarma (ALUControl = 01)");
        $display("A = %b, B = %b, ALUControl = %b, Result = %b, SignBit = %b, OV = %b, CY = %b, NEG = %b, ZERO = %b", A, B, ALUControl, Result, SignBit, OV, CY, NEG, ZERO);

        A = 4'b0101;
        B = 4'b0011;
        ALUControl = 2'b10;  // AND iþlemi
        #10;  // Zaman gecikmesi
        
        // Test 5: AND iþlemi (ALUControl = 10)
        $display("Test 5: AND (ALUControl = 10)");
        $display("A = %b, B = %b, ALUControl = %b, Result = %b, SignBit = %b, OV = %b, CY = %b, NEG = %b, ZERO = %b", A, B, ALUControl, Result, SignBit, OV, CY, NEG, ZERO);

        A = 4'b1101;
        B = 4'b1000;
        ALUControl = 2'b10;  // AND iþlemi
        #10;  // Zaman gecikmesi
        
        // Test 6: AND iþlemi (ALUControl = 10)
        $display("Test 6: AND (ALUControl = 10)");
        $display("A = %b, B = %b, ALUControl = %b, Result = %b, SignBit = %b, OV = %b, CY = %b, NEG = %b, ZERO = %b", A, B, ALUControl, Result, SignBit, OV, CY, NEG, ZERO);

        A = 4'b0101;
        B = 4'b0011;
        ALUControl = 2'b11;  // OR iþlemi
        #10;  // Zaman gecikmesi
        
        // Test 7: OR iþlemi (ALUControl = 11)
        $display("Test 7: OR (ALUControl = 11)");
        $display("A = %b, B = %b, ALUControl = %b, Result = %b, SignBit = %b, OV = %b, CY = %b, NEG = %b, ZERO = %b", A, B, ALUControl, Result, SignBit, OV, CY, NEG, ZERO);

        A = 4'b1101;
        B = 4'b1000;
        ALUControl = 2'b11;  // OR iþlemi
        #10;  // Zaman gecikmesi
        
        // Test 8: OR iþlemi (ALUControl = 11)
        $display("Test 8: OR (ALUControl = 11)");
        $display("A = %b, B = %b, ALUControl = %b, Result = %b, SignBit = %b, OV = %b, CY = %b, NEG = %b, ZERO = %b", A, B, ALUControl, Result, SignBit, OV, CY, NEG, ZERO);

        $finish; // Simülasyonun sonlandýrýlmasý
    end

endmodule