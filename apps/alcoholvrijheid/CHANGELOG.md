## **Coming up next:**
Deze app is nooit klaar! Dit zijn de verbeteringen die eraan zitten te komen in de nabije toekomst:
- Een dagboek met stemmingstracker
- Optie om periodieke herinneringen in te stellen om je dagboek bij te werken
- Een link naar een donatiepagina (ik moet die toeslag van Apple toch proberen te neutraliseren zeg..)

## **1.7.1**
#### Release: 7-12-2020
Even wat dingen opruimen! Doordat ik voor de iPhone app op een Mac moest gaan werken heb ik wat dingen parralel gecodeerd. Dit moet ik nu weer samenbrengen in deze kleine release. In het kort:
- Op Android ging iets mis met een SSL licentie van Alcoholvrijheid.nl. Dit is nu in de bron opgelost, maar ik moest wel een spoedrelease uitbrengen om de boel werkend te krijgen
- In de iPhone versie had ik het platform toegevoegd aan nieuwe registraties. Dit werkt nu ook op Android.
- En vanaf nu: One Codebase!! Wat is Flutter toch een ongelofelijk mooi framework zeg... ik kan er maar niet over uit.


## **1.7.0 iPhone release!** 
#### Release: 4-12-2020
Yes! Deze update staat geheel in het teken van de nieuwe iOS versie! Vanaf nu geniet je dus ook van alcoholvrijheid op je iPhone of iPad! Hoe gezellig is dat?! Maar dit ging niet zonder slag of stoot:
- eerst moest ik een Mac en een iPhone zien te lenen
- aanmelden voor (en wachten op) het Apple Developer Program om apps te mogen maken (99 euro per jaar! Man...)
- dan alle bestanden overzetten via Git en draaiend krijgen op die geleende app
- nieuwe emulators installeren, xCode installeren, noem maar op.
- uitzoeken waar de rechtermuisknop zit in Mac, je delete knop, een venster sluiten, enzovoort.. wat een gedoe.
- aan de database (Firestore) toevoegen of een nieuwe gebruiker met Android of iOS registreert 
- openingsscherm van de iPhone-app instellen
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
