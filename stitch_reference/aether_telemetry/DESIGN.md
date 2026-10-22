---
name: Aether Telemetry
colors:
  surface: '#051424'
  surface-dim: '#051424'
  surface-bright: '#2c3a4c'
  surface-container-lowest: '#010f1f'
  surface-container-low: '#0d1c2d'
  surface-container: '#122131'
  surface-container-high: '#1c2b3c'
  surface-container-highest: '#273647'
  on-surface: '#d4e4fa'
  on-surface-variant: '#bdc8d1'
  inverse-surface: '#d4e4fa'
  inverse-on-surface: '#233143'
  outline: '#87929a'
  outline-variant: '#3e484f'
  surface-tint: '#7bd0ff'
  primary: '#8ed5ff'
  on-primary: '#00354a'
  primary-container: '#38bdf8'
  on-primary-container: '#004965'
  inverse-primary: '#00668a'
  secondary: '#4fdbc8'
  on-secondary: '#003731'
  secondary-container: '#04b4a2'
  on-secondary-container: '#003f38'
  tertiary: '#52e87c'
  on-tertiary: '#003915'
  tertiary-container: '#2ccb63'
  on-tertiary-container: '#004f20'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#c4e7ff'
  primary-fixed-dim: '#7bd0ff'
  on-primary-fixed: '#001e2c'
  on-primary-fixed-variant: '#004c69'
  secondary-fixed: '#71f8e4'
  secondary-fixed-dim: '#4fdbc8'
  on-secondary-fixed: '#00201c'
  on-secondary-fixed-variant: '#005048'
  tertiary-fixed: '#6bff8f'
  tertiary-fixed-dim: '#4ae176'
  on-tertiary-fixed: '#002109'
  on-tertiary-fixed-variant: '#005321'
  background: '#051424'
  on-background: '#d4e4fa'
  surface-variant: '#273647'
typography:
  headline-xl:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-xl-mobile:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.01em
  headline-lg:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 26px
    letterSpacing: -0.01em
  headline-sm:
    fontFamily: Inter
    fontSize: 15px
    fontWeight: '600'
    lineHeight: 22px
    letterSpacing: 0em
  metric-display:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '500'
    lineHeight: 32px
    letterSpacing: -0.02em
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
    letterSpacing: 0em
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
    letterSpacing: 0em
  body-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 18px
    letterSpacing: 0.01em
  label-md:
    fontFamily: Inter
    fontSize: 13px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.01em
  label-sm:
    fontFamily: Inter
    fontSize: 11px
    fontWeight: '500'
    lineHeight: 14px
    letterSpacing: 0.02em
  caption-caps:
    fontFamily: Inter
    fontSize: 10px
    fontWeight: '600'
    lineHeight: 12px
    letterSpacing: 0.06em
rounded:
  sm: 0.125rem
  DEFAULT: 0.25rem
  md: 0.375rem
  lg: 0.5rem
  xl: 0.75rem
  full: 9999px
spacing:
  gutter: 1rem
  gutter-dense: 0.5rem
  margin: 1.5rem
  margin-mobile: 1rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 0.75rem
  space-lg: 1rem
  space-xl: 1.5rem
---

## Brand & Style

This design system targets environmental data scientists, platform engineers, and sustainability enterprise directors who monitor complex ecological sensor networks and planetary-scale atmospheric streams. The personality is rational, rigorous, and surgically precise—evoking absolute confidence, scientific accuracy, and low cognitive fatigue during round-the-clock monitoring operations. 

The aesthetic adheres to an exacting enterprise telemetry movement, merging structural minimalism with disciplined high-density data presentation. It rejects superfluous ornamentation, cyberpunk glowing bloat, and vaporous purple-to-pink gradients in favor of an authoritative command-center environment: crisp 1px borders, carefully stepped dark surfaces, controlled cyan-teal primary highlights, and clear semantic environmental statuses.

## Colors

The palette operates on a strict functional stratification designed for deep dark-mode telemetry. 

