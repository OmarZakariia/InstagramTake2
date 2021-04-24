//
//  DatabaseManager.swift
//  Instagram 2
//
//  Created by Omar Zakaria on /154/21.
//

import FirebaseDatabase

/// Figures out whether the user actually exists or not 
public class DatabaseManager {
    
    // create a single instance of the class
    static let shared = DatabaseManager()
    
    // reference the database
    private let database = Database.database().reference()
    
    //MARK:- Public functions
    /// Check if username is available
    /// - Parameters
    ///     - email: String representing email
    ///     - Password: String representing password
    
    public func canCreateNewUser(with email: String, username: String, completion: @escaping(Bool)->Void){
        completion(true)
        
    }
    public func insertNewUser(with email: String, username: String, completion:@escaping(Bool)->Void){
        let key = email.safeDatabaseKey()
        database.child(key).setValue(["username", username]) { error, _ in
            if error == nil{
                // succeeded
                completion(true)
                
            }
            else {
                // failed
                completion(false)
                return
            }
            
        }
    }
    
}
