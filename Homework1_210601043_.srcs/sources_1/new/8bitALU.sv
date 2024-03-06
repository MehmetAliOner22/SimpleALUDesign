module SekizbitALU(
    input logic [7:0] A,       // 8-bit geni�li�inde A giri�i
    input logic [7:0] B,       // 8-bit geni�li�inde B giri�i
    input logic [1:0] ALUControl, // 2-bit kontrol sinyali
    output logic [6:0] Result,  // 7-bit geni�li�inde sonu�
    output logic SignBit         // ��aret biti
);
    logic [7:0] sum, sum_;    // Toplama sonucu i�in 8-bit geni�li�inde bir sinyal
    logic[7:0] AND_Result;    // AND i�lemi sonu�lar� i�in sinyal
    logic[7:0] OR_Result;     // OR i�lemi sonu�lar� i�in sinyal

    // NbitFulladder kullanarak toplama i�lemi
    NbitFulladder u_adder0(
        .a((A[7] == 1 & B[7] == 0) ? ~A : A),  // A giri�i: Negatif kontrol� ve se�imi yapar
        .b((B[7] == 1 & A[7] == 0) ? ~((ALUControl == 2'b01) ? ~B : B) : ((ALUControl == 2'b01) ? ~B : B)),  // B giri�i: Negatif kontrol� ve i�lem se�imi
        .cin(ALUControl[0]),   // ALUControl'un en d���k biti toplama i�lemine y�nlendirilir
        .s(sum),               // Toplama sonucu
        .cout()                // Ta��ma ��k���
    );

    always_comb begin
        // ALU kontrol sinyaline g�re i�lem yap
        case (ALUControl)
            2'b10: begin
                // ALUControl 10 ise her bit i�in AND i�lemi yap
                for (integer i = 0; i < 8; i = i + 1) begin
                    AND_Result[i] = A[i] & B[i];
                end
            end
            2'b11: begin
                // ALUControl 11 ise her bit i�in OR i�lemi yap
                for (integer i = 0; i < 8; i = i + 1) begin
                    OR_Result[i] = A[i] | B[i];
                end
            end
        endcase
    end

    // Di�er i�lemleri ALUControl sinyallerine g�re se�in
    always_comb begin
        case (ALUControl)
            2'b00: begin // ALUControl 00 ise Toplama i�lemi yap�l�r
                sum_ = ((A[7] == 1 & B[7] == 0) | (B[7] == 1 & A[7] == 0) ? ~sum : sum); //��karma i�lemi yap�l�yorsa sum'n tersi al�n�r.
                Result = sum_[6:0];
                SignBit = sum_[7];
            end
            2'b01: begin // ALUControl 01 ise ��karma i�lemi yap�l�r
                sum_ = ((A[7] == 1 & B[7] == 0) | (B[7] == 1 & A[7] == 0) ? ~sum : sum); //��karma i�lemi yap�l�yorsa sum'n tersi al�n�r.
                Result = sum_[6:0];
                SignBit = sum_[7];
            end
            2'b10: begin // ALUControl 10 ise AND i�lemi yap�l�r
                Result = AND_Result;
                SignBit = sum[7];
            end
            2'b11: begin // ALUControl 11 ise OR i�lemi yap�l�r
                Result = OR_Result;
                SignBit = sum[7];
            end
        endcase
    end
endmodule