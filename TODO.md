# AniseikoniaHelper - App Store Relaunch Plan

## Context

Apple sent an **App Store Improvement Notice** (July 18, 2025) stating the app will be removed in 90 days unless an update is submitted. The app hasn't been updated in 3+ years and doesn't meet the minimum download threshold.

The app is a focused iPad diagnostic tool for optometrists — it helps measure **aniseikonia** (perceived size differences between the eyes) via interactive vertical and horizontal scale-comparison tests. ~1,000 lines of Swift/UIKit code, zero dependencies.

This is also an opportunity to rewrite from UIKit to **SwiftUI** as a learning exercise.

---

## Phase 0: Quickest Path Back to the Store (if needed)

If the 90-day deadline is tight and you want a safety net, you can do a minimal-effort submission _before_ the full SwiftUI rewrite. This buys time.

- [ ] Open project in latest Xcode, fix any build errors
- [ ] Update deployment target from iOS 10.2 to iOS 16.0+
- [ ] Remove `armv7` from `UIRequiredDeviceCapabilities` in Info.plist (Apple dropped 32-bit in iOS 11)
- [ ] Update `CFBundleShortVersionString` to `2.0` and `CFBundleVersion` to `3`
- [ ] Fix deprecated `contentEdgeInsets` usage (deprecated iOS 15+) — use `configuration` based buttons instead, or suppress for now
- [ ] Fix `protocol ... : class` → `protocol ... : AnyObject` (2 occurrences)
- [ ] Verify the "Learn More" PDF link still works: `https://www.drdrbill.com/downloads/optics/refraction/Aniseikonia.pdf`
- [ ] Update signing to current team/certificates
- [ ] Archive & submit to App Store Connect
- [ ] Add a privacy manifest (`PrivacyInfo.xcprivacy`) — required since Spring 2024

> **Skip Phase 0 if** you have enough runway to go straight to the SwiftUI rewrite.

---

## Phase 1: Project Setup (SwiftUI Rewrite)

- [ ] Create a new Xcode project targeting iOS 17.0+ (SwiftUI lifecycle, iPad)
- [ ] Set up the project with SwiftUI App lifecycle (`@main`, `App` protocol) — no more `AppDelegate` / `UIApplicationMain`
- [ ] Configure for landscape-only iPad (set in project settings + Info.plist)
- [ ] Set bundle ID to `com.laus102.AniseikoniaHelper` (same as existing, to keep App Store listing)
- [ ] Add a privacy manifest (`PrivacyInfo.xcprivacy`)
- [ ] Set up git — either a new branch on this repo or a fresh repo

---

## Phase 2: Core Data Model & Shared Logic

The app's logic is simple enough that models are lightweight, but worth defining cleanly.

- [ ] Create `DiagramDirection` enum (`.left`, `.right`, `.top`, `.bottom`) — port from `UIExtensions.swift`
- [ ] Create `TestOrientation` enum (`.vertical`, `.horizontal`)
- [ ] Define the app's color palette as SwiftUI `Color` extensions (AHGreen, AHRed, AHLightGray) — port from `UIExtensions.swift`
- [ ] Create a shared `TestViewModel` (or separate `VerticalTestViewModel` / `HorizontalTestViewModel`) as `@Observable` classes
  - Holds slider value, computed scale percentages for each eye
  - Port the scale math from `scaleAdjustSliderValueChanged` / `scaleAdjustmentSliderValueChanged`

---

## Phase 3: Diagram View (Canvas / Shape)

This is the most interesting SwiftUI learning opportunity — the custom `DiagramComponentView` currently uses Core Graphics (`draw(_ rect:)`). In SwiftUI, you'll use `Canvas` or `Shape`.

- [ ] Rewrite `DiagramComponentView` as a SwiftUI `Shape` or use `Canvas` for the drawing
  - Outline lines (3-sided open rectangle)
  - Big hash marks (4 pairs, evenly spaced from each end)
  - Small hash marks (5 pairs, from the center outward with alternating sizes)
  - Center circle (currently commented out — decide whether to include)
- [ ] Support both vertical and horizontal orientations via a parameter
- [ ] Support color (red vs green) via a parameter
- [ ] Support scale transforms (the `adjust(scale:diagramOrientation:)` method) — in SwiftUI this becomes `.scaleEffect()` and/or `GeometryReader`
- [ ] Support mirroring (left diagram is reflected across Y-axis; bottom diagram reflected across X-axis) — `.scaleEffect(x: -1)` in SwiftUI

**SwiftUI concepts you'll use here:**
- `Shape` protocol and `path(in rect:)` — direct analog to `draw(_ rect:)`
- `Canvas` — for more complex/performance-sensitive drawing
- `GeometryReader` — to get the parent size for proportional layout
- `.scaleEffect()` — replaces `CGAffineTransform`

---

## Phase 4: Test Screens

