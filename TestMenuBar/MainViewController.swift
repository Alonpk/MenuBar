//
//  ViewController.swift
//  TestMenuBar
//
//  Created by Pesok on 12/28/17.
//  Copyright © 2017 Owluzions. All rights reserved.
//

import UIKit

class MainViewController: ViewControllerWithMenuBar,ViewControllerWithMenuBarDelegate {

    @IBOutlet weak var mainAreaView: UIView!
    
    override func mainAreaViewFrame() -> CGRect {
        return mainAreaView.frame
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print ("preapre for Segure")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
