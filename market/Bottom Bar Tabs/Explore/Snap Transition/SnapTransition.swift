//
//  SnapTransition.swift
//  market
//
//  Created by Nicholas Nelson on 5/3/24.
//

import SwiftUI
import AVKit

// MARK: Video Model With Sample Videos
struct VideoFile: Identifiable{
    var id: UUID = .init()
    var fileURL: URL
    var thumbnail: UIImage?
    var player: AVPlayer
    var offset: CGSize = .zero
    var playVideo: Bool = false
}

/// - Sample Videos
/// - Video Bundle URLs
var videoURL1: URL = URL(filePath: Bundle.main.path(forResource: "Reel 6", ofType: "mp4") ?? "")
var videoURL2: URL = URL(filePath: Bundle.main.path(forResource: "Reel 7", ofType: "mp4") ?? "")
var videoURL3: URL = URL(filePath: Bundle.main.path(forResource: "Reel 8", ofType: "mp4") ?? "")
var videoURL4: URL = URL(filePath: Bundle.main.path(forResource: "Reel 9", ofType: "mp4") ?? "")
var videoURL5: URL = URL(filePath: Bundle.main.path(forResource: "Reel 10", ofType: "mp4") ?? "")

/// - List of Sample Videos
var files: [VideoFile] = [
    .init(fileURL: videoURL1, player: AVPlayer(url: videoURL1)),
    .init(fileURL: videoURL2, player: AVPlayer(url: videoURL2)),
    .init(fileURL: videoURL3, player: AVPlayer(url: videoURL3)),
    .init(fileURL: videoURL4, player: AVPlayer(url: videoURL4)),
    .init(fileURL: videoURL5, player: AVPlayer(url: videoURL5)),
]


import SwiftUI

struct SnapTransition: View {
    /// - View Properties
    @State private var videoFiles: [VideoFile] = files
    @State private var expandedID: String?
    @State private var isExpanded: Bool = false
    @Namespace private var namespace
    var body: some View {
        VStack(spacing: 0){
            HeaderView()
            
            /// - Lazy Grid
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: Array(repeating: .init(.flexible(),spacing: 10), count: 2), spacing: 10) {
                    ForEach($videoFiles) { $file in
                        if expandedID == file.id.uuidString && isExpanded{
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(height: 300)
                        }else{
                            SnapCardView(videoFile: $file, isExpanded: $isExpanded, animationID: namespace) {
                                /// - We're going to leave this empty
                            }
                            .frame(height: 300)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.8, blendDuration: 0.8)){
                                    expandedID = file.id.uuidString
                                    isExpanded = true
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal,15)
                .padding(.vertical,10)
            }
        }
        .overlay {
            if let expandedID,isExpanded{
                /// Displaying Detail View With Animation
                DetailView(videoFile: $videoFiles.index(expandedID), isExpanded: $isExpanded, animationID: namespace)
                /// - Adding Transition for Smooth Expansion
                    .transition(.asymmetric(insertion: .identity, removal: .offset(y: 5)))
            }
        }
    }
    
    /// - Header View
    @ViewBuilder
    func HeaderView()->some View{
        HStack(spacing: 12){
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .headerButtonBG()
            
            Button {
                
            } label: {
                Image(systemName: "magnifyingglass")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .headerButtonBG()
            }

            Spacer(minLength: 0)
            
            Button {
                
            } label: {
                Image(systemName: "person.badge.plus")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .headerButtonBG()
            }
            
            Button {
                
            } label: {
                Image(systemName: "ellipsis")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .headerButtonBG()
            }
        }
        .overlay(content: {
            Text("Stories")
                .font(.title3)
                .fontWeight(.black)
        })
        .padding(.horizontal,15)
        .padding(.vertical,10)
    }
}

struct SnapTransition_Previews: PreviewProvider {
    static var previews: some View {
        SnapTransition()
    }
}

/// - Fetching Binding indexOf
extension Binding<[VideoFile]>{
    func index(_ id: String)->Binding<VideoFile>{
        let index = self.wrappedValue.firstIndex { item in
            item.id.uuidString == id
        } ?? 0
        return self[index]
    }
}

