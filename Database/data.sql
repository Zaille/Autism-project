DELETE FROM questions;

INSERT INTO questions VALUE (0, 1, 1, 'Si vous pointez du doigt quelque chose de l’autre côté de la pièce, est-ce que votre enfant le regarde ? (Par Exemple, si vous pointez du doigt un jouet ou un animal, est-ce que votre enfant regarde le jouet ou l’animal ?)');
INSERT INTO questions VALUE (0, 2, 1, 'Vous êtes-vous déjà demandé si votre enfant était sourd ?');
INSERT INTO questions VALUE (0, 3, 1, 'Est-ce que votre enfant joue à faire semblant ? (Par Exemple, faire semblant de boire dans une tasse vide, faire semblant de parler au téléphone, faire semblant de donner à manger à une poupée ou à un animal en peluche ?)');
INSERT INTO questions VALUE (0, 4, 1, 'Est-ce que votre enfant aime grimper sur des choses ? (Par Exemple, meubles, jeux d’extérieur, escaliers)');
INSERT INTO questions VALUE (0, 5, 1, 'Est-ce que votre enfant fait des mouvements inhabituels avec ses doigts près de ses yeux ? (Par Exemple, agite-t-il ses doigts près de ses yeux ?)');
INSERT INTO questions VALUE (0, 6, 1, 'Est-ce que votre enfant pointe du doigt pour demander quelque chose ou obtenir de l’aide ? (Par Exemple, pointer du doigt un goûter ou un jouet hors de sa portée)');
INSERT INTO questions VALUE (0, 7, 1, 'Est-ce que votre enfant pointe du doigt pour vous montrer quelque chose d’intéressant ? (Par Exemple, pointer du doigt un avion dans le ciel ou un gros camion sur la route)');
INSERT INTO questions VALUE (0, 8, 1, 'Votre enfant s’intéresse-t-il aux autres enfants ? (Par Exemple, est-ce que votre enfant regarde les autres enfants, leur sourit, va vers eux ?)');
INSERT INTO questions VALUE (0, 9, 1, 'Est ce que votre enfant vous montre des choses en vous les apportant ou en les tenant devant vous pour que vous les voyiez, pas pour obtenir de l’aide mais juste dans un but de partage ? (Par Exemple, vous montrer une fleur, une peluche, une petite voiture)');
INSERT INTO questions VALUE (0, 10, 1, 'Est-ce que votre enfant répond quand vous l’appelez par son prénom ? (Par Exemple est-ce qu’il lève les yeux, parle ou émet un son, ou arrête ce qu’il est en train de faire quand vous l’appelez par son prénom ?)');
INSERT INTO questions VALUE (0, 11, 1, 'Quand vous souriez à votre enfant, vous sourit-il en retour ?');
INSERT INTO questions VALUE (0, 12, 1, 'Est-ce que des bruits du quotidien perturbent votre enfant ? (Par Exemple, est-ce que votre enfant crie ou pleure en entendant l’aspirateur ou de la musique forte ?)');
INSERT INTO questions VALUE (0, 13, 1, 'Votre enfant marche-t-il ?');
INSERT INTO questions VALUE (0, 14, 1, 'Est-ce que votre enfant vous regarde dans les yeux lorsque vous lui parlez, que vous jouez avec lui ou que vous l’habillez ?');
INSERT INTO questions VALUE (0, 15, 1, 'st-ce que votre enfant essaye d’imiter ce que vous faites ? (Par Exemple, faire au revoir de la main, taper dans les mains, ou faire un bruit rigolo quand vous le faites)');
INSERT INTO questions VALUE (0, 16, 1, 'Si vous tournez la tête pour regarder quelque chose, est-ce que votre enfant regarde autour de lui pour voir ce que vous regardez ?');
INSERT INTO questions VALUE (0, 17, 1, 'Est-ce que votre enfant essaye d’attirer votre attention ? (Par Exemple, vous regarde-t-il pour être félicité, ou dit-il regarde ou regarde-moi)');
INSERT INTO questions VALUE (0, 18, 1, 'Votre enfant comprend-t-il quand vous lui dites de faire quelque chose ? (Par Exemple, sans que vous pointiez du doigt, est-ce que votre enfant comprend pose le livre sur la chaise ou apporte-moi la couverture ?)');
INSERT INTO questions VALUE (0, 19, 1, 'Si quelque chose de nouveau arrive, est-ce que votre enfant regarde votre visage pour voir comment vous réagissez ? (Par Exemple, s’il entend un bruit étrange ou rigolo, ou voit un nouveau jouet, est-ce qu’il regarde votre visage ?)');
INSERT INTO questions VALUE (0, 20, 1, 'Votre enfant aime-t-il les activités où il est en mouvement ? (Par Exemple, le faire sauter sur vos genoux ou être balancé)');

