//
//  Front.swift
//  MPS - FanApp
//
//  Created by Christian Baltzer on 11.04.20.
//  Copyright © 2020 Christian Baltzer. All rights reserved.
//

import Foundation

func LoadData(){
    let db = openDatabase()
    
    // Fest Daten
    let MainLink = "https://www.spectaculum.de/"

    // Main Seite
    let Main_Html = laden_Websites(link: MainLink)

    let FestNamen = scrapper_Objecte_Text(html: Main_Html, Selector: "#linkTermine > ul > li > a")
    let FestLinks = scrapper_Objecte_Links(html: Main_Html, Selector: "#linkTermine > ul > li > a")


    // ----------------------------------------------------------------- //
    // Feste
    var i = 0
    for Fest in FestLinks{
        var link = ""
        var Sucher = ""
        
        var Fest_Name = ""
        var Fest_Anfahrt = ""
        
        let Datum = ""
        
        
        link = MainLink + Fest
        Sucher = "#main > p"
        let Fest_InfoText = scrapper_Objecte_Text(html: laden_Websites(link: link), Selector: Sucher)
        var Infos = ""
        
        for infos in Fest_InfoText{
            Infos += infos
            Infos += "\n"
        }
        
        Fest_Name = FestNamen[i]
        
        link = MainLink + Fest + "/anfahrt.php"
        Sucher = "#main > p"
        Fest_Anfahrt = scrapper_Objecte_Text(html: laden_Websites(link: link), Selector: Sucher)[0]
        
        //Einfügen
        insert_Fest(db: db!, Name: Fest_Name, link: link, Infotext: Infos, Datum: Datum, anfahrt: Fest_Anfahrt)
        
        
        // ----------------------------------------------------------------- //
        //Tage & Bands
        link = MainLink + Fest + "/kuenstler.php"
        Sucher = "#main > p"
        let Tage_Namen = scrapper_Objecte_Text(html: link, Selector: Sucher)
        let Tage_Links = scrapper_Objecte_Links(html: link, Selector: Sucher)
        
        var t = 0
        for tage in Tage_Links{
            let TagesHtml = laden_Websites(link: tage)
            // Typ
            Sucher = ".kategorie ui-helper-clearfix"
            let kategorien_HTML = scrapper_Objecte(html: TagesHtml, Selector: Sucher)
            
            for kategorie in kategorien_HTML{
                let Selector = "H2"
                let kategorie_Name = scrapper_Objecte_Text(html: kategorie, Selector: Selector)[0]
                let Künsteler = scrapper_Objecte(html: kategorie, Selector: ".container")
                
                for Kunst in Künsteler{
                    let KunstlerName = scrapper_Objecte_Text(html: Kunst, Selector: ".kuenstler_name")[0]
                    let KunstlerLink = try! scrapper_Objecte_Links(html: Kunst, Selector: ".kontakt_daten")[0]
                    
                    // Einfügen
                    insert_Band(db: db!, Name: KunstlerName, Typ: kategorie_Name, Zeit: Tage_Namen[t], Homepage: KunstlerLink, Fest_name: Fest_Name)
                }
                
            }

            t = t+1
        }
        
        // ----------------------------------------------------------------- //
        //Markt
        link = MainLink + Fest + "/markthaendler.php"
        Sucher = "#tabTeilnehmendeMarkthaendler > container"
        
        let MarktstandHTML = laden_Websites(link: link)
        let MarktStände = scrapper_Objecte(html: MarktstandHTML, Selector: Sucher)
        
        for Markt in MarktStände{
            var Markt_Namen = ""
            var Markt_Kontakt = ""
            var Markt_Homepage = ""
            
            Markt_Namen         = scrapper_Objecte_Text(html: Markt, Selector: ".description")[0]
            Markt_Kontakt       = try! scrapper_Objecte_Text(html: Markt, Selector: ".link_email")[0]
            Markt_Homepage      = try! scrapper_Objecte_Text(html: Markt, Selector: ".link_external")[0]
            
            //einfügen
            insert_Marktstand(db: db!, Name: Markt_Namen, Kontakt: Markt_Kontakt, Homepage: Markt_Homepage, Fest_name: Fest_Name)
        }
        // ----------------------------------------------------------------- //
        // Lager
        link = MainLink + Fest + "/heerlager.php"
        Sucher = "#tabTeilnehmendeHeerlager > container"
        
        let Lager_Html = laden_Websites(link: link)
        let Heerlager = scrapper_Objecte(html: Lager_Html, Selector: Sucher)
        
        for lager in Heerlager{
            var Lager_Name = ""
            var Lager_HomePage = ""
            var Lager_Link = ""
            
            Lager_Name      = scrapper_Objecte_Text(html: lager, Selector: "description")[0]
            Lager_HomePage  = try! scrapper_Objecte_Links(html: lager, Selector: ".link_external")[0]
            Lager_Link      = try! scrapper_Objecte_Links(html: lager, Selector: ".link_email")[0]
            
            // einfügen
            insert_Lager(db: db!, Name: Lager_Name, HomePage: Lager_HomePage, Link: Lager_Link, Fest_name: Fest_Name)
        }

        i = i + 1
    }
        


        
    
}
