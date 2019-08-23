//
//  Tabelle_AlleFeste.swift
//  MPS-Fanprojekt
//
//  Created by Christian Baltzer on 22.08.19.
//  Copyright © 2019 Christian Baltzer. All rights reserved.
//

import UIKit

class Tabelle_AlleFeste: UITableViewController {
    
    var WorkingObjekt: AlleDaten!
    var NewLoader = Loader()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let DatenLaden = UserDefaults.standard
        if (DatenLaden.object(forKey: "AlleDatenSpeicher") != nil){
            let Test = DatenLaden.object(forKey: "AlleDatenSpeicher") as? Data
            WorkingObjekt = try? PropertyListDecoder().decode(AlleDaten.self, from: Test!)
        }else{
            WorkingObjekt = NewLoader.start()
            DatenLaden.set(try? PropertyListEncoder().encode(WorkingObjekt), forKey: "AlleDatenSpeicher")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return WorkingObjekt.Feste.count
    }

    //MARK: - Table View Loading sequence
    
    @IBAction func RefreshMensa(_ sender: UIRefreshControl) {
        let que = DispatchQueue(label: "Update")
        que.async {
            self.WorkingObjekt = self.NewLoader.start()
            self.tableView.reloadData()
            sender.endRefreshing()
        }
        
        let DatenLaden = UserDefaults.standard
        DatenLaden.set(try? PropertyListEncoder().encode(WorkingObjekt), forKey: "AlleDatenSpeicher")
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let textDatum = WorkingObjekt.Feste[indexPath.row].Name.split(separator: " ", maxSplits: 1)
        
        
        cell.textLabel?.text = String(textDatum[1])
        cell.detailTextLabel?.text = String(textDatum[0]) 
        return cell
    }


    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let DatenLaden = UserDefaults.standard
        
        DatenLaden.set(try? PropertyListEncoder().encode(WorkingObjekt.Feste[indexPath.row]), forKey: "Ubergabe")
        performSegue(withIdentifier: "Weitere Infos", sender: Any?.self)
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
