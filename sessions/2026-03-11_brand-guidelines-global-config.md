# Brand Guidelines Global Configuration - C3PO Security Operations Command Center

**Session Date**: March 11, 2026
**Purpose**: Configure global brand standards for C3PO across all projects

---

## 🎯 Objective

Apply comprehensive brand guidelines globally to ensure consistent visual identity and voice across the C3PO Security Operations Command Center ecosystem.

## ✅ Completed Actions

### 1. Updated Memory System
- **Location**: `/memory/branding-guidelines.md`
- **Content**: Complete typography and color specifications
  - Fraunces typeface guidelines (primary/display)
  - Epilogue typeface guidelines (secondary/body)
  - Full color system with PMS, CMYK, RGB, HEX values
  - WCAG accessibility compliance matrix
  - Gradient specifications
  - Usage guidelines and restrictions

### 2. Global CLAUDE.md Configuration
- **Location**: `/Users/rsannicolas/.claude/CLAUDE.md`
- **Status**: Added brand guidelines as always-on global rule
- **Scope**: Applies to all projects automatically
- **Key Elements**:
  - Typography standards (condensed)
  - Core color palette
  - WCAG compliance requirements
  - Voice & tone principles

## 📋 Brand Standards Summary

### Typography
- **Headlines**: Fraunces (never uppercase, avoid Black weight)
- **Body**: Epilogue Regular
- **Subheads**: Epilogue Medium Small Caps

### Colors
- **Primary**: Warm Gray (#EAE8E3), Viridian Green (#00856C), Dark Green (#133B34)
- **Secondary**: Electrolight Green (#1ED75F), Medium Gray (#636466), Forest Green (#00524F)
- **Accessibility**: All combinations tested for WCAG compliance

### Voice
- Executive-ready clarity
- Thomas Method: Concrete, forward, methodical
- Direct and pragmatic

## 🚀 Next Steps

1. **CSS Implementation**: Create stylesheets with:
   ```css
   font-family: 'Fraunces', serif;
   letter-spacing: -0.02em;
   font-variant: small-caps; /* For Epilogue caps */
   ```

2. **Component Library**: Build reusable components following brand guidelines

3. **Documentation Templates**: Update all templates with proper typography hierarchy

4. **Accessibility Testing**: Validate all color combinations in production

## 💡 Key Learnings

- Brand guidelines now enforce automatically across all Claude sessions
- Typography requires specific technical settings (tracking, kerning, small caps)
- Color accessibility is critical - Electrolight Green has specific usage constraints
- Global configuration ensures consistency without manual intervention

## 🔒 Risk Mitigation

- WCAG compliance built into color selection
- Fallback colors defined for accessibility failures
- Typography guidelines prevent readability issues

---

*Configuration complete. Brand standards now apply globally to all C3PO-related projects.*