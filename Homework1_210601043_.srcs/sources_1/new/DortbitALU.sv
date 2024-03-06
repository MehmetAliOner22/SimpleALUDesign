module FourbitALU(
    input logic [3:0] A,           // 4-bit geni�li�inde A giri�i
    input logic [3:0] B,           // 4-bit geni�li�inde B giri�i
    input logic [1:0] ALUControl,  // 2-bit kontrol sinyali
    output logic [2:0] Result,     // 3-bit geni�li�inde sonu�
    output logic SignBit,          // ��aret biti
    output logic OV,               // Ta�ma bayra�� (Overflow)
    output logic CY,               // Ta��ma bayra�� (Carry)
    output logic NEG,              // Negatif bayra��
    output logic ZERO              // S�f�r bayra��
);

    logic [3:0] sum, sum_;           // Toplama sonucu i�in 4-bit geni�li�inde bir sinyal
    logic Cout = 0;                 // 1-bit geni�li�inde ta��ma ta��y�c� i�in sinyal
    logic[3:0] AND_Result;          // AND i�leminin sonucu
    logic[3:0] OR_Result;           // OR i�leminin sonucu
    
    // NbitFulladder kullanarak toplama i�lemi
    FourbitFulladder u_adder0(
        .a((A[3] == 1 & B[3] == 0) ? ~A : A),  // A giri�i (��karma i�lemi i�in gerekli)
        .b((B[3] == 1 & A[3] == 0) ? ~((ALUControl == 2'b01) ? ~B : B ): ((ALUControl == 2'b01) ? ~B : B )),  // B giri�i (��karma i�lemi i�in gerekli)
        .cin(ALUControl[0]),           // ALUControl'un en d���k biti toplama i�lemine y�nlendirilir
        .s(sum),                       // Toplama sonucu
        .cout(Cout)                    // Ta��ma ��k���
    );
    
    always_comb begin
    // ALU kontrol sinyaline g�re i�lem yap
    case (ALUControl)
        2'b10: begin
            // ALUControl 10 ise her bit i�in AND i�lemi yap
            for (integer i = 0; i < 4; i = i + 1) begin
                AND_Result[i] = A[i] & B[i];
            end
        end
        2'b11: begin
            // ALUControl 11 ise her bit i�in OR i�lemi yap
            for (integer i = 0; i < 4; i = i + 1) begin
                OR_Result[i] = A[i] | B[i];
            end
        end
    endcase
    end
    // Di�er i�lemleri ALUControl sinyallerine g�re se�in
    always_comb begin
        case (ALUControl)
            2'b00: begin // ALUControl 00 ise Toplama i�lemi yap�l�r
                sum_ = ((A[3] == 1 & B[3] == 0) | (B[3] == 1 & A[3] == 0) ? ~sum : sum);
                Result = sum_[2:0];            // Sonucun alt 3 biti
                SignBit = sum_[3];             // ��aret biti
                OV = (~(ALUControl[0]^A[3]^B[3]) & (sum[3]^A[3]) & (~ALUControl[1])); // Ta�ma bayra�� (Overflow)
                CY = (((ALUControl[1] == 0) & (Cout == 1)) ? 1 : 0);                   // Ta��ma bayra�� (Carry)
                NEG = SignBit;                 // Negatif bayra��
                ZERO = (~sum_[0]) & (~sum_[1]) & (~sum_[2]);                         // S�f�r bayra��
            end
            2'b01: begin // ALUControl 01 ise ��karma i�lemi yap�l�r
                sum_ = ((A[3] == 1 & B[3] == 0) | (B[3] == 1 & A[3] == 0) ? ~sum : sum);
                Result = sum_[2:0];
                SignBit = sum_[3];
                OV = (~(ALUControl[0]^A[3]^B[3]) & (sum[3]^A[3]) & (~ALUControl[1])); // Ta�ma bayra��
                CY = ((ALUControl[1] == 0) & (Cout == 1) ? 1 : 0); // Ta��ma bayra��
                NEG = SignBit;
                ZERO = (~sum_[0]) & (~sum_[1]) & (~sum_[2]); // S�f�r bayra��
            end
            2'b10: begin // ALUControl 10 ise AND i�lemi yap�l�r
                Result = AND_Result;
                SignBit = AND_Result[3];
                OV = (~(ALUControl[0]^A[3]^B[3]) & (sum[3]^A[3]) & (~ALUControl[1])); // Ta�ma bayra��
                CY = ((ALUControl[1] == 0) & (Cout == 1) ? 1 : 0); // Ta��ma bayra��
                NEG = SignBit;
                ZERO = (~AND_Result[0]) & (~AND_Result[1]) & (~AND_Result[2]); // S�f�r bayra��
            end
            2'b11: begin // ALUControl 11 ise OR i�lemi yap�l�r
                Result = OR_Result;
                SignBit = OR_Result[3];
                OV = (~(ALUControl[0]^A[3]^B[3]) & (sum[3]^A[3]) & (~ALUControl[1])); // Ta�ma bayra��
                CY = ((ALUControl[1] == 0) & (Cout == 1) ? 1 : 0); // Ta��ma bayra��
                NEG = SignBit;
                ZERO = (~OR_Result[0]) & (~OR_Result[1]) & (~OR_Result[2]); // S�f�r bayra��
            end
        endcase
    end
endmodule