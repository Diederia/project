# Process book

## Dag 2 | dinsdag | 10 januari
* Implementatie van de JT Apple Calendar.
	* De kalender werkt nog niet, dit komt doordat de mogelijkheden van de pod erg uitgebreid zijn. De komende dagen moet werking van de JT Apple Calendar duidelijk worden.

## Dag 3 | woensdag | 11 januari
* Vervolg implementatie van de JT Apple Calendar.
	* De kalender view wordt goed weergegeven en er kan doorheen gescrold worden.
	* Ik laat de kalender even voor wat het is en ga me nu richten op het rooster van de kalenderdag en het inlogen van de user.

## Dag 4 | donderdag | 12 januari
* Register en inlogview is aangemaakt met de werkende authenticatie in FireBase.
	* Het is nog niet helemaal duidelijk of uiteindelijk er een registerView gaat komen of dat alleen de admin in FireBase de gebruikers kan aanmaken. Er moet voorkomen worden dat er onbekende zich kunnen registeren en zo ongewenste aanpassingen in de app kunnen gaan doorvoeren.

## Dag 5 | vrijdag | 13 januari
* Ik heb lang zitten nadenken over hoe de kalenderdag het beste geïmplementeerd kan worden.
	* Uiteindelijk heb ik voor een UICollectionView  gekozen. Deze keuze is gemaakt omdat er in de UICollectionView verschillende lessen op hetzelfde tijdstip weergegeven kunnen worden en dit oneindig uitgebreid kan worden.
	* Om 14:00 werkte de UICollectionView.

## Weekend | zaterdag/zondag | 14/15 januari
* In het weekend zijn er geen grote aanpassing aan de app gedaan.

## Dag 6 | maandag | 16 januari
* De doelstelling van de dag was om in de UICollectionView het mogelijk te maken om als docent/leerling een tijdstip in te plannen.
	* Dit vindt plaats door een UIAlertController weer te geven wanneer er op een tijdstip geklikt wordt.
	* In de UIAlertController zit een UIPickerView waarin er gekozen kan worden hoeveel uur er ingepland wordt in het rooster.
	* Alle ingeplande uren worden opgeslagen in de dictionary (uiteindelijk ook in FireBase) met het uur als key en het id van de docent als waarde. Later zal dictionary waarde veder worden uitgebreid met een id van de leerling, wanneer de docent aan de leerling wordt gekoppeld.

## Dag 7 | dinsdag | 17 januari
* De doelstelling van dag 7 is om een preview van de UICollectionView weer te geven onderaan de kalendermaand wanneer er op een kalenderdag wordt geklikt.
	* Het is nog niet gelukt om een preview weer te geven, eerst moet de database goed werken voordat dit kan.
	* De UITableView is wel toegevoegd aan de view.
* Veel kleine aanpassingen zijn er gedaan in zowel de kalender als in de collection view.
	 * De huidige datum wordt in de kalender gemarkeerd.
	 * Twee buttons zijn toegevoegd om zo door de kalender heen te scrollen.

## Dag 8 | woensdag | 18 januari
* De doelstelling van de dag is om de aangeklikte kalenderdag datum mee te geven aan de collection view. Veder moet de werking van de onderdelen zonodig verbeterd worden.
	* Het is gelukt om de kalenderdag datum mee te geven aan de collection view. Dit was nog vrij lastig doordat naam van de maand wil weergeven, waardoor eerst de hele datum ontleed moest worden. 
	
## Dag 9 | donderdag | 19 januari
* De doelstelling van de dag is om de geregistreerde uren in de collection view op te slaan in de database. 
	* Dit is gelukt. Er ontstonden moeilijkheden doordat ik een indexpath met brackets wilde opslaan wat niet kan. Ik heb het nu opgelost door een fucntie te maken die de brackets verwijderd.

