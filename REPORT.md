# Report Zus & zo project
* Diederick Calkoen
* 10684883
* Januari/februari 2017

__De Zus & Zo app is een applicatie voor de iPhone om docenten en leerlingen van Zus & Zo aan elkaar te koppelen. De docenten van Zus & Zo publiceren hun beschikbare uren in een rooster van een kalenderdag. De leerlingen kunnen vervolgens de nog niet geboekte uren reserveren. De admin gebruiker kan nieuwe docenten en leerlingen toevoegen. __

__1:__ ![alt text] (https://github.com/Diederia/project/blob/master/Docs/Screen%20Shot%202017-02-02%20at%2012.48.21.png)
__2:__ ![alt text] (https://github.com/Diederia/project/blob/master/Docs/Screen%20Shot%202017-02-02%20at%2012.48.52.png)

__1:__ Scrollen door de kalender view. __2:__ Weergave van de kalenderdag met de ingeplande uren van docenten en leerlingen.

## Design
Het doel van de applicatie is om ervoor te zorgen dat docent en leerling makkelijk een bijles afspraak kunnen plannen. De applicatie moet dus op een simpele gebruiksvriendelijke manier zijn uitgevoerd. Het inplannen of reserveren van uren moet zo simpel mogelijk uitgevoerd kunnen worden, waarbij er een heldere grafische weergaven is van de al ingeplande uren. Er is daarom voor een JTAppleCalendar, UITableView, UICollectionView en een UIPickerView gekozen om de elementen weer te geven. De JTAppleCalendar geeft de kalender weer, de UITableView geeft de preview van de kalenderdag weer. De UICollectionView geeft het rooster weer met de ingeplande/gereserveerde uren erin. De UIPickerView is gebruikt voor de verwerking van de gebruikers input. Alle geplande en gereserveerde uren worden opgeslagen in FireBase.

### ViewControllers
De applicatie bevat vijf verschillende ViewControllers:
    * LoginViewController
    * RegisterViewController
    * ViewController
    * CollectionViewController
    * SettingsViewController

#### LoginViewController
De LoginViewController is het beginpunt van de applicatie en zullen de gebruikers dus als eerste zien. De view bestaat uit twee tekstvelden en twee buttons, hiermee kan een bestaande gebruiker zich aanmelden. Wanneer er echter nog geen gebruikers aanwezig zijn in de database moet eerst een admin gebruiker geregistreerd worden. De registreer button is verborgen wanneer wel gebruikers in de database aanwezig zijn.

### RegisterViewController
De RegisterViewController bestaat uit verschillende tekstvelden waarin de informatie van de gebruiker ingevoerd moet worden. Ook heeft de view een UISegmentController om te kiezen of het een docent of leerling is. Deze controller is verborgen wanneer een admin user zich registreert.

### ViewController
De ViewController bestaat uit een kalender en een table view. Om de kalender weer te geven is er gekozen om een pod te downloaden, de JTAppleCalendar. Met de installatie van de JTAppleCalendar is veel tijd bespaard en JTAppleCalendar biedt alle functionaliteiten die er nodig zijn voor het project. In de UITableView wordt alle data over de docenten van de kalenderdag weergegeven. Er kan duidelijk van tevoren gezien worden welke docenten er beschikbaar zijn op die dag.

### CollectionViewController
De CollectionViewController heeft een UICollectionView met daarin verschillende cellen. In elke kolom kan 1 docent zich inplannen, het ID van de docent komt in de kolomkop te staan. Op de ingeplande uren van de docent kunnen verschillende leerlingen uren reserveren, het ID van de leerling komt dan in de cellen te staan.

### SettingsViewController
De SettingsViewController bevat verschillende labels waarin de informatie van de gebruiker wordt weergegeven. Ook bevat het tekstvelden en buttons waarmee het ID, mobiel nummer en het wachtwoord mee aangepast kan worden.

## Models
De modellen van applicatie zijn van belang voor de werking met FireBase, elk model geeft een bepaalde tak weer in FireBase. Voor de Zus & Zo applicatie zijn twee verschillende modellen nodig:
* User -> verbonden met "users" in FireBase.
* CalendarDay -> verbonden met "data" in FireBase.

### User
De user bevat verschillende eigenschappen: voornaam, achternaam, email enz. Daarnaast staan er in het model een aantal functies die nodig koppeling met FireBase. De functies kunnen vanuit verschillende ViewControllers op een eenvoudige wijze data uit FireBase ophalen en plaatsen.

### CalendarDay
De CalendarDay bevat minder eigenschappen dan de user. Er is voor gekozen om alle data van de kalenderdag in een dictionary op te staan en deze vervolgens in FireBase te plaatsen. Hierdoor is er minder informatie nodig in het model en kan de data gemakkelijk in de CollectionView geplaatst worden.

## FireBase
In deze paragraaf wordt weergegeven hoe de dataopslag in FireBase plaats vindt:

* ProjectId
    * data
        * date
            * indexPath:
            * indexPath:
            * ..
        * date
            * ..
    * users
        * userId
            * email:
            * firstName:
            * id:
            * mobile:
            * surename:
            * uid:
            * userStatus:
        * userId
            * ..

## Extensions
In de applicatie zijn twee verschillende Extensions gebruikt:
* Voor een String.
* Voor een UIView

### String
De String extension is gebruikt om het kalendermaandnummer te kunnen converten naar de kalendermaandnaam. Het kalendermaandnummer moest uit een datum String gehaald worden, hierbij de datum doorlopen kunnen worden. Dit kan gedaan worden met de Extension.

## UIView
De UIView extension gebruikt om ronde randen te geven aan een view. Er kan aan alle randen een cornerRadius gegeven worden met swift, maar niet aan gepaalde hoeken. Zoals links en rechtsboven. Dit kan wel met de UIView extension.


## Challenges in process
### Week 1 | 10 t/m 15 januari
In de eerste week van het project zat de uitdaging in welke basis ga ik gebruiken voor de applicatie. Op welke wijze ga ik de functies implementeren en welke code ga ik daarvoor gebruiken. Ik had als eerste een kalender nodig waar de gebruiker doorheen kon scrollen. Apple stelt zijn eigen kalender niet beschikbaar, dus moest ik opzoek naar een alternatief. De JTAppleCalendar pod kwam naar voren als een goed alternatief. De JTAppleCalendar biedt veel mogelijkheden, waardoor het in het begin lastig te begrijpen was. Echter na enkele dagen begonnen de functionaliteiten te begrijpen en moest ik opzoek naar een basis om het kalenderdag rooster weer te geven. Al snel kwam ik uit op een CollectionView. De CollectionView lijkt sterk op UITableView echter kan bij de CollectionView meerdere kolommen toegevoegd worden. In de UICollectionView kunnen verschillende lessen op hetzelfde tijdstip weergegeven worden en dit kan oneindig uitgebreid worden.

### Dag 6 | maandag | 16 januari
Nu de CollectionView en JTAppleCalendar redelijk werkte moest er opzoek gegaan worden naar hoe de gebruiker het beste een uur kan inplannen/reserveren. Mijn beginpunt was dat er een UIAlert moest verschijnen wanneer een gebruiker op een cel klikt, echter was ik er nog niet uit hoe de gebruiker het beste de uren kan kiezen. Moet dit met een TextField of iets anders. Uiteindelijk kwam ik uit op een UIPickerView, hierbij staat alle te kiezen data vast. Ik wist nog niet of de UIPickerView in een UIAlert te verwerken was, dit kan en aan het einde van de was er iets functioneels.

### Dag 8 | woensdag | 18 januari
Op Dag 8 liep ik tegen het probleem aan dat ik niet precies wist hoe ik de aangeklikte datum op de JTAppleCalendar mee kon geven aan de CollectionView. Dit was nog vrij lastig doordat naam van de maand wilde weergeven, waardoor eerst de hele datum JTAppleCalendar ontleed moest worden. Het ontleden is gelukt door een String extension toe te voegen.

### Dag 9 | donderdag | 19 januari
Op dag 9 wilde ik de data van de CollectionView gaan opslaan in de FireBase. Dit was echter nog niet zo gemakkelijk doordat het indexPath was ik in een dictionary opsloeg brackets had die niet in FireBase opgeslagen kunnen worden. Dit is opgelost door de brackets te verwijderen en het op te slaan als een String.

### Dag 11 t/m 13 | 21 t/m 23 januari
Het opslaan van geplande uren in FireBase liep nog stroef doordat gebruiker gegevens nog niet goed geconfigureerd zijn. De gebruiker wordt aangemaakt in een user model en dit model wordt opgelagen in FireBase. Wanneer een user inlogde in de applicatie wordt alle gebruiker informatie opgeslagen in userdefaults. De informatie in userdefaults wordt weer gebruikt wanneer er een gepland uur wordt opgelsagen in FireBase. Ook over het opslaan van geplande uren is nagedacht. Een kalenderdag wordt opgeslagen in een dictionary met een indexPath als key en een value van "vrij" of "id van leerling". Per kolom kan zich maar 1 docent inplannen om zo het rooster overzichtelijk te houden.

### Dag 14 | dinsdag | 24 januari
De preview werd nog steeds niet weergeven, dit was lastig omdat alle informatie in losse uren was opgeslagen in een dictionary. Er moest eerst een functie worden geschreven om per docent de begin en eindtijd te krijgen.

### Dag 16 | donderdag | 26 januari
Wanneer er nog geen admin gebruiker geregistreerd was in de database kon de gehele app niet gebruikt worden, want er kon nergens een admin gebruiker geregistreerd worden. Dit is opgelost door een registreer button te voorschijn te laten komen wanneer de database nog leeg is en er eenmaal een admin gebruiker aangemaakt kan worden. Vervolgens kan de admin gebruiker leerlingen en docenten registreren.

### Dag 18/19 | zaterdag/zondag | 28/29 januari
De keyboards gaan over de view wanneer de applicatie op de iPhone wordt gebruikt. Dit is opgelost door functies toe te voegen die registreren of de gebruiker buiten het TextField klikt of op return klikt. Ook is er een UIScrollView toegevoegd aan de RegisterViewController en SettingsViewController om zo de view omhoog te scrollen wanneer de gebruiker erop klikt.

### Dag 22 | woensdag | 1 februari
De CollectionView was niet toegankelijk wanneer er nog geen tijden geregistreerd waren op die dag. Dit is opgelost door in de preview tekst te plaatsen wanneer de kalenderdag nog leeg is. Een leerling krijgt deze tekst niet te zien en kan dus niet een lege kalenderdag in.

## Defending these decisions
Gebruik maken van de JTAppleCalendar heeft een aantal voordelen. Ten eerste, JTAppleCalendar heeft zeer uitgebreide mogelijkheden en kan volledig worden afgestemd op eigen voorkeuren. Ten tweede, is er een hoop tijd bespaard om niet een gehele eigen kalender te hoeven implementeren. Een alternatief was om ook een CollectionView te maken voor de kalender, dit zou echter nooit de uitgebreide mogelijkheden bieden binnen dit tijdsbestek. 
Het gebruik maken van de UICollectionView heeft een aantal voordelen. Ten eerste, het aantal kolommen kan oneindig worden uitgebreid en zo kunnen er oneindig veel docenten naast elkaar worden ingepland. Ten Tweede, de data van de CollectionView kan gemakkelijk worden opgeslagen in een dictionary en zo ook in FireBase. Een alternatief zou een UITableView zijn waarbij de docenten onder elkaar worden weergeven met de tijden er achter, grafisch gezien is dit erg zwak. 
De admin gebruiker heeft alleen het recht om gebruikers te registreren. Deze keuze is gemaakt omdat ervoor te zorgen dat derden geen tijden kunnen gaan inplannen en zo de app omzeep helpen. Ook kan op deze wijze de applicatie snel uitgebreid worden met verschillende groepen met een admin gebruiker erboven.

## Reflection
De final state van de applicatie is nog niet optimaal. Alle functies van het minimum viable product zijn werkend. Het grootste gebrek van de app zit het in dat de admin user nu alleen nog de geplande of gereserveerde uren kan verwijderen en docent of leerling nog niet. Ook is de kalender nog niet optimaal, er kan nog niet in een oogopslag gezien worden welke dagen docenten zich hebben ingepland. Leerlingen moeten nu los op een kalenderdag klikken en in de preview zien of er een docent beschikbaar is. Dit kan opgelost worden door een klein bolletje onder de datum weer te geven wanneer een docent zich heeft ingepland. Over het algemeen ben ik toch tevreden over de app en heb ik een hoop geleerd tijdens het project.

