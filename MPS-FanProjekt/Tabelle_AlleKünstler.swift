//
//  Tabelle_AlleKünstler.swift
//  MPS-FanProjekt
//
//  Created by Christian Baltzer on 23.08.19.
//  Copyright © 2019 Christian Baltzer. All rights reserved.
//

import UIKit

class Tabelle_AlleKu_nstler: UITableViewController {

    var WorkingObjekt: Fest!
    var NewLoader = Loader()
    var index = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let DatenLaden = UserDefaults.standard
        let Test = DatenLaden.object(forKey: "Ubergabe") as? Data
        
        WorkingObjekt = try? PropertyListDecoder().decode(Fest.self, from: Test!)
        
        if(WorkingObjekt.Spielplan[0].Name == ""){
            WorkingObjekt.Spielplan.append(band(NameDerBand: "Leider Noch keine Infos :("))
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return WorkingObjekt.Heerlager.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = WorkingObjekt.Spielplan[indexPath.row].Name
        // Configure the cell...
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