## Dag 10 | vrijdag | 20 januari
* De doelstelling van de dag is de code te verbeteren in configuratie van de collection view. Ook moet de preview van de dag nu goed worden weergeven.
	* De code is verbeterd, een functie wordt nu aangeroepen om een cel van de collection view aan te maken.
	* 
	
## Dag 11/12 | zaterdag/zondag | 21/22 januari
* Usergegevens verbeterd, nog niet optimaal.

## Dag 13 | maandag | 23 januari
* De Usergegevens werken nu goed.
	* Wachtwoorden kunnen veranderd worden.
	* Userdefaults werkt goed
	* automatisch inloggen gaat goed 
	* registreren van nieuwe gebruikers gaat goed.
* Veder heb ik bedacht hoe ik de kalenderdag wil gaan opslaan in firebase om de informatie zo goed mogelijk eruit te kunnen halen.

## Dag 14 | dinsdag | 24 januari
* implementatie van de gedachten hoe firebase moet gaan werken, wat gelukt is.
	* Inplannen van zowel docent als leerling werkt nu goed.
	* Preview van de kalenderdag wordt nu goed weergegeven in de kalenderView

## Dag 15 | woensdag | 25 januari
* Het design van de kalender zag er niet goed uit, te veel roze. Dit was vandaag opgelost, ik liep echter wel tegen een aantal problemen aan. 
	* Het uitlijnen van de verschillende buttons was een hele opgaven.
	* Om de buitenste randen rond te krijgen moest er een aantal nieuwe views toegevoegd worden.
* Het design van de collectionView was ook niet goed. Wanneer er nieuwe tijden werden toegevoegd werden de blokken een ander formaat wanneer de gehele view herladen werd. 
	* Dit is opgelost door een variable uit de breedte te halen en de breedte constant te maken.
	* Ook zijn de kleuren verbeterd.

## Dag 16 | donderdag | 26 januari
* Wanneer er nog geen admin in de database aanwezig is kon de gehele app niet gebruikt worden. Want eerst moest er ingelogd worden voordat er iemand geregisteerd kon worden.
	* Dit is opgelost door wanneer de database nog leeg is er eenmaal een admin user aangemaakt kan worden. Vervolgens kan de admin user leerlingen en docenten aanmaken. 
	* Ook is de layout van het registreer en settings view verbeterd

## Dag 17 | vrijdag | 27 januari 
* Better Code Hub uitgevoerd. 
	* Hieruit kwam: Unit Interfaces zijn op sommige plaatsen te lang, Units of Code zijn op sommige plaatsen te lang, Keep Architecture Components Balanced, Automate Tests. De laatste twee punten weet ik niet hoe ik die moet verbeteren.
* State restoration. Het begin van de state restoration wordt uitgevoerd, alleen wordt de data van de objecten nog niet opgeslagen.

## Dag 18/19 | zaterdag/zondag | 28/29 januari
* Layout van de app is verbeterd. Er zijn borders om views aangebracht met een corner radius en kleur. 
* Bij het invoeren van een nieuwe gebruiker beleef het keyboard op dezelfde plaats, waardoor de gebruiker niet veder kon invoeren. Dit is aangepast, er zit nu een scroll view op de view geplakt met daarop alle buttons. De scroll view beweegt omhoog zodat alle velden en buttons zichtbaar blijven.

## Dag 20 | maandag | 30 januari
* De segue van de login view naar de main view vond elke keer twee keer plaats. Dit is opgelost door de segue buiten de functie om de data op te halen te plaatsen.
* De scroll views begonnen altijd lagen wanneer de view werd geladen. Dit kwam door de navigation bar en is opgelost.
* Er is een functie aangemaakt om de kleur mee te geven tijdens de configuratie van de collection view. Eerst werden er onodig twee parameters meegegeven.

## Dag 21 | dinsdag | 31 januari


## Dag 22 | woensdag | 1 februari

## Dag 23 | donderdag | 2 febrauri



	
	

	
