//
//  ReelsView.swift
//  market
//
//  Created by Nicholas Nelson on 5/4/24.
//

import Foundation
import SwiftUI
import AVKit
struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

struct ReelsView: View {
    //    var size: CGSize
    //    var safeArea: EdgeInsets
    /// View Properties
    @State private var reels: [Reel] = reelsData
    @State private var likedCounter: [Like] = []
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let safeArea = geometry.safeAreaInsets
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 0) {
                    ForEach($reels) { $reel in
                        ReelView(
                            reel: $reel,
                            likedCounter: $likedCounter,
                            size: size,
                            safeArea: safeArea
                        )
                        .frame(maxWidth: .infinity)
                        .containerRelativeFrame(.vertical)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.paging)
            .background(.black)
            /// Like Animation View
            .overlay(alignment: .topLeading, content: {
                ZStack {
                    ForEach(likedCounter) { like in
                        Image(systemName: "suit.heart.fill")
                            .font(.system(size: 75))
                            .foregroundStyle(.red.gradient)
                            .frame(width: 100, height: 100)
                        /// Adding Some Implicit Rotation & Scaling Animation
                            .animation(.smooth, body: { view in
                                view
                                    .scaleEffect(like.isAnimated ? 1 : 1.8)
                                    .rotationEffect(.init(degrees: like.isAnimated ? 0 : .random(in: -30...30)))
                            })
                            .offset(x: like.tappedRect.x - 50, y: like.tappedRect.y - 50)
                        /// Let's Animate
                            .offset(y: like.isAnimated ? -(like.tappedRect.y + safeArea.top) : 0)
                    }
                }
            })
            .overlay(alignment: .top, content: {
                Text("Reels")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .trailing) {
                        Button {
                            
                        } label: {
                            Image(systemName: "camera")
                        }
                        .font(.title2)
                    }
                    .foregroundStyle(.white)
                    .padding(.top, safeArea.top + 15)
                    .padding(.horizontal, 15)
            })
            .environment(\.colorScheme, .dark)
            .ignoresSafeArea(edges: .all)
        }
    }
}
struct ReelsView_Previews: PreviewProvider {
    static var previews: some View {
        ReelsView(
           ) // Example safe area insets
        
    }
}

struct ReelView: View {
    @Binding var reel: Reel
    @Binding var likedCounter: [Like]
    var size: CGSize
    var safeArea: EdgeInsets
    /// View Properties
    @State private var player: AVPlayer?
    @State private var looper: AVPlayerLooper?
    @State private var showPopup: Bool = false
    
    
    var body: some View {
        GeometryReader {
            let rect = $0.frame(in: .scrollView(axis: .vertical))
            
            /// Custom Video Player View
            reelsCustomVideoPlayer(player: $player)
                /// Offset Updates
                .preference(key: OffsetKey.self, value: rect)
                .onPreferenceChange(OffsetKey.self, perform: { value in
                    playPause(value)
                })
                .overlay(alignment: .bottom, content: {
                    ReelDetailsView()
                })
                /// Double Tap Like Animation
                .onTapGesture(count: 2, perform: { position in
                    let id = UUID()
                    likedCounter.append(.init(id: id, tappedRect: position, isAnimated: false))
                    /// Animating Like
                    withAnimation(.snappy(duration: 1.2), completionCriteria: .logicallyComplete) {
                        if let index = likedCounter.firstIndex(where: { $0.id == id }) {
                            likedCounter[index].isAnimated = true
                        }
                    } completion: {
                        /// Removing Like, Once it's Finished
                        likedCounter.removeAll(where: { $0.id == id })
                    }
                    
                    /// Liking the Reel
                    reel.isLiked = true
                })
                /// Creating Player
                .onAppear {
                    guard player == nil else { return }
                    guard let path = Bundle.main.path(forResource: reel.videoID, ofType: "mp4") else {
                        print("Failed to find video file: \(reel.videoID).mp4")
                        return
                    }
                    let videoURL = URL(fileURLWithPath: path)
                    let playerItem = AVPlayerItem(url: videoURL)
                    let queue = AVQueuePlayer(playerItem: playerItem)
                    looper = AVPlayerLooper(player: queue, templateItem: playerItem)
                    player = queue
                }
                /// Clearing Player
                .onDisappear {
                    player = nil
                }
        }
    }
    
