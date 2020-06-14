//
//  Datenbank Setter.swift
//  MPS - FanApp
//
//  Created by Christian Baltzer on 14.06.20.
//  Copyright © 2020 Christian Baltzer. All rights reserved.
//

import Foundation


func insert_Band(Name:String, Typ: String, Zeit: String, Homepage: String, Fest_name: String){
    // INSERT INTO `mydb`.`Band` (`Name`, `typ`, `Zeit`, `Homepage`, `Fest_name`) VALUES (NULL, NULL, NULL, NULL, NULL);
    let Query = " INSERT INTO `Band` (`Name`, `typ`, `Zeit`, `Homepage`, `Fest_name`) VALUES ( "
    let Query_Zusatz = "\" ); "
    
    let Query_Finished = Query + "\"" + Name + "\",\"" + Typ + "\",\"" + Zeit + "\",\"" + Homepage + "\",\"" + Fest_name + Query_Zusatz
    
    exeute_withoutReturn(Query: Query_Finished)
}

func insert_Fest(Name:String, link: String, Infotext: String, Datum: String, anfahrt: String){
    // INSERT INTO `mydb`.`Fest` (`anfahrt`, `Datum`, `Infotext`, `link`, `name`) VALUES (NULL, NULL, NULL, NULL, NULL);
    let Query = " INSERT INTO `Fest` (`anfahrt`, `Datum`, `Infotext`, `link`, `name`) VALUES ( "
    let Query_Zusatz = "\" ); "
    
    let Infotext_Bearbeitet = Infotext.replacingOccurrences(of: "\"", with: " ", options: NSString.CompareOptions.literal, range: nil)
    let Anfahrt_Bearbeitet = anfahrt.replacingOccurrences(of: "\"", with: " ", options: NSString.CompareOptions.literal, range: nil)
    
    let Query_Finished = Query + "\"" + Anfahrt_Bearbeitet + "\",\"" + Datum + "\",\"" + Infotext_Bearbeitet + "\",\"" + link + "\",\"" + Name + Query_Zusatz
    
    exeute_withoutReturn(Query: Query_Finished)
}

func insert_Lager(Name:String, HomePage: String, Link: String, Fest_name: String){
    // INSERT INTO `Lager` (`Name`, `Beschreibung`, `Link`, `Fest_name`) VALUES (NULL, NULL, NULL, NULL);
    let Query = "  INSERT INTO `Lager` (`Name`, `HomePage`, `Link`, `Fest_name`) VALUES ( "
    let Query_Zusatz = "\" ); "
    
    var Name_bearbeitet = Name.replacingOccurrences(of: "\"", with: " ", options: NSString.CompareOptions.literal, range: nil)
    Name_bearbeitet = Name_bearbeitet.replacingOccurrences(of: "\n", with: " ", options: NSString.CompareOptions.literal, range: nil)
    
    let Query_Finished = Query + "\"" + Name_bearbeitet + "\",\"" + HomePage + "\",\"" + Link + "\",\"" + Fest_name + Query_Zusatz
    
    exeute_withoutReturn(Query: Query_Finished)
}

func insert_Marktstand(Name:String, Kontakt: String, Homepage: String, Fest_name: String){
    // INSERT INTO `mydb`.`Marktstand` (`name`, `Kontakt`, `Homepage`, `Fest_name`) VALUES (NULL, NULL, NULL, NULL);
    let Query = " INSERT INTO `Marktstand` (`name`, `Kontakt`, `Homepage`, `Fest_name`) VALUES ( "
    let Query_Zusatz = "\" ); "
    
    var Name_bearbeitet = Name.replacingOccurrences(of: "\"", with: " ", options: NSString.CompareOptions.literal, range: nil)
    Name_bearbeitet = Name_bearbeitet.replacingOccurrences(of: "\n", with: " ", options: NSString.CompareOptions.literal, range: nil)
    
    let Query_Finished = Query + "\"" + Name_bearbeitet + "\",\"" + Kontakt + "\",\"" + Homepage + "\",\"" + Fest_name + Query_Zusatz
    
    exeute_withoutReturn(Query: Query_Finished)
}
