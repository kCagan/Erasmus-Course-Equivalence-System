USE ErasmusProjectDB;
GO

-- =============================================================
-- STORED PROCEDURE: AKTS'ye Göre Ders Arama Motoru
-- Amaç: Kullanýcýdan sadece bir sayý alýr ve o kredideki dersleri listeler.
-- Kullanýmý: EXEC sp_SearchCourseByECTS 5;
-- =============================================================

CREATE OR ALTER PROCEDURE sp_SearchCourseByECTS
    @TargetECTS INT -- (Kullanýcýnýn gireceði deðer parametre olarak tanýmlandý)
AS
BEGIN
    SET NOCOUNT ON; -- (Gereksiz "x rows affected" mesajýný gizler, performansý artýrýr)

    PRINT '>>> ARANAN KRITER: ' + CAST(@TargetECTS AS NVARCHAR(5)) + ' AKTS DEGERINE SAHIP DERSLER GETIRILIYOR...';

    SELECT 
        U.Name AS [University (Host)],
        D.Name AS [Department],
        C.CourseCode AS [Code],
        C.Name AS [Course Name],
        C.ECTS AS [ECTS],
        C.Language AS [Lang],
        C.ModeOfDelivery AS [Mode],
        LEFT(C.Description, 50) + '...' AS [Short Description] 
    FROM COURSE C
    JOIN DEPARTMENT D ON C.DeptID = D.DeptID
    JOIN FACULTY F ON D.FacultyID = F.FacultyID
    JOIN UNIVERSITY U ON F.UniversityID = U.UniversityID
    WHERE C.ECTS = @TargetECTS 
    ORDER BY U.Name, C.Name;
END;
GO