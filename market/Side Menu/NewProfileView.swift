//
//  NewProfileView.swift
//  market
//
//  Created by Nicholas Nelson on 4/13/24.
//

import SwiftUI

struct NewProfileView: View {
    
    @State var offset: CGFloat = 0
    
    // For Dark Mode Adoption..
    @Environment(\.colorScheme) var colorScheme
    
    @State var currentTab = "Tweets"
    
    // For Smooth Slide Animation...
    @Namespace var animation
    
    @State var tabBarOffset: CGFloat = 0
    
    @State var titleOffset: CGFloat = 0
    var user: User
    
    struct ProfileTab: Identifiable {
        var id = UUID()
        var title: String
    }

    // Example tabs
    let profileTabs = [
        ProfileTab(title: "Tweets"),
        ProfileTab(title: "Tweets & Replies"),
        ProfileTab(title: "Media"),
        ProfileTab(title: "Likes")
    ]
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false, content: {
            
            VStack(spacing: 15){
                
                // Header View...
                GeometryReader{proxy -> AnyView in
                    
                    // Sticky Header...
                    let minY = proxy.frame(in: .global).minY
                    
                    DispatchQueue.main.async {
                        
                        self.offset = minY
                    }
                    
                    return AnyView(
                    
                        ZStack{
                            
                            // Banner...
                            Image("download")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: getRect().width, height: minY > 0 ? 180 + minY : 180, alignment: .center)
                                .cornerRadius(0)
                                .clipped()
                            
                            BlurView()
                                .opacity(blurViewOpacity())
                            
//                            Color(.systemBackground) // You can specify any color you want here.
//                                    .opacity(minY < 0 ? 1 : 0)
                            
                            HStack(spacing: 10) {
                               
                                UserImage(imageName: user.imageName, isOnline: user.isOnline, size: 45)
                                VStack (alignment: .leading) {
                                    Text("Jane Doe")
                                        .fontWeight(.bold)
                                        
                                    Text("150 Predictions")
                                        .font(.subheadline)
                                        
                                }
                                Spacer()
                                
                            }
                            .padding(.horizontal, 70)
                            .offset(y: 120)
                            .offset(y: titleOffset > 100 ? 0 : -getTitleTextOffset())
                            .opacity(titleOffset < 100 ? 1 : 0)
                            .foregroundColor(.white)

                        }
                        .clipped()
                        // Stretchy Header...
                        .frame(height: minY > 0 ? 150 + minY : nil)
                        .offset(y: minY > 0 ? -minY : -minY < 80 ? 0 : -minY - 80)
                    )
                }
                .frame(height: 180)
                .zIndex(1)
                
                // Profile Image...
                
                VStack{
                    
                    HStack{
                        
//                        Image("logo")
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: 75, height: 75)
//                            .clipShape(Circle())
//                            .padding(8)
//                            .background(colorScheme == .dark ? Color.black : Color.white)
//                            .clipShape(Circle())
//                            .offset(y: offset < 0 ? getOffset() - 20 : -20)
//                            .scaleEffect(getScale())
                        
                        Spacer()
                        
                       
                    }
//                    .padding(.top,-25)
//                    .padding(.bottom,-10)
                    
                    // Profile Data...
                    
                    VStack(alignment: .leading, spacing: 8, content: {
                        HStack {
                            
                            UserImage(imageName: user.imageName, isOnline: user.isOnline, size: 50)
                                
                            VStack {
                                Text("Jane Doe")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    
                                    .foregroundColor(.primary)
                                
                                Text("@_JaneDoe")
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Button(action: {}, label: {
                                Text("Edit Profile")
                                    .foregroundColor(.blue)
                                    .padding(.vertical,10)
                                    .padding(.horizontal)
                                    .background(
                                    
                                        Capsule()
                                            .stroke(Color.blue,lineWidth: 1.5)
                                    )
                            })
                        }
                        .padding(.bottom,10)
                        
                        Text("Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs.")
                        
                        HStack(spacing: 5){
                            
                            Text("13")
                                .foregroundColor(.primary)
                                .fontWeight(.semibold)
                            
                            Text("Followers")
                                .foregroundColor(.gray)
                            
                            Text("680")
                                .foregroundColor(.primary)
                                .fontWeight(.semibold)
                                .padding(.leading,10)
                            
                            Text("Following")
                                .foregroundColor(.gray)
                        }
                        .padding(.top,8)
                    })
                    .overlay(
                    
                        GeometryReader{proxy -> Color in
                            
                            let minY = proxy.frame(in: .global).minY
                            
                            DispatchQueue.main.async {
                                self.titleOffset = minY
                            }
                            return Color.clear
                        }
                        .frame(width: 0, height: 0)
                        
                        ,alignment: .top
                    )
                    
                    // Custom Segmented Menu...
                    
                    VStack(spacing: 0){
                        
                        ScrollView(.horizontal, showsIndicators: false, content: {
                            
                            HStack(spacing: 0){
                                
                                TabButton(title: "Predictions", currentTab: $currentTab, animation: animation)
                                
                                TabButton(title: "Bets", currentTab: $currentTab, animation: animation)
                                
                                TabButton(title: "Media", currentTab: $currentTab, animation: animation)
                                
                                TabButton(title: "Likes", currentTab: $currentTab, animation: animation)
                            }
                        })
                        
                        Divider()
                    }
                    .padding(.top,30)
                    .background(colorScheme == .dark ? Color.black : Color.white)
                    .offset(y: tabBarOffset < 90 ? -tabBarOffset + 90 : 0)
                    .overlay(
                    
                        GeometryReader{reader -> Color in
                            
                            let minY = reader.frame(in: .global).minY
                            
                            DispatchQueue.main.async {
                                self.tabBarOffset = minY
                            }
                            
                            return Color.clear
                        }
                        .frame(width: 0, height: 0)
                        
                        ,alignment: .top
                    )
                    .zIndex(1)
                    
                    VStack(spacing: 18){
                        
                        // Sample Tweets...
                        TweetView(tweet: "Prediction here", tweetImage: "post")
                        
                        Divider()
                        
                        ForEach(1...20,id: \.self){_ in
                            
                            TweetView(tweet: sampleText)
                            
                            Divider()
                        }
                    }
                    .padding(.top)
                    .zIndex(0)
                }
                .padding(.horizontal)
                // Moving the view back if it goes > 80...
                .zIndex(-offset > 80 ? 0 : 1)
            }
        })
        .overlay(
                    HStack {
                        Image(systemName: "chevron.left")
                            .imageScale(.large)
                        Spacer()
                        HStack (spacing: 28) {
                            Image(systemName: "magnifyingglass")
                                .imageScale(.large)
                            Image(systemName: "ellipsis.circle")
                                .imageScale(.large)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 40)
                    .frame(height: 100)
//                    .background(Material.ultraThinMaterial)
                    .foregroundColor(.white),
                    alignment: .top
                )
                .ignoresSafeArea(.all, edges: .top)
            }
        
    
    func getTitleTextOffset()->CGFloat{
        
        // some amount of progress for slide effect..
        let progress = 20 / titleOffset
        
        let offset = 60 * (progress > 0 && progress <= 1 ? progress : 1)
        
        return offset
    }
    
    // Profile Shrinking Effect...
    func getOffset()->CGFloat{
        
        let progress = (-offset / 80) * 20
        
        return progress <= 20 ? progress : 20
    }
    
    func getScale()->CGFloat{
        
        let progress = -offset / 80
        
        let scale = 1.8 - (progress < 1.0 ? progress : 1)
        
        // since were scaling the view to 0.8...
        // 1.8 - 1 = 0.8....
        
        return scale < 1 ? scale : 1
    }
    
    func blurViewOpacity()->Double{
        
        let progress = -(offset + 80) / 150
        
        return Double(-offset > 80 ? progress : 0)
    }
}

