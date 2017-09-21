//
//  SignInViewController.swift
//  Project 6 - Snapchat
//
//  Created by Dong Hun Yi on 9/17/17.
//  Copyright © 2017 PrinceYiCoding. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signinTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            print("We tried to sign in")
            
            if error != nil {
                print("Hey we have an error: \(String(describing: error))")
                
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("We tried to create a user")
                    
                    if error != nil {
                        print("Hey we have an error: \(String(describing: error))")
                    } else {
                        print("Created user successfully")
                        Database.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email!)
                        self.performSegue(withIdentifier: "signinsegue", sender: nil)
                    }
                })
            } else {
                print("Signed in successfully")
                self.performSegue(withIdentifier: "signinsegue", sender: nil)
            }
        }
    }
    
}

