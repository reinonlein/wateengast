Hier lees je wat er allemaal nieuw is in elke update van de app.

## **Coming up next:**
Deze app is nooit klaar! Dit zijn de verbeteringen die eraan zitten te komen in de eerstvolgende update van de app:
- Als je op de tegels op het startscherm klikt krijg je meer informatie over je voortgang te zien!
- UserLastSeenTime toegevoegd aan database bij registratie

## **1.1.0** (release 24-10-2020)
- Het bekende 'pull-to-refresh' heb ik toegevoegd om manueel de posts te verversen
- In de Firestore (cloud database) wordt nu ook de registratiedatum en de 'laatst gezien op'-datum bijgehouden, zodat ik straks per gebruiker de nieuwe verhalen kan markeren
- bugfix: bij een verkeerde login wordt nu een melding weergegeven, met tijdelijke instructie voor als je je wachtwoord bent vergeten

## **1.0.0** (release 20-10-2020)

- FEESTJE: Publicatie van de eerste versie in de Play Store!
- Met automatische updates van Alcoholvrijheid.nl (via http calls naar WP-API)
- Drawermenu om retesnel te kunnen filteren zodra de verhalen eenmaal geladen zijn
- Mogelijkheid om verhalen te kunnen delen (sharing)
- Volledige connectie met Firebase backend
- Autorisatie op e-mail & password via Firebase Auth
- Stopgegevens opslaan per gebruiker in Firestore
- Analytics events om te zien welke functies gebruikt worden en niet
- Cloud Messaging toegevoegd zodat ik pushberichten kan versturen
- Andere layout als je ingelogd bent
- Stukje documentatie in 'Over deze app' en 'Over alcoholvrijheid'
