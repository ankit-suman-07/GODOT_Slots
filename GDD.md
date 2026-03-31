# Slot Machine Game – Game Design Document (GDD)

## 1. Overview
A simple 3-reel slot machine game built in Godot using GDScript. The game simulates classic slot mechanics including betting, spinning reels, random outcomes, and reward payouts based on symbol combinations. The focus is on core gameplay logic rather than graphics or advanced UI.

---

## 2. Core Gameplay Loop
1. Player selects a bet amount  
2. Player presses **Spin**  
3. Reels animate (spinning effect)  
4. Final symbols are displayed  
5. Winning logic is evaluated  
6. Player receives payout (or loses bet)  
7. Repeat until balance is depleted or player exits  

---

## 3. Symbols
| Index | Symbol  | Description       |
|------|--------|-------------------|
| 0    | SEVEN  | Highest value     |
| 1    | STAR   | High value        |
| 2    | CHERRY | Medium value      |
| 3    | LEMON  | Low value         |
| 4    | BELL   | Lowest value      |
| 5    | WILD   | Special symbol    |

---

## 4. Multipliers
| Symbol  | Multiplier |
|--------|-----------|
| SEVEN  | 25x       |
| STAR   | 15x       |
| CHERRY | 10x       |
| LEMON  | 5x        |
| BELL   | 2x        |
| WILD   | 1x        |

---

## 5. Winning Rules

### Full Match (3 Same)
- Player wins **bet × multiplier**

### Partial Match (2 Same)
- If third symbol is **WILD** → full multiplier  
- Otherwise → **50% of multiplier**

### Special Case
- **WILD WILD WILD → "Spin Again"**
  - No payout
  - Player gets a free spin

### No Match
- Player loses bet

---

## 6. Betting System
- Fixed bet options: **5, 25, 50, 100, 250**
- Player balance decreases when bet is placed
- Winnings are added after each spin
- Player cannot spin without placing a bet

---

## 7. Randomization
- Each reel uses weighted randomness:
```text
Weights: [2, 2, 4, 4, 2, 3]
```
- Higher weight → higher probability of appearing
- Each reel is generated independently
- Ensures a mix of common and rare symbols for balanced gameplay

---

## 8. UI Elements
- 3 Slot reels (left, middle, right)
- Spin button
- Bet selection buttons (5, 25, 50, 100, 250)
- Total balance display
- Round result display (win/lose/spin again)
- Control buttons:
    -   Restart
    -   Exit

---

## 9. Audio & Feedback

### Sounds Used
- Spinning Sound
    - Plays while reels are animating
- Stop Sound
    - Plays when reels stop
- Win Sound
    - Triggered on successful payout
- Click Sound
    - Plays on button interactions

### Visual Feedback

- Rapid symbol changes during spin (simulated animation)
- Optional delay between reel stops for realism
- Dynamic text updates:
    - "Spinning..."
    - "You won: X"
    - "No Win"
    - "Spin Again"

---

## 10. Game States
- **Idle** → Waiting for player input
- **Bet** Placed → Player selects a bet
- **Spinning** → Reels are animating
- **Result** → Outcome is calculated and displayed
- **Bonus(Spin Again)** → Triggered by WILD WILD WILD

---

## 11. Future Improvements

- 3D animations
- Smooth reel animation (instead of instant texture swaps)
- Enhanced sound effects based on win type
- Jackpot or progressive reward system
- Persistent player balance (save/load system)
- Improved UI/UX and visual polish
- Better probability tuning for realistic slot behavior

---

## 12. Technical Notes

- Built using Godot Engine (GDScript)
- Core logic separated into:
    - Spin generation
    - Win calculation
    - UI updates
- Uses RandomNumberGenerator for controlled randomness
- Uses async delays (await create_timer) for spin animation timing
- Structured to allow easy extension (features, UI, balancing)