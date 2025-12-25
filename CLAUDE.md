# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Awaon Synth** is a sophisticated web-based software synthesizer distributed as a native macOS application. It uses the **iPlug2 framework** to create a WebView-based UI that communicates with a C++ digital signal processor in real-time.

## Architecture

```
macOS Native App (Awaon.app)
    ↓
iPlug2 WebView Container
    ↓
┌────────────────────────────┬─────────────────┐
│  Frontend (HTML/CSS/JS)    │  C++ DSP Backend│
│  - UI Controls & Rendering │  - Audio Engine │
│  - Parameter Management    │  - 80+ Params   │
└────────────────────────────┴─────────────────┘
         ↕ JSON Communication via SMMFD()
```

### Frontend Architecture (Web UI)

- **index.html** (1,623 lines) - Comprehensive synthesizer interface with 12-column CSS Grid layout
  - Master section: tuning, voice mode, output
  - 2× Oscillators (wavetable + transient shaper)
  - 2× Filters (VCF with 4 types) + Resonator
  - Effects: Delay, Chorus, Reverb
  - Modulation: 2× Envelopes, 2× LFOs, Modulation Matrix
  - Virtual MIDI keyboard (C0-C5 range)
  - Preset management system

- **script.js** (12,742 lines) - Frontend logic
  - Parameter mapping system (indices 0-80+) synchronized with C++ DSP
  - Event handlers for all UI controls
  - WebView bridge to C++ via `SMMFD(paramIndex, value)` function calls
  - Preset load/save/search functionality
  - Modulation matrix routing implementation
  - Canvas-based waveform visualization and routing patch display

- **styles.css** (4,445 lines) - Styling and layout
  - Theme system using CSS custom properties (--osc1-color, --filter-color, etc.)
  - Responsive grid layout
  - Custom form controls (sliders, toggles, buttons)

### Backend Architecture (Not in This Repo)

The C++ DSP engine (iPlug2-based) handles:
- Real-time audio synthesis and processing
- Parameter processing from 80+ mapped indices
- Audio I/O management
- Plugin format support (VST, AU)

**Note**: The C++ source and build system are in a separate iPlug2 project. This repository contains only the compiled application and web UI source.

## Key Concepts

### Parameter System

Parameters are indexed (0-80+) and must match between frontend and C++ DSP:

```javascript
// In script.js
const Params = {
  OSC1_WAVE: 0,
  OSC1_SEMI: 1,
  FILTER1_CUTOFF: 40,
  // ... etc
};

// Send to DSP:
SMMFD(Params.OSC1_WAVE, newValue);
```

When modifying the UI, ensure:
- Parameter indices are correct and match C++ Param enum
- All new controls have corresponding DSP parameter indices
- Preset system includes the new parameters

### Preset System

- Stored as JSON data structures
- Load/save/filter/search functionality in script.js
- Must include all 80+ parameters in save data

### Modulation Matrix

- Routes modulation sources (LFO1, LFO2, Envelope1, Envelope2) to destinations
- Visualization shown in routing patch display
- Hard-wired default: LFO1 → OSC1 (depth mismatch issue noted below)

## Known Issues & Development Notes

**Priority Issues** (from PARAMETER_ISSUES.md):

1. **LFO Depth Mismatch** (High)
   - GUI displays 0% when LFO is off, but DSP runs at 20%/30%
   - Matrix has default LFO→OSC1 routing not visible in UI

2. **Voice Number Mismatch** (High)
   - GUI shows 16 voices available, but DSP currently runs monophonic
   - Voice mode parameter needs synchronization (Mono → Poly/Unison)

3. **Voicing Mode** (Medium)
   - Default mode is Mono, but Poly would be more expected for a synth

4. **Filter Mix Unimplemented** (Low)
   - No parallel routing option; filters always serial-connected

5. **Matrix LFO Split** (Medium)
   - UI shows one LFO source, DSP has separate LFO1/LFO2 indices

## Development Workflow

**To modify the synthesizer:**

1. **UI/UX changes**: Edit `Contents/Resources/web/index.html` (layout, controls, appearance)
2. **Interactivity**: Add JavaScript handlers to `script.js` and ensure parameters map to DSP indices
3. **Styling**: Modify `Contents/Resources/web/styles.css` (use CSS variables for themes)
4. **Audio features**: Requires editing C++ DSP code (in separate iPlug2 project)

**Building and Distributing:**

1. Modify web UI as needed
2. Rebuild app using iPlug2 build system (not in this repo)
3. Code-sign macOS binary (Contents/MacOS/Awaon)
4. Package as zip (Awaon-0.0.1.zip)
5. Distribute via GitHub Releases or website

## File Structure

```
awaon-synth/
├── build/
│   └── Awaon-0.0.1.zip          (Packaged macOS app bundle)
│       └── Awaon.app/
│           └── Contents/Resources/web/
│               ├── index.html    (Main UI)
│               ├── script.js     (Frontend logic)
│               ├── styles.css    (Styling)
│               ├── Fonts/        (Custom & system fonts)
│               └── Assets/       (Images, logos)
├── src/                          (Intended for source code storage)
├── README.md
├── CLAUDE.md                     (This file)
└── .gitignore
```

## Credits & Licensing

- **Developer**: Leo Kuroshita (Hügelton Instruments, Kōbe, Japan)
- **Copyright**: © Hügelton Instruments
- **Contributions**: Plaits algorithms by Emilie Gillet (MIT), Electrosmith Inc. (MIT)
- **Note**: License not explicitly stated; likely proprietary

## Resources

- **iPlug2 Documentation**: https://github.com/IPlug2/IPlug2
- **Web Audio API**: https://developer.mozilla.org/en-US/docs/Web/API/Web_Audio_API
- **CSS Grid**: https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Grid_Layout
