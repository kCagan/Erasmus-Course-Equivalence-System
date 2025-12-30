USE ErasmusProjectDB;
GO

-- =============================================================
-- TRIGGER 2: Deðerlendirme Puaný Kontrolü
-- Tablo: ASSESSMENT
-- Amaç: Bir dersin sýnav/ödev katký paylarý toplamý 100'ü geçemez.
-- Geçerse hata verir ve iþlemi iptal eder.
-- =============================================================

CREATE OR ALTER TRIGGER trg_CheckAssessmentTotal
ON ASSESSMENT
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @CourseCode NVARCHAR(50);
    DECLARE @TotalContribution INT;

    -- Ýþlem yapýlan dersin kodunu al
    SELECT @CourseCode = CourseCode FROM inserted;

    -- O dersin toplam puanýný hesapla
    SELECT @TotalContribution = SUM(Contribution) 
    FROM ASSESSMENT 
    WHERE CourseCode = @CourseCode;

    -- Kontrol: 100'ü geçti mi?
    IF @TotalContribution > 100
    BEGIN
        RAISERROR ('HATA: Bir dersin toplam degerlendirme puani 100''u gecemez! Islem iptal edildi.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        PRINT '>>> TRIGGER 2 KONTROL ETTI: Puan toplami 100 siniri icinde.';
    END
END;
GO