/// - Custom View Modifiers
extension View{
    func headerButtonBG()->some View{
        self
            .frame(width: 40, height: 40)
            .background {
                Circle()
                    .fill(.gray.opacity(0.1))
            }
    }
}


import SwiftUI
import AVKit

/// - Custom View Builder
/// - Which Allows to place custom overlay on Card views
struct SnapCardView<Overlay: View>: View {
    var overlay: Overlay
    /// - View Properties
    @Binding var videoFile: VideoFile
    @Binding var isExpanded: Bool
    var animationID: Namespace.ID
    var isDetailView: Bool = false
    
    init(videoFile: Binding<VideoFile>,isExpanded: Binding<Bool>,animationID: Namespace.ID,isDetailView: Bool = false,@ViewBuilder overlay: @escaping ()->Overlay){
        self._videoFile = videoFile
        self._isExpanded = isExpanded
        self.isDetailView = isDetailView
        self.animationID = animationID
        self.overlay = overlay()
    }
    
    var body: some View {
        GeometryReader{
            let size = $0.size
            
            /// - Displaying Thumbail Instead of showing paused video
            /// - For Saving Memory
            /// - Displaying Thumbnail
            if let thumbnail = videoFile.thumbnail{
                Image(uiImage: thumbnail)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .opacity(videoFile.playVideo ? 0 : 1)
                    .frame(width: size.width, height: size.height)
                    .overlay(content: {
                        /// - Displaying Video Player Only For Detail View
                        if videoFile.playVideo && isDetailView{
                            CustomVideoPlayer(player: videoFile.player)
                                .transition(.identity)
                        }
                    })
                    .overlay(content: {
                        /// - Displaying OVerlay View
                        overlay
                    })
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .scaleEffect(scale)
            }else{
                Rectangle()
                    .foregroundColor(.clear)
                    .onAppear {
                        /// - Since We need the Intial Image
                        extractImageAt(time: .zero, size: screenSize) { thumbnail in
                            videoFile.thumbnail = thumbnail
                        }
                    }
            }
        }
        /// - Adding Mathed Geometry
        .matchedGeometryEffect(id: videoFile.id.uuidString, in: animationID)
        /// - Adding Offset & Scaling
        .offset(videoFile.offset)
        /// - Making it Center
        .offset(y: videoFile.offset.height * -0.7)
    }
    
    /// - Dynamic Scaling Based On Offset
    var scale: CGFloat{
        var yOffset = videoFile.offset.height
        /// - Applying Scaling Only When Dragged Downwards
        yOffset = yOffset < 0 ? 0 : yOffset
        var progress = yOffset / screenSize.height
        /// - Limiting Progress
        progress = 1 - (progress > 0.4 ? 0.4 : progress)
        /// - When the View is Closed Immediately Resetting Scale to 1
        return (isExpanded ? progress : 1)
    }
    
    /// - Extracting Thumbnail From Video using AVAssetGenerator
    func extractImageAt(time: CMTime,size: CGSize,completion: @escaping (UIImage)->()){
        DispatchQueue.global(qos: .userInteractive).async {
            let asset = AVAsset(url: videoFile.fileURL)
            let generator = AVAssetImageGenerator(asset: asset)
            generator.appliesPreferredTrackTransform = true
            generator.maximumSize = size
            
            Task{
                do{
                    let cgImage = try await generator.image(at: time).image
                    guard let colorCorrectedImage = cgImage.copy(colorSpace: CGColorSpaceCreateDeviceRGB()) else{return}
                    let thumbnail = UIImage(cgImage: colorCorrectedImage)
                    /// UI Must be Updated on Main Thread
                    await MainActor.run(body: {
                        completion(thumbnail)
                    })
                }catch{
                    print("Failed to Fetch Thumbnail")
                }
            }
        }
    }
}

struct SnapCardView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        SnapCardView(videoFile: Binding.constant(VideoFile(fileURL: videoURL1, player: AVPlayer(url: videoURL1))), isExpanded: Binding.constant(false), animationID: namespace) {
            Text("Overlay Content Here")
        }
        }
    }


