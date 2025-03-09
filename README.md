# 🔒 Locker Security System

A digital locker security system implemented in VHDL that allows users to set and enter a 3-digit hexadecimal PIN to secure their belongings.


## 📋 Overview

This project implements a secure digital locking mechanism that could be used in various applications such as mall lockers, gym lockers, or any storage units requiring PIN-based security. The system uses a 3-digit hexadecimal PIN (0-9, A-F) with a simple user interface that guides users through the PIN creation and verification process.

### Features

- 🔢 3-digit hexadecimal PIN entry and verification
- 🔄 Visual feedback through Seven-Segment Display (SSD)
- 💡 LED indicators for locker status (locked/unlocked)
- 🔄 PIN reset functionality
- 📱 Debounced input buttons for reliable operation
- ⚡ Implemented entirely in VHDL for FPGA deployment

## 🛠️ Components

The system consists of several key components:

1. **Frequency Divider**: Divides the clock frequency to create visual effects like blinking digits
2. **Debouncer**: Filters out button bounce to ensure reliable input
3. **Counter**: Used by the debouncer and frequency divider
4. **D Flip-Flop**: Core component for storing state
5. **Code Selector**: Main logic for PIN setting and verification
6. **SSD Controller**: Manages the Seven-Segment Display output
7. **Main Circuit**: Top-level module connecting all components

## 🚀 Setup Instructions

### Prerequisites

- ✅ Xilinx Vivado IDE
- ✅ FPGA development board (tested on Basys3/Nexys boards)
- ✅ USB cable for programming

### Installation Steps

1. 📥 **Clone or download** this repository to your local machine
2. 🖥️ **Open Vivado** and create a new project
3. 📂 **Add all VHDL files** to your project
4. 🔨 **Set circuit.vhd** as the top-level entity
5. 🧩 **Generate bitstream** after synthesis and implementation
6. 📤 **Program** your FPGA board with the generated bitstream

## 🎮 How to Use

### Button Configuration

- **UP Button**: Increment the current digit (0→1→...→F)
- **DOWN Button**: Decrement the current digit (F→E→...→0)
- **SEL Button**: Confirm current digit and move to the next
- **RESET Button**: Clear all settings and start over

### Operation Steps

#### Setting a PIN
1. 🆕 Start with an empty locker (SSD displays "OPEN")
2. 📝 Press SEL to begin PIN creation
3. ⬆️/⬇️ Use UP/DOWN to select the first digit (will flash)
4. ✅ Press SEL to confirm and move to the second digit
5. 🔄 Repeat for all three digits
6. 🔒 After the third digit is confirmed, the locker is locked (LED lights up)

#### Unlocking with PIN
1. 🔐 Press SEL to begin PIN entry
2. 🎮 Enter the same 3-digit PIN using UP/DOWN and SEL
3. ✅ If PIN matches, the locker unlocks
4. ❌ If PIN does not match, you must try again

## 📊 System Architecture

```
                 ┌─────────────┐
                 │ User Inputs │
                 └──────┬──────┘
                        │
        ┌───────────────┼───────────────┐
        │               │               │
┌───────▼───────┐ ┌─────▼─────┐ ┌───────▼───────┐
│   Debouncer   │ │ Frequency │ │  Code Selector│
│   Circuits    │ │  Divider  │ │   (Main FSM)  │
└───────┬───────┘ └─────┬─────┘ └───────┬───────┘
        │               │               │
        └───────────────┼───────────────┘
                        │
                 ┌──────▼──────┐
                 │  SSD Driver │
                 └──────┬──────┘
                        │
                 ┌──────▼──────┐
                 │    Output   │
                 │  (Display & │
                 │    LEDs)    │
                 └─────────────┘
```

## 🧪 Technical Details

- Clock frequency: Board clock divided by 25,000,000 for visual effects
- Hexadecimal range: 16 values (0-9, A-F) per digit
- SSD multiplexing: Uses time-division multiplexing for display
- PIN storage: Using internal signals and registers
- Reset functionality: Asynchronous reset available at any time

## 🔜 Potential Enhancements

- Hexadecimal keyboard for faster PIN entry
- Digital display with graphical user interface
- RFID tag support for alternative access method
- Master key functionality for emergency access
- Haptic feedback for button presses
- Accessibility features (Braille, audio feedback)
- Maintenance mode indication

## 👥 Contributors

- Palacian Bogdan-Tudor
- Tianu Cosmin-Nicolae


---

Project developed as part of the DSD (Digital System Design) course at the Faculty of Automation and Computer Science, Technical University of Cluj-Napoca, 2023.