- [ ] Build `VerticalTestView`
  - Two `DiagramView`s side by side (left = red/mirrored, right = green)
  - A `Slider` (rotated 90 degrees via `.rotationEffect`) controlling scale
  - Two `PillLabel`-style readout labels showing `+X%` / `-X%`
  - "Switch to Horizontal" button
  - "Learn More" button → opens `SFSafariViewController` or `.sheet` with a `WebView`
  - Tap-to-reset gesture on the slider

- [ ] Build `HorizontalTestView`
  - Two `DiagramView`s stacked vertically (top = green, bottom = red/mirrored)
  - Same slider, readout, and button pattern as vertical
  - "Switch to Vertical" button

- [ ] Wire up navigation between the two tests
  - In SwiftUI: `TabView`, `NavigationStack` with programmatic navigation, or a simple state toggle
  - The custom slide transitions from `TransitionAnimator.swift` can be replicated with `.transition()` and `matchedGeometryEffect`

---

## Phase 5: Splash Screen / Onboarding

- [ ] Recreate the splash/welcome screen
  - "Welcome to Aniseikonia Helper" with styled attributed text (red highlight on "Aniseikonia Helper")
  - In SwiftUI: use `Text` with `+` concatenation or `AttributedString`
  - Fade-in description, then fade-out to test view
  - `.onAppear` + `withAnimation` + state-driven transitions

---

## Phase 6: Polish & App Store Requirements

- [ ] App icon — verify existing icon assets cover all required sizes for modern Xcode (1024x1024 single icon in Xcode 15+)
- [ ] Add a proper `LaunchScreen` (can be a simple storyboard or SwiftUI-based in modern Xcode)
- [ ] Handle iPad multitasking / different window sizes gracefully (even if you require full screen)
- [ ] Add an app description / "About" section if the doctors want it
- [ ] Ensure accessibility basics: VoiceOver labels on the slider, diagram descriptions, button labels
- [ ] Test on physical iPad devices (the scale comparison is the whole point — simulator may not be sufficient for the doctors to validate)

---

## Phase 7: App Store Submission

- [ ] Update App Store Connect metadata (screenshots, description, keywords)
- [ ] Take new iPad screenshots (show both vertical and horizontal tests)
- [ ] Update the app's privacy policy URL if required
- [ ] Set the correct app category (Medical? Utilities?)
- [ ] Submit for review
- [ ] Respond to any review feedback

---

## Architecture Comparison: UIKit vs SwiftUI

| UIKit (current) | SwiftUI (target) |
|---|---|
| `AppDelegate` + `UIWindow` | `@main struct App: App` + `WindowGroup` |
| `UIStoryboard` + `UIViewController` | SwiftUI `View` structs |
| `Router` + `UINavigationController` | `NavigationStack` or state-driven view switching |
| `DiagramComponentView.draw(_:)` (Core Graphics) | `Shape.path(in:)` or `Canvas` |
| `CGAffineTransform` for scale/mirror | `.scaleEffect()` modifier |
| `UISlider` + `IBAction` | SwiftUI `Slider` + `@Binding` |
| `TransitionAnimator` (custom `UIViewControllerAnimatedTransitioning`) | `.transition()` + `.animation()` |
| `PillButton` / `PillLabel` (UIView subclasses) | SwiftUI `Button` / `Text` with `.clipShape(Capsule())` |
| `@IBOutlet` / `@IBAction` | `@State` / `@Binding` / `@Observable` |
| Delegate protocols for navigation | Closures, `@Environment`, or `NavigationStack` |
| `SFSafariViewController` | `SafariView` wrapper or `.sheet` with `Link` |
| `DispatchQueue.main.async` + `UIView.animate` | `withAnimation` + `.onAppear` |

---

## Key Files to Port (priority order)

1. **`DiagramComponentView.swift`** (200 lines) — the core drawing logic, most educational SwiftUI value
2. **`VerticalTestViewController.swift`** (170 lines) — main test screen
3. **`HorizontalTestViewController.swift`** (135 lines) — second test screen
4. **`UIExtensions.swift`** (47 lines) — colors, enums
5. **`TransitionAnimator.swift`** (70 lines) — custom transitions
6. **`Router.swift`** (77 lines) — navigation (replaced by SwiftUI navigation)
7. **`SplashScreen.swift`** / **`StartUpViewController.swift`** — splash/onboarding
8. **`AppDelegate.swift`** — replaced entirely by SwiftUI App lifecycle

---

## Notes

- The codebase is small (~1,000 lines) — a full SwiftUI rewrite is very doable
- Zero third-party dependencies makes this clean to port
- The `DiagramComponentView` Core Graphics code maps almost 1:1 to SwiftUI's `Shape` protocol — great learning exercise
- The "Learn More" link points to an external PDF (`drdrbill.com`) — verify it still exists before shipping
- The `TestSelectViewController.swift` file is fully commented out — it's dead code from a previous design iteration, can be ignored
- The `StartUpViewControllerExtensions.swift` is an empty extension — also dead code
