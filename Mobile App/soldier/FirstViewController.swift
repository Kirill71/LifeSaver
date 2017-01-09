//
//  FirstViewController.swift
//  soldier
//
//  Created by Кирилл Жаренков on 02.12.16.
//  Copyright © 2016 Кирилл Жаренков. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var labl: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendRequest(_ sender: UIButton) {
        let request = RequestHandler(url:"http://localhost:8181/")
        request.httpMethod = "POST"
        var params = [String : String]()
        for  i in 0 ..< a.count {
            params[String(i+1)] = a[i].toString()
        }
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.sendRequest()
    }
    
    @IBAction func switcher_value_changed(_ sender: AnyObject) {
        var status:UInt
        labl.text! += "\n"
              for i in 0..<a.count {
            
            status = a[i].getStatus()
            if status == DEADH
            {
                labl.text! += " \(i+1) солдат  состояние : пульс- \(a[i].pulse) состояние - мертв"
            }
            
            if status == LIFE {
                labl.text! +=  " \(i+1) солдат  состояние : пульс- \(a[i].pulse) состояние - не нуждается в срочной помощи"
            }
            if status == HELP {
                labl.text! +=  " \(i+1) солдат  состояние : пульс- \(a[i].pulse) состояние - нуждается в срочной помощи"
            }
            labl.text! += "\n"
        }
    }
    
}
