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

func exeute_withoutReturn(Query: String){
    let db: OpaquePointer! = openDatabase()
    
    if sqlite3_exec(db, Query, nil , nil , nil) != SQLITE_OK {
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("error creating table: \(errmsg)")
        print(Query)
    } else {
        print("------------------- Done")
    }
}

func execute_withReturn(Query: String, ErgebnisZeilen: Int32) -> [String]{
    
    let db: OpaquePointer! = openDatabase()
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
