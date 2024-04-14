//
//  ResourcesView.swift
//  InMemory
//
//  Created by Summer Hasama on 4/13/24.
//

import SwiftUI

struct ResourcesView: View {
    var background: Background // Accepts a Background enum

    var body: some View {
        ZStack {
            background.makeGradient() // Apply the background gradient based on the enum

            var textColor: Color {
                    return background == .nighttime ? .white : .black
                }

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    Text("Coping With Loss")
                        .font(.custom("Gill Sans", size: 30))
                        .foregroundColor(textColor)

                    // Display each paragraph with the first sentence bolded
                    ParagraphView(
                        firstSentence: "Take care of yourself.",
                        remainingText: "Try to exercise regularly, eat healthy food, and get enough sleep. " +
                            "Avoid habits that can put your health at risk, like drinking too much alcohol or smoking."
                    ).foregroundColor(textColor)

                    ParagraphView(
                        firstSentence: "Talk with caring friends.",
                        remainingText: "Let others know if you need to talk."
                    ).foregroundColor(textColor)

                    ParagraphView(
                        firstSentence: "Try not to make any major changes right away.",
                        remainingText: "It’s a good idea to wait for a while before making big decisions, like moving or changing jobs."
                    ).foregroundColor(textColor)

                    ParagraphView(
                        firstSentence: "Join a grief support group in person or online.",
                        remainingText: "It might help to talk with others who are also grieving. " +
                            "Check with your local hospice, hospitals, religious communities, and government agencies to find a group in your area."
                    ).foregroundColor(textColor)

                    ParagraphView(
                        firstSentence: "Consider professional support.",
                        remainingText: "Sometimes talking to a counselor about your grief can help."
                    ).foregroundColor(textColor)

                    ParagraphView(
                        firstSentence: "Talk to your doctor.",
                        remainingText: "Be sure to let your healthcare provider know if you’re having trouble with everyday activities, like getting dressed, sleeping, or fixing meals."
                    ).foregroundColor(textColor)

                    ParagraphView(
                        firstSentence: "Be patient with yourself.",
                        remainingText: "Mourning takes time. It’s common to feel a mix of emotions for a while."
                    ).foregroundColor(textColor)

                    Text("Source: NIH")
                        .underline()
                        .foregroundColor(background == .nighttime ? .black : .blue)
                        .onTapGesture {
                            if let url = URL(string: "https://newsinhealth.nih.gov/2017/10/coping-grief") {
                                UIApplication.shared.open(url)
                            }
                        }
                }
                .padding()
            }
            .padding(20)
        }
        .ignoresSafeArea()
    }
}

// Preview
struct ResourcesView_Previews: PreviewProvider {
    static var previews: some View {
        ResourcesView(background: .nighttime) // Example usage with daytime background
    }
}

struct ParagraphView: View {
    var firstSentence: String
    var remainingText: String

    var body: some View {
        VStack(alignment: .leading) {
                    Text(firstSentence)
                        .bold()
                        .font(.custom("Gill Sans", size: 18))
                        .multilineTextAlignment(.leading)
                    Text(remainingText)
                        .font(.custom("Gill Sans", size: 18))
                        .multilineTextAlignment(.leading)
        }
    }
}
