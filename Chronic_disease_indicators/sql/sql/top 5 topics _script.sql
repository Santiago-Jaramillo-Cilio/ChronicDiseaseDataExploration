-- This query ranks the topics in the 'US_Chronic_disease' table by the number of records associated with each,
-- highlighting the top 5 topics. These topics are of particular interest because their high record count
-- suggests they are significant areas of focus within the dataset. Understanding these key topics
-- will provide valuable insights into major health concerns and data collection priorities.
SELECT "Topic", COUNT(*) AS record_count
FROM public."US_Chronic_disease"
GROUP BY "Topic"
ORDER BY record_count DESC
LIMIT 5;


-- This query extracts all records from the 'US_Chronic_disease' table that belong to the top 5 topics identified earlier.
-- By focusing on these topics, the analysis will concentrate on the most significant areas of the dataset,
-- allowing for a more targeted and relevant exploration of the data.
SELECT * FROM public."US_Chronic_disease"
WHERE "Topic" IN ('Cancer', 'Cardiovascular Disease', 'Chronic Obstructive Pulmonary Disease', 'Diabetes', 'Asthma');



