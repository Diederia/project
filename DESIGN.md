# Design Document

## Diagram van de app
Het diagram van de app geeft weer hoe de verschillende onderdelen van de app met elkaar in verbinding staan. 
![alt text] (https://github.com/Diederia/Project-/blob/master/Docs/Diagram%20app.png)

## classes
### Admin class
1.	Invoeren en deactiveren docenten
2.	Invoeren en deactiveren leerlingen
3.	Algemeen blokkeren les data en uren
4.	Toegang als docent om lesuren aan te passen
5.	Toegang als leerling om lesuren aan te passen
6. Handmatig aanpassen boetebedragen als gevolg ontijdig afzeggen

### Docent class
1.  Openstellen van lesuren
2.	Inzien van geboekte uren
3.	Boeken, aanpassen of verwijderen geboekte uren als leerling

#### optioneel
*	Aangeven of een les heeft plaatsgehad als afgesproken

### leerling class
1.	Boeken van lessen (ten minste één uur en te verlengen met blokken van 30 minuten)
2.	Inzien van geboekte uren
3.	Aanpassen of verwijderen geboekte uren als leerling

#### optioneel
*	Tot 72 uur vooraf, vrij aanpasbaar
*	Tot 24 uur vooraf, aanpasbaar maar tegen boetebedrag (half geld)
*	Na 24 uur vooraf: niet meer aanpasbaar, vol tarief betalen
*	Kwaliteit les beoordelen (1 – 5), achteraf – facultatief

## kalender
Voor de kalender wordt de basiscode JTAppleCalendar gebruikt. In de basiscode zijn verschillende classes aanwezig. Er moeten echter nog een aantal onderdelen worden toegevoegd aan de kalender om zo de preview weer te kunnen geven van de dag.
### Classes van de kalender
* JTAppleCalendarLayout:

In deze class moeten nog veel aanpassingen gedaan worden om zo de juiste layout van de kalender te krijgen. De class wordt aangeroepen door de view om een layout to stand te brengen.

* JTAppleCalendarView:

JTAppleCalendarView class nodig voor de interactie tussen de gridstyle opmaak van de cellen met de datum.

* JTAppleCollectionReusableView:

De headerview class van de calender.

* JTAppleDayCell:

In de deze class vindt de opmaak plaats van de cell met datum.

* JTAppleDayCellView:

De kalenderdag view, de cell met datum moet een subclass zijn van JTAppleDayCellView.

* JTAppleHeaderView:

De header view, de header moet een subclass zijn van de JTAppleHeaderView.

## kalenderdag
Voor de kalenderdag is een UItableview nodig waarin de verschillende uren worden weergegeven. Elke cel in de UItableview geeft een half uur weer. Van 9:00 -22:00 kunnen er lessen worden ingepland, elke les moet minimaal een uur duren en de les kan steeds met een half uur worden verlengd.  Er moeten dus 27 rijen in de tabel komen. Om de tabel overzichtelijk te houden kunnen er maximaal 8 verschillende lessen op dezelfde tijd worden ingepland, er moeten dus 8 kolommen in de tabel komen. 

## Database
Voor de database wordt er firebase gebruikt. Deze database staat volkomen los van de user, alleen de administrator zou erin kunnen om gebruikers te activeren en te deactiveren. 
In de firebase worden de volgende onderdelen opgelslagen:
* gebruikersnaam (admin,docent en leerling)
* wachtwoord (admin,docent en leerling)
* opgestelde lesuren (docent)
* geboekte uren, een opgesteld uur veranderd in een geboekt uur wanneer de les wordt geboekt door de leerling (docent en leerling)
Met deze onderdelen wordt er gestart om de app werkent te krijgen, wanneer de app werkent is kan dit nog worden uitgebreidt. Bijvoorbeeld de boete bedragen die moeten betaald worden door de leerling.
