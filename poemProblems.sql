-- 1. What grades are stored in the database?
SELECT Name FROM Grade;

-- 2. What emotions may be associated with a poem?
SELECT Name FROM Emotion

-- 3. How many poems are in the database?
SELECT COUNT(Poem.Id) as NumberOfPoems
FROM Poem

-- 4. Sort authors alphabetically by name. What are the names of the top 76 authors?
SELECT Name
FROM Author 
WHERE Author.Id < 77

-- 5. Starting with the above query, add the grade of each of the authors.
SELECT Author.Name, Grade.Name
FROM Author LEFT JOIN Grade ON Author.GradeId = Grade.Id
WHERE Author.Id < 77

-- 6. Starting with the above query, add the recorded gender of each of the authors.
SELECT Author.Name, Grade.Name, Gender.Name
FROM Author LEFT JOIN Grade ON Author.GradeId = Grade.Id
LEFT JOIN Gender ON Gender.Id = Author.GenderId 
WHERE Author.Id < 77

-- 7. What is the total number of words in all poems in the database? 
SELECT SUM(WordCount) as TotalNumberWords
FROM Poem

-- 8. Which poem has the fewest characters?
SELECT MIN(WordCount) as PoemWithFewestCharacters 
FROM Poem WHERE WordCount IS NOT NULL

-- 9. How many authors are in the third grade?
SELECT COUNT(Author.Name) as NumberOfAuthors
FROM Author JOIN Grade ON Author.GradeId = Grade.Id 
GROUP BY Grade.Name
HAVING Grade.Name = '3rd Grade'

-- 10. How many authors are in the first, second or third grades?
SELECT COUNT(Author.Name) as NumberOfAuthors, Grade.Name
FROM Author JOIN Grade ON Author.GradeId = Grade.Id
GROUP BY Grade.Name
HAVING Grade.Name = '1st Grade' OR Grade.Name = '2nd Grade' OR Grade.Name = '3rd Grade'

-- 11. What is the total number of poems written by fourth graders?
SELECT COUNT(Poem.Id) as PoemsWritten, Grade.Name
FROM Poem JOIN Author ON Poem.AuthorId = Author.Id
JOIN Grade ON Grade.Id = Author.GradeId 
GROUP BY Grade.Name
HAVING Grade.Name = '4th Grade'

-- 12. How many poems are there per grade?
SELECT COUNT(Poem.Id) as PoemsPerGrade, Grade.Name
FROM Poem JOIN Author ON Poem.AuthorId = Author.Id
JOIN Grade on Grade.Id = Author.GradeId
GROUP BY Grade.Name


-- beginning to declare with aliases

-- 13. How many authors are in each grade? (Order your results by grade starting with 1st Grade) 
SELECT COUNT(a.Id) as NumberOfAuthors, g.Name
FROM Author a JOIN Grade g ON a.GradeId = g.Id
GROUP BY g.Name
ORDER BY g.Name ASC

-- 14. What is the title of the poem that has the most words?
SELECT Title
FROM Poem 
WHERE WordCount = (SELECT MAX(WordCount) FROM Poem)

-- 15. Which author(s) have the most poems? (Remember authors can have the same name.)
SELECT TOP 1 COUNT(p.Title) as PoemNum, a.Name
FROM Poem p
JOIN Author a ON p.AuthorId = a.Id
GROUP BY a.Name
ORDER BY PoemNum DESC

-- 16. How many poems have an emotion of sadness?
SELECT COUNT(e.name)
FROM Emotion e JOIN PoemEmotion pe ON e.Id = pe.EmotionId
WHERE e.name = 'sadness'

-- 17. How many poems are not associated with any emotion?
SELECT COUNT(p.Title) AS PoemWithoutEmotion, e.name
FROM Poem p LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
LEFT JOIN Emotion e ON e.Id = pe.EmotionId
GROUP BY e.name
HAVING e.name IS NULL

-- 18. Which emotion is associated with the least number of poems?
SELECT TOP 1 COUNT(p.Title) AS NumOfPoemsWithEmotion, e.Name
FROM Emotion e LEFT JOIN PoemEmotion pe ON e.Id = pe.EmotionId
LEFT JOIN Poem p ON p.Id = pe.PoemId
GROUP BY e.Name
ORDER BY NumOfPoemsWithEmotion ASC

-- 19. Which grade has the largest number of poems with an emotion of joy?

-- Querying for Count of number of poem titles and grade name 
-- from author table
-- joining author table with grade table (author table has FK GradeId), grade.Id = PK --> which is querying for that author in that specific grade
-- joining poem table to author (poem has FK AuthorId), author.Id = PK --> which is querying for that poem written by that author
-- joining poem emotion table in order to access the relationship between poem and emotion; therefore... 
-- then need to join poem emotion to emotion table
-- filtering for emotion of joy
-- grouping by the grade name
-- ordering by descending order based on COUNT(p.Title) --> getting the largest number first
--TOP 1 will give you only that first entry you ordered by..

SELECT TOP 1 COUNT(p.Title) AS NumOfPoemsWithEmotion, g.Name
FROM Author a 
LEFT JOIN Grade g ON a.GradeId = g.Id
LEFT JOIN Poem p ON p.AuthorId = a.Id
LEFT JOIN PoemEmotion pe ON pe.PoemId = p.Id
LEFT JOIN Emotion e ON e.Id = pe.EmotionId
WHERE e.Name = 'joy'
GROUP BY g.Name
ORDER BY NumOfPoemsWithEmotion DESC

-- 20. Which gender has the least number of poems with an emotion of fear?
SELECT TOP 1 COUNT(p.Title) AS NumberOfPoemsWithEmotion, g.Name
FROM Author a
LEFT JOIN Gender g ON a.GenderId = g.Id
LEFT JOIN Poem p ON p.AuthorId = a.Id
LEFT JOIN PoemEmotion pe ON pe.PoemId = p.Id
LEFT JOIN Emotion e ON e.Id = pe.EmotionId
WHERE e.Name = 'fear'
GROUP BY g.Name
ORDER BY NumberOfPoemsWithEmotion ASC
