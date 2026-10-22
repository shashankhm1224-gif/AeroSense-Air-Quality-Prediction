---
name: Obsidian Telemetry
colors:
  surface: '#0f131c'
  surface-dim: '#0f131c'
  surface-bright: '#353942'
  surface-container-lowest: '#0a0e16'
  surface-container-low: '#181c24'
  surface-container: '#1c2028'
  surface-container-high: '#262a33'
  surface-container-highest: '#31353e'
  on-surface: '#dfe2ee'
  on-surface-variant: '#bec8d2'
  inverse-surface: '#dfe2ee'
  inverse-on-surface: '#2c3039'
  outline: '#88929b'
  outline-variant: '#3e4850'
  surface-tint: '#89ceff'
  primary: '#89ceff'
  on-primary: '#00344d'
  primary-container: '#0ea5e9'
  on-primary-container: '#003751'
  inverse-primary: '#006591'
  secondary: '#4cd7f6'
  on-secondary: '#003640'
  secondary-container: '#03b5d3'
  on-secondary-container: '#00424e'
  tertiary: '#c0c1ff'
  on-tertiary: '#1000a9'
  tertiary-container: '#8d90ff'
  on-tertiary-container: '#1407ad'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#c9e6ff'
  primary-fixed-dim: '#89ceff'
  on-primary-fixed: '#001e2f'
  on-primary-fixed-variant: '#004c6e'
  secondary-fixed: '#acedff'
  secondary-fixed-dim: '#4cd7f6'
  on-secondary-fixed: '#001f26'
  on-secondary-fixed-variant: '#004e5c'
  tertiary-fixed: '#e1e0ff'
  tertiary-fixed-dim: '#c0c1ff'
  on-tertiary-fixed: '#07006c'
  on-tertiary-fixed-variant: '#2f2ebe'
  background: '#0f131c'
  on-background: '#dfe2ee'
  surface-variant: '#31353e'
typography:
  display-hero:
    fontFamily: Space Grotesk
    fontSize: 48px
    fontWeight: '600'
    lineHeight: 56px
    letterSpacing: -0.03em
  display-hero-mobile:
    fontFamily: Space Grotesk
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Space Grotesk
    fontSize: 30px
    fontWeight: '600'
    lineHeight: 38px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Space Grotesk
    fontSize: 22px
    fontWeight: '500'
    lineHeight: 28px
    letterSpacing: -0.015em
  headline-sm:
    fontFamily: Space Grotesk
    fontSize: 18px
    fontWeight: '500'
    lineHeight: 24px
    letterSpacing: -0.01em
  body-lg:
    fontFamily: Geist
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
    letterSpacing: -0.01em
  body-md:
    fontFamily: Geist
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
    letterSpacing: -0.005em
  body-sm:
    fontFamily: Geist
    fontSize: 13px
    fontWeight: '400'
    lineHeight: 18px
    letterSpacing: 0em
  label-md:
    fontFamily: Geist
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.02em
  label-mono:
    fontFamily: Geist
    fontSize: 11px
    fontWeight: '500'
    lineHeight: 14px
    letterSpacing: 0.06em
  code-value:
    fontFamily: Geist
    fontSize: 13px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0em
rounded:
  sm: 0.125rem
  DEFAULT: 0.25rem
  md: 0.375rem
  lg: 0.5rem
  xl: 0.75rem
  full: 9999px
spacing:
  gutter: 1rem
  gutter-mobile: 0.5rem
  margin: 1.5rem
  margin-mobile: 0.75rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 0.75rem
  space-lg: 1.25rem
  space-xl: 2rem
---

## Brand & Style

This design system establishes a high-density, computational intelligence aesthetic calibrated for geospatial modeling, climate simulations, and planetary sensor analysis. Drawing visual inspiration from professional developer workflows, analytical terminals, and planetary observatory consoles, the interface prioritizes extreme typographic discipline, micro-precision borders, and information density over decorative embellishment.

The audience consists of environmental data scientists, climate modelers, and institutional researchers who demand immediate signal clarity, rigorous data integrity, and persistent situational awareness. The emotional response is one of surgical control, computational authority, and focused clarity under high-volume data streams.

The interface style merges high-density minimalism with computational telemetry styling:
- Deep obsidian and charcoal backdrops mitigate eye fatigue across extended monitoring cycles.
- Hairline structural framing creates distinct spatial zones without relying on heavy elevation or blurring.
- Electric cyan instrumentation highlights focus the user's attention onto anomalous signals and active variables.
- Monospaced numeric alignment reinforces empirical accuracy and auditability across all data matrices.

## Colors

The color system utilizes a four-tier architecture engineered for low-light computational settings:

