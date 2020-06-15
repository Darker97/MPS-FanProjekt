//
//  Datenbank inits.swift
//  MPS - FanApp
//
//  Created by Christian Baltzer on 14.06.20.
//  Copyright © 2020 Christian Baltzer. All rights reserved.
//

import Foundation


func DropAllTables(){
    let QuerrysToDrop = ["DROP TABLE IF EXISTS `Fest`",
                            "DROP TABLE IF EXISTS `Lager`",
                            "DROP TABLE IF EXISTS `Band`",
                            "DROP TABLE IF EXISTS `Marktstand`",
                            "DROP TABLE IF EXISTS `Fest_has_Band`",
                            "DROP TABLE IF EXISTS `Fest_has_Lager`",
                            "DROP TABLE IF EXISTS `Fest_has_Marktstand`"]
    
    for query in QuerrysToDrop{
        exeute_withoutReturn(Query: query)
    }
}

func createTables(){
    let querrysToCreate =
        ["""
        CREATE TABLE IF NOT EXISTS `Fest` ( `anfahrt` VARCHAR(255) NULL, `Datum` VARCHAR(255) NULL, `Infotext` VARCHAR(255) NULL, `link` VARCHAR(255) NULL, `name` VARCHAR(255) NOT NULL, PRIMARY KEY (`name`))
        """,
        """
        CREATE TABLE IF NOT EXISTS `Lager` ( `Name` VARCHAR(255) NOT NULL, `Beschreibung` VARCHAR(255) NULL, `Link` VARCHAR(255) NULL, PRIMARY KEY (`Name`))
        """,
        """
        CREATE TABLE IF NOT EXISTS `Band` ( `Name` VARCHAR(255) NOT NULL, `typ` VARCHAR(255) NULL, `Zeit` VARCHAR(255) NULL, `Homepage` VARCHAR(255) NULL, `BildLink` VARCHAR(255) NULL, PRIMARY KEY (`Name`))
        """,
        """
        CREATE TABLE IF NOT EXISTS `Marktstand` ( `name` VARCHAR(255) NOT NULL, `Kontakt` VARCHAR(255) NULL, `Homepage` VARCHAR(255) NULL, `BildLink` VARCHAR(255) NULL, PRIMARY KEY (`name`))
        """,
        """
        CREATE TABLE IF NOT EXISTS `Fest_has_Band` ( `Fest_name` VARCHAR(255) NOT NULL, `Band_Name` VARCHAR(255) NOT NULL, PRIMARY KEY (`Fest_name`, `Band_Name`), CONSTRAINT `fk_Fest_has_Band_Fest` FOREIGN KEY (`Fest_name`) REFERENCES `Fest` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION, CONSTRAINT `fk_Fest_has_Band_Band1` FOREIGN KEY (`Band_Name`) REFERENCES `Band` (`Name`) ON DELETE NO ACTION ON UPDATE NO ACTION)
        """,
        """
        CREATE TABLE IF NOT EXISTS `Fest_has_Marktstand` ( `Fest_name` VARCHAR(255) NOT NULL, `Marktstand_name` VARCHAR(255) NOT NULL, PRIMARY KEY (`Fest_name`, `Marktstand_name`), CONSTRAINT `fk_Fest_has_Marktstand_Fest1` FOREIGN KEY (`Fest_name`) REFERENCES `Fest` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION, CONSTRAINT `fk_Fest_has_Marktstand_Marktstand1` FOREIGN KEY (`Marktstand_name`) REFERENCES `Marktstand` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION)
        """,
        """
        CREATE TABLE IF NOT EXISTS `Fest_has_Lager` (`Fest_name` VARCHAR(255) NOT NULL,`Lager_Name` VARCHAR(255) NOT NULL,PRIMARY KEY (`Fest_name`, `Lager_Name`),CONSTRAINT `fk_Fest_has_Lager_Fest1` FOREIGN KEY (`Fest_name`) REFERENCES `Fest` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION, CONSTRAINT `fk_Fest_has_Lager_Lager1` FOREIGN KEY (`Lager_Name`) REFERENCES `Lager` (`Name`) ON DELETE NO ACTION ON UPDATE NO ACTION)
        """]
    
    for query in querrysToCreate{
        exeute_withoutReturn(Query: query)
    }
}
