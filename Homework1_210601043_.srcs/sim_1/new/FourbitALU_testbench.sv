module FourbitALU_tb;

    reg [3:0] A;  // 4-bit geni�li�inde A giri�i
    reg [3:0] B;  // 4-bit geni�li�inde B giri�i
    reg [1:0] ALUControl;  // 2-bit kontrol sinyali
    
    wire [2:0] Result;  // 3-bit geni�li�inde sonu�
    wire SignBit;  // ��aret biti
    wire OV;  // Ta�ma bayra�� (Overflow)
    wire CY;  // Ta��ma bayra�� (Carry)
    wire NEG;  // Negatif bayra�� (Negatif)
    wire ZERO;  // S�f�r bayra�� (Zero)

    // FourbitALU mod�l�n�n �a�r�lmas�
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
    
    // Sim�lasyon i�in giri� sinyallerinin ayarlanmas�
    initial begin
        A = 4'b0101;
        B = 4'b0011;
        ALUControl = 2'b00;  // Toplama i�lemi
        #10;  // Zaman gecikmesi
        
        // Test 1: Toplama i�lemi (ALUControl = 00)
        $display("Test 1: Toplama (ALUControl = 00)");
        $display("A = %b, B = %b, ALUControl = %b, Result = %b, SignBit = %b, OV = %b, CY = %b, NEG = %b, ZERO = %b", A, B, ALUControl, Result, SignBit, OV, CY, NEG, ZERO);

        A = 4'b0010;
        B = 4'b0011;
        ALUControl = 2'b00;  // Toplama i�lemi
        #10;  // Zaman gecikmesi
        
        // Test 2: Toplama i�lemi (ALUControl = 00)
        $display("Test 2: Toplama (ALUControl = 00)");
        $display("A = %b, B = %b, ALUControl = %b, Result = %b, SignBit = %b, OV = %b, CY = %b, NEG = %b, ZERO = %b", A, B, ALUControl, Result, SignBit, OV, CY, NEG, ZERO);

        A = 4'b0101;
        B = 4'b0011;
        ALUControl = 2'b01;  // ��karma i�lemi
        #10;  // Zaman gecikmesi
        
        // Test 3: ��karma i�lemi (ALUControl = 01)
        $display("Test 3: ��karma (ALUControl = 01)");
        $display("A = %b, B = %b, ALUControl = %b, Result = %b, SignBit = %b, OV = %b, CY = %b, NEG = %b, ZERO = %b", A, B, ALUControl, Result, SignBit, OV, CY, NEG, ZERO);

        A = 4'b1000;
        B = 4'b1000;
        ALUControl = 2'b01;  // ��karma i�lemi
        #10;  // Zaman gecikmesi
        
        // Test 4: ��karma i�lemi (ALUControl = 01)
        $display("Test 4: ��karma (ALUControl = 01)");
        $display("A = %b, B = %b, ALUControl = %b, Result = %b, SignBit = %b, OV = %b, CY = %b, NEG = %b, ZERO = %b", A, B, ALUControl, Result, SignBit, OV, CY, NEG, ZERO);

        A = 4'b0101;
        B = 4'b0011;
        ALUControl = 2'b10;  // AND i�lemi
        #10;  // Zaman gecikmesi
        
        // Test 5: AND i�lemi (ALUControl = 10)
        $display("Test 5: AND (ALUControl = 10)");
        $display("A = %b, B = %b, ALUControl = %b, Result = %b, SignBit = %b, OV = %b, CY = %b, NEG = %b, ZERO = %b", A, B, ALUControl, Result, SignBit, OV, CY, NEG, ZERO);

        A = 4'b1101;
        B = 4'b1000;
        ALUControl = 2'b10;  // AND i�lemi
        #10;  // Zaman gecikmesi
        
        // Test 6: AND i�lemi (ALUControl = 10)
        $display("Test 6: AND (ALUControl = 10)");
        $display("A = %b, B = %b, ALUControl = %b, Result = %b, SignBit = %b, OV = %b, CY = %b, NEG = %b, ZERO = %b", A, B, ALUControl, Result, SignBit, OV, CY, NEG, ZERO);

        A = 4'b0101;
        B = 4'b0011;
        ALUControl = 2'b11;  // OR i�lemi
        #10;  // Zaman gecikmesi
        
        // Test 7: OR i�lemi (ALUControl = 11)
        $display("Test 7: OR (ALUControl = 11)");
        $display("A = %b, B = %b, ALUControl = %b, Result = %b, SignBit = %b, OV = %b, CY = %b, NEG = %b, ZERO = %b", A, B, ALUControl, Result, SignBit, OV, CY, NEG, ZERO);

        A = 4'b1101;
        B = 4'b1000;
        ALUControl = 2'b11;  // OR i�lemi
        #10;  // Zaman gecikmesi
        
        // Test 8: OR i�lemi (ALUControl = 11)
        $display("Test 8: OR (ALUControl = 11)");
        $display("A = %b, B = %b, ALUControl = %b, Result = %b, SignBit = %b, OV = %b, CY = %b, NEG = %b, ZERO = %b", A, B, ALUControl, Result, SignBit, OV, CY, NEG, ZERO);

        $finish; // Sim�lasyonun sonland�r�lmas�
    end

endmodule