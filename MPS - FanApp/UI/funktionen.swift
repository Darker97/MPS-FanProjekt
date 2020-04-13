//
//  funktionen.swift
//  MPS - FanApp
//
//  Created by Christian Baltzer on 13.04.20.
//  Copyright © 2020 Christian Baltzer. All rights reserved.
//

import Foundation


func Fest_Function()->[Fest_Cellen]{
    var ZielArray = [Fest_Cellen]()
    
    let db = openDatabase()!
    //DropAllTables(db: db)
    //createTables(db: db)
    //LoadData(db: db)
    
    let temp = Get_Fest_all(db: db)
    
    for Fest in temp{
        let Name = Fest.components(separatedBy: "|")[4]
        let datum = Fest.components(separatedBy: "|")[1]
        ZielArray.append(Fest_Cellen(name: Name, datum: datum))
    }
    return ZielArray
}

func Spielleute_Function()-> [Spielleute_Cellen]{
    var ZielArray = [Spielleute_Cellen]()
    
    let db = openDatabase()!
    let temp = Get_Band_all(db: db)
    
    for Band in temp{
        var name: String =      Band.components(separatedBy: "|")[0]
        var typ: String =       Band.components(separatedBy: "|")[1]
        var Zeit: String =      Band.components(separatedBy: "|")[2]
        var homepage: String =  Band.components(separatedBy: "|")[3]
        
        ZielArray.append(Spielleute_Cellen(name: name, homepage: homepage, typ: typ, Zeit: Zeit))
    }
    return ZielArray
}

func Spielleute_Function(Fest:String)-> [Spielleute_Cellen]{
    var ZielArray = [Spielleute_Cellen]()
    
    let db = openDatabase()!
    let temp = Get_FromFest_Band(db: db, Fest: Fest)
    
    for Band in temp{
        var name: String =      Band.components(separatedBy: "|")[0]
        var typ: String =       Band.components(separatedBy: "|")[1]
        var Zeit: String =      Band.components(separatedBy: "|")[2]
        var homepage: String =  Band.components(separatedBy: "|")[3]
        
        ZielArray.append(Spielleute_Cellen(name: name, homepage: homepage, typ: typ, Zeit: Zeit))
    }
    return ZielArray
}

func Markt_Function()-> [Markt_Cellen]{
    var ZielArray = [Markt_Cellen]()
    
    let db = openDatabase()!
    let temp = Get_Marktstand_all(db: db)
    
    for Band in temp{
        var name: String =      Band.components(separatedBy: "|")[0]
        var kontakt: String =   Band.components(separatedBy: "|")[1]
        var homepage: String =  Band.components(separatedBy: "|")[2]
        
        ZielArray.append(Markt_Cellen(name: name, homepage: homepage, kontakt: kontakt))
    }
    return ZielArray
}

func Markt_Function(Fest:String)-> [Markt_Cellen]{
    var ZielArray = [Markt_Cellen]()
    
    let db = openDatabase()!
    let temp = Get_FromFest_Marktstand(db: db, Fest: Fest)
    
    for Band in temp{
        var name: String =      Band.components(separatedBy: "|")[0]
        var kontakt: String =   Band.components(separatedBy: "|")[1]
        var homepage: String =  Band.components(separatedBy: "|")[2]
        
        ZielArray.append(Markt_Cellen(name: name, homepage: homepage, kontakt: kontakt))
    }
    return ZielArray
}

func Heerlager_Function()-> [Heerlager_Cellen]{
    var ZielArray = [Heerlager_Cellen]()
    
    let db = openDatabase()!
    let temp = Get_Lager_all(db: db)
    
    for Band in temp{
        var name: String =      Band.components(separatedBy: "|")[0]
        var link: String =   Band.components(separatedBy: "|")[2]
        var homepage: String =  Band.components(separatedBy: "|")[1]
        
        ZielArray.append(Heerlager_Cellen(name: name, homepage: homepage, link: link))
    }
    
    return ZielArray
}

func Heerlager_Function(Fest:String)-> [Heerlager_Cellen]{
    var ZielArray = [Heerlager_Cellen]()
    
    let db = openDatabase()!
    let temp = Get_FromFest_Lager(db: db, Fest: Fest)
    
    for Band in temp{
        var name: String =      Band.components(separatedBy: "|")[0]
        var link: String =   Band.components(separatedBy: "|")[2]
        var homepage: String =  Band.components(separatedBy: "|")[1]
        
        ZielArray.append(Heerlager_Cellen(name: name, homepage: homepage, link: link))
    }
    
    return ZielArray
}

func Fest_Infos_ForStruct(Fest: String) -> Fest_Infos_struktur{
    var Ziel: Fest_Infos_struktur
     
    let db = openDatabase()!
    
    let temp = Get_Fest(db: db, Fest: Fest)[0]
    
    let anfahrt = temp.components(separatedBy: "|")[0]
    let links = temp.components(separatedBy: "|")[3]
    let Infotext = temp.components(separatedBy: "|")[2]
    
    Ziel = Fest_Infos_struktur(anfahrt: anfahrt, links: links, InfoText: Infotext)
    
    return Ziel
}


