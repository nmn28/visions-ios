//
//  ProfileView.swift
//  market
//
//  Created by Nicholas Nelson on 12/4/23.
//

import SwiftUI

struct ProfileView: View {
    var username: String
    @Binding var isOpened: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var selectedProfileTab: Int
    
    @State private var scrollOffset: CGFloat = 0
        @State private var pickerOffset: CGFloat = 0
    
    var body: some View {
        VStack {
//            ProfileCustomToolbar(isOpened: $isOpened)
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Jane Doe")
                        .font(.title3)
                    Text("jane.doe99")
                    Text("@forecast.ai")
                }
                

                VStack {
                    
                    HStack(alignment: .center, spacing: 20) {
                        Spacer()
                        Button(action: {
                            // Action for the first button
                        }) {
                            Image(systemName: "dollarsign.arrow.circlepath")
                        }
                        
                        Button(action: {
                            // Action for the second button
                        }) {
                            Image(systemName: "message")
                        }
                        
                        Button(action: {
                            // Action for the third button
                        }) {
                            Image(systemName: "bell.badge")
                        }
                        
                        Button(action: {
                            // Action for the fourth button
                        }) {
                            Image(systemName: "person.crop.circle.badge.plus")
                        }
                    }
                    .padding(5)
                    
                    HStack(alignment: .center, spacing: 20) {
                        Spacer()
                        Button(action: {
                            // Action for the fifth button
                        }) {
                            VStack {
                                Image(systemName: "flask")
                                Text("45%")
                                    .font(.system(size: 14))
                            }
                        }
                        
                        Button(action: {
                            // Action for the fifth button
                        }) {
                            VStack {
                                Image(systemName: "thermometer.medium")
                                Text("45%")
                                    .font(.system(size: 14))
                            }
                        }
                        
                        Button(action: {
                            // Action for the sixth button
                        }) {
                            VStack {
                                Image(systemName: "scope")
                                Text("36%")
                                    .font(.system(size: 14))
                            }
                        }
                        
                        Button(action: {
                            // Action for the seventh button
                        }) {
                            VStack {
                                Image(systemName: "person.2")
                                Text("1,085")
                                    .font(.system(size: 14))
                            }
                        }
                    }
                    .padding(5)
                    
                }
                Spacer()
                
            }
            
            
            HStack {
                Button(action: {
                    // Action for the eighth button
                }) {
                    Image(systemName: "mappin.and.ellipse")
                }
                
                Button(action: {
                    // Action for the ninth button
                }) {
                    Image(systemName: "link")
                }
                
                Button(action: {
                    // Action for the tenth button
                }) {
                    Image(systemName: "balloon")
                }
            }
            .padding(.vertical, 1)
            
            
            
//            ProfileCustomPicker(isOpened: $isOpened)
            
        }
        .navigationBarTitle("")
        
    }
}

//struct ProfileCustomToolbar: View {
//    @Binding var isOpened: Bool
//    @EnvironmentObject var viewModel: MainViewModel
//    
//    var body: some View {
//        CustomToolbar(
//            leftContent: {
//                AnyView(VStack(alignment: .leading, spacing: -4) {
//                    Text("Forecast.ai")
//                        .font(.title3).fontWeight(.heavy)
//                        .bold()
//                    Text("date")
//                        .font(.title3).fontWeight(.heavy)
//                        .bold()
//                        .foregroundColor(Color(uiColor: .secondaryLabel))
//                })
//            },
//            centerContent: {
//                AnyView(Text("Profile").font(.headline))
//            },
//            rightContent: {
//                AnyView(HStack(spacing: 28) {
//                    Button(action: {
//                        viewModel.toggleSearchBarVisibility()
//                    }) {
//                        Image(systemName: "magnifyingglass")
//                            .imageScale(.large)
//                            .foregroundColor(.blue)
//                    }
//                    Button(action: {
//                        isOpened.toggle()
//                    }) {
//                        Image(systemName: "menucard")
//                            .imageScale(.large)
//                            .foregroundColor(.blue)
//                    }
//                })
//            }
//        )
//    }
//}

struct ProfileView_Previews: PreviewProvider {
    @State static var selectedProfileTab = 0
    @State static var isOpened = false
    static var previews: some View {
        ProfileView(username: "Jane Doe", isOpened: $isOpened, selectedProfileTab: $selectedProfileTab)
    }
}
