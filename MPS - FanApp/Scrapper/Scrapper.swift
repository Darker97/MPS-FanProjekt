// Funktionen zum Scrappen von Websites
// ----------------------------------------------------------------- //
// Pluggins
import Foundation
import SwiftSoup
import Alamofire
import UIKit
import Alamofire_Synchronous

// ----------------------------------------------------------------- //

func ladeStandart(){
    let link = "https://upload.wikimedia.org/wikipedia/commons/8/89/Blaues_Viereck.png"
    Alamofire.request(link).responseImage { response in
    if case .success(let image) = response.result {
        print("image downloaded: \(image)")
        // speichern des Bildes
        let SavePoint = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("standart")
        let BildDaten = image.jpegData(compressionQuality: 0.5)
        try! BildDaten?.write(to: SavePoint)
    }
    }
}

func laden_Websites(link:String)-> String{
    var HTML = ""
    
    let response = Alamofire.request(link).responseString().value
        HTML = response!
    return HTML
}

func scrapper_Objecte(html:String, Selector: String) -> [String]{
    var ZielArray = [String]()
    
    let doc = try! SwiftSoup.parse(html)
    let Array = try! doc.select(Selector)
    
    for Objects in Array{
        try! ZielArray.append(Objects.html())
    }
    
    return ZielArray
}

func scrapper_Objecte_Text(html: String, Selector: String) -> [String]{
    var ZielArray = [String]()
    
    let doc = try! SwiftSoup.parse(html)
    
    let Namen: Elements = try! doc.select(Selector)
    let Array = Namen.array()
    
    for link in Array{
        let linkText: String = try! link.text()
        ZielArray.append(linkText)
    }
    return ZielArray
}
    
func scrapper_Objecte_Links(html: String, Selector: String) -> [String]{
    var ZielArray = [String]()
    
    let doc = try! SwiftSoup.parse(html)
    
    let Namen: Elements = try! doc.select(Selector)
    let Array = Namen.array()
    
    for link in Array{
        let linkText: String = try! link.attr("href")
        ZielArray.append(linkText)
    }
    
    return ZielArray
}
