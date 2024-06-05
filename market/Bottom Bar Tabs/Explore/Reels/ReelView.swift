//
//  ReelView.swift
//  market
//
//  Created by Nicholas Nelson on 5/4/24.
//

//import SwiftUI
//import AVKit
//
///// Reel View
//struct ReelView: View {
//    @Binding var reel: Reel
//    @Binding var likedCounter: [Like]
//    var size: CGSize
//    var safeArea: EdgeInsets
//    /// View Properties
//    @State private var player: AVPlayer?
//    @State private var looper: AVPlayerLooper?
//    var body: some View {
//        GeometryReader {
//            let rect = $0.frame(in: .scrollView(axis: .vertical))
//            
//            /// Custom Video Player View
//            reelsCustomVideoPlayer(player: $player)
//                /// Offset Updates
//                .preference(key: OffsetKey.self, value: rect)
//                .onPreferenceChange(OffsetKey.self, perform: { value in
//                    playPause(value)
//                })
//                .overlay(alignment: .bottom, content: {
//                    ReelDetailsView()
//                })
//                /// Double Tap Like Animation
//                .onTapGesture(count: 2, perform: { position in
//                    let id = UUID()
//                    likedCounter.append(.init(id: id, tappedRect: position, isAnimated: false))
//                    /// Animating Like
//                    withAnimation(.snappy(duration: 1.2), completionCriteria: .logicallyComplete) {
//                        if let index = likedCounter.firstIndex(where: { $0.id == id }) {
//                            likedCounter[index].isAnimated = true
//                        }
//                    } completion: {
//                        /// Removing Like, Once it's Finished
//                        likedCounter.removeAll(where: { $0.id == id })
//                    }
//                    
//                    /// Liking the Reel
//                    reel.isLiked = true
//                })
//                /// Creating Player
//                .onAppear {
//                    guard player == nil else { return }
//                    guard let path = Bundle.main.path(forResource: reel.videoID, ofType: "mp4") else {
//                        print("Failed to find video file: \(reel.videoID).mp4")
//                        return
//                    }
//                    let videoURL = URL(fileURLWithPath: path)
//                    let playerItem = AVPlayerItem(url: videoURL)
//                    let queue = AVQueuePlayer(playerItem: playerItem)
//                    looper = AVPlayerLooper(player: queue, templateItem: playerItem)
//                    player = queue
//                }
//                /// Clearing Player
//                .onDisappear {
//                    player = nil
//                }
//        }
//    }
//    
//    /// Play/Pause Action
//    func playPause(_ rect: CGRect) {
//        if -rect.minY < (rect.height * 0.5) && rect.minY < (rect.height * 0.5) {
//            player?.play()
//        } else {
//            player?.pause()
//        }
//        
//        if rect.minY >= size.height || -rect.minY >= size.height {
//            player?.seek(to: .zero)
//        }
//    }
//    
//    /// Reel Details & Controls
//    @ViewBuilder
//    func ReelDetailsView() -> some View {
//        HStack(alignment: .bottom, spacing: 10) {
//            VStack(alignment: .leading, spacing: 8, content: {
//                HStack(spacing: 10) {
//                    Image(systemName: "person.circle.fill")
//                        .font(.largeTitle)
//                    
//                    Text(reel.authorName)
//                        .font(.callout)
//                        .lineLimit(1)
//                }
//                .foregroundStyle(.white)
//                
//                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry")
//                    .font(.caption)
//                    .foregroundStyle(.secondary)
//                    .lineLimit(2)
//                    .clipped()
//            })
//            
//            Spacer(minLength: 0)
//            
//            /// Controls View
//            VStack(spacing: 35) {
//                
//                Button {
//                    
//                } label: {
//                    Image(systemName: "banknote")
//                }
//                HStack (spacing: 10) {
//                    Button {
//                        
//                    } label: {
//                        Image(systemName: "checkmark.circle")
//                        
//                    }
//                    
//                    Button {
//                        
//                    } label: {
//                        Image(systemName: "xmark.circle")
//                    }
//                }
//                
//                Button(action: {
//                    // Toggles the `isLiked` property of `reel` when the button is tapped
//                    reel.isLiked.toggle()
//                }) {
//                    // This determines which icon to display based on the `isLiked` property
//                    Image(systemName: reel.isLiked ? "suit.heart.fill" : "suit.heart")
//                }
//                .foregroundStyle(reel.isLiked ? .red : .white) // Changes the color of the icon
//                .symbolRenderingMode(.hierarchical)
//                .symbolEffect(.bounce, value: reel.isLiked)
//                
//                
//                Button {
//                    
//                } label: {
//                    Image(systemName: "message")
//                }
//                
//                Button {
//                    
//                } label: {
//                    Image(systemName: "paperplane")
//                }
//                
//                Button {
//                    
//                } label: {
//                    Image(systemName: "ellipsis")
//                }
//            }
//            .font(.title2)
//            .foregroundStyle(.white)
//        }
//        .padding(.leading, 15)
//        .padding(.trailing, 10)
//        .padding(.bottom, safeArea.bottom + 15)
//    }
//}
//
//#Preview {
//    ReelsView()
//}