### Core Surfaces & Neutral Canvas
- **Background Canvas (`#0B1220`)**: Base layer for full-screen analytics workspaces.
- **Surface / Card Base (`#111827`)**: Structural panels, telemetry grids, and standard dashboard widgets.
- **Elevated Container (`#172033`)**: Popovers, active table rows, flyout inspector drawers, and elevated card clusters.
- **Border / Structural Outline (`#243244`)**: Architectural boundaries, grid cell dividers, and inputs.
- **Text Primary (`#F8FAFC`)**: High-contrast display metrics, active headings, and focal tabular values.
- **Text Secondary (`#94A3B8`)**: Metric keys, navigation labels, standard body copy, and axis labels.
- **Text Muted (`#64748B`)**: Timestamps, unit suffixes (`µg/m³`, `ppm`), disabled states, and table column sorters.

### Brand Accents
- **Primary Accent (`#38BDF8`)**: Focal interactions, selected states, primary controls, and active series curves.
- **Secondary Accent (`#14B8A6`)**: Secondary analytical streams, model prediction overlays, and comparative series.

### Semantic Telemetry (AQI / Air Quality Tiers)
- **Optimal / Good (`#22C55E`)**: Baseline healthy thresholds.
- **Moderate (`#84CC16`)**: Marginal warnings; acceptable tolerances.
- **Poor (`#F59E0B`)**: Advisory threshold exceedances.
- **Very Poor (`#F97316`)**: Acute alert levels.
- **Severe (`#EF4444`)**: Critical anomalies and environmental incidents.

No luminous neon casts, colored drop-shadows, or irrelevant gradient spectrums may be introduced.

## Typography

Typography relies on `Inter` across headers, analytical dashboards, controls, and data matrices to preserve maximum structural clarity and horizontal budget efficiency.

### Typographic Directives
- **Tabular Figures**: Every table cell, sensor readout, coordinate display, and timestamp strictly leverages `font-variant-numeric: tabular-nums` to eliminate layout jitter during high-frequency telemetry updates.
- **Hierarchy through Contrast and Tone**: Hierarchy is established via font weight transitions (`400` to `600`) and the distinct neutral text levels (`#F8FAFC`, `#94A3B8`, `#64748B`), avoiding oversized headlines on analytical boards.
- **Metric Readouts**: Telemetry cards feature `metric-display` (`28px / 500`) paired with `label-sm` or `caption-caps` in uppercase muted text (`#64748B`) to establish standard instrumentation visual patterns.

## Layout & Spacing

The layout operates on a compact 4px base increment fluid grid engineered for responsive telemetry screens.

### Grid Architecture & Breakpoints
- **Desktop (≥ 1280px)**: 12-column fluid grid or dynamic CSS grid with `1rem` (16px) gutters and `1.5rem` (24px) canvas margins. Dense telemetry matrices (e.g., sensor monitor clusters) reduce gutters to `gutter-dense` (8px).
- **Tablet (768px – 1279px)**: 8-column grid with `1rem` gutters; multi-column KPI clusters collapse to 2-column or 4-column groupings.
- **Mobile (< 768px)**: 4-column flow with `0.5rem` gutters and `1rem` margins. Dense charts switch from inline comparisons to vertically stacked views.

### Spacing Hygiene
Whitespace is measured and compact. Internal card padding defaults to `space-md` (12px) for high-density monitors and `space-lg` (16px) for standard analytical reports. Elements rely on `space-xs` (4px) and `space-sm` (8px) for badge gaps, metric pairings, and input-icon padding.

## Elevation & Depth

This design system avoids heavy shadows, saturated colored blurs, and glassmorphic diffusion. Depth is communicated strictly via tonal step layering, 1px structural outlines, and restrained ambient shadows.

### Tonal Stratification
1. **Base Floor (`#0B1220`)**: The canvas floor housing all viewport components.
2. **First Tier (`#111827`)**: Primary analytic cards, data tables, and chart containers; bounded by a crisp 1px solid `#243244` outline.
3. **Elevated Tier (`#172033`)**: Active states, hovered table rows, filter chips, popover inspectors, and dropdown panels; bordered with 1px solid `#334155` or `#243244`.

