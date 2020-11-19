## **Coming up next:**
Deze app is nooit klaar! Dit zijn de verbeteringen die eraan zitten te komen in de nabije toekomst:
- Een dagboek met stemmingstracker
- Optie om periodieke herinneringen in te stellen om je dagboek bij te werken
- Optie om notificaties bij nieuwe verhalen aan en uit te zetten
#
#
## **1.6.2**
#### Release: 19-11-2020
- Fix: behaalde prestaties hadden een kleine vertraging, dit is nu opgelost zodat ze direct vrijgespeeld worden.
- Firebase Crashlytics toegevoegd om te kijken wat er gebeurd als het nog een keer mis gaat
- En tegelijkertijd ook maar Firebase Performance zodat ik bijvoorbeeld de initiële laadtijden van de app kan monitoren
#
#
## **1.6.1**
#### Release: 18-11-2020
- Fix: de app crashte als je de notificaties aanzette. Paniek! Hopelijk lost deze fix dit op.
#  
#  
## **1.6.0**
#### Release: 16-11-2020
- Superleuk! Je krijgt nu een felicitatie-melding als je een mijlpaal hebt vrijgespeeld!
- Mocht het niet vanzelf werken, dan kan je de schakel een keer uit en aan zetten voor een reset
- Dus ingeplande notificaties bij vrijspelen prestaties kan je ook naar hartenlust uitzetten!
#  
#  
## **1.5.0**
#### Release: 8-11-2020
- Het is nu mogelijk om zelf per mail je wachtwoord te resetten.
- Belangrijke fix: registratie kon misgaan bij loze spaties of lege velden. Dit is nu (hopelijk) allemaal opgelost!
#  
#  
## **1.4.0**
#### Release: 5-11-2020
- Wederom een nieuwe feature! Nu kun je een handig lijstje bijhouden waarom je ook alweer gestopt bent met drinken. Speciaal voor die momentjes dat je het even moeilijk hebt. Hoe leuk!
#  
#  
## **1.3.1**
#### Release: 4-11-2020
- Kleine fix: er zat een rekenfoutje op de 'behaald op'-datum van een prestatie
#  
#  
## **1.3.0**
#### Release: 2-11-2020
- Wederom een briljante update: vanaf nu kun je prestaties vrijspelen door te stoppen! Wat je daarvoor moet doen? Simpel: gewoon blijven volhouden!
- Veel tijd besteedt aan het invullen en bedenken van melige prestaties
- Aanpassingen in de structuur van het zijmenu
- In het ondermenu is de snelkoppeling naar de stopgegevens vervangen door de prestaties
#  
#  
## **1.2.0**
#### Release: 26-10-2020
- Supermooi: als je op de tegels op het startscherm klikt krijg je nu meer informatie over je voortgang te zien!
- Je kunt nu mooier nalezen wat er nieuw is en elke update van deze app (de changelog)
- Minor Firestore fix achter de schermen: datumvelden werden leeggemaakt bij opslaan van de stopgegevens
#  
#  
## **1.1.1**
#### Release: 25-10-2020
- Kleine aanpassing achter de schermen: het veld UserLastSeenTime is toegevoegd aan de database bij registratie
#  
#  
## **1.1.0**
#### Release: 24-10-2020
- Het bekende 'pull-to-refresh' heb ik toegevoegd om manueel de posts te verversen
- In de Firestore (cloud database) wordt nu ook de registratiedatum en de 'laatst gezien op'-datum bijgehouden, zodat ik straks per gebruiker de nieuwe verhalen kan markeren
- bugfix: bij een verkeerde login wordt nu een melding weergegeven, met tijdelijke instructie voor als je je wachtwoord bent vergeten
#  
#  
## **1.0.0**
#### Release: 20-10-2020
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
