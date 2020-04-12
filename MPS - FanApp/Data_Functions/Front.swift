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
    var MainLink = "https://www.spectaculum.de/"

    // Main Seite
    var Main_Html = Scrapper.laden_Websites(MainLink)

    var FestNamen = Scrapper.scrapper_Objecte_Text(Main_Html, "#linkTermine > ul > li > a")
    var FestLinks = Scrapper.scrapper_Objecte_Links(Main_Html, "#linkTermine > ul > li > a")


    // ----------------------------------------------------------------- //
    // Feste
    var i = 0
    for Fest in FestLinks{
        var link = ""
        var Sucher = ""
        
        var Fest_InfoText = []
        var Fest_Name = ""
        var Fest_Anfahrt = ""
        
        var Datum = ""
        
        
        link = MainLink + Fest
        Sucher = "#main > p"
        Fest_InfoText = Scrapper.scrapper_Objecte_Text(Scrapper.laden_Websites(link), Sucher)
        
        Fest_Name = FestNamen[i]
        
        link = MainLink + Fest + "/anfahrt.php"
        Sucher = "#main > p"
        Fest_Anfahrt = Scrapper.scrapper_Objecte_Text(Scrapper.laden_Websites(link), Sucher)[0]
        
        //Einfügen
        insert_Fest(db, Fest_Name, link, Fest_InfoText, Datum, Fest_Anfahrt)
        
        
        // ----------------------------------------------------------------- //
        //Tage & Bands
        link = MainLink + FestLink + "/kuenstler.php"
        Sucher = "#main > p"
        var Tage_Namen = Scrapper.scrapper_Objecte_Text(link, Sucher)
        var Tage_Links = Scrapper.scrapper_Objecte_Links(link, Sucher)
        
        var Fest_BandNamen = []
        var t = 0
        for tage in Tage_Links{
            var TagesHtml = laden_Websites(link: tage)
            // Typ
            Sucher = ".kategorie ui-helper-clearfix"
            var kategorien_HTML = scrapper_Objecte(html: TagesHtml, Selector: Sucher)
            
            for kategorie in kategorien_HTML{
                Selector = "H2"
                kategorie_Name = scrapper_Objecte_Text(html: kategorie, Selector: Selector)[0]
                Künsteler = scrapper_Objecte(html: kategorie, Selector: ".container")
                
                for Kunst in Künsteler{
                    KunstlerName = scrapper_Objecte_Text(html: Kunst, Selector: ".kuenstler_name")[0]
                    KunstlerLink = nil
                    KunstlerLink = try scrapper_Objecte_Links(html: Kunst, Selector: ".kontakt_daten")[0]
                    
                    // Einfügen
                    insert_Band(db, KunstlerName, kategorie_Name, Tage_Name[t], KunstlerLink, Fest_Name)
                }
                
            }

            t = t+1
        }
        
        // ----------------------------------------------------------------- //
        //Markt
        link = MainLink + FestLink + "/markthaendler.php"
        Sucher = "#tabTeilnehmendeMarkthaendler > container"
        
        var MarktstandHTML = Scrapper.laden_Websites(link)
        var MarktStände = Scrapper.scrapper_Objecte_Text(MarktstandHTML, Sucher)
        
        for Markt in MarktStände{
            var Markt_Namen = ""
            var Markt_Kontakt = ""
            var Markt_Homepage = ""
            
            Markt_Namen         = Scrapper.scrapper_Objecte_Text(Markt, ".description")[0]
            Markt_Kontakt       = try Scrapper.scrapper_Objecte_Text(Markt, ".link_email")[0]
            Markt_Homepage      = try Scrapper.scrapper_Objecte_Text(Markt, ".link_external")[0]
            
            //einfügen
            insert_Marktstand(db, Markt_Namen, Markt_Kontakt, Markt_Homepage, Fest_Name)
        }
        // ----------------------------------------------------------------- //
        // Lager
        
        
        
        
        // TODO: einfügen
        // func insert_Lager(db: OpaquePointer, Name:String, Beschreibung: String, Link: String, Fest_name: String)
        
        
        
        i = i + 1
    }
        


        
    
}
