//
//  aiView.swift
//  market
//
//  Created by Nicholas Nelson on 1/19/24.
//

import SwiftUI
import OpenAIKit
import Combine

class AppSettings: ObservableObject {
    // Default system prompt
    @AppStorage("systemPrompt") var systemPrompt: String = "You are a helpful AI assistant."
}

// Native color shades
//struct AppColors {
//    static let purple = Color(#colorLiteral(red: 0.525, green: 0.435, blue: 0.690, alpha: 1))
//    static let gray = Color(#colorLiteral(red: 0.196, green: 0.212, blue: 0.224, alpha: 1))
//}

struct aiView: View {
    @StateObject var settings = AppSettings()
    @StateObject var viewModel = aiChatViewModel(settings: AppSettings())
    @State var chatInput: String = ""
    @State private var animate: Bool = false
    @ObservedObject var mainViewModel: MainViewModel
    @Binding var isOpened: Bool
    @Binding var isShowingAiSideMenu: Bool
    let impactFeedback = UIImpactFeedbackGenerator(style: .medium)

    let buttonLabels = ["Which Categories are trending?", "Explain escrow options like I'm 5 years old",
                        "What are disputes and why do they exist?", "Give me Ideas for a stock option that will produce frothy returns"]
    let colors: [Color] = [.gray, .gray, .gray, .gray]

    init(isOpened: Binding<Bool>, isShowingAiSideMenu: Binding<Bool>, mainViewModel: MainViewModel) {
        self._isOpened = isOpened
        self._isShowingAiSideMenu = isShowingAiSideMenu
        self.mainViewModel = mainViewModel
    }

