# Inkognito

Copyright (c) Dok100. All rights reserved.

This repository is not open source. No permission is granted to use, copy, modify, or distribute this software without prior written consent.

## Overview

Inkognito is a native macOS app for locally anonymizing sensitive content in:

- PDFs
- images
- clipboard text

Detection, OCR, review, and export stay on the Mac. Inkognito combines local model-based detection, document-aware regex patterns, Apple Vision OCR, and manual review so confidential files do not need to leave the device.

## Core Capabilities

- Local anonymization for PDFs, images, and clipboard workflows
- Review-first workflow before final redaction
- OCR fallback for scanned or broken-text PDFs
- Manual redactions and recovery actions during review
- Document-aware heuristics for letters, invoices, and structured forms
- Export flow with final redaction output and summary guidance

## Product Direction

Inkognito is being prepared as a commercial macOS product with a privacy-first local workflow. The current repository is the active product base; historical commercial-readiness and relicensing cleanup remains documented in the earlier reference repository.

## Requirements

- macOS 26 or newer
- Apple Silicon
- Xcode 16 or newer for local builds

## Release Readiness

- The app currently builds successfully via `xcodebuild -project Inkognito.xcodeproj -scheme Inkognito -sdk macosx build`.
- Detection regressions currently pass with `202` checks.
- Distribution-specific reset work for Sparkle and historical update paths remains tracked separately under `PROJ-22`.

## Build

```bash
open Inkognito.xcodeproj
```

Then in Xcode:

1. Select the `Inkognito` scheme.
2. Run the app with `Cmd+R`.

## Regression Checks

```bash
CLANG_MODULE_CACHE_PATH=/private/tmp/swift-module-cache swift scripts/run_detection_regressions.swift
```

## Repository Layout

- `Inkognito/`: application source
- `Inkognito.xcodeproj/`: Xcode project
- `scripts/`: local maintenance and regression scripts
- `fixtures/`: regression and diagnostic fixtures
- `docs/`: runbook, release, and operating notes
- `features/`: product workstreams and feature notes

## Notes

- This repository is the new product base for Inkognito.
- Legacy commercial-readiness audit history remains in the earlier reference repository.
- Runtime migration paths that still reference older `HideMyData` user directories are intentionally retained for compatibility.
