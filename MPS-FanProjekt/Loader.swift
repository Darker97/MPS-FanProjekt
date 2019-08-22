//
//  Loader.swift
//  MPS-Fanprojekt
//
//  Created by Christian Baltzer on 20.08.19.
//  Copyright © 2019 Christian Baltzer. All rights reserved.
//

import Foundation
import SwiftSoup
import Alamofire
import UIKit
import Alamofire_Synchronous


class Loader{
    
    func start()-> AlleDaten{
        let MainLink: String = "https://www.spectaculum.de/"
        var Work = AlleDaten(LinkDerSeite: MainLink)
        print("eins")
            Work = self.ladenDerMainSeite(MainLink: MainLink, Temporär: Work)
            print("zwei")
            Work = self.scrappenDerLinks(temporär: Work)
            print("drei")
            Work = self.ladenDerLinkSeiten(temporär: Work)
            print("vier")
            Work = self.scrappenDerInfos(temporär: Work)
        
        return Work
    }
    
    func ladenDerMainSeite(MainLink: String, Temporär: AlleDaten) -> AlleDaten{
        var Temp = Temporär
        
        
        let response = Alamofire.request(MainLink).responseString().value
            //print(response)
            Temp.html = response!

        return Temp
        
    }
    
    func scrappenDerLinks(temporär: AlleDaten) -> AlleDaten{
        var Temp = temporär
        do {
            let html = try Temp.html
            
            let doc = try SwiftSoup.parse(html)
            
            let Namen: Elements = try doc.select("[id=\"linkTermine\"] > ul > li > a")
            print(Namen.size())
            for link: Element in Namen.array(){
                let linkText: String = try link.text()
                    //print(linkText)
                let linkHref = try link.attr("href")
                    //print(linkHref)
                Temp.Feste.append(Fest(NameDesFestes: linkText, linkDesFestes: linkHref))
            }
        } catch Exception.Error(let type, let message) {
                print(message)
                print(type)
        } catch {
                print("error")
        }
        return Temp
    }
    
    func ladenDerLinkSeiten(temporär: AlleDaten) ->AlleDaten{
        var Temp = temporär
        
        for index in 0..<Temp.Feste.count{
            let response = Alamofire.request(Temp.hauptLink + Temp.Feste[index].link).responseString().value
            //print(response)
            Temp.Feste[index].html = response!
        }
        return Temp
    }
    
    func scrappenDerInfos(temporär: AlleDaten) -> AlleDaten{
        var Temp = temporär
        
        for index in 0..<Temp.Feste.count{
            
            do {
                let doc = try SwiftSoup.parse(Temp.Feste[index].html)
                Temp.Feste[index].InfoText = try doc.select("#main > p").text()
                   
               } catch Exception.Error(let type, let message) {
                       print(message)
                       print(type)
               } catch {
                       print("error")
               }
            
            Temp.Feste[index] = ScrappenDerSpielLeut(SuchDasFest: Temp.Feste[index])
            Temp.Feste[index] = ScrappenDerLager(SuchDasFest: Temp.Feste[index])
        }
        
        
        return Temp
    }
    
    func ScrappenDerSpielLeut(SuchDasFest:Fest) -> Fest{
        var aktuelleFest = SuchDasFest
        
        //BUG: ES WERDEN NUR DIE SAMSTAGS BANDS GEZEIGT... FEHLER IST ABER BEKANNT.
        
        let response = Alamofire.request("https://www.spectaculum.de" + aktuelleFest.link + "/kuenstler_2019_0.html").responseString().value
        
        do{
            var doc = try SwiftSoup.parse(response!)
        
            let Namen: Elements = try doc.select(".kuenstler_name")
        
            for index in 0..<Namen.size(){
                aktuelleFest.Spielplan.append(band(NameDerBand: try Namen[index].text()))
                //print(aktuelleFest.Spielplan)
            }
            
        }catch Exception.Error(let type, let message) {
                print(message)
                print(type)
        } catch {
                print("error")
        }
        
        
        return aktuelleFest
    }
    
    func ScrappenDerLager(SuchDasFest:Fest) -> Fest{
        var aktuelleFest = SuchDasFest
        
        let response = Alamofire.request("https://www.spectaculum.de" + aktuelleFest.link + "heerlager.php").responseString().value
        
        do{
            var doc = try SwiftSoup.parse(response!)
        
            let Namen: Elements = try doc.select(".description")
        
            for index in 0..<Namen.size(){
                var tempString = try Namen[index].text()
                
                let endIndex = tempString.index(tempString.endIndex, offsetBy: -7)
                let truncated = tempString.substring(to: endIndex)
                
                aktuelleFest.Heerlager.append(lager(NameDesLagers: truncated))
                //print(aktuelleFest.Spielplan)
            }
            
        }catch Exception.Error(let type, let message) {
                print(message)
                print(type)
        } catch {
                print("error")
        }
        
        
        return aktuelleFest
    }
}



