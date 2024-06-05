//
//  ExploreView.swift
//  market
//
//  Created by Nicholas Nelson on 11/30/23.
//

import SwiftUI

// Custom async image loading view
struct AsyncImageView: View {
    let url: URL?
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image.resizable()
            case .failure:
                Image(systemName: "photo") // Now correctly using SwiftUI's built-in Image
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct ExploreView: View {
    @Binding var isOpened: Bool
    @StateObject var jsonModel = JSONViewModel()
    var body: some View {
        
        VStack{
//            ExploreCustomToolbar(isOpened: $isOpened)
            HStack {
                HStack{
                    
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $jsonModel.search)
                }
                .padding(.vertical,10)
                .padding(.horizontal)
                .background(Color.primary.opacity(0.06))
                .cornerRadius(10)
                
                Button(action: {}, label: {
                    
                    Image(systemName: "slider.horizontal.3")
                        .font(.system(size: 30))
                        .foregroundColor(.primary)
                })
            }
            .padding()
            
            if jsonModel.cards.isEmpty{
                
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            else{
                
                ScrollView{
                    
                    // Compositional Layout....
                    
                    VStack(spacing: 4){
                        
                        ForEach(jsonModel.compositionalArray.indices,id: \.self){index in
                            
                            // Basic Logic For Mixing Layouts...
                            
                            if index == 0 || index % 6 == 0{
                                
                                Layout1(cards: jsonModel.compositionalArray[index])
                            }
                            else if index % 3 == 0{
                                
                                Layout3(cards: jsonModel.compositionalArray[index])
                            }
                            else{
                                
                                Layout2(cards: jsonModel.compositionalArray[index])
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}
struct ExploreCustomToolbar: View {
    @Binding var isOpened: Bool
    
    var body: some View {
        CustomToolbar(
            leftContent: {
                AnyView(VStack(alignment: .leading, spacing: -4) {
                    Text("Forecast.ai")
                        .font(.title3).fontWeight(.heavy)
                        .bold()
                    Text("date")
                        .font(.title3).fontWeight(.heavy)
                        .bold()
                        .foregroundColor(Color(uiColor: .secondaryLabel))
                })
            },
            centerContent: {
                AnyView(Text("Explore").font(.headline))
            },
            rightContent: {
                AnyView(HStack(spacing: 28) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                    }
                    Button(action: {
//                        isOpened.toggle()
                    }) {
                        Image(systemName: "menucard")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                    }
                })
            }
        )
    }
}

struct ExploreView_Previews: PreviewProvider {
    @State static var isOpened = false
    
    static var previews: some View {
        ExploreView(isOpened: $isOpened)
        .environmentObject(MainViewModel())
    }
}
