# Animation Practice Guide - Fitness Tracker App

This guide tells you **where** and **what** animation to add in each file.
Start from the top (easiest) and work your way down.

---

## Level 1: Implicit Animations (Easiest - No Controller Needed)

These are the simplest animations in Flutter. You just swap a normal widget
with its "Animated" version, give it a `duration`, and Flutter handles the rest.

---

### 1. Goal Progress Bar — AnimatedContainer

**File:** `lib/widgets/goal_card.dart`

**Where:** The `LinearProgressIndicator` that shows goal progress.

**What to do:**
- Replace the `ClipRRect` + `LinearProgressIndicator` with an `AnimatedContainer`
- Give it a fixed height (like 8)
- Set its width as a fraction of the parent width based on progress
- Set `duration: Duration(milliseconds: 500)`
- Set `curve: Curves.easeInOut`
- When the user taps "+ Add Progress", the bar will smoothly grow

**Widget to use:** `AnimatedContainer`

**Hint:**
```dart
AnimatedContainer(
  duration: Duration(milliseconds: 500),
  curve: Curves.easeInOut,
  height: 8,
  width: maxWidth * progress,  // use LayoutBuilder to get maxWidth
  decoration: BoxDecoration(
    color: progressColor,
    borderRadius: BorderRadius.circular(4),
  ),
)
```

---

### 2. Workout Card Expand/Collapse — AnimatedCrossFade

**File:** `lib/widgets/workout_card.dart`

**Where:** The expanded section that shows exercises when you tap a card.

**What to do:**
- Currently the exercises section just appears/disappears instantly
- Wrap it in `AnimatedCrossFade`
- First child: empty SizedBox (collapsed state)
- Second child: the exercises column (expanded state)
- crossFadeState: based on isExpanded

**Widget to use:** `AnimatedCrossFade`

**Hint:**
```dart
AnimatedCrossFade(
  duration: Duration(milliseconds: 300),
  firstChild: SizedBox.shrink(),
  secondChild: _buildExercisesList(),
  crossFadeState: isExpanded
      ? CrossFadeState.showSecond
      : CrossFadeState.showFirst,
)
```

---

### 3. Stat Cards — AnimatedOpacity

**File:** `lib/screens/dashboard_page.dart`

**Where:** The 3 stat cards (Steps, Distance, Heart Rate).

**What to do:**
- Convert DashboardPage to a StatefulWidget
- Add a bool `_visible = false`
- In initState, use `Future.delayed(Duration(milliseconds: 300))` to set `_visible = true`
- Wrap each StatCard row in `AnimatedOpacity`
- When page loads, the cards will fade in

**Widget to use:** `AnimatedOpacity`

**Hint:**
```dart
AnimatedOpacity(
  opacity: _visible ? 1.0 : 0.0,
  duration: Duration(milliseconds: 600),
  child: Row(children: [ ... stat cards ... ]),
)
```

---

### 4. Expand Arrow Icon — AnimatedRotation

**File:** `lib/widgets/workout_card.dart`

**Where:** The trailing arrow icon on the workout card.

**What to do:**
- Replace the static Icon with `AnimatedRotation`
- When expanded, rotate 0.5 turns (180 degrees)
- When collapsed, rotate 0 turns

**Widget to use:** `AnimatedRotation`

**Hint:**
```dart
AnimatedRotation(
  turns: isExpanded ? 0.5 : 0.0,
  duration: Duration(milliseconds: 300),
  child: Icon(Icons.expand_more, color: Colors.white),
)
```

---

## Level 2: Explicit Animations (Need AnimationController)

These give you full control. You create an `AnimationController`,
mix in `TickerProviderStateMixin`, and drive the animation yourself.

---

### 5. Activity Rings — TweenAnimationBuilder

**File:** `lib/widgets/activity_ring.dart`

**Where:** The CircularProgressIndicator value.

**What to do:**
- Convert ActivityRing to use `TweenAnimationBuilder<double>`
- Tween from 0.0 to the actual value
- Duration of 1 second
- The ring will fill up from 0 to target when the page loads

**Widget to use:** `TweenAnimationBuilder`

**Hint:**
```dart
TweenAnimationBuilder<double>(
  tween: Tween(begin: 0.0, end: value),
  duration: Duration(milliseconds: 1000),
  curve: Curves.easeOut,
  builder: (context, animatedValue, child) {
    return CircularProgressIndicator(
      value: animatedValue,
      // ... rest of your code
    );
  },
)
```

---

### 6. Timer Pulse Effect — AnimationController + ScaleTransition