// Extending View to get Screen Size...
extension View{
    
    func profilegetRect()->CGRect{
        
        return UIScreen.main.bounds
    }
}

// Tab Button...
struct profileTabButton: View {
    
    var title: String
    @Binding var currentTab: String
    var animation: Namespace.ID
    
    var body: some View{
        
        Button(action: {
            withAnimation{
                currentTab = title
            }
        }, label: {
            
            // if i use LazyStack then the text is visible fully in scrollview...
            // may be its a bug...
            LazyVStack(spacing: 12){
                
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(currentTab == title ? .blue : .gray)
                    .padding(.horizontal)
                
                if currentTab == title{
                    
                    Capsule()
                        .fill(Color.blue)
                        .frame(height: 1.2)
                        .matchedGeometryEffect(id: "TAB", in: animation)
                }
                else{
                    Capsule()
                        .fill(Color.clear)
                        .frame(height: 1.2)
                }
            }
        })
    }
}

struct profilepostView: View {
    var tweet: String
    var tweetImage: String?
    
    var body: some View {
        HStack(alignment: .top, spacing: 10, content: {
            
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 55, height: 55)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 10, content: {
                
                (
                    
                    Text("Jane Doe")
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        
                        +
                        
                        Text("@_JaneDoe")
                        .foregroundColor(.gray)
                )
                
                Text(tweet)
                    .frame(maxHeight: 100, alignment: .top)
                
                if let image = tweetImage{
                    
                    GeometryReader{proxy in
                        
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: proxy.frame(in: .global).width, height: 250)
                            .cornerRadius(15)
                    }
                    .frame(height: 250)
                }
            })
        })
    }
}



var profilesampleText = "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book."

struct profileBlurView: UIViewRepresentable {

    func makeUIView(context: Context) -> UIVisualEffectView {
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}

struct NewProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NewProfileView(user: User.stub)  // Using the stub user for previews
    }
}
