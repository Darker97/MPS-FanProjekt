//
//  Cellen.swift
//  MPS - FanApp
//
//  Created by Christian Baltzer on 13.04.20.
//  Copyright © 2020 Christian Baltzer. All rights reserved.
//

import SwiftUI

struct Fest_Celle: View {
    let name:String
    let datum: String
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                 //Name & Datum
                Text(name).font(.title)
                Text(datum).font(.footnote)
            }
            NavigationLink(destination: FestInfo(Fest: name, Name: name, BandSpeicher: Spielleute_Function(Fest: name), Stände: Markt_Function(Fest: name), Lager: Heerlager_Function(Fest: name), Fest_Infos: Fest_Infos_ForStruct(Fest: name))) {
                Text("")
                }
        }
    }
}



struct Spielleute_Celle: View {
    let name: String
    let homepage: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name).font(.title)
            Text(homepage).font(.footnote)
        }
    }
}

struct Markt_Celle: View {
    let name: String
    let homepage: String
    let kontakt: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name).font(.title)
            Text(homepage).font(.footnote)
            Text(kontakt).font(.footnote)
        }
    }
}

struct Heerlager_Celle: View {
    let name: String
    let homepage: String
    let link: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name).font(.title)
            Text(homepage).font(.footnote)
            Text(link).font(.footnote)
        }
    }
}
