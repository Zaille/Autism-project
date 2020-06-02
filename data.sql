-- POST /api/answers --

INSERT INTO Answers VALUE ( idPatient, réponse1, …, réponseN );
INSERT INTO Users VALUE ( idPatient, Prénom, Nom, Age, NomParent, PrénomParent, Email, telephone );

-- POST /api/pictures --

INSERT INTO Pictures VALUE ( idPatient, idPicture1, idPicture2, pictureName1, pictureName2 );

-- GET /api/scores --

SELECT prénom, nom, score INTO Users u, Scores s WHERE u.idPatient = s.idPatient;

-- GET /api/info/:id --

SELECT * FROM Anwsers a
INNER JOIN Scores s ON s.idPatient =  a.idPatient
INNER JOIN Users u ON u.idPatient =  a.idPatient
INNER JOIN Pictures p ON p.idPatient = a.idPatient
WHERE a.idPatient  = id;
