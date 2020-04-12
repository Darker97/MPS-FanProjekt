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
    createTables(db)
    
    return db
}

func createTables(db: OpaquePointer){
    var querrysToCreate =
        [""" CREATE SCHEMA IF NOT EXISTS `mydb`; """,
         """ USE `mydb`; """,
         """ CREATE TABLE IF NOT EXISTS `mydb`.`Fest` ( `anfahrt` VARCHAR(255) NULL, `Datum` VARCHAR(255) NULL, `Infotext` VARCHAR(255) NULL, `link` VARCHAR(255) NULL, `name` VARCHAR(255) NOT NULL, PRIMARY KEY (`name`)); """,
         """ CREATE TABLE IF NOT EXISTS `mydb`.`Lager` ( `Name` VARCHAR(255) NOT NULL, `Beschreibung` VARCHAR(255) NULL, `Link` VARCHAR(255) NULL, `Fest_name` VARCHAR(255) NOT NULL, PRIMARY KEY (`Name`), INDEX `fk_Lager_Fest1_idx` (`Fest_name` ASC) VISIBLE, CONSTRAINT `fk_Lager_Fest1` FOREIGN KEY (`Fest_name`) REFERENCES `mydb`.`Fest` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION) ; """,
         """ CREATE TABLE IF NOT EXISTS `mydb`.`Band` ( `Name` VARCHAR(255) NOT NULL, `typ` VARCHAR(255) NULL, `Zeit` VARCHAR(255) NULL, `Homepage` VARCHAR(255) NULL, `Fest_name` VARCHAR(255) NOT NULL, PRIMARY KEY (`Name`), INDEX `fk_Band_Fest_idx` (`Fest_name` ASC) VISIBLE, CONSTRAINT `fk_Band_Fest` FOREIGN KEY (`Fest_name`) REFERENCES `mydb`.`Fest` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION) ; """,
         """ CREATE TABLE IF NOT EXISTS `mydb`.`Marktstand` ( `name` VARCHAR(255) NOT NULL, `Kontakt` VARCHAR(255) NULL, `Homepage` VARCHAR(255) NULL, `Fest_name` VARCHAR(255) NOT NULL, PRIMARY KEY (`name`), INDEX `fk_Marktstand_Fest1_idx` (`Fest_name` ASC) VISIBLE, CONSTRAINT `fk_Marktstand_Fest1` FOREIGN KEY (`Fest_name`) REFERENCES `mydb`.`Fest` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION) ; """
        ]
    
    for query in querrysToCreate{
        exeute_withoutReturn(db, query)
    }
}