    /// Play/Pause Action
    func playPause(_ rect: CGRect) {
        if -rect.minY < (rect.height * 0.5) && rect.minY < (rect.height * 0.5) {
            player?.play()
        } else {
            player?.pause()
        }
        
        if rect.minY >= size.height || -rect.minY >= size.height {
            player?.seek(to: .zero)
        }
    }
    
    /// Reel Details & Controls
    @ViewBuilder
    func ReelDetailsView() -> some View {
        HStack(alignment: .bottom, spacing: 10) {
            VStack(alignment: .leading, spacing: 8, content: {
                HStack(spacing: 10) {
                    Image(systemName: "person.circle.fill")
                        .font(.largeTitle)
                    
                    Text(reel.authorName)
                        .font(.callout)
                        .lineLimit(1)
                }
                .foregroundStyle(.white)
                
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .clipped()
            })
            
            Spacer(minLength: 0)
            
            /// Controls View
            VStack(spacing: 35) {
                
                Button {
                    
                } label: {
                    Image(systemName: "banknote")
                }
                HStack (spacing: 10) {
                    Button {
                        
                    } label: {
                        Image(systemName: "checkmark.circle")
                        
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "xmark.circle")
                    }
                }
                
                Button(action: {
                    // Toggles the `isLiked` property of `reel` when the button is tapped
                    reel.isLiked.toggle()
                }) {
                    // This determines which icon to display based on the `isLiked` property
                    Image(systemName: reel.isLiked ? "suit.heart.fill" : "suit.heart")
                }
                .foregroundStyle(reel.isLiked ? .red : .white) // Changes the color of the icon
                .symbolRenderingMode(.hierarchical)
                .symbolEffect(.bounce, value: reel.isLiked)
                
                
                Button {
                    
                } label: {
                    Image(systemName: "message")
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "paperplane")
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
            .font(.title2)
            .foregroundStyle(.white)
        }
        .padding(.leading, 15)
        .padding(.trailing, 10)
        .padding(.bottom, safeArea.bottom + 15)
    }
}

#Preview {
    ReelsView()
}

struct reelsCustomVideoPlayer: UIViewControllerRepresentable {
    @Binding var player: AVPlayer?
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.videoGravity = .resizeAspectFill
        controller.showsPlaybackControls = false
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        if let player = player {
            uiViewController.player = player
        }
    }
}

struct Reel: Identifiable {
    var id: UUID = .init()
    var videoID: String
    var authorName: String
    var isLiked: Bool = false
}

var reelsData: [Reel] = [
    /// https://www.pexels.com/video/sea-waves-crashing-the-cliff-coast-6010489/
    .init(videoID: "Reel 6", authorName: "Tima Miroshnichenko"),
    /// https://www.pexels.com/video/panning-shot-of-the-sea-at-sunset-6202759/
    .init(videoID: "Reel 7", authorName: "Trippy Clicker"),
    /// https://www.pexels.com/video/sea-waves-causing-erosion-on-the-shore-rocks-formation-6010502/
    .init(videoID: "Reel 8", authorName: "Tima Miroshnichenko"),
    /// https://www.pexels.com/video/close-up-shot-of-a-water-falls-8242987/
    .init(videoID: "Reel 9", authorName: "Ana Benet"),
    /// https://www.pexels.com/video/calm-river-under-blue-sky-and-white-clouds-5145199/
    .init(videoID: "Reel 10", authorName: "Anna Medvedeva")
]

struct Like: Identifiable {
    var id: UUID = .init()
    var tappedRect: CGPoint = .zero
    var isAnimated: Bool = false
}
