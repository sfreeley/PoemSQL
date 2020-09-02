-- 1. What grades are stored in the database?
SELECT Name FROM Grade;

-- 2. What emotions may be associated with a poem?
SELECT Name FROM Emotion
-- FROM Poem JOIN PoemEmotion ON Poem.Id = PoemEmotion.PoemId
-- JOIN Emotion ON Emotion.Id = PoemEmotion.EmotionId 

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

-- 13. How many authors are in each grade? (Order your results by grade starting with 1st Grade) 
