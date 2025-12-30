USE ErasmusProjectDB;
GO

-- =============================================================
-- ERASMUS DERS EÞDEÐERLÝLÝK RAPORU
-- Format: Yan Yana Karþýlaþtýrma (Side-by-Side Comparison)
-- =============================================================

DECLARE @SourceCode NVARCHAR(20) = '501002232023'; -- Örn: Ege (Logic Design)
DECLARE @TargetCode NVARCHAR(20) = 'BIL113';       -- Örn: TOBB (Prog I)

-- 1. BAÞLIK: HANGÝ DERSLERÝ KARÞILAÞTIRIYORUZ? 
-- =============================================================
PRINT '>>> DERS KARSILASTIRMA RAPORU ';

SELECT 
    U.Name AS University,
    D.Name AS Department,
    F.Name AS Faculty,
    C.Name AS Course_Name,
    C.CourseCode,
    C.ECTS AS Official_ECTS,
    SUM(W.TotalWorkload) AS Calculated_Total_Hours,
    (SUM(W.TotalWorkload) / 30) AS Estimated_ECTS, -- (1 AKTS ~ 30 Saat)
    CASE 
        WHEN C.CourseCode = @SourceCode THEN 'SOURCE'
        ELSE 'TARGET'
    END AS Status
FROM 
    COURSE C
JOIN 
    DEPARTMENT D ON C.DeptID = D.DeptID
JOIN 
    FACULTY F ON D.FacultyID = F.FacultyID
JOIN 
    UNIVERSITY U ON F.UniversityID = U.UniversityID
JOIN 
    ECTS_WORKLOAD W ON C.CourseCode = W.CourseCode
WHERE 
    C.CourseCode IN (@SourceCode, @TargetCode)
GROUP BY 
    U.Name, D.Name, F.Name, C.Name, C.CourseCode, C.ECTS;

-- =============================================================
-- TABLO 2: STRUCTURAL COMPARISON (YAPISAL DENKLÝK)
-- Amaç: Dersin yapýsal iskeletini (AKTS, Kredi, Dil vb.) kýyaslamak.
-- =============================================================
PRINT ' ';
PRINT '>>> 2. STRUCTURAL COMPARISON (Yapisal Karsilastirma)';

SELECT 
    Attributes AS [Criteria],
    MAX(CASE WHEN CourseCode = @SourceCode THEN Value END) AS [Source Course],
    MAX(CASE WHEN CourseCode = @TargetCode THEN Value END) AS [Target Course],
    CASE 
        WHEN MAX(CASE WHEN CourseCode = @SourceCode THEN Value END) = MAX(CASE WHEN CourseCode = @TargetCode THEN Value END) 
        THEN 'MATCH' 
        ELSE 'DIFFERENT' 
    END AS [Equivalence Check]
FROM (
    -- 1. ECTS (En önemli kriter en baþta)
    SELECT CourseCode, 'ECTS' AS Attributes, CAST(ECTS AS NVARCHAR(50)) AS Value 
    FROM COURSE WHERE CourseCode IN (@SourceCode, @TargetCode)
    
    UNION ALL
    
    -- 2. Local Credit
    SELECT CourseCode, 'Local Credit', CAST(Credit AS NVARCHAR(50)) 
    FROM COURSE WHERE CourseCode IN (@SourceCode, @TargetCode)
    
    UNION ALL
    
    -- 3. Language
    SELECT CourseCode, 'Language', Language 
    FROM COURSE WHERE CourseCode IN (@SourceCode, @TargetCode)
    
    UNION ALL
    
    -- 4. Mode of Delivery
    SELECT CourseCode, 'Mode of Delivery', ModeOfDelivery 
    FROM COURSE WHERE CourseCode IN (@SourceCode, @TargetCode)


) AS BaseData
GROUP BY Attributes
ORDER BY Attributes ASC; -- Numaralandýrdýðýmýz için (1, 2, 3...) sýrasýyla gelir.


-- =============================================================
-- TABLO 3: ÝÇERÝK ÖZETÝ (YAN YANA)
-- Amaç: Dersin amacý ve tanýmý benziyor mu?
-- =============================================================
PRINT ' ';
PRINT '>>> 3. ICERIK VE AMAC KARSILASTIRMASI';

SELECT 
    'Course Purpose' AS [Section],
    (SELECT Purpose FROM COURSE WHERE CourseCode = @SourceCode) AS [Source_Course],
    (SELECT Purpose FROM COURSE WHERE CourseCode = @TargetCode) AS [Target_Course]
UNION ALL
SELECT 
    'Course Description',
    (SELECT Description FROM COURSE WHERE CourseCode = @SourceCode),
    (SELECT Description FROM COURSE WHERE CourseCode = @TargetCode);


-- =============================================================
-- REPORT 4: LEARNING OUTCOMES COMPARISON (KAZANIM KIYASLAMASI)
-- Amaç: Öðrenme çýktýlarýný yan yana, madde numarasý olmadan listelemek.
-- =============================================================
PRINT ' ';
PRINT '>>> 4. LEARNING OUTCOMES COMPARISON';

WITH SourceOutcomes AS (
    SELECT Description, ROW_NUMBER() OVER(ORDER BY Description) AS RowNo
    FROM LEARNING_OUTCOME WHERE CourseCode = @SourceCode
),
TargetOutcomes AS (
    SELECT Description, ROW_NUMBER() OVER(ORDER BY Description) AS RowNo
    FROM LEARNING_OUTCOME WHERE CourseCode = @TargetCode
)
SELECT 
    ISNULL(S.Description, '') AS [Source Course Learning Outcomes], -- NULL ise boþluk bas
    ISNULL(T.Description, '') AS [Target Course Learning Outcomes]  -- NULL ise boþluk bas
FROM SourceOutcomes S
FULL OUTER JOIN TargetOutcomes T ON S.RowNo = T.RowNo;