    var body: some View {
        VStack(spacing: 0) {
            aiCustomToolbar(isOpened: $isOpened, isShowingAiSideMenu: $isShowingAiSideMenu)

            GeometryReader { geometry in
                ZStack {
                    MatrixRainView()
                        .clipped()

                    VStack(spacing: 20) { // Added spacing between elements
                        ForEach(0..<2) { index in // First two buttons
                            Text(buttonLabels[index])
                                .padding(5)
                                .frame(width: geometry.size.width, height: 50)
                                .background(colors[index])
                                .cornerRadius(5)
                                .foregroundColor(.white)
                                .offset(x: self.animate ? (index % 2 == 0 ? -geometry.size.width * 1.5 : geometry.size.width * 1.5) : 0)
                                .animation(Animation.linear(duration: 30.0).repeatForever(autoreverses: false), value: animate)
                        }

                        Spacer()

                        VStack {
                            HStack(spacing: 0) {
                                ForEach(Array("Forecast.ai".enumerated()), id: \.offset) { index, character in
                                    AnimatedCharacterView(character: String(character), delay: (Double(index) + 1) * 0.05)
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }

                        Spacer()

                        ForEach(2..<4) { index in // Last two buttons
                            Text(buttonLabels[index])
                                .padding(5)
                                .frame(width: geometry.size.width, height: 50)
                                .background(colors[index])
                                .cornerRadius(5)
                                .foregroundColor(.white)
                                .offset(x: self.animate ? (index % 2 == 0 ? geometry.size.width * 1.5 : -geometry.size.width * 1.5) : 0)
                                .animation(Animation.linear(duration: 30.0).repeatForever(autoreverses: false), value: animate)
                        }
                    }
                    .onAppear {
                        self.animate = true
                    }
                }
            }

            BottomActionBar(chatInput: $chatInput, viewModel: viewModel, impactFeedback: impactFeedback)
        }
    }
}
                    
struct BottomActionBar: View {
    @Binding var chatInput: String
    var viewModel: aiChatViewModel
    var impactFeedback: UIImpactFeedbackGenerator

    var body: some View {
        HStack {
            Image(systemName: "trash.fill")
                .foregroundColor(viewModel.messages.isEmpty ? Color.gray : Color.gray.opacity(0.9))
                .onTapGesture {
                    if !viewModel.messages.isEmpty {
                        impactFeedback.impactOccurred()
                        viewModel.clearAllMessages()
                        chatInput = ""
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }

            Menu {
                Button(action: { /* Action for Menu Item 1 */ }) {
                    Label("File", systemImage: "folder")
                }
                Button(action: { /* Action for Menu Item 1 */ }) {
                    Label("Photo/Video Library", systemImage: "photo")
                }
                Button(action: { /* Action for Menu Item 1 */ }) {
                    Label("Camera", systemImage: "camera")
                }
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
            }

            ZStack(alignment: .trailing) {
                CustomTextField(placeholder: "Message", text: $chatInput)
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 1.5)
                    )
                Image(systemName: "waveform")
                    .padding(.horizontal, 8)
            }

            Button(action: {
                if !chatInput.isEmpty {
                    impactFeedback.impactOccurred()
                    viewModel.sendMessage(chatInput)
                    chatInput = ""
                }
            }) {
                Image(systemName: "arrow.up.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
            }
            .disabled(chatInput.isEmpty || viewModel.isLoading)
            .padding(.trailing, 10)
        }
        .padding()
    }
}
//                .background(
//                    // Apply the matrix effect as a background, ensuring it's contained within this view
//                    MatrixRainView()
//                        .clipped()
//                        .frame(height: 550)// Optional based on desired effect
//                )
                //        .background(Color.black)
                //        .colorScheme(.dark)
                
                //            .onChange(of: settings.systemPrompt) { _ in
                //                viewModel.clearAllMessages()
                //            }
                //            .navigationBarTitle("")
                //            .navigationBarTitle(viewModel.messages.isEmpty ? "No Messages" : "Messages", displayMode: .inline)
                //            .navigationBarItems(
                //                leading: Button(action: {
                //                    withAnimation {
                //
                //                    }
                //                }) {
                //                    Image(systemName: "square.fill.text.grid.1x2")
                //                },
                //                trailing: HStack {
                //                    Picker("Model", selection: $selectedModel) {
                //                        ForEach(OpenAIModel.allCases, id: \.self) { model in
                //                            Text(model.displayName).tag(model)
                //                        }
                //                    }
                //                    .pickerStyle(SegmentedPickerStyle())
                //                    .onChange(of: selectedModel) { newModel in
                //                        impactFeedback.impactOccurred()
                //                        viewModel.changeModel(to: newModel.modelID)
                //                    }
                //
                //                    Menu {
                //                        Button("Settings", action: {
                //                            showingSettings = true
                //                        })
                //                    } label: {
                //                        Image(systemName: "ellipsis.circle")
                //                        //                        .foregroundColor(AppColors.purple)
                //                    }
                //                    .sheet(isPresented: $showingSettings) {
                //                        aiSettingsView(settings: settings)
                //                    }
                //                }
                //            )
            
            //        .blur(radius: isShowingAiSideMenu ? 3 : 0) // Optional: Blur content when menu is visible
            
            // Overlay the side menu
            //                    if isShowingAiSideMenu {
            //                        aiSideMenuView(isShowingAiSideMenu: $isShowingAiSideMenu)
            ////                            .ignoresSafeArea()
            //                    }
            
        
    

struct aiCustomToolbar: View {
    @Binding var isOpened: Bool
    @Binding var isShowingAiSideMenu: Bool
    var body: some View {
        CustomToolbar(
            leftContent: {
                AnyView(HStack(spacing: 28) {
                    Button(action: {
                        isShowingAiSideMenu.toggle()
                    }) {
                        Image(systemName: "square.fill.text.grid.1x2")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                    }
                    
                })
            },
            centerContent: {
                AnyView(Text("ai Model 1").font(.headline))
            },
            rightContent: {
                AnyView(HStack(spacing: 28) {
                    Button(action: {
                       
                        
                    }) {
                        Image(systemName: "square.and.pencil")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                    }
                    Button(action: {
                       
                        isOpened.toggle()
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


struct aiSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var settings: AppSettings
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Prompts")) {
                    NavigationLink(destination: SystemPromptView(settings: settings)) {
                        HStack {
                            Text("System Prompt")
//                                .foregroundColor(.white)
                            Spacer()
                            Text(settings.systemPrompt)
                                .foregroundColor(.gray)
                                .lineLimit(1)
                        }
                    }
                    
                    
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Settings", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.gray)
                        .padding(7.5)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                }
            )
        }
//        .background(Color.black.ignoresSafeArea())
//        .colorScheme(.dark)
    }
}

struct SystemPromptView: View {
    @ObservedObject var settings: AppSettings
    
    var body: some View {
        Form {
            TextField("System Prompt", text: $settings.systemPrompt, axis: .vertical)
                .lineLimit(5)
        }
        .navigationBarTitle("System Prompt", displayMode: .inline)
    }
}


struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
//                    .foregroundColor(AppColors.gray)
            }
            TextField("", text: $text, axis: .vertical)
                .lineLimit(4)
//                .foregroundColor(.white)
        }
        .padding(.trailing)
    }
}

enum OpenAIModel: String, Hashable, CaseIterable {
    case gpt3_5Turbo = "gpt3_5Turbo"
    case gpt4 = "gpt4"
    
