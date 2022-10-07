//
//  ContentView.swift
//  OnboardingScreen
//
//  Created by Can on 8.10.2022.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        if currentPage > totalPages {
            Home()
        } else {
            WalkthroughScreen()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Home Page
struct Home: View {
    var body: some View {
        Text("Welcome Home!")
            .font(.title)
            .fontWeight(.heavy)
    }
}

// Walkthrough Screen
struct WalkthroughScreen: View {
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        // For Slide Animation
        
        ZStack {
            // Change between views
            
            if currentPage == 1 {
                ScreenView(image: "Launch",
                           title: "Step 1",
                           detail: "",
                           bgColor: Color("color1"))
                .transition(.slide)
            }
            
            if currentPage == 2 {
                ScreenView(image: "Hiring",
                           title: "Step 2",
                           detail: "",
                           bgColor: Color("color1"))
                .transition(.opacity)
            }
            
            if currentPage == 3 {
                ScreenView(image: "Podcast",
                           title: "Step 3",
                           detail: "",
                           bgColor: Color(red: 0.867, green: 0.657, blue: 0.794))
                .transition(.scale)
            }
        }
        .overlay(alignment: .bottom, content: {
            Button(action: {
                // change screens
                withAnimation(.easeInOut) {
                    // checking
                    if currentPage <= totalPages {
                        currentPage += 1
                    } else {
                        currentPage = 1
                    }
                }
            }) {
                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .clipShape(Circle())
                    // Circular slider
                    .overlay {
                        ZStack {
                            Circle()
                                .stroke(Color.black.opacity(0.4), lineWidth: 4)
                            
                            Circle()
                                .trim(from: 0,
                                      to: CGFloat(currentPage) / CGFloat(totalPages))
                                .stroke(Color.white, lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                        }
                        .padding(-15)
                    }
            }
            .padding(.bottom, 20)
        })
    }
}

struct ScreenView: View {
    var image: String
    var title: String
    var detail: String
    var bgColor: Color
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                // Show for first page only
                
                if currentPage == 1 {
                    Text("Hello Member")
                        .font(.title)
                        .fontWeight(.semibold)
                        .kerning(1.4)
                } else {
                    // Back Button
                    Button(action: {
                        withAnimation(.easeInOut) {
                            currentPage -= 1
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                    }
                }
                
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut) {
                        currentPage = 4
                    }
                }) {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .kerning(1.2)
                }
            }
            .foregroundColor(.black)
            .padding()
            
            Spacer()
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(title)
                .font(.title)
                .font(.body)
                .foregroundColor(.black)
                .padding(.top)
            
            // detail
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                .fontWeight(.semibold)
                .kerning(1.3)
                .multilineTextAlignment(.center)
            
            Spacer(minLength: 120)
        }
        .background(bgColor.cornerRadius(10).ignoresSafeArea())
    }
}

var totalPages = 3
