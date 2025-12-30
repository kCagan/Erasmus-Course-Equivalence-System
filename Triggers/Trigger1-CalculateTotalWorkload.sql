USE ErasmusProjectDB;
GO

-- =============================================================
-- TRIGGER 1: Otomatik Ýþ Yükü Hesaplama
-- Tablo: ECTS_WORKLOAD
-- Amaç: Kullanýcý 'Count' ve 'Duration' girdiðinde, sistem 
-- 'TotalWorkload' alanýný otomatik olarak (Count * Duration) hesaplar.
-- =============================================================

CREATE OR ALTER TRIGGER trg_CalculateTotalWorkload
ON ECTS_WORKLOAD
AFTER INSERT, UPDATE
AS
BEGIN
    -- Sonsuz döngüyü (Recursive Trigger) engellemek için kontrol
    IF TRIGGER_NESTLEVEL() > 1 RETURN;

    -- Inserted tablosundan gelen verilerle güncelleme yap
    UPDATE ECTS_WORKLOAD
    SET TotalWorkload = i.Count * i.Duration
    FROM ECTS_WORKLOAD w
    INNER JOIN inserted i ON w.CourseCode = i.CourseCode AND w.ActivityName = i.ActivityName;
    
    PRINT '>>> TRIGGER 1 CALISTI: Toplam is yuku otomatik hesaplandi.';
END;
GO