extension View{
    /// - Current Phone Screen Size
    var screenSize: CGSize{
        guard let size = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.screen.bounds.size else{return .zero}
        return size
    }
}


import SwiftUI
import AVKit

struct CustomVideoPlayer: UIViewControllerRepresentable {
    var player: AVPlayer
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.videoGravity = .resizeAspectFill
        controller.view.backgroundColor = .clear
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.player = player
    }
}


import SwiftUI
import AVKit

struct DetailView: View{
    @Binding var videoFile: VideoFile
    @Binding var isExpanded: Bool
    var animationID: Namespace.ID
    /// - View Properties
    @GestureState private var isDragging: Bool = false
    
    var body: some View{
        GeometryReader{
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            SnapCardView(videoFile: $videoFile, isExpanded: $isExpanded, animationID: animationID,isDetailView: true) {
                OverlayView()
                    .frame(width: size.width, height: size.height)
                    .padding(.top,safeArea.top)
                    .padding(.bottom,safeArea.bottom)
            }
            .ignoresSafeArea()
        }
        .gesture(
            DragGesture()
                .updating($isDragging, body: { _, out, _ in
                    out = true
                }).onChanged({ value in
                    var translation = value.translation
                    translation = isDragging && isExpanded ? translation : .zero
                    videoFile.offset = translation
                }).onEnded({ value in
                    /// - Your Condition
                    if value.translation.height > 200{
                        /// - Closing View With Animation
                        videoFile.player.pause()
                        
                        /// - First Closing View And In the Mid of Animation Resetting The player to Start and Hiding the Video View
                        
                        /// - You may fix the interactiveSpring() Animation Bug if you are experiencing any delays or glitches by changing the spring animation to easeInOut.
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15){
                            videoFile.player.seek(to: .zero)
                            videoFile.playVideo = false
                        }

                        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.7)){
                            videoFile.offset = .zero
                            isExpanded = false
                        }
                        
                        /// - EaseInOut Implementation
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
//                            videoFile.player.seek(to: .zero)
//                            videoFile.playVideo = false
//                        }
//
//                        withAnimation(.easeInOut(duration: 0.25)){
//                            videoFile.offset = .zero
//                            isExpanded = false
//                        }
                    }else{
                        withAnimation(.easeInOut(duration: 0.25)){
                            videoFile.offset = .zero
                        }
                    }
                })
        )
        .onAppear {
            /// - Playing the Video As Soon the Animation Finished
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.28){
                /// - Transition Needs Animation
                withAnimation(.easeInOut){
                    videoFile.playVideo = true
                    videoFile.player.play()
                }
            }
        }
    }
    
    /// - Sample Overlay View
    @ViewBuilder
    func OverlayView()->some View{
        VStack{
            HStack{
                Image("Pic")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("iJustine")
                        .font(.callout)
                        .fontWeight(.bold)
                    Text("4 hr ago")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white.opacity(0.7))
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                
                Image(systemName: "bookmark")
                    .font(.title3)
                
                Image(systemName: "ellipsis")
                    .font(.title3)
                    .rotationEffect(.init(degrees: -90))
            }
            .foregroundColor(.white)
            .frame(maxHeight: .infinity,alignment: .top)
            /// - Hiding When Dragging
            .opacity(isDragging ? 0 : 1)
            .animation(.easeInOut(duration: 0.2), value: isDragging)
            
            Button {
                
            } label: {
                Text("View More Episodes")
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.horizontal,12)
                    .padding(.vertical,8)
                    .background {
                        Capsule()
                            .fill(.white)
                    }
            }
            .frame(maxWidth: .infinity)
            .overlay(alignment: .trailing) {
                Button {
                    
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background {
                            Circle()
                                .fill(.ultraThinMaterial)
                        }
                }
            }
        }
        .padding(.horizontal,15)
        .padding(.vertical,10)
        /// - Displaying Only When Videos Starts Playing
        .opacity(videoFile.playVideo && isExpanded ? 1 : 0)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(videoFile: .constant(VideoFile(fileURL: videoURL1, player: AVPlayer(url: videoURL1))), isExpanded: .constant(true), animationID: Namespace().wrappedValue)
    }
}
