//
//  Struct - HomeScreen.swift
//  MPS - FanApp
//
//  Created by Christian Baltzer on 15.06.20.
//  Copyright © 2020 Christian Baltzer. All rights reserved.
//

import Foundation
import SwiftUI

struct Homescreen_Fest{
    let Name: String
    let Datum: String
    
    init(Name: String, Datum: String){
        self.Name = Name
        self.Datum = Datum
    }
}

struct Homescreen_Band{
    let Name: String
    let Bild: UIImage
    
    init(Name: String, Bild: UIImage){
        self.Name = Name
        self.Bild = Bild
    }
}

struct Homescreen_Marktstände{
    let Name: String
    let Bild: UIImage
    
    init(Name: String, Bild: UIImage){
        self.Name = Name
        self.Bild = Bild
    }
}

struct Homescreen{
    let id: Int
    var Feste: [Homescreen_Fest] = []
    var bands: [Homescreen_Band] = []
    var Marktstände: [Homescreen_Marktstände] = []
    
    init() {
        self.id = 1
        let Fest_Name = {() -> [String] in
            return execute_withReturn(Query: "select name from Fest", ErgebnisZeilen: 1)
        }()
        let Fest_Datum = {() -> [String] in
            return execute_withReturn(Query: "select Datum from Fest", ErgebnisZeilen: 1)
        }()
        
        if (Fest_Name.count != 0){
            for i in Range(0...Fest_Name.count - 1){
                self.Feste.append(Homescreen_Fest.init(Name: Fest_Name[i], Datum: Fest_Datum[i]))
            }
            
            let Band_Namen      = { () -> [String] in
                let Query = "select name from Band"
                return execute_withReturn(Query: Query, ErgebnisZeilen: 1)
            }()
            
            for i in Range(0...Band_Namen.count - 1){
                self.bands.append(Homescreen_Band.init(Name: Band_Namen[i], Bild: { () -> UIImage in
                    let Query = "select BildLink from Band where Name = \"" + Band_Namen[i] + "\""
                    let link =  execute_withReturn(Query: Query, ErgebnisZeilen: 1)[0]
                    
                    let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(link)
                    return UIImage(contentsOfFile: filePath.path)!
                }()))
            }
            
            
            var Marktstände_Namen   = { () -> [String] in
                var Query = "select name from Marktstand"
                return execute_withReturn(Query: Query, ErgebnisZeilen: 1)
            }()
            var Marktstände_Bilder  = { () -> [UIImage] in
                var Query = "select BildLink from Marktstand"
                var Bilder =  execute_withReturn(Query: Query, ErgebnisZeilen: 1)
                var ZielArray:[UIImage] = []
                
                for bild in Bilder{
                    let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(bild)
                    ZielArray.append(UIImage(contentsOfFile: filePath.path)!)
                    }
                return ZielArray
            }()
            
            for i in Range(0...Marktstände_Namen.count - 1){
                self.Marktstände.append(Homescreen_Marktstände.init(Name: Marktstände_Namen[i], Bild: Marktstände_Bilder[i]))
            }
        }else{
            // Nix...
        }
    }
    

}
