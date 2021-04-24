//
//  AuthManager.swift
//  Instagram 2
//
//  Created by Omar Zakaria on /224/21.
//

import FirebaseAuth

public class AuthManager{
    // create a shared instance of the class
    static let shared = AuthManager()
    
    //MARK:- Public
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping(Bool)-> Void){
        /*
         - Check if username is available
         - Check if email is available
         - Create Account
         - Insert into Database
         */
        
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate{
                /*
                 - Create Account
                 - Insert account into database
                 */
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else {
                        // Firebase auth could not create account 
                        completion(false)
                        return
                    }
                    // Insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { inserted in
                        if inserted {
                            completion(true)
                            return
                        } else {
                            // Failed to insert into database 
                            completion(false)
                            return
                        }
                        
                    }
                }
                
            }
            else {
                // either username or email does not exist
                completion(false)
            }
            
        }

        
    }
    /// Attempt to log out user
    public func logout(completion: (Bool)->Void){
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch{
            print("Could not log out user because \(error)")
            completion(false)
            return
        }
    }
    
    /*
     username and email are optional because the user may log in with either email or the username
     this needs to be @escaping because I am using a completion inside a closure and as a result the scope needs to be escaped
     completion:@escaping(Bool)-> Void, to check if user succcessfully signed in or not
     */
    public func loginUser(username: String?, email:String?, password: String, completion: @escaping(Bool)->Void){
        // check to see if the username or email exists
        if let email = email {
            // email login
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            
                guard authResult != nil, error == nil else {
                    // user signed in successfully
                    completion(false)
                    print("User signed in successfully")
                    return
                }
                completion(true)
               
            }
            
        }
        else if let username = username{
            // username log in
            print(username)
        }
        
    }
}

