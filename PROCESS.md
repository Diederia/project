# Process book

## Dag 2
* Implementatie van de JT Apple Calendar.
* De kalender werkt nog niet, dit komt doordat de mogelijkheden van de pod erg uitgebreid zijn. De komende dagen moet werking van de Calendar duidelijk worden.

## Dag 3 
* Vervolg implementatie van de JT Apple Calendar
* De kalender view wordt goed weergegeven en er kan doorheen gescrold worden.
* Ik laat de kalender even voor wat het is en ga me nu richten op het rooster van de kalenderdag en het inlogen van de user.

## Dag 4 
* Register en inlogview aangemaakt met de werkende authenticatie met FireBase.
	* Het is nog niet helemaal duidelijk of uiteindelijk er een registerView gaat komen of dat alleen de admin in FireBase de gebruikers kan aanmaken. Er moet voorkomen worden dat er onbekende zich kunnen registeren en zo ongewenste aanpassingen in de app kunnen gaan doorvoeren.

## Dag 5
* Lang nagedacht over hoe de kalenderdag het beste geïmplementeerd kan worden.
*   Uiteindelijk heb ik voor een UICollectionView  gekozen. Deze keuze is gemaakt omdat er in de UICollectionView verschillende lessen op hetzelfde tijdstip weergegeven kunnen worden en dit oneindig uitgebreid kan worden.
	* Om 14:00 werkte de UICollectionView.

## Weekend
*In het weekend zijn er geen grote aanpassing aan de app gedaan.

## Dag 6
* De doelstelling van de dag was om in de UICollectionView het mogelijk te maken om als docent/leerling een tijdstip in te plannen. 
*Dit vindt plaats door een UIAlertController weer te geven wanneer er op een tijdstip geklikt wordt. 
* In de UIAlertController zit een UIPickerView waarin er gekozen kan worden hoeveel uur er ingepland wordt in het rooster.
* Alle ingeplande uren worden opgeslagen in de dictionary (uiteindelijk ook in FireBase) met het uur als key en het id van de docent als waarde. Later zal dictionary waarde veder worden uitgebreid met een id van de leerling, wanneer de docent aan de leerling wordt gekoppeld. 

## Dag 7
*De doelstelling van dag 7 is om een preview van de UICollectionView weer te geven onderaan de kalendermaand wanneer er op een kalenderdag wordt geklikt. 