    var displayName: String {
        switch self {
        case .gpt3_5Turbo:
            return "GPT-3.5"
        case .gpt4:
            return "GPT-4"
        }
    }
    
    var modelID: ModelID {
        switch self {
        case .gpt3_5Turbo:
            return Model.GPT3.gpt3_5Turbo
        case .gpt4:
            return Model.GPT4.gpt4
        }
    }
}

struct AnimatedCharacterView: View {
    let character: String
    let delay: Double
    
    @State private var animate = false
    
    var body: some View {
        Text(character)
                    .font(.largeTitle)
                    .bold()
                    .opacity(animate ? 1 : 0)
                    .animation(Animation.easeOut(duration: 0.15).delay(delay), value: animate)
                    .onAppear {
                        animate = true
                    }
            }
        }
//        Group {
//            if character == "✈️" {
//                Image(systemName: "paperplane.fill")
//                    .font(.title)
////                    .foregroundColor(.white)
//            } else {
//                Text(character)
//                    .font(.largeTitle)
////                    .foregroundColor(.white)
//                    .bold()
//            }
//        }
//        .opacity(animate ? 1 : 0)
//        .animation(Animation.easeOut(duration: 0.15).delay(delay), value: animate)
//        .onAppear {
//            animate = true
//        }
//    }
//}

struct TypingIndicatorView: View {
    @State private var scale: CGFloat = 0.2
    
    var body: some View {
        HStack(spacing: 5) {
            Circle()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 10, height: 10)
                .scaleEffect(scale)
                .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: scale)
                .onAppear() { self.scale = 1.0 }
            
            Circle()
                .fill(Color.gray.opacity(0.6))
                .frame(width: 10, height: 10)
                .scaleEffect(scale)
                .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true).delay(0.2), value: scale)
                .onAppear() { self.scale = 1.0 }
            
            Circle()
                .fill(Color.gray.opacity(0.8))
                .frame(width: 10, height: 10)
                .scaleEffect(scale)
                .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true).delay(0.4), value: scale)
                .onAppear() { self.scale = 1.0 }
        }
        .padding(10)
//        .background(AppColors.gray)
        .cornerRadius(10)
    }
}


// Uncomment to get a live preview in Xcode
// Might cause lag on older Macs

struct aiView_Previews: PreviewProvider {
    @State static var isOpened = false
    @State static var isShowingAiSideMenu = false
    static var previews: some View {
        // Create an instance of MainViewModel for preview purposes
        let mainViewModel = MainViewModel()
        aiView(isOpened: $isOpened, isShowingAiSideMenu: $isShowingAiSideMenu, mainViewModel: mainViewModel)
    }
}
