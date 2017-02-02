# Zus & Zo 
## App voor bijles inplannen
* Programmeer project minor programmeren
  * Diederick Calkoen 
  * 10684883 
  * Januari 2017 
  * [![BCH compliance](https://bettercodehub.com/edge/badge/Diederia/project)](https://bettercodehub.com)


## Doelstelling van de app 
Plannen van bijlessen die worden gegeven door de docenten van Zus & Zo aan verschillende leerlingen, waarbij de docenten hun beschikbare uren publiceren en de leerlingen vervolgens daarop kunnen inboeken.

### Technische omgeving  
*	Database in de cloud
*	Database: Firebase
*	Aanvankelijk starten met app voor iOS
*	Programmeertaal Swift
*	Custom UITableView Cell
* UICollectionView
* JTAppleCalendar
*	JSON als gegevensformaat voor de datatransfer over het net en database

### Gebruikers van de app 
1.	Admin
2.	Docent
3.	Leerling

### Gegevens vast te leggen van 
1.	 Docenten
2.	 Leerlingen
3.	 Scholen
4.	 Leslocaties
5.	 Type opleidingen
6.	 Klassen
7.	 Vakken
8.	 Tarieven docenten (de kosten voor Zus & Zo)
9. 	Tarieven leerlingen (wat de leerling betaald voor de les)
10. Lesbeoordeling

### Wie doet wat?
#### a) Admin
1.	Invoeren en deactiveren docenten
2.	Invoeren en deactiveren leerlingen
3.	Algemeen blokkeren les data en uren
4.	Toegang als docent om lesuren aan te passen
5.	Toegang als leerling om lesuren aan te passen
6. Handmatig aanpassen boetebedragen als gevolg ontijdig afzeggen

#### b)	Docent
1. Openstellen van lesuren
2.	Inzien van geboekte uren
3.	Boeken, aanpassen of verwijderen geboekte uren als leerling
4.	Aangeven of een les heeft plaatsgehad als afgesproken

#### c)	Leerling
1.	Boeken van lessen (ten minste één uur en te verlengen met blokken van 30 minuten)
2.	Inzien van geboekte uren
3.	Aanpassen of verwijderen geboekte uren als leerling
*	Tot 72 uur vooraf, vrij aanpasbaar
*	Tot 24 uur vooraf, aanpasbaar maar tegen boetebedrag (half geld)
*	Na 24 uur vooraf: niet meer aanpasbaar, vol tarief betalen
4.	Kwaliteit les beoordelen (1 – 5), achteraf – facultatief

### 1.	Gebruik van de app door Admin
#### Invoeren leslocaties (maximaal 4)
*	locatie1, locatie2, locatie3, locatie4
*	Straat
*	Huisnummer
*	Postcode
* Plaats

#### Invoeren standaard gegevens van docent
* Docent-nummer
* Docent-wachtwoord
* Voornaam
* Tussenvoegsel
* Achternaam
* Straat (zichtbaar – niet zichtbaar)
* Huisnummer (zichtbaar – niet zichtbaar)
* Postcode (zichtbaar – niet zichtbaar)
* Plaats (zichtbaar – niet zichtbaar)
* Mobiel nummer
* Email-adres
* Bijlesvakken (maximaal 6)
* Mogelijke leslocaties (thuis, locatie1, locatie2, locatie3, locatie4)
* Tarief inkoop
* Tarief klant
* Foto

#### Blokkeren data
*	Blokkeren data waarop geen bijlessen geboekt kunnen worden
*	Blokkeren kan alleen in toekomst (vanaf opvolgende dag)

#### Inzien welke lessen zijn geboekt
*	Alleen per docent inzien, dus niet alle docenten tegelijk

#### Optreden als administrator
*	In staat zijn lessen te verwijderen en aan te passen zoals een docent dat kan doen

#### Invoeren standaard gegevens van leerling
*	Leerling-nummer
*	Leerling-wachtwoord
*	Voornaam
*	Tussenvoegsel
*	Achternaam
*	Straat
*	Huisnummer
*	Postcode
*	Plaats
*	Mobiel nummer leerling
*	Mobiel nummer moeder
*	Mobiel nummer vader
*	Email-adres leerling
*	Email-adres ouders (factuur-email-adres)
*	Naam school
*	Type opleiding
*	klas

#### Algemene gegevens
*	Scholen
*	Type opleidingen
*	Klassen
*	Vakken

### 2.	Gebruik van de app door de docent
#### Invoeren beschikbare uren door docent
*	Docent opent de kalender (specificatie tot kwartieren).
*	Docent geeft beschikbare lestijden aan door groene kleuring van uren.
*	Mogelijke locatie aangeven van de les (thuis, locatie1, locatie2, locatie3, locatie4)

#### Uitlezen geboekte lesuren door leerlingen
*	Docent kan scrollen door agenda en ziet welke uren les gegeven moet worden aan wie
*	Geboekte lessen staan in oranje
*	Informatie geboekte lessen (naam leerling, mobiel leerling, onderwerp les)

#### Verwijderen geboekte les
*	Docent kan les verwijderen
*	Docent kan vervolgens uur tonen als geblokkeerd of juist open staand voor een 

#### Docent gebruikt app als leerling
*	Docent krijgt permissie van leerling om app voor hem/haar te benaderen
*	Docent vult geboekte uren zelf in

### 3.	Gebruik van de app door de leerling
#### Boeken lessen door leerling
* Leerling opent de kalender (specificatie tot kwartieren).
* Leerling boekt lessen door groene kleuring van uren.
* Locatie aangeven van de les (kiezen uit beschikbare locaties zoals opgegeven door docent).

#### Uitlezen geboekte lesuren door leerlingen
*	Leerling kan scrollen door agenda en zien welke lesuren door hem/haar zijn geboekt.
*	Geboekte lessen staan in oranje
*	Informatie geboekte lessen (naam leerling, mobiel leerling, onderwerp les)

#### Verwijderen geboekte les
* Leerling kan les verwijderen
  * Tot 72 uur vooraf, vrij aanpasbaar
  * Tot 24 uur vooraf, aanpasbaar maar tegen boetebedrag (half geld)
  * Na 24 uur vooraf: niet meer aanpasbaar, vol tarief betalen
*	Email-bericht (liever sms) aan docent dat les is gecanceld
*	Uren blijven wel geblokt staan, pas weer te boeken als docent ze opnieuw heeft opengesteld

#### Docent gebruikt app als leerling
*	Docent krijgt permissie van leerling om app voor hem/haar te benaderen
*	Docent vult geboekte uren zelf in

### Visual sketch
User    | inlogView | inputView | calenderView | cellView | verwijdering |
------- | --------- | --------- | ------------ | -------- | -----------  |
Admin   | YES       | YES       | YES          | YES      | YES          |
Docent  | YES       | YES       | YES          | YES      | REQUEST      |
leerling| YES       | YES       | YES          | YES      | CONDITIONALLY|

### Technical problems or limitations
De gebruikers van de app moeten veel data invoeren om een bijles tot stand te laten komen, dit wordt als vervelend ervaren. Om dit te voorkomen wordt er veel grafisch weergegeven en vooraf ingevuld.

### Similar applications
InPlanning App is een voorbeeld van een inplannings app, alleen hierbij gaat het om inplannen van werkroosters. Er kan niet verschillende gebruikers aan elkaar gekoppeld worden en zo een les ingepland worden. Ook kan er geen keuze gemaakt worden in welke les er gevolgd wilt worden. 

### Minimum viable product
De minimale voorwaarden waaraan de app moet voldoen aan het einde van het project zijn: de leerling moet een bijles kunnen inplannen bij een docent. De admin moet deze kunnen verwijderen. 
De optionele onderdelen zijn: de leerling en de docent aanpassingen kunnen maken, boetebedrag wordt verrekent bij te late afmelding. Uitgebreide beschrijving van leerling en docent. 

### Disclaimer
Er zal geen vergoeding plaatsvinden vanuit Zus & Zo.
