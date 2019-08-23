//
//  Tabelle_AlleLAger.swift
//  MPS-FanProjekt
//
//  Created by Christian Baltzer on 23.08.19.
//  Copyright © 2019 Christian Baltzer. All rights reserved.
//

import UIKit

class Tabelle_AlleLAger: UITableViewController {

    var WorkingObjekt: Fest!
    var NewLoader = Loader()
    var index = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let DatenLaden = UserDefaults.standard
        let Test = DatenLaden.object(forKey: "Ubergabe") as? Data
        
        WorkingObjekt = try? PropertyListDecoder().decode(Fest.self, from: Test!)
        
        if(WorkingObjekt.Heerlager.count == 0){
            WorkingObjekt.Heerlager.append(lager(NameDesLagers: "Leider Noch keine Infos :("))
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of row
        return WorkingObjekt.Heerlager.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var temp = ""
        
        if (WorkingObjekt.Heerlager[indexPath.row].name.contains("Homepage")){
            let text = WorkingObjekt.Heerlager[indexPath.row].name.split(separator: " ")
            for wörter in 0...text.count-2{
                temp = temp + String(text[wörter]) + " "
            }
        }else{
            temp = WorkingObjekt.Heerlager[indexPath.row].name
        }
        // Configure the cell...

        cell.textLabel?.text = temp
        
        cell.textLabel?.numberOfLines=0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
