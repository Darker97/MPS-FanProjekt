//
//  Front.swift
//  MPS - FanApp
//
//  Created by Christian Baltzer on 11.04.20.
//  Copyright © 2020 Christian Baltzer. All rights reserved.
//

import Foundation
import SwiftSoup

import Alamofire
import AlamofireImage

func LadenAllerBands(){
    let Link = "https://www.spectaculum.de/hoehepunkte/konzerte/"
    
    let HTML = laden_Websites(link: Link)
    let AlleBands = scrapper_Objecte(html: HTML, Selector: "div.col.col-3-1")
    
    var Name: [String] = []
    var Bild: [String] = []
    
    for Bands in AlleBands{
        let doc = try! SwiftSoup.parse(Bands)
        
        // Name
        let TempName = try! doc.text()
        
        // Bild  -> .thumbContainer img -> attr("src")
        // https://www.spectaculum.de/_lib/img/kuenstler/294.jpg
        let TempBild = try! doc.select("img").array()[0].attr("src")
        
        if(!Name.contains(TempName)){
            Name.append(TempName)
            Bild.append("https://www.spectaculum.de" + TempBild)
        }
    }
    
    // Bilder laden falls noch nicht vorhanden
    var i = 0
    for temp in Bild{
        // link runterladen
        
        var tempName = Name[i]
        
        Alamofire.request(temp).responseImage { response in
            if case .success(let image) = response.result {
                print("image downloaded: \(image)")
                // speichern des Bildes
                let SavePoint = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(tempName)
                let BildDaten = image.jpegData(compressionQuality: 0.5)
                try! BildDaten?.write(to: SavePoint)
                
                let Query = "UPDATE Band SET BildLink = \"" + tempName + "\" WHERE Name = \"" + tempName + "\""
                exeute_withoutReturn(Query: Query)
                
                
            } else {
                // Eintragen vom Standart Bild falls das andere Bild nicht gepasst hat
                let standart = "standart"
                _ = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(standart)
                let Query = "UPDATE Band SET BildLink = \"" + standart + "\" WHERE Name = \"" + tempName + "\""
                exeute_withoutReturn(Query: Query)
            }
        }
        i+=1
    }
    // Einfügen
    
    for p in Range(0...Name.count-1){
        NeueBand(Name:Name[p], Typ: "", Zeit: "", Homepage: "", BildLink: "")
    }
}

