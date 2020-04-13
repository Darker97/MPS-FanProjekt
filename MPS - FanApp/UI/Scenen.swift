//
//  Scenen.swift
//  MPS - FanApp
//
//  Created by Christian Baltzer on 13.04.20.
//  Copyright © 2020 Christian Baltzer. All rights reserved.
//

import SwiftUI

struct AlleFeste: View{
    
    var alleFeste_Var = Fest_Function()
     
    var body: some View{
    //Allen Festen
    NavigationView {
        List(alleFeste_Var, id: \.name) { Fest in
            HStack(alignment: .lastTextBaseline){
                Fest_Celle(name: Fest.name, datum: Fest.datum)
            }
        }
        // Überschrift
        .navigationBarTitle(Text("Alle Feste"), displayMode: .automatic)
        // Button zum updaten
        .navigationBarItems(
            leading:
            Button(action:{
                let db = openDatabase()!
                DropAllTables(db: db)
                createTables(db: db)
                LoadData(db: db)
            }) {
                Text("Update")
            },
            // Button fürs Impressum
            trailing: NavigationLink(destination: Impressum()) {
                    Text("Impressum")
                }
        )}}
}

struct Impressum: View{
    var body: some View{
        NavigationView{
            ScrollView {
                Text(impressumText).font(.body)
            }
        }
    }
}

struct AlleBandsUndMärkte: View{
    var Spielleute = Spielleute_Function()
    var Märkte = Markt_Function()
    var Lager = Heerlager_Function()
    
    var body: some View{
        List(Spielleute, id: \.name) { Band in
            HStack(alignment: .lastTextBaseline){
                Spielleute_Celle(name: Band.name, homepage: Band.homepage)
            }
    }
    }}
    
struct BandView: View{
    var Bands: [Spielleute_Cellen]
    var body: some View{
        List(Bands, id: \.name) { Band in
            HStack(alignment: .lastTextBaseline){
                Spielleute_Celle(name: Band.name, homepage: Band.homepage)
            }
    }
    }}
    
struct StändeView: View{
    var Bands: [Markt_Cellen]
    var body: some View{
        List(Bands, id: \.name) { Band in
            HStack(alignment: .lastTextBaseline){
                Markt_Celle(name: Band.name, homepage: Band.homepage, kontakt: Band.kontakt)
            }
    }
    }}

struct LagerView: View{
    var Bands: [Heerlager_Cellen]
    var body: some View{
        List(Bands, id: \.name) { Band in
            HStack(alignment: .lastTextBaseline){
                Heerlager_Celle(name: Band.name, homepage: Band.homepage, link: Band.link)
            }
    }
    }}
    
struct FestInfo: View{
    var Fest: String
    var Name: String
    
    var BandSpeicher: [Spielleute_Cellen]
    var Stände: [Markt_Cellen]
    var Lager: [Heerlager_Cellen]
    var Fest_Infos: Fest_Infos_struktur
    
    var body: some View{
        NavigationView{
            ScrollView{
            HStack{
                NavigationLink("Spielleute", destination: BandView(Bands: self.BandSpeicher))
                NavigationLink("Marktstände", destination: StändeView(Bands: self.Stände))
                NavigationLink("HeerLager", destination: LagerView(Bands: self.Lager))
            }
                Text("Link").font(.title)
                Text(Fest_Infos.links).font(.body)
            Divider()
                Text("Infos").font(.title)
                Text(Fest_Infos.InfoText).font(.body)
            Divider()
                Text("Anfahrt").font(.title)
                Text(Fest_Infos.anfahrt).font(.body)
            }
            .navigationBarTitle(Text(Fest), displayMode: .automatic)
        }
    }
}


let impressumText = """
Dies ist eine kleine FanApp für das Mittelalter Phantasie Spectaculum, kurz MPS.

Sollten dir inhaltliche Fehler oder Bugs auffallen, würde ich mich über eine Bewertung oder Rückmeldung sehr freuen 🙂

Falls du wissen möchtest, wie die App funktioniert oder eigene Ideen hast:
Den gesamten Code zur App findest du auf Github.

Always happy Coding
Christian


Copyright (C) <2019>  <Christian Baltzer>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
"""
