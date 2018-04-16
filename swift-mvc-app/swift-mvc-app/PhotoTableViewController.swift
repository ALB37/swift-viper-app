//
//  PhotoTableViewController.swift
//  swift-mvc-app
//
//  Created by Andrew Bloom on 4/15/18.
//  Copyright © 2018 Andrew Bloom. All rights reserved.
//

import UIKit
import os.log

class PhotoTableViewController: UITableViewController {

    // MARK: Properties
    
    var photos = [Photo]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedPhotos = loadPhotos() {
            photos += savedPhotos
        } else {
            loadSamplePhotos()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return photos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PhotoTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PhotoTableViewCell else {
            fatalError("The dequeued cell is not an instance of PhotoTableViewCell.")
        }
        
        let picture = photos[indexPath.row]

        cell.nameLabel.text = picture.name
        cell.photoImageView.image = picture.photo
        cell.ratingControl.rating = picture.rating
        
        return cell
    }
    

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            photos.remove(at: indexPath.row)
            savePhotos()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new Photo", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let photoDetailViewController = segue.destination as? PhotoViewController	else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedPhotoCell = sender as? PhotoTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: selectedPhotoCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedPhoto = photos[indexPath.row]
            photoDetailViewController.picture = selectedPhoto
        default:
            fatalError("Unexpected segue identifier: \(String(describing: segue.identifier))")
        }
        
    }

    
    // MARK: Actions
    @IBAction func unwindToPhotoList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? PhotoViewController, let picture = sourceViewController.picture {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                photos[selectedIndexPath.row] = picture
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: photos.count, section: 0)
                photos.append(picture)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            savePhotos()
        }
    }
    
    // MARK: Private Methods
    
    private func loadSamplePhotos() {
        let image1 = UIImage(named: "Image1")
        let image2 = UIImage(named: "Image2")
        let image3 = UIImage(named: "Image3")
    
        guard let photo1 = Photo(name: "Latch", photo: image1, rating: 4) else {
            fatalError("Unable to instantiate photo1")
        }
        guard let photo2 = Photo(name: "Chain", photo: image2, rating: 2) else {
            fatalError("Unable to instantiate photo1")
        }
        guard let photo3 = Photo(name: "Cracks", photo: image3, rating: 5) else {
            fatalError("Unable to instantiate photo1")
        }
        
        photos += [photo1, photo2, photo3]
    }
    
    private func savePhotos() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(photos, toFile: Photo.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Photos successfully saved", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save photos", log: OSLog.default, type: .debug)
        }
    }
    
    private func loadPhotos() -> [Photo]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Photo.ArchiveURL.path) as? [Photo]
    }
}
