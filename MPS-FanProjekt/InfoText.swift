//
//  InfoText.swift
//  MPS-FanProjekt
//
//  Created by Christian Baltzer on 23.08.19.
//  Copyright © 2019 Christian Baltzer. All rights reserved.
//

import UIKit

class InfoText: UIViewController {

    @IBOutlet weak var InfoText: UITextView!
    
    let DatenLaden = UserDefaults.standard
    //var WorkingObjekt: Fest = DatenLaden.object(forKey: "Ubergabe") as! Fest
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let WorkingObjekt: Fest = DatenLaden.object(forKey: "Ubergabe") as! Fest
        
        
        InfoText.text = WorkingObjekt.InfoText
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
