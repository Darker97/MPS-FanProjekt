// Funktionen zum analysieren
import UIKit
import SQLite3

func openDatabase() -> OpaquePointer? {
    var db: OpaquePointer?
    

   //the database file
   let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
       .appendingPathComponent("Database.sqlite")

   //opening the database
    if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
       print("error opening database")
   }
    
    return db
}

func DropAllTables(db: OpaquePointer){
    let QuerrysToDrop = ["DROP TABLE IF EXISTS `Fest` ;",
                         "DROP TABLE IF EXISTS `Lager` ;",
                         "DROP TABLE IF EXISTS `Band` ;",
                         "DROP TABLE IF EXISTS `Marktstand` ;"]
    
    for query in QuerrysToDrop{
        exeute_withoutReturn(db: db, Query: query)
    }
}

func createTables(db: OpaquePointer){
    let querrysToCreate =
        ["""
            CREATE TABLE IF NOT EXISTS `Fest` ( `anfahrt` VARCHAR(255) NULL, `Datum` VARCHAR(255) NULL, `Infotext` VARCHAR(255) NULL, `link` VARCHAR(255) NULL, `name` VARCHAR(255) NOT NULL, PRIMARY KEY (`name`));
         """,
         """
            CREATE TABLE IF NOT EXISTS `Lager` (`Name` VARCHAR(255) NOT NULL,`Beschreibung` VARCHAR(255) NULL,`Link` VARCHAR(255) NULL,`Fest_name` VARCHAR(255) NOT NULL,PRIMARY KEY (`Name`, `Fest_name`), FOREIGN KEY (`Fest_name`)  REFERENCES `Fest` (`name`)  ON DELETE NO ACTION  ON UPDATE NO ACTION)

         """,
         """
            CREATE TABLE IF NOT EXISTS `Band` (`Name` VARCHAR(255) NOT NULL,`typ` VARCHAR(255) NULL,`Zeit` VARCHAR(255) NULL,`Homepage` VARCHAR(255) NULL,`Fest_name` VARCHAR(255) NOT NULL,PRIMARY KEY (`Name`, `Fest_name`), FOREIGN KEY (`Fest_name`)  REFERENCES `Fest` (`name`)  ON DELETE NO ACTION  ON UPDATE NO ACTION);
         """,
         """
            CREATE TABLE IF NOT EXISTS `Marktstand` (`name` VARCHAR(255) NOT NULL,`Kontakt` VARCHAR(255) NULL,`Homepage` VARCHAR(255) NULL,`Fest_name` VARCHAR(255) NOT NULL,PRIMARY KEY (`name`, `Fest_name`), FOREIGN KEY (`Fest_name`)  REFERENCES `Fest` (`name`)  ON DELETE NO ACTION  ON UPDATE NO ACTION)
         """
        ]
    
    for query in querrysToCreate{
        exeute_withoutReturn(db: db, Query: query)
    }
}

func insert_Band(db: OpaquePointer, Name:String, Typ: String, Zeit: String, Homepage: String, Fest_name: String){
    // INSERT INTO `mydb`.`Band` (`Name`, `typ`, `Zeit`, `Homepage`, `Fest_name`) VALUES (NULL, NULL, NULL, NULL, NULL);
    let Query = " INSERT INTO `Band` (`Name`, `typ`, `Zeit`, `Homepage`, `Fest_name`) VALUES ( "
    let Query_Zusatz = "\" ); "
    
    let Query_Finished = Query + "\"" + Name + "\",\"" + Typ + "\",\"" + Zeit + "\",\"" + Homepage + "\",\"" + Fest_name + Query_Zusatz
    
    exeute_withoutReturn(db: db, Query: Query_Finished)
}

func insert_Fest(db: OpaquePointer, Name:String, link: String, Infotext: String, Datum: String, anfahrt: String){
    // INSERT INTO `mydb`.`Fest` (`anfahrt`, `Datum`, `Infotext`, `link`, `name`) VALUES (NULL, NULL, NULL, NULL, NULL);
    let Query = " INSERT INTO `Fest` (`anfahrt`, `Datum`, `Infotext`, `link`, `name`) VALUES ( "
    let Query_Zusatz = "\" ); "
    
    let Infotext_Bearbeitet = Infotext.replacingOccurrences(of: "\"", with: " ", options: NSString.CompareOptions.literal, range: nil)
    let Anfahrt_Bearbeitet = anfahrt.replacingOccurrences(of: "\"", with: " ", options: NSString.CompareOptions.literal, range: nil)
    
    var Datum_Bearbeitet = ""
    Datum_Bearbeitet = try! Name.components(separatedBy: " ")[1]
    
    let Query_Finished = Query + "\"" + Anfahrt_Bearbeitet + "\",\"" + Datum_Bearbeitet + "\",\"" + Infotext_Bearbeitet + "\",\"" + link + "\",\"" + Name + Query_Zusatz
    
    exeute_withoutReturn(db: db, Query: Query_Finished)
}

func insert_Lager(db: OpaquePointer, Name:String, HomePage: String, Link: String, Fest_name: String){
    // INSERT INTO `Lager` (`Name`, `Beschreibung`, `Link`, `Fest_name`) VALUES (NULL, NULL, NULL, NULL);
    let Query = "  INSERT INTO `Lager` (`Name`, `HomePage`, `Link`, `Fest_name`) VALUES ( "
    let Query_Zusatz = "\" ); "
    
    let Query_Finished = Query + "\"" + Name + "\",\"" + HomePage + "\",\"" + Link + "\",\"" + Fest_name + Query_Zusatz
    
    exeute_withoutReturn(db: db, Query: Query_Finished)
}

func insert_Marktstand(db: OpaquePointer, Name:String, Kontakt: String, Homepage: String, Fest_name: String){
    // INSERT INTO `mydb`.`Marktstand` (`name`, `Kontakt`, `Homepage`, `Fest_name`) VALUES (NULL, NULL, NULL, NULL);
    let Query = " INSERT INTO `Marktstand` (`name`, `Kontakt`, `Homepage`, `Fest_name`) VALUES ( "
    let Query_Zusatz = "\" ); "
    
    let Query_Finished = Query + "\"" + "\"" + Name + "\",\"" + Kontakt + "\",\"" + Homepage + "\",\"" + Fest_name + Query_Zusatz
    
    exeute_withoutReturn(db: db, Query: Query_Finished)
}

func exeute_withoutReturn(db: OpaquePointer, Query: String){
    if sqlite3_exec(db, Query, nil , nil , nil) != SQLITE_OK {
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("error creating table: \(errmsg)")
        print(Query)
    } else {
        print("Done")
    }
}

func execute_withReturn(db: OpaquePointer, Query: String, ErgebnisZeilen: Int32) -> [String]{
    //TODO
    var queryStatement: OpaquePointer?
    var Ergebnis = [String]()
        if sqlite3_prepare_v2(db, Query, -1, &queryStatement, nil) == SQLITE_OK {
          // 2
            while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                var ZielString = ""
                for i:Int32 in (0...ErgebnisZeilen-1){
                    try ZielString.append(String(cString: sqlite3_column_text(queryStatement, i)))
                    ZielString.append("|")
                }
                Ergebnis.append(ZielString)
            }
    }
    return Ergebnis
}
