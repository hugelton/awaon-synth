# Changelog

All notable changes to Awaon Synth are documented in this file.

## [0.0.1 Alpha] - 2025-12-26

### Added
- Initial alpha release of Awaon Synth
- Standalone macOS application (AU v3, VST3 coming soon)
- Software synthesizer with comprehensive modulation capabilities
- Real-time audio processing with iPlug2 framework
- GitHub Pages distribution site with bilingual support (Japanese/English)
- Language toggle for Japanese and English interfaces
- Auto dark mode detection with comprehensive dark mode styling
- Dynamic known issues display fetched from GitHub Issues API
- Automatic English translation of known issues and feature requests
- AppleScript-based preset installer for macOS
- Flat design interface (no shadows, gradients, or effects)

### Features
- LFO (Low Frequency Oscillator) modulation system with parameters:
  - Delay, Attack, Rate, Phase, Depth controls
- Filter modules (Filter 1/2) with resonance control
- Resonator with multiple modes (including Modal mode)
- Software pitch bend wheel with MIDI controller support
- Software keyboard for note input
- Preset system with Init.awaon initial preset
- Comprehensive UI with collapsible help sections:
  - Known Issues section with severity levels
  - Init Preset installation guide (macOS only)
  - Troubleshooting guide for launch issues

### Known Issues
1. **LFO1/2: Delay not working** - Delay parameter changes not reflected in audio output (High)
2. **Filter Resonance causes distortion** - High resonance settings cause audio clipping (High)
3. **Resonator Modal distortion** - Modal mode produces distortion at high frequencies (High)
4. **Software pitch bend MIDI sync** - External MIDI pitch bend not reflected in software wheel (High)

### Planned Features
- Software keyboard glissando/portamento support
- AU v3 plugin format support
- VST3 plugin format support
- Additional preset library
- Performance optimizations

### Known Limitations
- macOS only (11+) in current alpha release
- Plugin versions not yet available
- Some parameters may not work as expected
- Unexpected behavior or crashes may occur during normal use

### Technical Details
- Built with iPlug2 framework
- HTML/CSS/JavaScript frontend
- GitHub Pages hosting for distribution site
- Automated English translation via Claude AI
- Dark mode support with `@media (prefers-color-scheme: dark)`

### File Distribution
- **Awaon-0.0.1.dmg** (12.1 MB) - macOS standalone application
- **Init.awaon** - Initial preset file for the synthesizer
- **install-preset.scpt** - AppleScript for automated preset installation

---

For more information, visit the [GitHub repository](https://github.com/hugelton/awaon-synth) or the [distribution site](https://hugelton.github.io/awaon-synth).
