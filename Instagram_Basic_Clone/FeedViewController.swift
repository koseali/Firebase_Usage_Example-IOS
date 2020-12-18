//
//  FeedViewController.swift
//  Instagram_Basic_Clone
//
//  Created by Ali Köse on 7.12.2020.
//
import SDWebImage
import UIKit
import Firebase

class FeedViewController: UIViewController , UITableViewDelegate,UITableViewDataSource{
 
    var userEmailArray = [String]()
    var likeArray = [Int]()
    var userCommentArray = [String]()
    var userImageArray = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getDataFireStore()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tbvCell", for: indexPath) as! FeedTableViewCell
        cell.lbMail.text =  userEmailArray[indexPath.row]
        cell.lbLike.text =  String(likeArray[indexPath.row])
        cell.lbComment.text = userCommentArray[indexPath.row]
        cell.userImageView.sd_setImage(with:URL(string: self.userImageArray[indexPath.row]))
        return cell
    }
    func getDataFireStore(){
        let db = Firestore.firestore()
        /* Tarih ayarı
        let settings = db.settings
        settings.areTimes */
        db.collection("Posts").addSnapshotListener { (snapshot, error) in // sadece post altı postun içindeki için daha devam
            if error != nil {
                
            }
            else{
                if snapshot?.isEmpty == false {
                    self.userImageArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents{
                        let documentId = document.documentID
                        print("dokuman idleri burada")
                        print(documentId)
                        if let postedBy = document.get("postedBy") as? String{
                            self.userEmailArray.append(postedBy)
                        }
                        if let postComment = document.get("postComment") as? String{
                            self.userCommentArray.append(postComment)
                        }
                        if let userImageUrl = document.get("imageUrl") as? String{
                            self.userImageArray.append(userImageUrl)
                            print("IMAGEE URL BURDA")
                            print(userImageUrl)
                        }
                        if let likes = document.get("likes") as? Int{
                            self.likeArray.append(likes)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
       
    }



}
