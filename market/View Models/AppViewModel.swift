//
//  AppViewModel.swift
//  market
//
//  Created by Nicholas Nelson on 11/24/23.
//

import Foundation
import SwiftUI


@MainActor
class AppViewModel: ObservableObject {
    
    @Published var ideas: [Idea] = [] {
        didSet { saveIdeas() }
    }
    @Published var selectedIdea: Idea?
 
    var titleText = "Forecast.ai"
    @Published var subtitleText: String
    var emptyIdeasText = "Search for Ideas"
    var attributionText = "Powered by Yahoo! finance API"
    
    private let subtitleDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "d MMM"
        return df
    }()
    
    let ideaListRepository: IdeaListRepository
    
    init(repository: IdeaListRepository = IdeaPlistRepository()) {
        self.ideaListRepository = repository
        self.subtitleText = subtitleDateFormatter.string(from: Date())
        loadIdeas()
    }
    
    private func loadIdeas() {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                self.ideas = try await ideaListRepository.load()
            } catch {
                print(error.localizedDescription)
                self.ideas = []
            }
        }
    }
    
    private func saveIdeas() {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                try await self.ideaListRepository.save(self.ideas)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func removeIdeas(atOffsets offsets: IndexSet) {
        ideas.remove(atOffsets: offsets)
    }
    
    func isAddedToMyIdeas(idea: Idea) -> Bool {
        ideas.first { $0.symbol == idea.symbol } != nil
    }
    
    func toggleIdea(_ idea: Idea) {
        if isAddedToMyIdeas(idea: idea) {
            removeFromMyIdeas(idea: idea)
        } else {
            addToMyIdeas(idea: idea)
        }
    }
    
    private func addToMyIdeas(idea: Idea) {
        ideas.append(idea)
    }
    
    private func removeFromMyIdeas(idea: Idea) {
        guard let index = ideas.firstIndex(where: { $0.symbol == idea.symbol }) else { return }
        ideas.remove(at: index)
    }
    
    
    func openYahooFinance() {
        let url = URL(string: "https://finance.yahoo.com")!
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}
