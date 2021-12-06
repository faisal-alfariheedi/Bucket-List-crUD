//
//  ViewController.swift
//  Bucket List crUD
//
//  Created by faisal on 01/05/1443 AH.
//

import UIKit
import CoreData

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
                (owner as! TableViewController).items[ed].text = String(add.text!)
                edit=false
            }else{
                let thing = NSEntityDescription.insertNewObject(forEntityName: "Bucketitems", into: (owner as! TableViewController).objectmanage) as! Bucketitems
                thing.text = String(add.text!)
                if (owner as! TableViewController).objectmanage.hasChanges {
                    do {
                        try (owner as! TableViewController).objectmanage.save()
                        print("Success")
                    } catch {
                        print("\(error)")
                    }
                }
//            (owner as! TableViewController).items.append(String(add.text!))
            }
                dele?.cancel(by: self)
//            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dele?.cancel(by: self)
//        dismiss(animated: true, completion: nil)
    }
}