func LadenAllerMärkte(){
    let Link = "https://www.spectaculum.de/hoehepunkte/markt/"
    
    let HTML = laden_Websites(link: Link)
    let AlleStände = scrapper_Objecte(html: HTML, Selector: "div.container")
    
    var Name: [String] = []
    var Email: [String] = []
    var Webpage: [String] = []
    var Bild: [String] = []
    
    for Stand in AlleStände{
        var doc = try! SwiftSoup.parse(Stand)
        
        // Namen -> .description -> Erster Text
        var TempName = try! doc.text()
        
        // Email -> .kontakt_daten .link_email -> attr("href")
        var TempEmail = ""
        var temo = try! doc.select(".kontakt_daten .link_email").array()
        for x in temo{TempEmail.append(try! x.attr("href"))}
        
        // Link  -> .kontakt_daten .link_external -> attr("href")
        var TempLink = ""
        temo = try! doc.select(".kontakt_daten .link_external").array()
        for x in temo{TempLink.append(try! x.attr("href"))
            break}
        
        // Bild  -> .thumbContainer img -> attr("src")
        var TempBild = ""
        temo = try! doc.select(".thumbContainer img").array()
        for x in temo{TempBild.append(try! x.attr("src"))}
        
        if(!Name.contains(TempName)){
            TempName = TempName.replacingOccurrences(of: "Kontakt", with: "", options: NSString.CompareOptions.literal, range: nil)
            TempName = TempName.replacingOccurrences(of: "> ", with: "", options: NSString.CompareOptions.literal, range: nil)
            TempName = TempName.replacingOccurrences(of: "Homepage", with: "", options: NSString.CompareOptions.literal, range: nil)
            TempName = TempName.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range: nil)
            
            //mailto:
            TempEmail = TempEmail.replacingOccurrences(of: "mailto:", with: "", options: NSString.CompareOptions.literal, range: nil)
            
            
            Name.append(TempName)
            Email.append(TempEmail)
            Webpage.append(TempLink)
            Bild.append(TempBild)
        }
    }
    
    // Bilder laden falls noch nicht vorhanden
    var i = 0
    for temp in Bild{
        // link runterladen
        // link runterladen
        
        var tempName = Name[i]
        
        let standart = "standart"
        _ = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(standart)
        let Query = "UPDATE Marktstand SET BildLink = \"" + standart + "\" WHERE name = \"" + tempName + "\""
        exeute_withoutReturn(Query: Query)
        
        /*
        Alamofire.request(temp).responseImage { response in
            if case .success(let image) = response.result {
                print("image downloaded: \(image)")
                // speichern des Bildes
                let SavePoint = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(tempName)
                let BildDaten = image.jpegData(compressionQuality: 0.5)
                try! BildDaten?.write(to: SavePoint)
                
                let Query = "UPDATE Marktstand SET BildLink = \"" + tempName + "\" WHERE name = \"" + tempName + "\""
                exeute_withoutReturn(Query: Query)
                
                
            } else {
                // Eintragen vom Standart Bild falls das andere Bild nicht gepasst hat
                let standart = "standart"
                _ = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(standart)
                let Query = "UPDATE Marktstand SET BildLink = \"" + standart + "\" WHERE name = \"" + tempName + "\""
                exeute_withoutReturn(Query: Query)
            }
        }*/
        i+=1
    }
    // Einfügen
    
    for p in Range(0...Name.count-1){

        
        NeuerMarktstand(Name:Name[p], Kontakt: Email[p], Homepage: Webpage[p], BildLink: "")
    }
}

