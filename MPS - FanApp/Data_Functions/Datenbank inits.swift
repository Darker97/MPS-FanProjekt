//
//  Datenbank inits.swift
//  MPS - FanApp
//
//  Created by Christian Baltzer on 14.06.20.
//  Copyright © 2020 Christian Baltzer. All rights reserved.
//

import Foundation


func DropAllTables(){
    let QuerrysToDrop = ["""DROP TABLE IF EXISTS `Fest`""",
                        """DROP TABLE IF EXISTS `Lager`""",
                        """DROP TABLE IF EXISTS `Band`""",
                        """DROP TABLE IF EXISTS `Marktstand`"""
                        """DROP TABLE IF EXISTS `Fest_has_Band`""",
                        """DROP TABLE IF EXISTS `Fest_has_Lager`""",
                        """DROP TABLE IF EXISTS `Fest_has_Marktstand`"""] 
    
    for query in QuerrysToDrop{
        exeute_withoutReturn(Query: query)
    }
}

func createTables(){
    let querrysToCreate =
        ["""
            CREATE TABLE IF NOT EXISTS `Fest` ( `anfahrt` VARCHAR(255) NULL, `Datum` VARCHAR(255) NOT NULL, `Infotext` VARCHAR(255) NULL, `link` VARCHAR(255) NULL, `name` VARCHAR(255) NOT NULL, PRIMARY KEY (`name`, `Datum`));
         """,
         """
            CREATE TABLE IF NOT EXISTS `Lager` (`Name` VARCHAR(255) NOT NULL,`HomePage` VARCHAR(255) NULL,`Link` VARCHAR(255) NULL,`Fest_name` VARCHAR(255) NOT NULL,PRIMARY KEY (`Name`, `Fest_name`), FOREIGN KEY (`Fest_name`)  REFERENCES `Fest` (`name`)  ON DELETE NO ACTION  ON UPDATE NO ACTION)

         """,
         """
            CREATE TABLE IF NOT EXISTS `Band` (`Name` VARCHAR(255) NOT NULL,`typ` VARCHAR(255) NULL,`Zeit` VARCHAR(255) NOT NULL,`Homepage` VARCHAR(255) NULL,`Fest_name` VARCHAR(255) NOT NULL,PRIMARY KEY (`Name`, `Fest_name`, `Zeit`), FOREIGN KEY (`Fest_name`)  REFERENCES `Fest` (`name`)  ON DELETE NO ACTION  ON UPDATE NO ACTION);
         """,
         """
            CREATE TABLE IF NOT EXISTS `Marktstand` (`name` VARCHAR(255) NOT NULL,`Kontakt` VARCHAR(255) NULL,`Homepage` VARCHAR(255) NULL,`Fest_name` VARCHAR(255) NOT NULL,PRIMARY KEY (`name`, `Fest_name`), FOREIGN KEY (`Fest_name`)  REFERENCES `Fest` (`name`)  ON DELETE NO ACTION  ON UPDATE NO ACTION)
         """
        ]
    
    for query in querrysToCreate{
        exeute_withoutReturn(Query: query)
    }
}