1. **Surfaces & Canvas Foundation**:
   - `surface-canvas`: `#0B0F17` (Deep Obsidian base)
   - `surface-subtle`: `#111827` (Panel and module base)
   - `surface-elevated`: `#161F30` (Interactive cards, popovers, and floating drawers)
   - `surface-overlay`: `#1E293B` (Dropdown menus and command palettes)

2. **Structural Lines & Demarcation**:
   - `border-subtle`: `#1F2937` (Base panel dividers, standard matrix gridlines)
   - `border-strong`: `#243042` (Active card perimeters, input borders)
   - `border-highlight`: `rgba(14, 165, 233, 0.4)` (Active focus, telemetry node selection)

3. **Accent & Interactive Telemetry**:
   - Primary (`#0EA5E9`): High-signal interactive controls, key vector lines, and primary callouts.
   - Secondary (`#06B6D4`): Sensor streams, telemetry readouts, spatial data points, and coordinate labels.
   - Tertiary (`#6366F1`): Predictive simulations, machine learning variance envelopes, and temporal shifts.

4. **Semantic Data Visualization**:
   - Nominal/Normal (`#10B981`): Balanced ecological thresholds, carbon sink parity.
   - Advisory (`#F59E0B`): Moderate deviations, sensory latency, moisture deficits.
   - Critical/Alarm (`#F43F5E`): Environmental tipping points, thermal threshold breaches.
   - Specialized Variant (`#8B5CF6`): Synthetic interpolations and atmospheric ozone indices.

5. **Text & Data Contrast**:
   - `text-primary`: `#F8FAFC` (Pure optical legibility for core values and headers)
   - `text-secondary`: `#94A3B8` (Metadata, units of measurement, static labels)
   - `text-muted`: `#64748B` (De-emphasized timestamps, inactive axis notches)

## Typography

The typographic hierarchy coordinates geometric display typography (`Space Grotesk`) with razor-sharp computational body text (`Geist`).

- **Display & Headline Levels**: Handled exclusively by `Space Grotesk`. Tight negative tracking (`-0.01em` to `-0.03em`) produces an architectural, instrument-calibrated silhouette suitable for primary telemetry dashboards and analytical section heads.
- **Narrative, Query, and Analytical Text**: Handled by `Geist` at standard weights (400 and 500). Optimized for maximum rendering clarity when parsing spatial coordinates, dataset descriptions, or tabular metadata.
- **Telemetry Indicators & Micro Labels**: Handled by `label-mono`, rendered with uppercase transformations, tabular alignment, and positive tracking (`0.06em`) to ensure legibility across dense dashboard panels.
- **Data Densities**: All numeric readings, metric tables, and coordinate vectors must employ tabular numbers (`font-variant-numeric: tabular-nums`) to prevent horizontal jitter during real-time data streaming.

## Layout & Spacing

The structural layout utilizes a dense, terminal-grade responsive fluid grid tailored to multi-monitor operations, laptop workstations, and mobile telemetry capture:

- **Grid Architecture**:
  - **Desktop (1440px+)**: 12-column or 16-column layout with `1rem` gutters. Accommodates persistent left-hand query sidebars (280px fixed width), a center geospatial viewport, and a right-hand telemetry rail (340px fixed width).
  - **Tablet (768px - 1439px)**: 8-column layout. Collapses secondary telemetry into contextual tabbed drawers; primary analytical viewport remains dominant.
  - **Mobile (< 768px)**: 4-column layout with `0.5rem` gutters and `0.75rem` margins. Sidebars collapse into sliding bottom sheets; metrics switch from horizontal matrix strips to vertical cards.

- **Spatial Rhythm**:
  - Spacing operates on a baseline 4px computational module (`space-xs: 0.25rem`, `space-sm: 0.5rem`, `space-md: 0.75rem`, `space-lg: 1.25rem`, `space-xl: 2rem`).
  - Gaps within tabular summaries or metric badges adhere strictly to `space-xs` and `space-sm` to maintain high analytical density without visual noise.

## Elevation & Depth

Depth in this system is conveyed through tonal layering, razor-thin perimeter boundaries, and subtle optical luminescence rather than diffuse skeuomorphic shadows.

- **Hairline Framing**: Separation between spatial panes, chart cards, and viewports is executed using 1px borders (`#1F2937`). Stacked panels use progressive darkening (`#111827` nested within `#0B0F17`) to establish visual depth.
- **Specular Border Gradients**: High-priority cards (such as anomaly alerts or active geospatial queries) employ directional 1px border gradients: transitioning from `rgba(14, 165, 233, 0.45)` at the top edge to `rgba(36, 48, 66, 0.1)` at the bottom edge.
- **Atmospheric Glows**: Interactive state triggers (such as focused input fields or hovered metric cells) cast an internal and external cyan tint:
  - Drop shadow: `0 0 16px -4px rgba(14, 165, 233, 0.25)`.
