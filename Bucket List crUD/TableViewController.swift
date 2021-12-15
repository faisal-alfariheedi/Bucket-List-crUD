//
//  TableViewController.swift
//  Bucket List crUD
//
//  Created by faisal on 01/05/1443 AH.
//

import UIKit
import CoreData

class TableViewController: UITableViewController,cans {
    
    
    @IBOutlet var table: UITableView!
    
    var objectmanage=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items = [bucketitemapi]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getall()
        table.dataSource=self
        table.delegate=self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(sender is UIBarButtonItem){
            let nv = segue.destination as! UINavigationController
            let seg = nv.topViewController! as! ViewController
            seg.owner=self
            seg.dele=self
            seg.ed=items.count
            seg.last=items.last!.id
        }else if(sender is Int){
            let nv = segue.destination as! UINavigationController
            let seg = nv.topViewController! as! ViewController
            seg.owner=self
            seg.dele=self
            seg.ed=sender as! Int
            seg.edit=true
            seg.last=items.last!.id
            seg.tex = items[sender as! Int].text
        }
        
    }
    func cancel(by cont: UIViewController) {
        getall()
        table.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func getall(){
        /*let req=NSFetchRequest<NSFetchRequestResult>(entityName: "Bucketitems")
        do{
            let fet = try objectmanage.fetch(req)
            items = fet as! [Bucketitems]
            
        }catch{
            print(error)
        }*/
        BucketAPI.getAll(completionHandler: {
            data, response, error in
                        
                        do{
                            self.items = try JSONDecoder().decode([bucketitemapi].self, from: data!)
                            DispatchQueue.main.async {
                                self.table.reloadData()
                            }
                        }catch{
                            print(error)
                        }
                    })
        
    }
    

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "", sender: indexPath.row )
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        /*
        objectmanage.delete(items[indexPath.row])
        if objectmanage.hasChanges {
            do {
                try objectmanage.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        getall()
        table.reloadData()*/
        
        BucketAPI.delete(index: items[indexPath.row].id , completionHandler: {
            data, response, error in
                        do{
                            
                            print("good")
                            self.getall()
                        }catch{
                            print(error)
                        }
        })
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row].text
        // Configure the cell...

        return cell
    }
    

    

}