**File:** `lib/screens/timer_page.dart`

**Where:** The countdown timer text.

**What to do:**
- Add `TickerProviderStateMixin` to the State class
- Create an AnimationController that repeats (pulse effect)
- Create a Tween from 1.0 to 1.05 (subtle scale)
- Wrap the timer text in `ScaleTransition`
- Start the animation when timer is running, stop when paused

**Widgets to use:** `AnimationController`, `Tween`, `ScaleTransition`

**Hint:**
```dart
late AnimationController _pulseController;
late Animation<double> _pulseAnimation;

@override
void initState() {
  super.initState();
  _pulseController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 800),
  );
  _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
    CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
  );
}

// When timer starts:
_pulseController.repeat(reverse: true);

// When timer pauses:
_pulseController.stop();

// In build:
ScaleTransition(
  scale: _pulseAnimation,
  child: Text(_formatTime(_remainingSeconds), ...),
)
```

---

### 7. Timer Color Change — ColorTween + AnimatedBuilder

**File:** `lib/screens/timer_page.dart`

**Where:** The timer text color.

**What to do:**
- The timer text should change color from green to red as time runs out
- Use the remaining time ratio to interpolate the color
- You can use `Color.lerp(Colors.greenAccent, Colors.redAccent, 1 - ratio)`
- This doesn't even need an AnimationController — just calculate color in build

**Simple approach (no controller):**
```dart
Color _getTimerColor() {
  double ratio = _remainingSeconds / _totalSeconds;
  return Color.lerp(Colors.redAccent, Colors.greenAccent, ratio)!;
}
```

---

## Level 3: Page Transitions & Hero (Intermediate)

---

### 8. Hero Animation — Workout Icon

**File:** `lib/widgets/workout_card.dart` AND `lib/screens/timer_page.dart`

**Where:** The workout icon on the card and the icon on the timer page.

**What to do:**
- Wrap the workout icon in the card with `Hero(tag: 'workout-icon-$name')`
- Wrap the workout icon in timer_page with the same Hero tag
- When navigating to timer page, the icon will fly from the card to the center

**Widget to use:** `Hero`

**Hint:**
```dart
// In workout_card.dart:
Hero(
  tag: 'workout-${workout.name}',
  child: CircleAvatar(
    child: Icon(workout.icon),
  ),
)

// In timer_page.dart (same tag):
Hero(
  tag: 'workout-${widget.workout.name}',
  child: Icon(widget.workout.icon, size: 60),
)
```

---

### 9. Custom Page Transition — SlideTransition

**File:** `lib/screens/workouts_page.dart`

**Where:** The Navigator.push to TimerPage.

**What to do:**
- Replace `MaterialPageRoute` with `PageRouteBuilder`
- Add a slide-from-bottom transition
- The timer page will slide up instead of the default transition

**Widget to use:** `PageRouteBuilder`, `SlideTransition`

**Hint:**
```dart
Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return TimerPage(workout: workout);
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        )),
        child: child,
      );
    },
  ),
);
```

---

### 10. Staggered List Animation — Dashboard Recent Activity

**File:** `lib/screens/dashboard_page.dart`

**Where:** The 3 recent activity ListTile cards.

**What to do:**
- Make each card slide in from the right with a slight delay between them
- Use `AnimationController` + `Interval` for staggered timing
- First card appears at 0.0-0.4, second at 0.2-0.6, third at 0.4-0.8

**Widgets to use:** `AnimationController`, `SlideTransition`, `Interval`

**This is the hardest one — try it last!**

---

## Checklist

Use this to track your progress:

- [ ] 1. Goal Progress Bar (AnimatedContainer)
- [ ] 2. Workout Card Expand (AnimatedCrossFade)
- [ ] 3. Stat Cards Fade In (AnimatedOpacity)
- [ ] 4. Expand Arrow Rotation (AnimatedRotation)
- [ ] 5. Activity Rings Fill (TweenAnimationBuilder)
- [ ] 6. Timer Pulse (AnimationController + ScaleTransition)
- [ ] 7. Timer Color Change (Color.lerp)
- [ ] 8. Hero Icon (Hero widget)
- [ ] 9. Custom Page Transition (PageRouteBuilder)
- [ ] 10. Staggered List (AnimationController + Interval)

---

## Tips

- Always add `duration` to implicit animations
- Use `Curves.easeInOut` as your default curve — it looks smooth
- When using AnimationController, always dispose it in `dispose()`
- Add `with TickerProviderStateMixin` when using AnimationController
- Test one animation at a time — don't try to add all at once
- If something breaks, check that your State class has the right mixins
