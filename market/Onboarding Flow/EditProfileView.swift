//
//  EditProfileView.swift
//  market
//
//  Created by Nicholas Nelson on 12/9/23.
//

import SwiftUI

struct EditProfileView: View {
    var body: some View {
        VStack(alignment: .leading) {
            TopSection
            Form {
                NameSection
                UsernameSection
                ProfilePictureSection
                BannerImageSection
                WebsiteSection
                AboutMeSection
                BitcoinLightningTipsSection
                NostrAddressSection

                Button(NSLocalizedString("Save", comment: "Button for saving profile.")) {
                    // Action for saving profile
                }
            }
        }
        .ignoresSafeArea(edges: .top)
        .background(Color(.systemGroupedBackground))
    }

    var TopSection: some View {
        // Content for the top section
        Text("Top Section Placeholder")
    }

    var NameSection: some View {
        Section(NSLocalizedString("Name", comment: "Label for Your Name section of user profile form.")) {
            TextField("John Doe", text: .constant(""))
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
        }
    }

    var UsernameSection: some View {
        Section(NSLocalizedString("Username", comment: "Label for Username section of user profile form.")) {
            TextField("john.doe", text: .constant(""))
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
        }
    }

    var ProfilePictureSection: some View {
        Section(NSLocalizedString("Profile Picture", comment: "Label for Profile Picture section of user profile form.")) {
            TextField("https://example.com/pic.jpg", text: .constant(""))
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
        }
    }

    var BannerImageSection: some View {
        Section(NSLocalizedString("Banner Image", comment: "Label for Banner Image section of user profile form.")) {
            TextField("https://example.com/banner.jpg", text: .constant(""))
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
        }
    }

    var WebsiteSection: some View {
        Section(NSLocalizedString("Website Link", comment: "Label for Website section of user profile form.")) {
            TextField("https://jb55.com", text: .constant(""))
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
        }
    }

    var AboutMeSection: some View {
        Section(NSLocalizedString("Bio", comment: "Label for About Me section of user profile form.")) {
            ZStack(alignment: .topLeading) {
                TextEditor(text: .constant(""))
                    .frame(minHeight: 20, alignment: .leading)
                Text("Placeholder text")
                    .padding(.leading, 4)
                    .opacity(0.5)
                    .foregroundColor(Color(uiColor: .placeholderText))
            }
        }
    }

    var BitcoinLightningTipsSection: some View {
        Section(NSLocalizedString("Bitcoin Lightning Tips", comment: "Label for Bitcoin Lightning Tips section of user profile form.")) {
            TextField("Lightning Address or LNURL", text: .constant(""))
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
        }
    }

    var NostrAddressSection: some View {
        Section(content: {
            TextField("jb55@jb55.com", text: .constant(""))
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
        }, header: {
            Text("Nostr Address", comment: "Label for the Nostr Address section of user profile form.")
        })
    }
}

#Preview {
    EditProfileView()
}
