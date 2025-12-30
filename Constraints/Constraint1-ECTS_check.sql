USE ErasmusProjectDB;
GO

-- =============================================================
-- CONSTRAINT 1: AKTS Geçerlilik Kontrolü
-- Tablo: COURSE
-- Kural: ECTS deðeri 0'dan büyük ve 30'a eþit veya küçük olmalýdýr.
-- =============================================================

ALTER TABLE COURSE
ADD CONSTRAINT CHK_ECTS_Valid 
CHECK (ECTS > 0 AND ECTS <= 30);

PRINT '>>> CONSTRAINT 1 EKLENDI: AKTS degerleri artik 1-30 arasinda olmak zorunda.';
GO