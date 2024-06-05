//
//  NewActionView.swift
//  market
//
//  Created by Nicholas Nelson on 12/4/23.
//

import SwiftUI
import MobileCoreServices

// Enumeration for different idea types
enum ActionType {
    case prediction, market, event, transaction, none
}

struct NewActionView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var postBody = ""
    @State private var headlineText = ""
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    @FocusState private var focusPostEditor: Bool
    @ObservedObject var ideaPostingVM = IdeaPostingViewModel()
    @State private var currentActionType: ActionType
    @Binding var selectedNewActionTab: Int
    
    // Custom initializer
    init(initialActionType: ActionType = .prediction, selectedNewActionTab: Binding<Int>) {
        _currentActionType = State(initialValue: initialActionType)
        _selectedNewActionTab = selectedNewActionTab
        // Initialize other properties as needed
    }
    var body: some View {
        VStack {
            headerView
            
            CustomDivider()
            
            NewActionsCustomPicker()
                .padding(.top, 4)
            
            CustomDivider()
            
            postTabs
            
        }
        .onAppear {
            focusPostEditor = true
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private var headerView: some View {
        HStack {
            IconButton(iconName: "xmark", action: {
                presentationMode.wrappedValue.dismiss()
            })
            Spacer()
//            IconButton(iconName: "rays", action: {
//                // action for rays
//            })
            Text("New Action")
            Spacer()
            IconButton(iconName: "paperplane", action: {
                postIdea()
            })
        }
        .padding(.horizontal)
    }
    
    private var postTabs: some View {
        HStack(spacing: 20) {
            
            Button(action: {
                
            }) {
                Image(systemName: "camera")
            }
            
            Button(action: { showingImagePicker = true }) {
                Image(systemName: "photo")
            }
            
            Button(action: {
                
            }) {
                Image(systemName: "folder")
            }
            
            Button(action: {
                
            }) {
            Image(systemName: "chevron.left.forwardslash.chevron.right")
            }
            
            Button(action: {
                
            }) {
                Image(systemName: "link")
            }
            
            
            Spacer()
            
            Divider().frame(height: 36).padding(.vertical, 4)
            
            Button(action: {
                
            }) {
                Image(systemName: "slider.horizontal.3")
            }
        }
        .padding(.horizontal)
    }
    
    private func hideKeyboard() {
        focusPostEditor = false
    }
    
    private func postIdea() {
        ideaPostingVM.postIdea(title: headlineText, body: postBody) { success in
            if success {
                presentationMode.wrappedValue.dismiss()
            } else {
                // Handle error
            }
        }
    }
    
    private var newBinaryView: some View {
        ScrollView {
            
            VStack(alignment: .leading) {
                HStack {
                    IconButton(iconName: "text.line.first.and.arrowtriangle.forward", action: {
                        // action for paperplane
                    })
                    TextField("Headline", text: $headlineText)
                }
                HStack {
                    IconButton(iconName: "calendar", action: {
                        // action for paperplane
                    })
                    TextField("by When?", text: $headlineText)
                    
                }
//                HStack {
//                    IconButton(iconName: "storefront", action: {
//                        // action for paperplane
//                    })
//                    TextField("Add to a Category? (optional)", text: $headlineText)
//                }
//                HStack {
//                    IconButton(iconName: "person.3", action: {
//                        // action for paperplane
//                    })
//                    TextField("Add to a Conference? (optional)", text: $headlineText)
//                }
                HStack {
                    IconButton(iconName: "pencil", action: {
                        // action for paperplane
                    })
                    TextField("Rationale", text: $postBody)
                        .focused($focusPostEditor)
                }
                if let postImage = selectedImage {
                    Image(uiImage: postImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var newPredictionView: some View {
        ScrollView {
            
            VStack(alignment: .leading) {
                HStack {
                    IconButton(iconName: "text.line.first.and.arrowtriangle.forward", action: {
                        // action for paperplane
                    })
                    TextField("Headline", text: $headlineText)
                }
                HStack {
                    IconButton(iconName: "calendar", action: {
                        // action for paperplane
                    })
                    TextField("by When?", text: $headlineText)
                }
//                HStack {
//                    IconButton(iconName: "storefront", action: {
//                        // action for paperplane
//                    })
//                    TextField("Add to a Category? (optional)", text: $headlineText)
//                }
//                HStack {
//                    IconButton(iconName: "person.3", action: {
//                        // action for paperplane
//                    })
//                    TextField("Add to a Conference? (optional)", text: $headlineText)
//                }
                HStack {
                    IconButton(iconName: "pencil", action: {
                        // action for paperplane
                    })
                    TextField("Rationale", text: $postBody)
                        .focused($focusPostEditor)
                }
                if let postImage = selectedImage {
                    Image(uiImage: postImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var newCategoryView: some View {
        ScrollView {
           
            VStack(alignment: .leading) {
                HStack {
                    IconButton(iconName: "storefront", action: {
                        // action for paperplane
                    })
                    TextField("New Category Title", text: $headlineText)
                }
                HStack {
                    IconButton(iconName: "note.text", action: {
                        // action for paperplane
                    })
                    TextField("Description", text: $postBody)
                        .focused($focusPostEditor)
                }
                if let postImage = selectedImage {
                    Image(uiImage: postImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var newEventView: some View {
        ScrollView {
            Text ("New Event")
                .padding(.vertical, 2)
                .underline()
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    IconButton(iconName: "calendar.badge.plus", action: {
                        // action for paperplane
                    })
                    Text("Regular")
                    Spacer()
                    IconButton(iconName: "calendar.badge.plus", action: {
                        // action for paperplane
                    })
                    Text("Escrow")
                    Spacer()
                }
                
                HStack {
                    IconButton(iconName: "calendar.badge.plus", action: {
                        // action for paperplane
                    })
                    TextField("New Event Title", text: $headlineText)
                }
                HStack {
                    IconButton(iconName: "note.text", action: {
                        // action for paperplane
                    })
                    TextField("Description", text: $postBody)
                        .focused($focusPostEditor)
                }
                HStack {
                    IconButton(iconName: "clock", action: {
                        // action for paperplane
                    })
                    TextField("Open Until", text: $postBody)
                        .focused($focusPostEditor)
                }
                if let postImage = selectedImage {
                    Image(uiImage: postImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var newConferenceView: some View {
        ScrollView {
            Text ("New Conference")
                .padding(.vertical, 2)
                .underline()
            VStack(alignment: .leading) {
                HStack {
                    IconButton(iconName: "person.badge.plus", action: {
                        // action for paperplane
                    })
                    TextField("Add Members", text: $postBody)
                        .focused($focusPostEditor)
                }
                HStack {
                    IconButton(iconName: "text.line.first.and.arrowtriangle.forward", action: {
                        // action for paperplane
                    })
                    TextField("Conference Title", text: $headlineText)
                }
                HStack {
                    IconButton(iconName: "note.text", action: {
                        // action for paperplane
                    })
                    TextField("Description", text: $postBody)
                        .focused($focusPostEditor)
                }
               
                if let postImage = selectedImage {
                    Image(uiImage: postImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var newTransactionView: some View {
        ScrollView {
            
            VStack(alignment: .leading) {
                HStack {
                    IconButton(iconName: "person", action: {
                        // action for paperplane
                    })
                    TextField("Name, Username or Email", text: $postBody)
                        .focused($focusPostEditor)
                }
                HStack {
                    IconButton(iconName: "arrow.down", action: {
                        // action for paperplane
                    })
                    TextField("Request", text: $headlineText)
                    Spacer()
                    IconButton(iconName: "arrow.up", action: {
                        // action for paperplane
                    })
                    TextField("Send", text: $headlineText)
                }
                HStack {
                    IconButton(iconName: "dollarsign", action: {
                        // action for paperplane
                    })
                    TextField("0.00", text: $postBody)
                        .focused($focusPostEditor)
                    Spacer()
                    
                }
                HStack {
                    IconButton(iconName: "bitcoinsign", action: {
                        // action for paperplane
                    })
                    TextField("0.00", text: $headlineText)
                }
                HStack {
                    IconButton(iconName: "note.text", action: {
                        // action for paperplane
                    })
                    TextField("Leave a note", text: $postBody)
                        .focused($focusPostEditor)
                }
                if let postImage = selectedImage {
                    Image(uiImage: postImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var newDepositorWithdrawalView: some View {
        ScrollView {
            
            VStack(alignment: .leading) {
                HStack {
                    IconButton(iconName: "plus.circle", action: {
                        // action for paperplane
                    })
                    TextField("Deposit", text: $headlineText)
                    Spacer()
                    IconButton(iconName: "banknote", action: {
                        // action for paperplane
                    })
                    TextField("Withdraw", text: $headlineText)
                }
                
                HStack {
                    IconButton(iconName: "building.columns", action: {
                        // action for paperplane
                    })
                    TextField("Bank Account", text: $postBody)
                        .focused($focusPostEditor)
                }
                
                HStack {
                    IconButton(iconName: "creditcard", action: {
                        // action for paperplane
                    })
                    TextField("Choose Card", text: $headlineText)
                }
                
                HStack {
                    IconButton(iconName: "dollarsign", action: {
                        // action for paperplane
                    })
                    TextField("0.00", text: $postBody)
                        .focused($focusPostEditor)
                    Spacer()
                }
                
                HStack {
                    IconButton(iconName: "bitcoinsign", action: {
                        // action for paperplane
                    })
                    TextField("0.00", text: $headlineText)
                }
                
                HStack {
                    IconButton(iconName: "note.text", action: {
                        // action for paperplane
                    })
                    TextField("Describe the Deposit (optional)", text: $postBody)
                        .focused($focusPostEditor)
                }
                
                if let postImage = selectedImage {
                    Image(uiImage: postImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
        }
    }
}


struct IconButton: View {
    let iconName: String
    let action: () -> Void
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: action) {
            Image(systemName: iconName)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
//                .foregroundColor(colorScheme == .dark ? .white : .black)
                .frame(width: 44, height: 44)
        }
    }
}


struct NewActionView_Previews: PreviewProvider {
    
    @State static var selectedNewActionTab = 0
    
    static var previews: some View {
        NewActionView(selectedNewActionTab: $selectedNewActionTab)
    }
}
