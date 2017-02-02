# Zus & Zo 
## Programmeer project minor programmeren
* Diederick Calkoen 
* 10684883 
* Januari 2017 
* [![BCH compliance](https://bettercodehub.com/edge/badge/Diederia/project)](https://bettercodehub.com)

De Zus & Zo app is een aplicatie voor de iphone om bijles docenten en leerlingen van Zus & Zo aanelkaar te koppelen. De docenten van Zus & Zo publiceren hun beschikbare uren in een rooster van een kalenderdag. De leerlingen kunnen vervolgens de nog niet geboekte uren reserveren. 

## Afbeeldingen van de app

1: ![alt text] (https://github.com/Diederia/project/blob/master/Docs/Screen%20Shot%202017-02-02%20at%2012.49.23.png)
2: ![alt text] (https://github.com/Diederia/project/blob/master/Docs/Screen%20Shot%202017-02-02%20at%2012.48.29.png)
3: ![alt text] (https://github.com/Diederia/project/blob/master/Docs/Screen%20Shot%202017-02-02%20at%2012.48.21.png)

1 InlogView: 
* Textfields voor emailadres en wachtwoord.
* Login button om in te loggen.
* Registreer button om te registreren. De regristratie button is alleen zichtbaar wanneer er nog geen admin user bekent is in de database.

2 RegisterView:
* Texfields voor emailadres, wachtwoord en bevestigingswachtwoord.
* Segment controller om een leerling of docent te kiezen. Deze is niet zichtbaar wanneer een admin user zich registreerd.
* Texfields voor voornaam, achternaam, id en mobiel.
* Registreren button om de regristratie te voltooien.

3 CalendarView: 
* < > button om door de kalender heen te scrollen.
* Kalenderdagen kunnen aangeklikt worden en dan wordt er een preview van weergegeven.
* In de preview worden alle docenten weergeven die zichzelf hebben ingeroosterd op de kalenderdag.

4: ![alt text] (https://github.com/Diederia/project/blob/master/Docs/Screen%20Shot%202017-02-02%20at%2012.48.52.png)
5: ![alt text] (https://github.com/Diederia/project/blob/master/Docs/Screen%20Shot%202017-02-02%20at%2012.49.11.png)
6: ![alt text] (https://github.com/Diederia/project/blob/master/Docs/Screen%20Shot%202017-02-02%20at%2012.48.39.png)

4 CollectionView:
* Cellen met de uren van de dag
* Als er in de kolomkop vrij staat is de kolom vrij, is de kolom gepland door een docent dan staat zijn ID in de kolomkop.

5 CollectionView:
* Alert om aanvraag van de user te verwerken.
* In de pickerview kunnen het aantal te plannen uren gekozen worden, er moet minimaal 1 uur ingepland worden.

6 SettingsView:
* Texfields om ID, mobiel en wachtwoord aan te kunnen passen.
* In de labels wordt de overige informatie over de user weergegeven.

## CopyRight statement
Voor dit project geldt een MIT lisence. Alle code kan vrij gerbuikt worden als gerefereerd wordt naar dit poject. Veder kunt u mij niet aansprakelijk stellen. Meer informatie kunt u vinden in LISENCE. 

## Acknowledgements
Voor de Zus & Zo app is er gebruik gemaakt van de JTAppleCalendar en de CustomCollectionViewLayout. De JTAppleCalendar en de CustomCollectionViewLayout hebben een MIT License en kunnen dus vrij grbuikt worden. Meer informatie over de JTAppleCalendar kunt vinden op https://github.com/patchthecode/JTAppleCalendar. Meer informatie over CustomCollectionViewLayout kunt u vinden op http://www.brightec.co.uk/ideas/uicollectionview-using-horizontal-and-vertical-scrolling-sticky-rows-and-columns.

### Disclaimer
Er zal geen vergoeding plaatsvinden vanuit Zus & Zo.
