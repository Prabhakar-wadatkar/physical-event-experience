# EVENTOS - Spatial Venue Engine

**A Smart, Dynamic Event Orchestration Platform**

EVENTOS is a premium Spatial Venue Engine designed to transform physical event orchestration into a data-driven, immersive experience. Built for the **Event Management vertical**, it bridges the gap between public marketing and private venue logistics.

## 🚀 Live Demo
[https://physical-event-exp-26.web.app](https://physical-event-exp-26.web.app)

---

## 🏗️ Vertical & Persona
**Vertical:** Event Management & Spatial Operations  
**Persona:** Venue Managers & Event Coordinators who require real-time visibility into physical spaces while maintaining a high-end public-facing presence.

## 💡 Approach and Logic
The solution follows a **Gate-Controlled Modular Architecture**:
- **Layer 1 (The Experience):** A high-performance landing page designed to "WOW" users with custom particle physics, glassmorphism, and live activity tickers.
- **Layer 2 (The Command Center):** A private, functional dashboard (Console) that manage events, tracks venue load, and monitors spatial beacon statuses.
- **Logic:** The app uses local state management (via `Provider`) to sync event data across the entire platform. It simulates real-world spatial data streams (Traffic, Load, Safety) to demonstrate practical usability.

## 🛠️ Google Services Integration
- **Firebase Core:** Provides the unified identity and project infrastructure.
- **Firebase Hosting:** Delivers the platform globally with optimized delivery for large assets and high-performance WebGL/CanvasKit rendering.
- **Material 3 Design:** Leverages Google's latest design system for a sleek, responsive, and accessible user experience.

## 🎯 How It Works
1. **Public View:** Visitors arrive at the futuristic landing page where they can see live metrics and upcoming summit highlights.
2. **Dashboard Transition:** By interacting with "Launch Hub" buttons, users transition into the **Management Console**.
3. **Event Lifecycle:** Managers can **Create**, **Read**, and **Delete** event projects in real-time. The dashboard tracks dynamic "System Stats" like Network Load and Beacon Status.
4. **Data Visualization:** Built-in spatial charts provide a visual representation of venue traffic trends.

## 📋 Assumptions
- **Modern Hardware:** The spatial animations (CanvasKit) work best on modern web browsers (Chrome/Edge/Safari).
- **Public access:** For the purpose of this challenge round, the complex login wall has been simplified to allow immediate evaluation of the dashboard functionality.
- **Persistence:** This prototype uses in-memory state management; a full Firestore integration would be the next step for production persistence.

---

## 🏆 Challenge Compliance
- **Repository Size:** ~103 KB (Well under the 1 MB limit)
- **Branching:** Single `main` branch.
- **Accessibility:** High-contrast dark mode with clear typography.
- **Usability:** Responsive layout from mobile to wide-screen desktops.

---
*Built with Google Antigravity & Flutter*
