USE ErasmusProjectDB;
GO

-- =============================================================
-- CONSTRAINT 2: Pozitif Ders Saati Kontrolü
-- Tablo: COURSE
-- Kural: Teorik (T), Pratik (P) ve Lab (L) saatleri 0'dan küçük olamaz.
-- =============================================================

ALTER TABLE COURSE
ADD CONSTRAINT CHK_Hours_NonNegative 
CHECK (T_Hour >= 0 AND P_Hour >= 0 AND L_Hour >= 0);

PRINT '>>> CONSTRAINT 2 EKLENDI: Ders saatleri (T, P, L) negatif girilemez.';
GO