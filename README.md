# Inkognito

Copyright (c) Dok100. All rights reserved.

Dieses Repository ist nicht Open Source. Ohne vorherige schriftliche Zustimmung wird keine Erlaubnis erteilt, diese Software zu nutzen, zu kopieren, zu verändern oder weiterzugeben.

## Überblick

Inkognito ist eine native macOS-App zur lokalen Anonymisierung sensibler Inhalte in:

- PDFs
- Bildern
- Zwischenablage-Text

Erkennung, OCR, Review und Export bleiben auf dem Mac. Inkognito kombiniert lokale modellgestützte Erkennung, dokumentbewusste Regex-Muster, Apple Vision OCR und manuelle Prüfung, damit vertrauliche Daten das Gerät nicht verlassen müssen.

## Kernfunktionen

- Lokale Anonymisierung für PDFs, Bilder und Zwischenablage-Workflows
- Review-zentrierter Ablauf vor der finalen Schwärzung
- OCR-Fallback für gescannte oder fehlerhafte PDF-Textschichten
- Manuelle Schwärzungen und Rücknahmen direkt im Review
- Dokumentbewusste Heuristiken für Briefe, Rechnungen und strukturierte Formulare
- Export-Ablauf mit finaler Schwärzung und verständlicher Zusammenfassung

## Produktrichtung

Inkognito wird als kommerzielles macOS-Produkt mit privacy-first Local-Workflow vorbereitet. Dieses Repository ist die aktive Produktbasis; die historische Commercial-Readiness- und Relicensing-Bereinigung bleibt im früheren Referenz-Repository dokumentiert.

## Voraussetzungen

- macOS 26 oder neuer
- Apple Silicon
- Xcode 16 oder neuer für lokale Builds

## Release-Stand

- Die App baut aktuell erfolgreich über `xcodebuild -project Inkognito.xcodeproj -scheme Inkognito -sdk macosx build`.
- Die Detection-Regressionen laufen aktuell mit `202` Checks grün.
- Distributionsspezifische Neuaufsetzung für Sparkle und historische Update-Pfade bleibt separat unter `PROJ-22` nachgehalten.

## Build

```bash
open Inkognito.xcodeproj
```

Dann in Xcode:

1. Das Scheme `Inkognito` auswählen.
2. Die App mit `Cmd+R` starten.

## Regressionen

```bash
CLANG_MODULE_CACHE_PATH=/private/tmp/swift-module-cache swift scripts/run_detection_regressions.swift
```

## Repository-Struktur

- `Inkognito/`: App-Quellcode
- `Inkognito.xcodeproj/`: Xcode-Projekt
- `scripts/`: lokale Wartungs- und Regressionsskripte
- `fixtures/`: Regressions- und Diagnose-Fixtures
- `docs/`: Runbook, Release- und Betriebsnotizen
- `features/`: Produkt-Arbeitsstränge und Feature-Notizen

## Hinweise

- Dieses Repository ist die neue Produktbasis für Inkognito.
- Die frühere Commercial-Readiness-Audit-Historie bleibt im älteren Referenz-Repository erhalten.
- Laufzeit-Migrationspfade, die noch auf frühere `HideMyData`-Benutzerverzeichnisse zeigen, bleiben bewusst aus Kompatibilitätsgründen erhalten.