func LadenDerFeste(){
    // Fest Daten
    let MainLink = "https://www.spectaculum.de/"

    // Main Seite
    let Main_Html = laden_Websites(link: MainLink + "indexMPS.php")

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
        
        var Datum = ""
        
        link = MainLink + Fest
        Sucher = "#main > p"
        let Fest_InfoText = scrapper_Objecte_Text(html: laden_Websites(link: link), Selector: Sucher)
        var Infos = ""
        
        for infos in Fest_InfoText{
            Infos += infos
            Infos += "\n"
        }
        
        Fest_Name = FestNamen[i]
        
        let Name_Zerlegt = Fest_Name.components(separatedBy: " ")
        Datum = Name_Zerlegt[0]
        
        var Name_Bearbeitet = ""
        
        for i in (1...Name_Zerlegt.count-1){
            Name_Bearbeitet.append(" ")
            Name_Bearbeitet.append(Name_Zerlegt[i])
        }
        
        Fest_Name = Name_Bearbeitet
        
        link = MainLink + Fest + "/anfahrt.php"
        Sucher = "#main > p"
        var temp = scrapper_Objecte_Text(html: laden_Websites(link: link), Selector: Sucher)
        for i in (1...temp.count-1){
            Fest_Anfahrt.append(temp[i])
        }
        
        //Einfügen
        NeuesFest(Name: Fest_Name, link: link, Infotext: Infos, Datum: Datum, anfahrt: Fest_Anfahrt)
        
        
        // ----------------------------------------------------------------- //
        //Tage & Bands
        link = MainLink + Fest + "/kuenstler.php"
        Sucher = "#main .tabContainer ul LI A"
        var html = laden_Websites(link: link)
        let Tage_Namen = scrapper_Objecte_Text(html: html, Selector: Sucher)
        let Tage_Links = scrapper_Objecte_Links(html: html, Selector: Sucher)
        
        var t = 0
        for tage in Tage_Links{
            let TagesHtml = laden_Websites(link: MainLink + Fest + tage)
            // Typ
            Sucher = ".kategorie.ui-helper-clearfix"
            let kategorien_HTML = scrapper_Objecte(html: TagesHtml, Selector: Sucher)
            
            for kategorie in kategorien_HTML{
                let Selector = "H2"
                let kategorie_Name = scrapper_Objecte_Text(html: kategorie, Selector: Selector)[0]
                let Künsteler = scrapper_Objecte(html: kategorie, Selector: ".container")
                
                for Kunst in Künsteler{
                    let KunstlerName = scrapper_Objecte_Text(html: Kunst, Selector: ".kuenstler_name")[0]
                    let KunstlerLink = try! scrapper_Objecte_Links(html: Kunst, Selector: ".kontakt_daten")[0]
                    
                    // Künstler Updaten
                    // UPDATE Band SET Homepage = WHERE Name =
                    let Query = "UPDATE Band SET Homepage = \"" + KunstlerLink + "\" WHERE Name = \"" + KunstlerName + "\""
                    exeute_withoutReturn(Query: Query)
                    
                    // Neuer Auftritt
                    NeuerAuftritt(Band: KunstlerName, Fest: Fest_Name)
                }
                
            }

            t = t+1
        }
        
        // ----------------------------------------------------------------- //
        //Markt
        link = MainLink + Fest + "/markthaendler.php"
        Sucher = "#tabTeilnehmendeMarkthaendler > .container"
        
        let MarktstandHTML = laden_Websites(link: link)
        let MarktStände = scrapper_Objecte(html: MarktstandHTML, Selector: Sucher)
        
        for Markt in MarktStände{
            var Markt_Namen = " "
            var Markt_Kontakt = " "
            var Markt_Homepage = " "
            
            for t in scrapper_Objecte_Text(html: Markt, Selector: ".description"){Markt_Namen.append(t)            }
            for kontakt in scrapper_Objecte_Text(html: Markt, Selector: ".kontakt_daten .link_email")       {Markt_Kontakt.append(kontakt)}
            for kontakt in scrapper_Objecte_Text(html: Markt, Selector: ".kontakt_daten .link_external")    {Markt_Homepage.append(kontakt)}
            
            Markt_Namen = Markt_Namen.replacingOccurrences(of: "Kontakt", with: "", options: NSString.CompareOptions.literal, range: nil)
            Markt_Namen = Markt_Namen.replacingOccurrences(of: "Homepage", with: "", options: NSString.CompareOptions.literal, range: nil)
            
            //einfügen
            NeuerMarktstand(Marktstand: Markt_Namen, Fest: Fest_Name)
            //insert_Marktstand(Name: Markt_Namen, Kontakt: Markt_Kontakt, Homepage: Markt_Homepage, Fest_name: Fest_Name)
        }
        // ----------------------------------------------------------------- //
        // Lager
        link = MainLink + Fest + "/heerlager.php"
        Sucher = "#tabTeilnehmendeHeerlager > .container"
        
        let Lager_Html = laden_Websites(link: link)
        let Heerlager = scrapper_Objecte(html: Lager_Html, Selector: Sucher)
        
        for lager in Heerlager{
            var Lager_Name = " "
            var Lager_HomePage = " "
            var Lager_Link = " "
            
            for t in scrapper_Objecte_Text(html: lager, Selector: ".description"){Lager_Name.append(t)}
            for t in scrapper_Objecte_Links(html: lager, Selector: ".kontakt_daten .link_external"){Lager_HomePage.append(t)}
            for t in scrapper_Objecte_Links(html: lager, Selector: ".kontakt_daten .link_email"){Lager_Link.append(t)}
            
            Lager_Name = Lager_Name.replacingOccurrences(of: "Kontakt", with: "", options: NSString.CompareOptions.literal, range: nil)
            Lager_Name = Lager_Name.replacingOccurrences(of: "Homepage", with: "", options: NSString.CompareOptions.literal, range: nil)
            
            // einfügen
            NeuesLager(Name: Lager_Name, HomePage: Lager_HomePage, Link: Lager_Link)
            
            NeuesLager(Lager: Lager_Name, Fest: Fest_Name)
            //insert_Lager(Name: Lager_Name, HomePage: Lager_HomePage, Link: Lager_Link, Fest_name: Fest_Name)
        }

        i = i + 1
    }
}
