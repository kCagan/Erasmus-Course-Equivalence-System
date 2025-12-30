USE ErasmusProjectDB;
GO

-- =============================================================
-- UNIVERSITY & COURSE HIERARCHY REPORT
-- Amaç: Üniversite/Fakülte/Bölüm isimlerini tekrar etmeden (Grouping Visual),
-- altýndaki dersleri listelemek.
-- Teknik: JOIN + WINDOW FUNCTION (LAG)
-- =============================================================

SELECT 
    -- 1. ÜNÝVERSÝTE: Bir önceki satýrla aynýysa boþ göster 
    CASE 
        WHEN U.Name = LAG(U.Name) OVER(ORDER BY U.Name, F.Name, D.Name, C.Name) 
        THEN '' 
        ELSE U.Name 
    END AS [University],

    -- 2. FAKÜLTE: Bir öncekiyle aynýysa ve üniversite deðiþmediyse boþ göster
    CASE 
        WHEN F.Name = LAG(F.Name) OVER(ORDER BY U.Name, F.Name, D.Name, C.Name) 
             AND U.Name = LAG(U.Name) OVER(ORDER BY U.Name, F.Name, D.Name, C.Name)
        THEN '' 
        ELSE F.Name 
    END AS [Faculty],

    -- 3. BÖLÜM: Bir öncekiyle aynýysa boþ göster
    CASE 
        WHEN D.Name = LAG(D.Name) OVER(ORDER BY U.Name, F.Name, D.Name, C.Name) 
             AND F.Name = LAG(F.Name) OVER(ORDER BY U.Name, F.Name, D.Name, C.Name)
        THEN '' 
        ELSE D.Name 
    END AS [Department],

    -- 4. DERS BÝLGÝLERÝ 
    C.Name AS [Course Name],
    C.CourseCode AS [Code],
    C.ECTS AS [ECTS],
    C.Language AS [Language]

FROM UNIVERSITY U
JOIN FACULTY F ON U.UniversityID = F.UniversityID
JOIN DEPARTMENT D ON F.FacultyID = D.FacultyID
JOIN COURSE C ON D.DeptID = C.DeptID


ORDER BY U.Name, F.Name, D.Name, C.Name;