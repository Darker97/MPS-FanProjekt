// Funktionen zum analysieren

func openDatabase() -> OpaquePointer? {
  var db: OpaquePointer?

   //the database file
   let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
       .appendingPathComponent("HeroesDatabase.sqlite")

   //opening the database
   if sqlite3_open(fileURL.path, &amp;db) != SQLITE_OK {
       print("error opening database")
   }

   //creating table
    createTables(db: db!)
    
    return db
}

func createTables(db: OpaquePointer){
    let querrysToCreate =
        ["""
            CREATE SCHEMA IF NOT EXISTS `mydb`;
         """,
         """
            USE `mydb`;
         """,
         """
            CREATE TABLE IF NOT EXISTS `mydb`.`Fest` ( `anfahrt` VARCHAR(255) NULL, `Datum` VARCHAR(255) NULL, `Infotext` VARCHAR(255) NULL, `link` VARCHAR(255) NULL, `name` VARCHAR(255) NOT NULL, PRIMARY KEY (`name`));
         """,
         """
            CREATE TABLE IF NOT EXISTS `mydb`.`Lager` ( `Name` VARCHAR(255) NOT NULL, `HomePage` VARCHAR(255) NULL, `Link` VARCHAR(255) NULL, `Fest_name` VARCHAR(255) NOT NULL, PRIMARY KEY (`Name`), INDEX `fk_Lager_Fest1_idx` (`Fest_name` ASC) VISIBLE, CONSTRAINT `fk_Lager_Fest1` FOREIGN KEY (`Fest_name`) REFERENCES `mydb`.`Fest` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION) ;

         """,
         """
            CREATE TABLE IF NOT EXISTS `mydb`.`Band` ( `Name` VARCHAR(255) NOT NULL, `typ` VARCHAR(255) NULL, `Zeit` VARCHAR(255) NULL, `Homepage` VARCHAR(255) NULL, `Fest_name` VARCHAR(255) NOT NULL, PRIMARY KEY (`Name`), INDEX `fk_Band_Fest_idx` (`Fest_name` ASC) VISIBLE, CONSTRAINT `fk_Band_Fest` FOREIGN KEY (`Fest_name`) REFERENCES `mydb`.`Fest` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION) ;
         """,
         """
            CREATE TABLE IF NOT EXISTS `mydb`.`Marktstand` ( `name` VARCHAR(255) NOT NULL, `Kontakt` VARCHAR(255) NULL, `Homepage` VARCHAR(255) NULL, `Fest_name` VARCHAR(255) NOT NULL, PRIMARY KEY (`name`), INDEX `fk_Marktstand_Fest1_idx` (`Fest_name` ASC) VISIBLE, CONSTRAINT `fk_Marktstand_Fest1` FOREIGN KEY (`Fest_name`) REFERENCES `mydb`.`Fest` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION) ;
         """
        ]
    
    for query in querrysToCreate{
        exeute_withoutReturn(db: db, Query: query)
    }
}

func insert_Band(db: OpaquePointer, Name:String, Typ: String, Zeit: String, Homepage: String, Fest_name: String){
    // INSERT INTO `mydb`.`Band` (`Name`, `typ`, `Zeit`, `Homepage`, `Fest_name`) VALUES (NULL, NULL, NULL, NULL, NULL);
    let Query = " INSERT INTO `mydb`.`Band` (`Name`, `typ`, `Zeit`, `Homepage`, `Fest_name`) VALUES ( "
    let Query_Zusatz = " ); "
    
    let Query_Finished = Query + Name + "," + Typ + "," + Zeit + "," + Homepage + "," + Fest_name + Query_Zusatz
    
    exeute_withoutReturn(db: db, Query: Query_Finished)
}

func insert_Fest(db: OpaquePointer, Name:String, link: String, Infotext: String, Datum: String, anfahrt: String){
    // INSERT INTO `mydb`.`Fest` (`anfahrt`, `Datum`, `Infotext`, `link`, `name`) VALUES (NULL, NULL, NULL, NULL, NULL);
    let Query = " INSERT INTO `mydb`.`Fest` (`anfahrt`, `Datum`, `Infotext`, `link`, `name`) VALUES ( "
    let Query_Zusatz = " ); "
    
    let Query_Finished = Query + anfahrt + "," + Datum + "," + Infotext + "," + link + "," + Name + Query_Zusatz
    
    exeute_withoutReturn(db: db, Query: Query_Finished)
}

func insert_Lager(db: OpaquePointer, Name:String, HomePage: String, Link: String, Fest_name: String){
    // INSERT INTO `mydb`.`Lager` (`Name`, `Beschreibung`, `Link`, `Fest_name`) VALUES (NULL, NULL, NULL, NULL);
    let Query = "  INSERT INTO `mydb`.`Lager` (`Name`, `HomePage`, `Link`, `Fest_name`) VALUES ( "
    let Query_Zusatz = " ); "
    
    let Query_Finished = Query + Name + "," + HomePage + "," + Link + "," + Fest_name + Query_Zusatz
    
    exeute_withoutReturn(db: db, Query: Query_Finished)
}

func insert_Marktstand(db: OpaquePointer, Name:String, Kontakt: String, Homepage: String, Fest_name: String){
    // INSERT INTO `mydb`.`Marktstand` (`name`, `Kontakt`, `Homepage`, `Fest_name`) VALUES (NULL, NULL, NULL, NULL);
    let Query = " INSERT INTO `mydb`.`Marktstand` (`name`, `Kontakt`, `Homepage`, `Fest_name`) VALUES ( "
    let Query_Zusatz = " ); "
    
    let Query_Finished = Query + Name + "," + Kontakt + "," + Homepage + "," + Fest_name + Query_Zusatz
    
    exeute_withoutReturn(db: db, Query: Query_Finished)
}

func exeute_withoutReturn(db: OpaquePointer, Query: String){
    if sqlite3_exec(db, Query, nil , nil , nil) != SQLITE_OK {
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("error creating table: \(errmsg)")
    }
}

