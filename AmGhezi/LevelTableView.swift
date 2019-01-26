//
//  LevelTableView.swift
//  AmGhezi
//
//  Created by Aria on 10/24/18.
//  Copyright © 2018 Aria. All rights reserved.
//

import UIKit

class LevelTableView: UITableViewController {
    
    var games : [[String]] = []
    var selectedCell: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        var contents = ""
        if let filepath = Bundle.main.path(forResource: "words", ofType: "txt") {
            do {
                contents = try String(contentsOfFile: filepath)
            } catch {
                // contents could not be loaded
            }
        } else {
            // example.txt not found!
        }
        let data: NSData = contents.data(using: String.Encoding.utf8)! as NSData
        guard var gamesData = try? JSONDecoder().decode([[String]].self, from: data as Data) else { return }
        var hardness : [Int] = []
        for l in gamesData{
            var max = 0
            for x in l{
                if x.count > max{
                    max = x.count
                }
            }
            let hardnes = max * l.count
            hardness.append(hardnes)
        }
        for i in 0..<gamesData.count{
            for j in i..<gamesData.count{
                if hardness[i] > hardness[j]{
                    hardness.swapAt(i, j)
                    gamesData.swapAt(i, j)
                }
            }
        }
        self.games = gamesData
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "LevelTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LevelTableViewCell  else {
            fatalError("The dequeued cell is not an instance of LevelTableViewCell.")
        }
        
        let level = games[indexPath.row]
        
        // configure cell
        let levelNam = indexPath.row + 1
        var max = 0
        for l in level{
            if l.count > max{
                max = l.count
            }
        }
        let hardnes = max * level.count
        
        cell.levelName.text = String(levelNam)
        if hardnes <= 50{
            cell.hardness.text = "Easy"
        } else if hardnes <= 80{
            cell.hardness.text = "Medium"
        }else{
            cell.hardness.text = "hard"
        }
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("This cell from the chat list was selected: \(indexPath.row)")
        selectedCell = indexPath.row
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        if let dest = segue.destination as? GViewController{
            dest.game = self.games[selectedCell]
        }
    }
    

}

