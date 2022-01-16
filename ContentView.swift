import SwiftUI

struct ContentView: View {
    @State private var currentRotation: Angle = .zero
    @State private var finalRotation: Angle = .zero
    
    @State private var rectPos1 = CGPoint(x:300, y:400)
    @State private var rectPos2 = CGPoint(x:600, y:400)
    @State private var rectPos3 = CGPoint(x:900, y:400)
    //@State private var rotationAngle = Angle(degrees: 0.0)
    
    @State var collision: Bool = false
    var body: some View {
        Text("Are they congruent triangles?")
            .font(.system(size: 60))
        Spacer()
        Spacer()
        Text("Drag and rotate the middle triangle to see if it overlaps with the others")
            .font(.system(size: 30))
        Spacer(minLength: 80)
        ZStack {
            Image("Image Asset")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .position(rectPos1)
                .rotationEffect(.degrees(45))
            
            Image("Image Asset")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .position(rectPos2)
                .gesture(DragGesture().onChanged({ value in
                    self.rectPos2 = value.location
                    self.checkCollision()
                }))
            
            //collision works
                .rotationEffect(currentRotation + finalRotation)
                .gesture(RotationGesture()
                            .onChanged { angle in
                    currentRotation = angle
                    self.checkCollision()
                }
                            .onEnded { angle in
                    finalRotation += currentRotation
                    currentRotation = Angle(degrees: 0)
                }
                         
                )
            if self.collision {
                Text("Overlaps 🤩")
                    .font(.system(size: 40))
            }
            
            Image("Image Asset2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .position(rectPos3)
                .rotationEffect(.degrees(-60))
            
        }
    }
    
    func checkCollision () {
        if abs(self.rectPos1.x - self.rectPos2.x) < 10 && abs(self.rectPos1.y - self.rectPos2.y) < 10 {
            self.collision = true
            print("Collision")
        }
        else {
            self.collision = false
            print ("rectPos1:", rectPos1," rectPos2:", rectPos2)
        }
    }
}
