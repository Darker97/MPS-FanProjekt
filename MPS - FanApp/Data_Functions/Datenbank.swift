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
