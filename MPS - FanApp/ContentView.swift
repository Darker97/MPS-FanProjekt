//
//  ContentView.swift
//  MPS - FanApp
//
//  Created by Christian Baltzer on 11.04.20.
//  Copyright © 2020 Christian Baltzer. All rights reserved.
//

import SwiftUI

// ZU Debug zwecken
struct TestView: View{
    var body: some View{
        Text("Hello World")
    }
}

struct ContentView: View {
    var Working: Homescreen
    
    var body: some View{
        //Überschrift && SettingsButton
        NavigationView{
            List{
                // Feste
                Section{
                    AlleFeste(Feste: Working.Feste)
                }.frame(height: CGFloat(185))
                // Alle Bands
                Section{
                    AlleBands(Bands: Working.bands)
                }
                // Alle Marktstände
                Section{
                    AlleStände(Stände: Working.Marktstände)
                }.frame(height: CGFloat(220))
                
            }
            .navigationBarTitle("MPS Fan App")
                
            .navigationBarItems(trailing: NavigationLink(destination: Impressum()) {
                Image(systemName: "book")
            })

        }
        
        
    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(Working: Homescreen())
    }
}
#endif

struct AlleFeste: View {
    var Feste: [Homescreen_Fest]
        
    var body: some View {
        List(Feste, id: \.Name) { Fest in
            Image(systemName: "photo")
            VStack {
                Text(Fest.Name)
                    .font(.headline)
                    .foregroundColor(Color.black)
                Text(Fest.Datum)
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
            }
        }
    }
}

struct AlleBands: View {
    var Bands: [Homescreen_Band]
    
    
    var body: some View {
            VStack {
                Text(verbatim: "Alle Bands")
                    .font(.headline)
                    .padding(.leading, 15)
                    .padding(.top, CGFloat(5))
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: CGFloat(8)) {
                        ForEach(Bands, id: \.Name) { bxy in
                            NavigationLink(destination: BandView(Band: Band(Name: bxy.Name))) {
                            VStack{
                                Group{
                                    Image(uiImage: bxy.Bild)
                                        .resizable()
                                        .frame(width: CGFloat(155), height: CGFloat(155))
                                        .cornerRadius(CGFloat(5))
                                        
                                    Text(bxy.Name)
                                    }
                                }.buttonStyle(PlainButtonStyle())
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                    
                }
                .frame(height: CGFloat(185))
            }
        }
}

struct AlleStände: View{
    var Stände: [Homescreen_Marktstände]
    
    var body: some View {
        VStack{
           Text(verbatim: "Alle Marktstände")
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, CGFloat(5))
            List(Stände, id: \.Name) { Stand in
                Image(systemName: "cart")
                VStack {
                   Text(Stand.Name)
                    .font(.headline)
                    .foregroundColor(Color.black)
                }
            }
        }
        
    }}

struct Impressum: View{
    
    var body: some View{
        Text("""
        Dies ist eine kleine FanApp für das Mittelalter Phantasie Spectaculum, kurz MPS.

        Sollten dir inhaltliche Fehler oder Bugs auffallen, würde ich mich über eine Bewertung oder Rückmeldung sehr freuen 🙂

        Falls du wissen möchtest, wie die App funktioniert oder eigene Ideen hast:
        Den gesamten Code zur App findest du auf Github.

        Always happy Coding
        Christian


        Copyright (C) <2019>  <Christian Baltzer>

        This program is free software: you can redistribute it and/or modify
        it under the terms of the GNU General Public License as published by
        the Free Software Foundation, either version 3 of the License, or
        (at your option) any later version.

        This program is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        GNU General Public License for more details.

        """)
            .font(.body)
            .padding(.top, CGFloat(5))
    }
}
