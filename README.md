[README.md](https://github.com/user-attachments/files/26333322/README.md)
# ⚡ Frankenstein E-Waste Upcycler

> Turn piles of broken electronics into useful campus devices.

This repo contains the design, mockups, and prototype notes for a system that identifies salvaged parts, logs them into a personal inventory, and generates safe wiring diagrams + starter code (C++ / Python) — so students can build low-cost smart campus gadgets without needing a degree in electrical engineering.

---

## What This Is (In Plain Words)

Imagine you take a photo of random e-waste sitting on a table. The system:

1. **Recognizes the parts** — motors, sensor boards, batteries, microcontrollers.
2. **Classifies them** — what's broken, what's repairable, what's still good.
3. **Stores the reusable parts** in your personal "Draft" vault.
4. **Suggests projects** you can actually build from those parts — complete with wiring sketches and starter code, scaled to your available tools and skill level.

The goal is to make upcycling approachable for students and campus teams who aren't electrical engineers.

---

## Key Features

- **CV-based part detection** from photos — PCBs, modules, motors, sensors
- **Automated teardown report** — sorts components into irreparable / repairable / good
- **Draft Vault** — a personal, persistent inventory of salvaged components
- **Frankenstein Engine** — combinatorial logic that finds useful device ideas from whatever parts you have
- **Wiring diagrams + starter code** (C++ / Python) tailored to your toolset and skill level
- **Safety warnings** for hazardous parts — swollen Li-ion batteries, exposed high-voltage components, and more

---

## How It Works

### Step-by-step (no jargon)

**1. Submit your device**
Upload photos and answer a few short questions — model name, what happened to it, your available tools, and your skill level.

**2. Triage**
The system inspects your images and input, lists each part, flags any dangers, and produces a categorized teardown report.

**3. Vault it**
Good and repairable parts are automatically logged into your Draft Vault — a simple personal inventory that grows every time you process a new device.

**4. Combinatorial matching**
The Frankenstein Engine tries combinations from your vault and newly salvaged parts to suggest a viable build. Example: a pump + moisture sensor + microcontroller → "auto plant waterer."

**5. Get your output**
You receive a wiring diagram and short starter code. If you don't have a soldering iron or advanced tools, suggestions stay appropriately simple.

---

## Demo & Assets

The project deck is included in this repo and contains slide-by-slide detail covering the mockups, architecture notes, dataset plan, and sprint roadmap. See the PDF assets folder for the full presentation.

**Prototype:**
- GitHub Repo: *(this repo)*
- Demo Video: *(link to be added)*

---

## Getting Started (MVP Roadmap)

High-level steps to prototype quickly — contributions welcome at any step.

**1. Build the input form**
A web form that accepts: model name, damage notes, tool checklist, skill slider (Beginner → Electrical Engineer), and image uploads.

**2. Hook up image inspection**
Connect uploads to a basic image inspection service. Start with manual labels or a lightweight classifier to verify output before integrating a full CV model.

**3. Set up the Draft Vault**
A simple database table is all you need to start:

```sql
CREATE TABLE draft_vault (
  id          SERIAL PRIMARY KEY,
  user_id     TEXT,
  part_name   TEXT,
  condition   TEXT,  -- 'good' | 'repairable' | 'irreparable'
  notes       TEXT,
  added_at    TIMESTAMP DEFAULT NOW()
);
```

**4. Build the suggestion engine**
Start rule-based. Define known combinations and map them to project templates:

```
IF vault CONTAINS (ESP32 + moisture_sensor + pump)
  → SUGGEST "Automated Plant Waterer"
  → OUTPUT wiring_sketch.svg + starter_code.ino
```

Then layer in generative AI once the rule layer is stable.

**5. Add safety warnings**
Flag hazardous parts visibly before the user sees any build suggestions. No output should appear before safety checks run.

> 💡 Want a JSON schema for the vault, a starter API spec, or a code template for the rule engine? Open an issue and ask — happy to draft it.

---

## ⚠️ Safety & Responsibility

Please read this before building or contributing.

- **E-waste can be dangerous.** The system must always flag hazardous items — leaking or swollen batteries, exposed high-voltage capacitors, damaged PCBs — and direct users to dispose of them safely.
- **Never encourage inexperienced users** to handle unknown battery packs, mains-connected components, or damaged boards without supervision.
- **All generated outputs** that involve advanced repair must include a clear "⚠️ Do Not Build Without Supervision" notice.
- When in doubt, the system should err on the side of caution and recommend professional recycling over DIY repair.

---

## Architecture Overview

```
┌────────────────────────────────────────────────┐
│              Frontend / Input Layer             │
│  Web form · Image upload · Tool & skill select  │
└───────────────────┬────────────────────────────┘
                    │
┌───────────────────▼────────────────────────────┐
│            Backend / Inventory Layer            │
│   PostgreSQL (Draft Vault) · API routing layer  │
└──────────┬──────────────────────────┬──────────┘
           │                          │
┌──────────▼──────────┐   ┌───────────▼───────────┐
│  Intelligent Triage │   │  Combinatorial Engine  │
│  Engine (CV + LLM)  │   │  (Frankenstein Engine) │
│  Part ID · Classify │   │  Match · Invent · Gen  │
└─────────────────────┘   └───────────────────────┘
```

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Computer Vision | YOLOv8 / Mask R-CNN — component detection on PCBs |
| Multimodal LLM | GPT-4o / Gemini 1.5 Pro — image + text diagnostics |
| Hardware LLM | CircuitLM / MuaLLM — valid schematic generation |
| RAG | Vector DB of component specs + pinouts |
| Agentic Framework | ReAct + Chain-of-Thought prompting |
| Database | PostgreSQL |
| Frontend | HTML · CSS · Vanilla JS (current prototype) |

---

## Roadmap

- [x] Design & wireframes
- [x] Prototype UI (input form + vault + results view)
- [ ] Input form + Draft Vault backend
- [ ] CV model integration (YOLOv8 — start with manual tagging for MVP)
- [ ] Combinatorial suggestion engine (rule-based → generative)
- [ ] RAG integration for pinout-accurate schematic generation
- [ ] Safety flagging system
- [ ] Wiring diagram renderer + code template output

---

## Team

**Cyber Warriors**
Team Lead: Nitin Mudgal

---

## License

This project does not currently have a license assigned. All rights reserved until a license is explicitly added.