- **Command Overlays**: Menus, popovers, and model parameter dialogs utilize a high-density background (`#161F30`) supplemented by a 1px border (`#243042`) and an ambient, dark-toned shadow (`0 12px 32px -4px rgba(0, 0, 0, 0.7)`).

## Shapes

The design language uses tight corner treatments (`roundedness: 1`), reinforcing an instrument-grade aesthetic.

- **Base Corner Radii (`0.25rem` / 4px)**: Applied to interactive chips, input fields, terminal buttons, tabular row highlights, and internal metric cards.
- **Containers & Major Panels (`0.5rem` / 8px via `rounded-lg`)**: Applied to high-level dashboard containers, telemetry cards, and analytical modal viewports.
- **Modal Dialogs & Floating Command Menus (`0.75rem` / 12px via `rounded-xl`)**: Applied to full-screen overlays, contextual inspectors, and spatial layer configuration flyouts.
- **Pills / Radians**: Circle treatments are strictly reserved for live pulse dots (real-time stream connectivity) and quantitative scatter plot nodes.

## Components

### Buttons
- **Primary Action**: Background `#0EA5E9`, text `#0B0F17`, font weight 500, height 32px, horizontal padding `space-md`, border-radius `0.25rem`. On hover: `#38BDF8` with a `0 0 12px rgba(14, 165, 233, 0.35)` glow.
- **Secondary / Terminal Action**: Background `#111827`, border 1px solid `#243042`, text `#F8FAFC`, height 32px. On hover: border-color `#0EA5E9`, background `#161F30`.
- **Ghost Action**: Background transparent, text `#94A3B8`. On hover: text `#F8FAFC`, background `rgba(255, 255, 255, 0.04)`.

### Chips & Telemetry Status Badges
- Compact height (20px - 22px), border-radius `0.25rem`, uppercase label typography (`label-mono`), padding `0 6px`.
- Composed of a faint tint background (10% opacity) and matching 1px border (25% opacity) corresponding to the semantic state:
  - *Active Telemetry*: Background `rgba(6, 182, 212, 0.1)`, border `rgba(6, 182, 212, 0.25)`, text `#06B6D4`.
  - *Anomaly Alert*: Background `rgba(244, 63, 94, 0.1)`, border `rgba(244, 63, 94, 0.3)`, text `#F43F5E`.
- An optional 6px circular indicator dot with pulse animation precedes the label for live streams.

### Cards & Analytical Modules
- Structured on `#111827` with a 1px uniform border `#1F2937` and `rounded-lg` (8px) corners.
- Header bars are cleanly segmented by a bottom 1px border `#1F2937`, containing the panel label (`Space Grotesk`, 13px, uppercase tracking) and contextual tool actions (range selector, export icon).
- Inner card padding is uniformly set to `space-md` or `space-lg`.

### Data Inputs & Query Fields
- Background `#0B0F17`, border 1px solid `#1F2937`, height 34px, text `#F8FAFC`, font size 13px.
- Placeholder text in `#64748B`.
- Focus state switches border to `#0EA5E9` with an accompanying box-shadow `0 0 0 1px rgba(14, 165, 233, 0.3)`. No default browser rings.

### Checkboxes & Segmented Toggles
- Checkboxes: 14x14px square, radius `2px`, border 1px solid `#243042`, background `#0B0F17`. Selected state displays `#0EA5E9` fill with an obsidian checkmark.
- Segmented Toggles: Enclosed container with `#0B0F17` background and 1px border `#1F2937`. Individual toggles slide over an active `#161F30` background tile bounded by a 1px border `#243042`.

### Tabular Lists & Data Matrices
- Row height: 32px to 36px for dense scanning.
- Alternating subtle row hover: `rgba(255, 255, 255, 0.02)`.
- Numeric data cells use tabular figures (`Geist`), right-aligned with unit descriptors rendered in `#64748B`.
- Header rows feature a persistent bottom border `#243042`, uppercase `label-mono` type, and interactive sorting indicators.

### Additional Scientific Domain Components
- **Spatial Coordinate HUD**: Fixed floating pill showing cursor longitude, latitude, elevation, and sensor timestamp in monospaced cyan typography.
- **Timeseries Scrubber / Range Bar**: Dual-point slider with integrated sparkline histogram, featuring active selection bounds marked by electric cyan hairlines.
- **Variable Matrix Legend**: Horizontal swatches showing discrete color bins for continuous gradients (e.g., Sea Surface Temperature, NDVI indices).