USE ErasmusProjectDB;
GO

-- =============================================================
-- CONSTRAINT 3: Eðitim Dili (Language) Kontrolü
-- Tablo: COURSE
-- Kural: Ders eþdeðerliliði (Equivalency) kurallarý gereði,
-- dersin dili sistemde tanýmlý dillerden (Turkish veya English) biri olmalýdýr.
-- =============================================================

ALTER TABLE COURSE
ADD CONSTRAINT CHK_Language_Valid 
CHECK (Language IN ('Turkish', 'English'));

PRINT '>>> CONSTRAINT 3 EKLENDI: Egitim dili sadece Turkish veya English olabilir.';
GO