module FourbitALU(
    input logic [3:0] A,           // 4-bit geniþliðinde A giriþi
    input logic [3:0] B,           // 4-bit geniþliðinde B giriþi
    input logic [1:0] ALUControl,  // 2-bit kontrol sinyali
    output logic [2:0] Result,     // 3-bit geniþliðinde sonuç
    output logic SignBit,          // Ýþaret biti
    output logic OV,               // Taþma bayraðý (Overflow)
    output logic CY,               // Taþýma bayraðý (Carry)
    output logic NEG,              // Negatif bayraðý
    output logic ZERO              // Sýfýr bayraðý
);

    logic [3:0] sum, sum_;           // Toplama sonucu için 4-bit geniþliðinde bir sinyal
    logic Cout = 0;                 // 1-bit geniþliðinde taþýma taþýyýcý için sinyal
    logic[3:0] AND_Result;          // AND iþleminin sonucu
    logic[3:0] OR_Result;           // OR iþleminin sonucu
    
    // NbitFulladder kullanarak toplama iþlemi
    FourbitFulladder u_adder0(
        .a((A[3] == 1 & B[3] == 0) ? ~A : A),  // A giriþi (çýkarma iþlemi için gerekli)
        .b((B[3] == 1 & A[3] == 0) ? ~((ALUControl == 2'b01) ? ~B : B ): ((ALUControl == 2'b01) ? ~B : B )),  // B giriþi (çýkarma iþlemi için gerekli)
        .cin(ALUControl[0]),           // ALUControl'un en düþük biti toplama iþlemine yönlendirilir
        .s(sum),                       // Toplama sonucu
        .cout(Cout)                    // Taþýma çýkýþý
    );
    
    always_comb begin
    // ALU kontrol sinyaline göre iþlem yap
    case (ALUControl)
        2'b10: begin
            // ALUControl 10 ise her bit için AND iþlemi yap
            for (integer i = 0; i < 4; i = i + 1) begin
                AND_Result[i] = A[i] & B[i];
            end
        end
        2'b11: begin
            // ALUControl 11 ise her bit için OR iþlemi yap
            for (integer i = 0; i < 4; i = i + 1) begin
                OR_Result[i] = A[i] | B[i];
            end
        end
    endcase
    end
    // Diðer iþlemleri ALUControl sinyallerine göre seçin
    always_comb begin
        case (ALUControl)
            2'b00: begin // ALUControl 00 ise Toplama iþlemi yapýlýr
                sum_ = ((A[3] == 1 & B[3] == 0) | (B[3] == 1 & A[3] == 0) ? ~sum : sum);
                Result = sum_[2:0];            // Sonucun alt 3 biti
                SignBit = sum_[3];             // Ýþaret biti
                OV = (~(ALUControl[0]^A[3]^B[3]) & (sum[3]^A[3]) & (~ALUControl[1])); // Taþma bayraðý (Overflow)
                CY = (((ALUControl[1] == 0) & (Cout == 1)) ? 1 : 0);                   // Taþýma bayraðý (Carry)
                NEG = SignBit;                 // Negatif bayraðý
                ZERO = (~sum_[0]) & (~sum_[1]) & (~sum_[2]);                         // Sýfýr bayraðý
            end
            2'b01: begin // ALUControl 01 ise Çýkarma iþlemi yapýlýr
                sum_ = ((A[3] == 1 & B[3] == 0) | (B[3] == 1 & A[3] == 0) ? ~sum : sum);
                Result = sum_[2:0];
                SignBit = sum_[3];
                OV = (~(ALUControl[0]^A[3]^B[3]) & (sum[3]^A[3]) & (~ALUControl[1])); // Taþma bayraðý
                CY = ((ALUControl[1] == 0) & (Cout == 1) ? 1 : 0); // Taþýma bayraðý
                NEG = SignBit;
                ZERO = (~sum_[0]) & (~sum_[1]) & (~sum_[2]); // Sýfýr bayraðý
            end
            2'b10: begin // ALUControl 10 ise AND iþlemi yapýlýr
                Result = AND_Result;
                SignBit = AND_Result[3];
                OV = (~(ALUControl[0]^A[3]^B[3]) & (sum[3]^A[3]) & (~ALUControl[1])); // Taþma bayraðý
                CY = ((ALUControl[1] == 0) & (Cout == 1) ? 1 : 0); // Taþýma bayraðý
                NEG = SignBit;
                ZERO = (~AND_Result[0]) & (~AND_Result[1]) & (~AND_Result[2]); // Sýfýr bayraðý
            end
            2'b11: begin // ALUControl 11 ise OR iþlemi yapýlýr
                Result = OR_Result;
                SignBit = OR_Result[3];
                OV = (~(ALUControl[0]^A[3]^B[3]) & (sum[3]^A[3]) & (~ALUControl[1])); // Taþma bayraðý
                CY = ((ALUControl[1] == 0) & (Cout == 1) ? 1 : 0); // Taþýma bayraðý
                NEG = SignBit;
                ZERO = (~OR_Result[0]) & (~OR_Result[1]) & (~OR_Result[2]); // Sýfýr bayraðý
            end
        endcase
    end
endmodule