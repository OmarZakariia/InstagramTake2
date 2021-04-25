//
//  StorageManager.swift
//  Instagram 2
//
//  Created by Omar Zakaria on /154/21.

///  When the user uploads a photo or a video I need to store it somewhere on the cloud in firebase

import FirebaseStorage

public class StorageManager {
    
    //MARK:- Enums and Structs
    public enum UserPostType{
        case photo, video
    }
    public enum IGStorageManagerError: Error {
        case failedToDownload
    }
    public struct UserPost {
        let postType: UserPostType
    }
    
    //MARK:- Variables and Constants
    // Create one instance of the class
    static let shared = StorageManager()
    
    // Bucket reference
    private let bucket = Storage.storage().reference()
    
    //MARK:- Public Functions
    public func uploadUserPost(model: UserPost, completion: @escaping(Result<URL,IGStorageManagerError>)-> Void){
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping(Result<URL,IGStorageManagerError>)->Void){
        bucket.child(reference).downloadURL { (url, error) in
            guard let url = url, error == nil else {
                completion(.failure(.failedToDownload))
                return
            }
            completion(.success(url))
        }
        
    }
}
