//
//  Posts.swift
//  Auc
//
//  Created by Elijah Smith on 6/27/23.
//

import SwiftUI
import Foundation
struct Post: Identifiable {
    let id = UUID()
    var title: String
    var content: String
    var author: String
    var timestamp: Date
    var likeCount: Int
    var repostCount: Int
    var commentCount: Int
    var image: Image? // Optional image property
}

struct PostView: View {
    var post: Post
    @State private var isLiked = false
    @State private var isReposted = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(post.title)
                    .font(.headline)
                    .bold()
                Spacer()
                Image(systemName: "ellipsis")
                    .foregroundColor(.gray)
            }
            
            if let image = post.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
            }
            
            Text(post.content)
                           .font(.body)
                           .foregroundColor(.black) // Set text color to black
                       
                       Text("Author: \(post.author)")
                           .font(.caption)
                           .foregroundColor(.black) // Set text color to black
                       
                       Text("Posted: \(formatTimestamp(post.timestamp))")
                           .font(.caption)
                           .foregroundColor(.gray)
            
            HStack(spacing: 20) {
                Button(action: {
                    isLiked.toggle()
                }) {
                    Image(systemName: isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .foregroundColor(isLiked ? .blue : .gray)
                    Text("\(post.likeCount)")
                }
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    isReposted.toggle()
                }) {
                    Image(systemName: isReposted ? "arrow.2.squarepath.fill" : "arrow.2.squarepath")
                        .foregroundColor(isReposted ? .green : .gray)
                    Text("\(post.repostCount)")
                }
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    // Add comment functionality here
                }) {
                    Image(systemName: "message")
                        .foregroundColor(.gray)
                    Text("\(post.commentCount)")
                }
                .buttonStyle(PlainButtonStyle())
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
    
    private func formatTimestamp(_ timestamp: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: timestamp)
    }
}

struct PostDetailView: View {
    var post: Post
    
    var body: some View {
        VStack {
            Text(post.title)
                .font(.title)
                .bold()
                .padding()
            
            if let image = post.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
            }
            
            Text(post.content)
                .font(.body)
                .padding()
            
            Text("Author: \(post.author)")
                .font(.caption)
            
            Text("Posted: \(formatTimestamp(post.timestamp))")
                .font(.caption)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func formatTimestamp(_ timestamp: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: timestamp)
    }
}

struct PostListView: View {
    var posts: [Post] = [
        Post(title: "First Post", content: "This is the content of the first post.", author: "John Doe", timestamp: Date(), likeCount: 694, repostCount: 0, commentCount: 33, image: Image("example-image")),
        Post(title: "Second Post", content: "This is the content of the second post.", author: "Jane Smith", timestamp: Date(), likeCount: 801, repostCount: 0, commentCount: 0),
        Post(title: "Third Post", content: "This is the content of the third post.", author: "Alex Johnson", timestamp: Date(), likeCount: 700, repostCount: 0, commentCount: 0)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(posts) { post in
                        NavigationLink(destination: PostDetailView(post: post)) {
                            PostView(post: post)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            
        }
    }
}



struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
    }
}
