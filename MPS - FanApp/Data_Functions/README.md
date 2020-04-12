#  What to Load?

var MainLink = "https://www.spectaculum.de/"

    - Feste
        - LinkZusatz            -> MainLink
        - namen
            - Selector          -> "#linkTermine > ul > li > a"
        - Link
            - Selector          -> "#linkTermine > ul > li > a"
        

## Feste
    - Info
    - LinkZusatz                -> MainLink + FestLink    
        - infoText
            - Selector          -> "#main > p" 

    - Anfahrt
        - LinkZusatz            -> MainLink + FestLink + "/anfahrt.php" 
        - Beschreibung
            - Selector          -> "#main > p"
        
    - Bands
        - LinkZusatz            -> MainLink + FestLink + "/kuenstler.php"
    
        - Bühne
            - Selector          ->
        - Namen
            - Selector          -> .kuenstler_name
        - Zeit
            - Selector          ->
    - Heerlager
        - LinkZusatz            -> MainLink + FestLink + "/heerlager.php"
        
        - Name
            - Selector          -> 
        - Beschreibung
            - Selector          -> 
    
    - Marktgruppe
        - Linkzusatz            -> MainLink + FestLink +
        
        - Name
            - Selector          ->
        - Staende
            - name
                - Selector      ->
            - Homepage
                - Selector      ->
                - Namen und Links?
            - Kontakt
                - Selector      ->
                - Namen und Links?

   
