module SekizbitALU(
    input logic [7:0] A,       // 8-bit geniþliðinde A giriþi
    input logic [7:0] B,       // 8-bit geniþliðinde B giriþi
    input logic [1:0] ALUControl, // 2-bit kontrol sinyali
    output logic [6:0] Result,  // 7-bit geniþliðinde sonuç
    output logic SignBit         // Ýþaret biti
);
    logic [7:0] sum, sum_;    // Toplama sonucu için 8-bit geniþliðinde bir sinyal
    logic[7:0] AND_Result;    // AND iþlemi sonuçlarý için sinyal
    logic[7:0] OR_Result;     // OR iþlemi sonuçlarý için sinyal

    // NbitFulladder kullanarak toplama iþlemi
    NbitFulladder u_adder0(
        .a((A[7] == 1 & B[7] == 0) ? ~A : A),  // A giriþi: Negatif kontrolü ve seçimi yapar
        .b((B[7] == 1 & A[7] == 0) ? ~((ALUControl == 2'b01) ? ~B : B) : ((ALUControl == 2'b01) ? ~B : B)),  // B giriþi: Negatif kontrolü ve iþlem seçimi
        .cin(ALUControl[0]),   // ALUControl'un en düþük biti toplama iþlemine yönlendirilir
        .s(sum),               // Toplama sonucu
        .cout()                // Taþýma çýkýþý
    );

    always_comb begin
        // ALU kontrol sinyaline göre iþlem yap
        case (ALUControl)
            2'b10: begin
                // ALUControl 10 ise her bit için AND iþlemi yap
                for (integer i = 0; i < 8; i = i + 1) begin
                    AND_Result[i] = A[i] & B[i];
                end
            end
            2'b11: begin
                // ALUControl 11 ise her bit için OR iþlemi yap
                for (integer i = 0; i < 8; i = i + 1) begin
                    OR_Result[i] = A[i] | B[i];
                end
            end
        endcase
    end

    // Diðer iþlemleri ALUControl sinyallerine göre seçin
    always_comb begin
        case (ALUControl)
            2'b00: begin // ALUControl 00 ise Toplama iþlemi yapýlýr
                sum_ = ((A[7] == 1 & B[7] == 0) | (B[7] == 1 & A[7] == 0) ? ~sum : sum); //Çýkarma iþlemi yapýlýyorsa sum'n tersi alýnýr.
                Result = sum_[6:0];
                SignBit = sum_[7];
            end
            2'b01: begin // ALUControl 01 ise Çýkarma iþlemi yapýlýr
                sum_ = ((A[7] == 1 & B[7] == 0) | (B[7] == 1 & A[7] == 0) ? ~sum : sum); //Çýkarma iþlemi yapýlýyorsa sum'n tersi alýnýr.
                Result = sum_[6:0];
                SignBit = sum_[7];
            end
            2'b10: begin // ALUControl 10 ise AND iþlemi yapýlýr
                Result = AND_Result;
                SignBit = sum[7];
            end
            2'b11: begin // ALUControl 11 ise OR iþlemi yapýlýr
                Result = OR_Result;
                SignBit = sum[7];
            end
        endcase
    end
endmodule