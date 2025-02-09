//
//  aiChatViewModel.swift
//  market
//
//  Created by Nicholas Nelson on 1/20/24.
//

import Foundation
import OpenAIKit

class aiChatViewModel: ObservableObject {
    @Published var messages: [aiChatMessage] = []
    @Published var isLoading: Bool = false
    
    let apiService: aiAPIService
    let settings: AppSettings
    
    init(settings: AppSettings) {
        self.settings = settings
        self.apiService = aiAPIService(settings: settings)
    }
    
    func sendMessage(_ content: String) {
        self.isLoading = true
        let userMessage = aiChatMessage(message: content, isUser: true)
        messages.append(userMessage)
        
        var responseContent = ""
        var currentApiResponseIndex: Int? = nil
        
        apiService.sendStreamMessage(content) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let chunk):
                    responseContent += chunk
                    
                    // If this is a new API response, add a new message and store its index
                    if currentApiResponseIndex == nil {
                        let apiMessage = aiChatMessage(message: responseContent, isUser: false)
                        self.messages.append(apiMessage)
                        currentApiResponseIndex = self.messages.count - 1
                    } else {
                        // If this is a subsequent chunk of the current API response, update the existing message
                        self.messages[currentApiResponseIndex!] = aiChatMessage(message: responseContent, isUser: false)
                    }
                case .failure(let error):
                    print("Error sending message: \(error)")
                }
                self.isLoading = false
            }
        }
    }
    
    
    func changeModel(to newModel: ModelID) {
        apiService.changeModel(to: newModel)
    }
    
    func clearAllMessages() {
        messages.removeAll()
        apiService.cancelCurrentRequest()
        apiService.clearAllMessages()
        self.isLoading = false
    }
    
}
