# Process book

## Dag 2 | dinsdag | 10 januari
* Implementatie van de JT Apple Calendar.
	* De kalender werkt nog niet, dit komt doordat de mogelijkheden van de pod erg uitgebreid zijn. De komende dagen moet werking van de JT Apple Calendar duidelijk worden.

## Dag 3 | woensdag |11 januari
* Vervolg implementatie van de JT Apple Calendar.
	* De kalender view wordt goed weergegeven en er kan doorheen gescrold worden.
	* Ik laat de kalender even voor wat het is en ga me nu richten op het rooster van de kalenderdag en het inlogen van de user.

## Dag 4 | donderdag |12 januari
* Register en inlogview is aangemaakt met de werkende authenticatie in FireBase.
	* Het is nog niet helemaal duidelijk of uiteindelijk er een registerView gaat komen of dat alleen de admin in FireBase de gebruikers kan aanmaken. Er moet voorkomen worden dat er onbekende zich kunnen registeren en zo ongewenste aanpassingen in de app kunnen gaan doorvoeren.

## Dag 5 | vrijdag |13 januari
* Ik heb lang zitten nadenken over hoe de kalenderdag het beste geïmplementeerd kan worden.
	* Uiteindelijk heb ik voor een UICollectionView  gekozen. Deze keuze is gemaakt omdat er in de UICollectionView verschillende lessen op hetzelfde tijdstip weergegeven kunnen worden en dit oneindig uitgebreid kan worden.
	* Om 14:00 werkte de UICollectionView.

## Weekend | zaterdag/zondag |14/15 januari
* In het weekend zijn er geen grote aanpassing aan de app gedaan.

## Dag 6 | maandag |16 januari
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
	

	