### Ambient Shadow Directives
- **Panel Base**: `0 1px 3px 0 rgba(0, 0, 0, 0.4)`
- **Flyouts / Overlays**: `0 10px 15px -3px rgba(0, 0, 0, 0.5), 0 4px 6px -4px rgba(0, 0, 0, 0.4)`
- **Outline Priority**: Ambient shadows must never replace surface borders; borders (`#243244`) provide the primary edge definition in all scenarios.

## Shapes

The design system enforces a soft, low-radius shape profile (`roundedness: 1`), conveying engineering rigor without visual harshness.

### Application Rules
- **Base Components**: Inputs, buttons, dropdown triggers, and status badges take `0.25rem` (4px).
- **Cards & Data Containers (`rounded-lg`)**: Standard telemetry cards and charts take `0.5rem` (8px).
- **Flyout Modals & Slide-out Drawers (`rounded-xl`)**: Complex overlays, slide-overs, and config dialogs take `0.75rem` (12px).
- **Pill Exceptions**: Fully rounded (`9999px`) shapes are prohibited except for miniature live-status beacon dots (`size: 6px` or `8px`). Chips and tags maintain the standard `0.25rem` radius.

## Components

### Buttons
- **Primary**: Background `#38BDF8`, text `#0B1220` (bold weight for contrast), border none. Hover state transitions to `#7DD3FC`. Focus ring is `2px solid #38BDF8` with a 2px offset (`#0B1220`).
- **Secondary / Outline**: Background `#111827`, text `#F8FAFC`, border `1px solid #243244`. Hover state shifts background to `#172033` and border to `#38BDF8`.
- **Tertiary / Ghost**: Transparent background, text `#94A3B8`. Hover state uses background `#172033` and text `#F8FAFC`.
- **Sizing**: Default height is 32px (dense) with 12px horizontal padding; form factor controls cap at 36px.

### Badges & Telemetry Chips
- **Structural**: Padding `2px 6px`, radius `4px`, typography `label-sm` or `caption-caps`.
- **AQI / Alert Badges**: Semi-transparent fill against elevated dark backgrounds to prevent blinding neon glow. Example: Severe badge uses `background: rgba(239, 68, 68, 0.15)`, `border: 1px solid rgba(239, 68, 68, 0.4)`, `text: #EF4444`. Good status follows `rgba(34, 197, 94, 0.15)` with `#22C55E`.

### Form Inputs & Selectors
- **Input Field**: Height 32px, background `#0B1220`, border `1px solid #243244`, text `#F8FAFC`, placeholder `#64748B`, radius `4px`.
- **Active / Focused**: Border switches to `#38BDF8`, outline is `1px solid #38BDF8`.
- **Checkboxes & Radios**: 16x16px frame, background `#0B1220`, border `1px solid #243244`, radius 3px (checkbox) or circular (radio). Checked state fills `#38BDF8` with `#0B1220` checkmark indicator.

### Data Tables & Tabular Grids
- **Header Row**: Background `#111827`, border-bottom `1px solid #243244`, text `#64748B`, typography `label-sm` (uppercase, track-wide).
- **Body Row**: Height 36px (compact density), border-bottom `1px solid #1E293B`, text `#F8FAFC`, font tabular nums.
- **Row States**: Hover triggers `#172033`; selected row features a 2px vertical border-left accent `#38BDF8` and background `rgba(56, 189, 248, 0.04)`.

### Cards & Container Panels
- Base container uses background `#111827`, border `1px solid #243244`, radius `8px`.
- Header section features an integrated action zone (range picker, threshold toggles) separated by a 1px horizontal divider (`#243244`).

### Specialized Telemetry Widgets
- **Sensor Sparkline Cells**: Inline sparklines use `#38BDF8` or `#14B8A6` strokes (1.5px thickness, no gradient area fills) set directly into table rows.
- **Live Status Beacons**: 6px pulsing indicators showing network transmission status without blurred rings.