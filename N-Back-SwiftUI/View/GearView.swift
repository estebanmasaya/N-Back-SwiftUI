//
//  Gear.swift
//  N-Back-SwiftUI
//
//  Created by Esteban Masaya on 2023-11-18.
//

import SwiftUI

struct GearView: View {
    var wide = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    var body: some View {
        ZStack {
            Circle().foregroundColor(Color(red: 66/255, green: 139/255, blue: 221/255))

            Image(systemName: "gearshape.circle.fill").font(.system(size: wide * 0.08))
                .foregroundColor(Color(red: 196/255, green: 216/255, blue: 239/255))
        }
        .frame(width: wide * 0.1, height: wide * 0.1, alignment: .center)
    }
}

struct Gear_Previews: PreviewProvider {
    static var previews: some View {
        GearView()
    }
}
