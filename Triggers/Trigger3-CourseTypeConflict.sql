USE ErasmusProjectDB;
GO

-- =============================================================
-- TRIGGER 3: Ders Türü Çakýþma Kontrolü
-- Tablo: MANDATORY (Zorunlu Dersler)
-- Amaç: Bir ders 'Zorunlu' tablosuna eklenirken, 'Teknik Seçmeli' 
-- tablosunda olup olmadýðý kontrol edilir. Varsa engellenir.
-- =============================================================

CREATE OR ALTER TRIGGER trg_CheckCourseTypeConflict
ON MANDATORY
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @CourseCode NVARCHAR(50);
    -- Eklenen dersin kodunu al
    SELECT @CourseCode = CourseCode FROM inserted;

    -- Diðer tabloda (TECHNICAL_ELECTIVE) var mý diye bak
    IF EXISTS (SELECT * FROM TECHNICAL_ELECTIVE WHERE CourseCode = @CourseCode)
    BEGIN
        RAISERROR ('HATA: Bu ders zaten TEKNIK SECMELI olarak kayitli. Ayni anda ZORUNLU olamaz!', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        PRINT '>>> TRIGGER 3 ONAYLADI: Ders turu cakismasi yok.';
    END
END;
GO