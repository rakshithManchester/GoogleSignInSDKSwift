//
//  TableVwViewController.swift
//  GoogleSignInSDK
//
//  Created by rakshith appaiah on 3/31/18.
//  Copyright © 2018 rakshith appaiah. All rights reserved.
//

import UIKit
import Locksmith
import GoogleSignIn

class TableVwViewCell: UITableViewCell {
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDetails: UILabel!
    
}

class TableVwViewController: UIViewController,UITableViewDataSource {
    
    var userDeatails = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /**
         Note: Decrypting (userID,idToken,name,givenName,familyName,email) using Locksmith SDK.
         */
        let dictionary = Locksmith.loadDataForUserAccount(userAccount: "USER")
        if let dict = dictionary {
            userDeatails = dict
            // Decrypted OAth-Token
            print(userDeatails["idToken"] as? String)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDeatails.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableVwViewCell
        
        switch indexPath.row {
        case 0:
            cell?.labelName.text = "User ID"
            cell?.labelDetails.text = userDeatails["userID"] as? String
            return cell!
        case 1:
            cell?.labelName.text = "Name"
            cell?.labelDetails.text = userDeatails["name"] as? String
            return cell!
        case 2:
            cell?.labelName.text = "Given Name"
            cell?.labelDetails.text = userDeatails["givenName"] as? String
            return cell!
        case 3:
            cell?.labelName.text = "Family Name"
            cell?.labelDetails.text = userDeatails["familyName"] as? String
            return cell!
        default:
            cell?.labelName.text = "Email"
            cell?.labelDetails.text = userDeatails["email"] as? String
            return cell!
        }
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        self.dismiss(animated: true, completion: nil)
    }
    

}
