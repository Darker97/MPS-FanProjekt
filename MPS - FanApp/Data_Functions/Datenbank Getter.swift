//
//  Datenbank Getter.swift
//  MPS - FanApp
//
//  Created by Christian Baltzer on 12.04.20.
//  Copyright © 2020 Christian Baltzer. All rights reserved.
//

import Foundation

// Tabellen:    Fest, Lager, Band, Marktstand

// ------------------------------------------------------------------------- //
// Bekomm alles
func Get_Band_all(db:OpaquePointer){
    let query = "SELECT * FROM Band"
    return execute_withReturn(db: db, Query: query)
}

func Get_Fest_all(db:OpaquePointer){
    let query = "SELECT * FROM Fest"
    return execute_withReturn(db: db, Query: query)
}
func Get_Lager_all(db:OpaquePointer){
    let query = "SELECT * FROM Lager"
    return execute_withReturn(db: db, Query: query)
}
func Get_Marktstand_all(db:OpaquePointer){
    let query = "SELECT * FROM Marktstand"
    return execute_withReturn(db: db, Query: query)
}

// ------------------------------------------------------------------------- //
// Bekomme alle Infos des bestimmten Objektes
func Get_Lager(db:OpaquePointer, Lager:String){
    let query = "SELECT * FROM Lager WHERE Name = " + Lager
    return execute_withReturn(db: db, Query: query)
}
func Get_Marktstand(db:OpaquePointer, Marktstand:String){
    let query = "SELECT * FROM Marktstand WHERE Name = " + Marktstand
    return execute_withReturn(db: db, Query: query)
}
func Get_Band(db:OpaquePointer, Band:String){
    let query = "SELECT * FROM Band WHERE Name = " + Band
    return execute_withReturn(db: db, Query: query)
}

// ------------------------------------------------------------------------- //
//Get alle Namen des beschtimmten Festes
func Get_FromFest_Lager(db:OpaquePointer, Fest:String){
    let query = "SELECT Name FROM Lager WHERE Fest_name = " + Fest
    return execute_withReturn(db: db, Query: query)
}
func Get_FromFest_Marktstand(db:OpaquePointer, Fest:String){
    let query = "SELECT Name FROM Marktstand WHERE Fest_name = " + Fest
    return execute_withReturn(db: db, Query: query)
}
func Get_FromFest_Band(db:OpaquePointer, Fest:String){
    let query = "SELECT Name FROM Band WHERE Fest_name = " + Fest
    return execute_withReturn(db: db, Query: query)
}
