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
    var documentIdArray  = [String]()
    
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
        cell.lbDocumentId.text = documentIdArray[indexPath.row]
        return cell
    }
    func getDataFireStore(){
        let db = Firestore.firestore()
        /* Tarih ayarı
        let settings = db.settings
        settings.areTimes */
        db.collection("Posts").order(by: "date", descending: true)
            .addSnapshotListener { (snapshot, error) in // sadece post altı postun içindeki için daha devam
            if error != nil {
                self.makeAlert(title: "Document Error", error: "Document doesnt connection.")
            }
            else{
                if snapshot?.isEmpty == false {
                    self.userImageArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.documentIdArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents{
                        let documentId = document.documentID
                        self.documentIdArray.append(documentId)
                        print("dokuman idleri burada")
                        
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
    func makeAlert( title : String , error : String){
        let alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertController.Style.alert)
         let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
         alert.addAction(okButton)
         self.present(alert, animated: true, completion: nil)
        
    }


}
