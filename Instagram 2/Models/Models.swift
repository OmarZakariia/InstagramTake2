//
//  Models.swift
//  Instagram 2
//
//  Created by Omar Zakaria on /304/21.
//

import Foundation


/// Respresent a user post
public struct UserPost {
    let postType: UserPostType
    let thumbnailImage: URL
    let caption: String?
    let likeCount : [PostLike]
    let comments : [PostComment]
    let postURL : URL // either returns a url of a full resolution phot
    let identifier: String // random ID to identify post
    let createdData: Date
    let taggedUsers : [String]
    
}
public enum UserPostType{
    case photo, video
}

struct PostComment {
    let username : String
    let text: String
    let createdDate: Date
    let likes : [CommentLikes]
    let identifier : String
}

struct PostLike {
    let username: String
    let postIdentifier : String
}

struct CommentLikes {
    let username: String
    let commentIdentifier : String
}

struct user {
    let username : String
    let name : (first : String, last : String)
    let birthDate: Date
    let gender : Gender
    let bio: String
    let counts : UserCount
    let joinDate: Date
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts : Int
}

enum Gender {
    case male, female, other
}
