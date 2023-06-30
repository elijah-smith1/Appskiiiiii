import SwiftUI

struct Explorefeed: View {
    @State private var searchText = ""
    
    var body: some View {
        VStack {
       
                // Search Bar
                Spacer()
                Spacer()
           
                SearchBar(text: $searchText)
                    .padding()
                Divider()
                // Post List View
                PostListView()
            
            
               
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Menu {
                    NavigationLink(destination: Followingfeed()) {
                        Label("Following", systemImage: "house.fill")
                    }
                   
                    NavigationLink(destination: Favoritefeed()) {
                        Label("Favorites", systemImage: "star.fill")
                    }
                    
                    NavigationLink(destination: Explorefeed()) {
                        Label("Explore", systemImage: "magnifyingglass")
                    }
                } label: {
                    Label("Menu", systemImage: "line.horizontal.3")
                        .font(.title)
                        .foregroundColor(.black)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: Notifications()) {
                    Label("Notifications", systemImage: "bell.fill")
                }
            }
        }
       
    }
}

struct Explorefeed_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Explorefeed()
        }
    }
}
 