INSERT INTO questions VALUE
    (1, 1, 3, 'Please give me an example of how he/she will respond if you point at something'),
    (1, 2, 1, 'Est ce qu''il/elle regarde l’objet'),
    (1, 3, 1, 'Est ce qu''il/elle pointe l’objet'),
    (1, 4, 1, 'Est ce qu''il/elle regarde et commente l’objet'),
    (1, 5, 1, 'Est ce qu''il/elle regarde si le parent pointe et dit "Regarde !"'),
    (1, 6, 1, 'Est ce qu''il/elle ignore le parent'),
    (1, 7, 1, 'Est ce qu''il/elle regarde autour de lui au hasard'),
    (1, 8, 1, 'Est ce qu''il/elle regarde le doigt du parent'),
    (1, 9, 2, 'Which one does he/she do most often?'),

    (2, 1, 1, 'Est-ce qu’il/elle ignore souvent les sons ?'),
    (2, 2, 1, 'Est-ce qu’il/elle ignore souvent les gens ?'),
    (2, 3, 1, 'Est-ce que vous avez fait passer un test auditif à l’enfant ?'),
    (2, 4, 4, 'Quels étaient les résultats du test auditif ?'),

    (3, 1, 3, 'Please give me an example of his/her pretend play.'),
    (3, 2, 1, 'Est-ce qu’il/elle fait semblant de boire dans une tasse de dinette ?'),
    (3, 3, 1, 'Est-ce qu’il/elle fait semblant de manger avec une cuillère ou une fourchette de dinette ?'),
    (3, 4, 1, 'Est-ce qu’il/elle fait semblant de parler au téléphone ?'),
    (3, 5, 1, 'Est-ce qu’il/elle fait semblant de nourrir une poupée ou une peluche avec de la nourriture réelle ou imaginaire ?'),
    (3, 6, 1, 'Est-ce qu’il/elle pousse une petite voiture comme si elle était sur une route imaginaire ?'),
    (3, 7, 1, 'Est-ce qu’il/elle fait semblant d’être un robot, un avion, une danseuse, ou n’importe lequel de ses personnages préférés ?'),
    (3, 8, 1, 'Est-ce qu’il/elle met une casserole de dinette sur une gazinière imaginaire ?'),
    (3, 9, 1, 'Est-ce qu’il/elle met une poupée ou un personnage dans une voiture ou un camion à la place du conducteur ou du passager ?'),
    (3, 10, 1, 'Est-ce qu’il/elle fait semblant de passer l’aspirateur, la serpillère, ou de tondre la pelouse ?'),
    (3, 11, 4, 'Autres (décrivez)'),

    (4, 1, 3, 'Please give me an example of something he/she enjoys climbing on.'),
    (4, 2, 1, 'Est-ce qu’il/elle aime grimper sur les marches ?'),
    (4, 3, 1, 'Est-ce qu’2il/elle aime grimper sur les chaises ?'),
    (4, 4, 1, 'Est-ce qu’il/elle aime grimper sur les meubles ?'),
    (4, 5, 1, 'Est-ce qu’il/elle aime grimper sur les jeux d’extérieur ?'),

    (5, 1, 3, 'Est-ce qu’il/elle aime grimper sur les jeux d’extérieur ?'),
    (5, 2, 1, 'Est-ce qu’il/elle regarde ses mains ?'),
    (5, 3, 1, 'Est-ce qu’il/elle bouge ses doigts en jouant à faire "coucou" ?'),
    (5, 4, 1, 'Est-ce qu’il/elle agite ses doigts près de ses yeux ?'),
    (5, 5, 1, 'Est-ce qu’il/elle met ses mains devant ses yeux ?'),
    (5, 6, 1, 'Est-ce qu’il/elle met ses mains sur le côté de ses yeux ?'),
    (5, 7, 1, 'Est-ce qu’il/elle agite ses mains près de son visage ?'),
    (5, 8, 4, 'Autre (décrivez)'),
    (5, 9, 2, 'Does this happen more than twice a week?'),

    (6, 1, 3, 'If there is something your child wants that is out of reach, such as a snack or toy that is out of reach, how does he/she get it? '),
    (6, 2, 1, 'Est-ce qu’il/elle tente de l’attraper avec sa main ?'),
    (6, 3, 1, 'Est-ce qu’il/elle vous mène à l’objet ?'),
    (6, 4, 1, 'Est-ce qu’il/elle essaye de l’attraper par lui/elle-même ?'),
    (6, 5, 1, 'Est-ce qu’il/elle le demande en utilisant des mots ou sons ?'),
    (6, 6, 1, 'Si vous disiez "montre-moi", est-ce qu’il le pointerait du doigt ?'),

    (7, 1, 3, 'Please give me an example something he/she might point at to show you'),
    (7, 2, 1, 'Est-ce que votre enfant veut parfois vous montrer une chose intéressante comme un avion dans le ciel ?'),
    (7, 3, 1, 'Est-ce que votre enfant veut parfois vous montrer une chose intéressante comme un camion sur la route ?'),
    (7, 4, 1, 'Est-ce que votre enfant veut parfois vous montrer une chose intéressante comme un insecte sur le sol ?'),
    (7, 5, 1, 'Est-ce que votre enfant veut parfois vous montrer une chose intéressante comme un animal dans le jardin ?'),
    (7, 6, 1, 'Comment votre enfant attire-t-il/elle votre attention sur cela ? Est-ce qu’il/elle le pointerait du doigt ?'),
    (7, 7, 1, 'C’est pour montrer de l''intérêt, pas pour demander de l’aide ?'),

    (8, 1, 1, 'Est ce qu’il/elle est intéressé(e) par des enfants qui ne sont pas ses frères ou sœurs ?'),
    (8, 2, 1, 'Lorsque vous êtes au square ou au supermarché, est-ce que votre enfant réagit habituellement aux autres enfants ?'),
    (8, 3, 1, 'Est-ce que votre enfant joue avec un autre enfant ?'),
    (8, 4, 1, 'Est-ce que votre enfant parle avec un autre enfant ?'),
    (8, 5, 1, 'Est-ce que votre enfant gazouille ou fait des sons ?'),
    (8, 6, 1, 'Est-ce que votre enfant regarde un autre enfant ?'),
    (8, 7, 1, 'Est-ce que votre enfant sourit à un autre enfant ?'),
    (8, 8, 1, 'Est-ce que votre enfant est d’abord timide mais finit par sourire ?'),
    (8, 9, 1, 'Est-ce que votre enfant est excité par la présence d''un autre enfant ?'),

    (9, 1, 3, 'Please give me an example of something he/she might bring to show you or hold up for you to see.'),
    (9, 2, 1, 'Est-ce que votre enfant vous amène parfois une photo ou un jouet, juste pour vous le montrer ?'),
    (9, 3, 1, 'Est-ce que votre enfant vous amène parfois un dessin qu’il/elle a fait ?'),
    (9, 4, 1, 'Est-ce que votre enfant vous amène parfois une fleur qu’il/elle a cueilli ?'),
    (9, 5, 1, 'Est-ce que votre enfant vous amène parfois un insecte qu’il/elle a trouvé dans l’herbe ?'),
    (9, 6, 1, 'Est-ce que votre enfant vous amène parfois un assemblage de cubes qu’il/elle a réalisé ?'),
    (9, 7, 4, 'Autre (décrivez)'),
    (9, 8, 1, 'Est-ce parfois simplement pour vous montrer et non pour obtenir de l’aide ?'),

    (10, 1, 3, 'If he/she is not involved in something fun or interesting, what does he/she do when you call his/her name?'),
    (10, 2, 1, 'Est-ce qu’il/elle regarde vers vous ?'),
    (10, 3, 1, 'Est-ce qu’il/elle parle ou gazouille ?'),
    (10, 4, 1, 'Est-ce qu’il/elle arrête ce qu’il/elle est entrain de faire ?'),
    (10, 5, 1, 'Est-ce qu’il/elle ne réagit pas ?'),
    (10, 6, 1, 'Est-ce qu’il/elle semble entendre mais ignore le parent ?'),
    (10, 7, 1, 'Est-ce qu’il/elle réagit uniquement si le parent est en face du visage de l’enfant ?'),
    (10, 8, 1, 'Est-ce qu’il/elle réagit uniquement si le parent le/la touche ?'),
    (10, 9, 2, 'Which one does he/she do most often?'),

    (11, 1, 3, 'What makes your child smile?'),
    (11, 2, 1, 'Est-ce qu’il/elle sourit quand vous souriez ?'),
    (11, 3, 1, 'Est-ce qu’il/elle sourit quand vous entrez dans la pièce ?'),
    (11, 4, 1, 'Est-ce qu’il/elle sourit quand vous revenez après vous être absenté ?'),
    (11, 5, 1, 'Est-ce qu’il/elle est-ce que votre enfant sourit tout le temps ?'),
    (11, 6, 1, 'Est-ce qu’il/elle est-ce que votre enfant sourit à son jouet préféré ou son activité favorite ?'),
    (11, 7, 1, 'Est-ce qu’il/elle est-ce que votre enfant sourit au hasard sans raison apparente ?'),
    (11, 8, 2, 'Which one does he/she do most often?'),

    (12, 1, 1, 'Est-ce que votre enfant a une réaction négative au son de la machine à laver ?'),
    (12, 2, 1, 'Est-ce que votre enfant a une réaction négative au son de pleurs d’un bébé ?'),
    (12, 3, 1, 'Est-ce que votre enfant a une réaction négative au son de l''aspirateur ?'),
    (12, 4, 1, 'Est-ce que votre enfant a une réaction négative au son de sèche cheveux ?'),
    (12, 5, 1, 'Est-ce que votre enfant a une réaction négative au son de trafic ?'),
    (12, 6, 1, 'Est-ce que votre enfant a une réaction négative au son de hurlements de bébés ?'),
    (12, 7, 1, 'Est-ce que votre enfant a une réaction négative au son de musique forte ?'),
    (12, 8, 1, 'Est-ce que votre enfant a une réaction négative au son de téléphone/ Sonnette ?'),
    (12, 9, 1, 'Est-ce que votre enfant a une réaction négative au son de lieux bruyants tels que supermarché ou restaurant ?'),
    (12, 10, 4, 'Autre (décrivez)'),
    (12, 11, 1, 'Est-ce qu’il/elle se couvre calmement les oreilles ?'),
    (12, 12, 1, 'Est-ce qu’il/elle dit qu’il/elle n’aime pas ce bruit ?'),
    (12, 13, 1, 'Est-ce qu’il/elle crie ?'),
    (12, 14, 1, 'Est-ce qu’il/elle pleure ?'),
    (12, 15, 1, 'Est-ce qu’il/elle se couvre les oreilles nerveusement ?'),
    (12, 16, 2, 'Which one does he/she do most often?'),

    (13, 1, 1, 'Est-ce qu’il/elle marche sans se tenir ?'),

    (14, 1, 3, 'Please give me an example of when he/she looks you in the eye'),
    (14, 2, 1, 'Est-ce qu’il/elle vous regarde dans les yeux quand il/elle a besoin de quelque chose ?'),
    (14, 3, 1, 'Est-ce qu’il/elle vous regarde dans les yeux quand vous jouez avec lui/elle ?'),
    (14, 4, 1, 'Est-ce qu’il/elle vous regarde dans les yeux quand vous le/la nourrissez ?'),
    (14, 5, 1, 'Est-ce qu’il/elle vous regarde dans les yeux quand vous le/la changez ? '),
    (14, 6, 1, 'Est-ce qu’il/elle vous regarde dans les yeux quand vous lui lisez une histoire ?'),
    (14, 7, 1, 'Est-ce qu’il/elle vous regarde dans les yeux quand vous lui parlez ?'),
    (14, 8, 1, 'Est-ce que votre enfant vous regarde dans les yeux tous les jours ?'),
    (14, 9, 1, 'Les jours où vous êtes ensemble toute la journée, est-ce qu’il/elle vous regarde au moins 5 fois dans les yeux ?'),

    (15, 1, 1, 'Please give me an example of something he/she would try to copy'),
    (15, 2, 1, 'Est-ce qu’il/elle vous imite quand vous tirez la langue ?'),
    (15, 3, 1, 'Est-ce qu’il/elle vous imite quand vous faites un bruit rigolo ?'),
    (15, 4, 1, 'Est-ce qu’il/elle vous imite quand vous faites "coucou" de la main ?'),
    (15, 5, 1, 'Est-ce qu’il/elle vous imite quand vous frappez vos mains ?'),
    (15, 6, 1, 'Est-ce qu’il/elle vous imite quand vous faites "chut" avec le doigt sur la bouche ?'),
    (15, 7, 1, 'Est-ce qu’il/elle vous imite quand vous envoyez un bisou ?'),
    (15, 8, 4, 'Autre (décrivez)'),

    (16, 1, 3, 'What does he/she do when you turn to look at something?'),
    (16, 2, 1, 'Est-ce qu’il/elle regarde vers la chose que vous regardez ?'),
    (16, 3, 1, 'Est-ce qu’il/elle pointe du doigt vers la chose que vous regardez ?'),
    (16, 4, 1, 'Est-ce qu’il/elle regarde autour pour voir ce que vous regardez ?'),
    (16, 5, 1, 'Est-ce qu’il/elle vous ignore ?'),
    (16, 6, 1, 'Est-ce qu’il/elle regarde votre visage ?'),
    (16, 7, 2, 'Which one does he/she do most often?'),

    (17, 1, 3, 'Please give me an example of how he/she would try to get you to watch him/her'),
    (17, 2, 1, 'Est-ce qu’il/elle dit "Regarde" ou "Regarde-moi" ? '),
    (17, 3, 1, 'Est-ce qu’il/elle gazouille ou fait du bruit pour attirer votre attention sur ce qu’il/elle fait ?'),
    (17, 4, 1, 'Est-ce qu’il/elle vous regarde pour avoir un compliment ou un commentaire ?'),
    (17, 5, 1, 'Est-ce qu’il/elle vous regarde pour voir si vous le/la regardez ?'),
    (17, 6, 4, 'Autre (décrivez)'),

    (18, 1, 3, 'Please give me an example of how you know he/she understands you'),
    (18, 2, 1, 'Lorsque la situation lui donne un indice, est-ce qu’il/elle suit une consigne ? Par exemple quand vous êtes habillés pour sortir et que vous lui demandez d’amener ses chaussures, est-ce qu’il/elle comprend ?'),
    (18, 3, 1, 'Si c’est l’heure du dîner, et que le repas est servi et que vous lui demandez de s’asseoir, est-ce qu’il/elle vient s’asseoir à table ?'),
    (18, 4, 1, 'Lorsque la situation ne lui donne pas d’indice, est ce qu’il/elle peut suivre une consigne ? Par exemple Si vous dites : "Montre moi tes chaussures", sans les pointer du doigt, faire de geste ou donner d’indices (quand vous n’êtes pas en train de vous préparer pour sortir, ou de vous habiller), est-ce que votre enfant vous montre ses chaussures ?'),
    (18, 5, 1, 'Lorsque la situation ne lui donne pas d’indice, est ce qu’il/elle peut suivre une consigne ? Par exemple Si vous dites : "Apporte-moi la couverture" ou un autre objet sans les pointer du doigt, faire de geste ou donner d’indices, est ce que votre enfant l’apporte ?'),
    (18, 6, 1, 'Lorsque la situation ne lui donne pas d’indice, est ce qu’il/elle peut suivre une consigne ? Par exemple Si vous dites : "Met le livre sur la chaise" sans le pointer du doigt, faire des gestes ou donner d''indices, est ce que votre enfant met le livre sur la chaise ?'),

    (19, 1, 1, 'Si votre enfant entend un bruit étrange ou effrayant, est-ce qu’il/elle vous regarde avant de réagir ?'),
    (19, 2, 1, 'Est-ce que votre enfant vous regarde lorsque quelqu’un de nouveau approche ?'),
    (19, 3, 1, 'Est-ce que votre enfant vous regarde lorsque qu’il/elle est face à quelque chose d’un peu effrayant ou non familier ?'),

    (20, 1, 1, 'Est-ce qu’il/elle aime être balancé(e) ou sauter sur les genoux ?'),
    (20, 2, 3, 'When you swing or bounce him/her, how does he/she react? '),
    (20, 3, 1, 'Lorsque vous le/la balancez ou le/la faites sauter sur vos genoux est-ce que votre enfant rit ou sourit ?'),
    (20, 4, 1, 'Lorsque vous le/la balancez ou le/la faites sauter sur vos genoux est-ce que votre enfant parle ou gazouille ?'),
    (20, 5, 1, 'Lorsque vous le/la balancez ou le/la faites sauter sur vos genoux est-ce que votre enfant montre qu''il en veut plus en tendant les bras ? '),
    (20, 6, 4,'Autre (décrivez)');
/*
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
*/