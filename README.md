# startup-en-folie-JB
startup en folie : atelier proposé par Emmanuel B.

J'ai volontairement laissé mon code dans l'état après la fin du temps imparti lors de l'atelier.

# Retrospective

## Mes sentiments sur la session
L'atelier est amusant et stimulant, on ressent le stress de la compétition !

L'internet était accessible, permettant à certain de recopier des morceaux de code leur permettant d'aller plus vite. J'avoue ne même pas y avoir pensé, je me suis limité à la consultation de la documentation de mes bibliothèques.

L'animateur donnait peut-être parfois trop d'aide : par exemple le fait qu'un serveur à planté. A mon avis, cela fait partie des choses à gérer par le joueur.

## Haskell
J'ai décidé de tenter l'atelier en Haskell.
Voici d'abord les choses qui m'ont freiné :
- J'avais activé tous les warnings, ainsi que l'option de compilation `-all`, rendant difficile le déploiement de correctif tant que le code n'est pas totalement fonctionnel.
- Les tests sont plutôt long à lancer (>10s). Dans ce type d'atelier, c'est très pénalisant. J'ai donc écrit peu de test.
- Je me suis aperçu que je connaisais mal les classes de type des nombres. Cela m'a posé beaucoup de problèmes sur les questions impliquant du calcul sur les entiers. Par exemple j'ai eu de grande difficultés à faire accepter ma fonction `isPrime` au compilateur, et de plus je me suis aperçu seulement à la fin de la session que mon implémentation était fausse, suite à une concession de ma part pour éviter la racine carrée que je n'arrivait pas faire passer, et à ma réticence à lancer les tests (pour gagner du temps...)

En revanche, voici les avantages que j'y ai trouvé :
- Le framework web Spock (https://github.com/agrafix/Spock) fonctionne parfaitement et offre des fonctionnalités intéressantes, comme les routes "type safe" (inutiles lors de l'atelier). Je n'ai pas retouché au code web après le tour de chauffe, question préliminaire permettant de mettre en place son serveur.
- Le parseur par combinateurs `Parsec` est élégant et efficace, aboutissant à du code factorisable et lisible. Son interface `Applicative functor` est rapide à prendre en main : les symboles qui rebutent souvent les débutants sont en fait une force. Une fois le `design pattern` compris, on l'identifie très rapidement et on évite ainsi d'avoir une API spécifique à apprendre.
- Le code final est plutôt propre et structuré, on est guidé par les  erreurs et warning du compilateur lors de l'implémentations.
- Le langage aide à avoir une compréhension profonde du problème, afin d'être capable d'écrire une solution qui passe l'étape du typage.
- l'outil `cabal` est très utile pour la standardisation d'un projet (build, lancement de tests, description des dépendences, etc.)

## Conclusion
La force d'Haskell semblent également être sa faiblesse dans se genre d'exercice. Il est très difficile de passer la compilation tant que le problème n'est pas maitrisé, ce qui est une bonne chose à plus long terme, mais empèche d'avoir des succès immédiats.

La durée de compilation (une petite dizaine de secondes), et donc de lancement des tests, est pénalisante dans ce genre de blitz, bien qu'elle ne m'ait jamais ennuyé lors de séance plus zen ;)
