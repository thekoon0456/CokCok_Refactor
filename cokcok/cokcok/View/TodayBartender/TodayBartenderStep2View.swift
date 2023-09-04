//
//  TodayBartenderStep2View.swift
//  cokcok
//
//  Created by Da Hae Lee on 2023/01/06.
//

import Foundation
import FirebaseAuth
import SwiftUI

struct TodayBartenderStep2View: View {
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @State var stepCounter: Int = 1
    @Binding var isShowing: Bool
    let beforeAnswer: String
    
    var body: some View {
        ZStack {
            Image("surveyBg2")
                .resizable()
                .aspectRatio(contentMode: .fill)
            VStack {    // 질문 답변 뷰
                Text(questionList[stepCounter])
                    .font(.title3)
                    .bold()
                    .padding(30)
                Spacer()
                
                ForEach(answerList[stepCounter], id:\.self) { answer in
                    NavigationLink {
                        TodayBartenderStep3View(stepCounter: stepCounter+1, isShowing: $isShowing, beforeAnswer: answer)
                    } label: {
                        Text(answer)
                            .modifier(BasicButtonModifier())
                    }
                }
                Spacer()
            }
            .navigationTitle("콕콕🍸")
            .onAppear {
                print("\(beforeAnswer)")
                profileViewModel.surveyAnswer.favoriteTaste.append(beforeAnswer)
                Task {
                    await profileViewModel.updateUserInfo(in: Auth.auth().currentUser?.uid, with: .userSurveyAnswer(value: .favoriteTaste(value: [beforeAnswer])))
                }
            }
        }
    }
}
