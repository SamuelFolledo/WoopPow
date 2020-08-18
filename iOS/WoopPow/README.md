#  Woop Pow
Fighting game written in Swift using UIKit for most screens and SceneKit and SpriteKit for the Game screen.

### To Add New Attack/Move Controls
1. Go to `Models/Control/Attack/AttackType.swift`
2. Slide down to `AttackType extensions` where I have the enum like `None`, `Punch`, `Kick`
3. Create an enum similar to Punch or Kick's pattern and make sure you conform to `Attack` protocol
