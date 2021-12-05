//
//  ViewController.swift
//  Bucket List crUD
//
//  Created by faisal on 01/05/1443 AH.
//

import UIKit

protocol cans:class{
    func cancel(by cont:UIViewController)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var add: UITextField!
    var dele:cans?
    var owner:UITableViewController?
    var ed=0
    var edit=false
    var tex=""

    override func viewDidLoad() {
        super.viewDidLoad()
        add.text=tex
        // Do any additional setup after loading the view.
    }

    @IBAction func additem(_ sender: UIBarButtonItem) {
        if(add.text!.isEmpty){}else{
            if(edit){
                (owner as! TableViewController).items[ed]=String(add.text!)
                edit=false
            }else{
            (owner as! TableViewController).items.append(String(add.text!))
            }
                dele?.cancel(by: self)
            print("shit")
//            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dele?.cancel(by: self)
//        dismiss(animated: true, completion: nil)
    }
}

