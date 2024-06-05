//
//  CustomVideoPlayer.swift
//  market
//
//  Created by Nicholas Nelson on 5/4/24.
//

//import SwiftUI
//import AVKit
//
//struct reelsCustomVideoPlayer: UIViewControllerRepresentable {
//    @Binding var player: AVPlayer?
//    func makeUIViewController(context: Context) -> AVPlayerViewController {
//        let controller = AVPlayerViewController()
//        controller.player = player
//        controller.videoGravity = .resizeAspectFill
//        controller.showsPlaybackControls = false
//        
//        return controller
//    }
//    
//    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
//        if let player = player {
//            uiViewController.player = player
//        }
//    }
//}
