//
//  NewSchoolViewController.swift
//  Northwest-KC-App
//
//  Created by rayaan on 14/03/19.
//  Copyright © 2019 Northwest. All rights reserved.
//

import UIKit

class NewSchoolViewController: UIViewController {
    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func done(_ sender: Any) {
        let schoolName = schoolNameTF.text!
        let coachName = coachNameTF.text!
        
        Schools.shared.add(school: School(name: schoolName, coach: coachName))
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var coachNameTF: UITextField!
    @IBOutlet weak var schoolNameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
        
        // Do any additional setup after loading the view.
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
