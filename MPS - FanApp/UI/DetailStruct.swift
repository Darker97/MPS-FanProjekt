//
//  DetailStruct.swift
//  MPS - FanApp
//
//  Created by Christian Baltzer on 15.06.20.
//  Copyright © 2020 Christian Baltzer. All rights reserved.
//

import Foundation
import SwiftUI

struct Band{
    let Name: String
    let Homepage: String
    let Bild: UIImage
    
    init(Name:String){
        self.Name = Name
        self.Homepage = { () -> String in
            let Query = "select Homepage from Band where Name = \"" + Name + "\""
            return execute_withReturn(Query: Query, ErgebnisZeilen: 1)[0]
        }()
        self.Bild = { () -> UIImage in
            let Query = "select BildLink from Band where Name = \"" + Name + "\""
            let link =  execute_withReturn(Query: Query, ErgebnisZeilen: 1)[0]
            
            let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(link)
            return UIImage(contentsOfFile: filePath.path)!
        }()
    }
}


struct Fest{
    let Name: String
    let Datum: String
    let Infotext: String
    let anfahrt: String
    //let Bands: [Homescreen_Band]
    
    init(Name: String){
        self.Name = Name
        self.Datum = { () -> String in
               let Query = "select Datum from Fest where Name = \"" + Name + "\""
               return execute_withReturn(Query: Query, ErgebnisZeilen: 1)[0]
           }()
        self.Infotext = { () -> String in
                let Query = "select Infotext from Fest where Name = \"" + Name + "\""
                return execute_withReturn(Query: Query, ErgebnisZeilen: 1)[0]
            }()
        
        self.anfahrt = { () -> String in
            let Query = "select anfahrt from Fest where Name = \"" + Name + "\""
            return execute_withReturn(Query: Query, ErgebnisZeilen: 1)[0]
        }()
        
        //TODO: Homescreen_BandS
    }
}

struct Marktstand{
    let Name: String
    let Kontakt: String
    let Homepage: String
    let BildLink: String
}

