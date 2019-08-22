//
//  Data.swift
//  MPS-Fanprojekt
//
//  Created by Christian Baltzer on 20.08.19.
//  Copyright © 2019 Christian Baltzer. All rights reserved.
//

import Foundation


struct AlleDaten: Codable{
    var Feste: [Fest]
    var hauptLink: String
    var html: String
    init( LinkDerSeite: String){
        hauptLink = LinkDerSeite
        Feste = []
        html = ""
    }
}

struct Fest: Codable{
    var link: String
    var Name: String
    var Datum: Date
    var Ort: String
    var InfoText: String
    var Spielplan: [band]
    var Heerlager: [lager]
    var html: String
    
    init(NameDesFestes: String, linkDesFestes: String){
        Name = NameDesFestes
        link = linkDesFestes
        Datum = Date()
        Ort = ""
        InfoText = ""
        Spielplan = []
        Heerlager = []
        html = ""
    }
}

struct band: Codable{
    var Name: String
    var Zeit: Date
    var Bühne: String
    
    init(NameDerBand: String){
        Name = NameDerBand
        Zeit = Date()
        Bühne = ""
    }
}

struct lager: Codable{
    var name: String
    var Beschreibung: String
    
    init(NameDesLagers: String){
        name = NameDesLagers
        Beschreibung = ""
    }
}
