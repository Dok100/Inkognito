# Release Draft 0.3.0

## Titel

Inkognito 0.3.0 - sensible Dokumente schneller, klarer und sicherer anonymisieren

## Kurzfassung

Inkognito 0.3.0 macht die lokale Anonymisierung vertraulicher PDFs, Bilder und Zwischenablage-Texte auf dem Mac deutlich alltagstauglicher. Dieses Release macht die Erkennung robuster, die manuelle Pruefung ruhiger und die Nacharbeit deutlich schneller, damit aus sensiblen Unterlagen veroeffentlichbare Dateien werden, ohne dass sie den Mac verlassen muessen.

## Store-/Release-Kurztext

Inkognito 0.3.0 macht lokale Dokument-Anonymisierung auf dem Mac deutlich praxisnaeher: bessere Erkennung in Rechnungen, Formularen und Geschaeftsbriefen, klarerer Review-Workflow und schnellere Nacharbeit bei aehnlichen Treffern. Fuer Menschen, die sensible Unterlagen teilen muessen, aber Kontrolle und Vertraulichkeit behalten wollen.

## GitHub-Release-Text

Inkognito 0.3.0 ist das bislang staerkste Release fuer alle, die sensible Dokumente lokal auf dem Mac anonymisieren wollen, ohne Kontrolle oder Vertraulichkeit abzugeben.

Dieses Update bringt Inkognito naeher an den echten Dokumentalltag: robustere Erkennung in Rechnungen, Formularen, Geschaeftsbriefen und E-Rechnungen, weniger false positives in Briefkoepfen und Rechtstexten und ein deutlich klarerer Review-Workflow vor dem finalen Export.

Besonders spuerbar wird das Release dort, wo Datenschutz im Alltag sonst Zeit kostet: bei OCR-lastigen PDFs, bei zerfallenen Textschichten, bei wiederkehrenden Treffern und bei Dokumenten, die vor dem Teilen mit Kolleg:innen, Mandant:innen oder KI-Tools noch sauber geprueft werden muessen.

Inkognito bleibt dabei dem Kernversprechen treu: sensible Inhalte werden lokal verarbeitet, du behaeltst die Entscheidungshoheit ueber jede Schwaerzung und aus einem nervoesen Pruefschritt wird ein ruhiger, nachvollziehbarer Workflow.

Wenn du vertrauliche Unterlagen schneller freigeben willst, ohne sie leichtfertig aus der Hand zu geben, ist 0.3.0 der bisher beste Einstiegspunkt.

## Highlights

- robustere Erkennung in Rechnungen, Formularen, Bankseiten, DIN-5008-Geschaeftsbriefen und E-Rechnungen
- klarerer Review-Workflow mit Seitenstatus, nachvollziehbaren Unsicherheiten und schnelleren Sammelaktionen fuer aehnliche Treffer
- weniger false positives in Briefkoepfen, Ortsangaben, Rechtstexten und AGB
- verstaendlichere Export-Zusammenfassung und ruhigere Trust-Momente vor und nach dem Speichern
- produktnaehere `Eigene Regeln` mit Vorlagen, Qualitaets-Hinweisen und Treffer-Vorschau im aktuellen Dokument
- klarerer Clipboard-Flow fuer lokale Anonymisierung und spaetere Rueckfuehrung von Platzhaltern

## Fuer Nutzer wichtig

- weniger Zeit in manueller Nacharbeit bei typischen Geschaeftsdokumenten
- bessere Orientierung, welche Treffer noch offen sind und welche Seiten besondere Sichtpruefung brauchen
- schnellere Freigabe oder Ablehnung aehnlicher Treffer statt Klick-fuer-Klick-Korrekturen
- robusterer Umgang mit OCR-lastigen PDFs und zerfallenen Textschichten
- klarerer lokaler Workflow, wenn Texte erst anonymisiert und spaeter wieder rueckgefuehrt werden sollen

## Verkaufsargumente

- **Alles lokal auf dem Mac**: sensible Inhalte muessen fuer Erkennung, Review und Nacharbeit nicht in externe Webdienste hochgeladen werden.
- **Mehr Kontrolle vor dem Export**: Inkognito schwaerzt nicht blind, sondern fuehrt erst durch eine nachvollziehbare Pruefung.
- **Praxisnaeher fuer echte Unterlagen**: besonders bei Rechnungen, Formularen, Briefen und E-Rechnungen ist das Release deutlich belastbarer.
- **Schneller fuer Teams und Einzelpersonen**: aehnliche Treffer lassen sich gesammelt bearbeiten, statt jede Wiederholung einzeln anzufassen.

## Appcast-kompatible Kurz-Highlights

- Klarerer Review-Workflow mit Seitenstatus und schnellerer Nacharbeit
- Robustere Erkennung fuer Rechnungen, Formulare und E-Rechnungen
- Weniger false positives in Briefkoepfen, Ortsangaben und Rechtstexten

## Empfohlene Sparkle-Release-Werte

```bash
--highlight "Klarerer Review-Workflow mit Seitenstatus und schnellerer Nacharbeit" \
--highlight "Robustere Erkennung fuer Rechnungen, Formulare und E-Rechnungen" \
--highlight "Weniger false positives in Briefkoepfen, Ortsangaben und Rechtstexten" \
--user-facing-note "Inkognito 0.3.0 macht die lokale Anonymisierung sensibler Dokumente auf dem Mac deutlich praxisnaeher und verlaesslicher." \
--migration-note "Bei bestehenden Installationen kann einmalig ein erneuter Modelldownload noetig sein; bei sehr alten Vorabstaenden kann zusaetzlich eine bewusste Neuinstallation sinnvoll sein."
```

## Technische Highlights

- Detection-Regressionen auf `202` Checks erweitert
- neue anonymisierte Fixtures fuer DIN-5008, ZUGFeRD und E-Rechnungs-Feldreferenzen
- Build-Warnungen fuer die ab macOS 26 veraltete `Text + Text`-Komposition entfernt
- aktive Legacy-Migrationspfade bewusst erhalten, obwohl der laufende App-Pfad bereits `Inkognito` spricht

## Verifikation

- `swift scripts/run_detection_regressions.swift`
  - `Detection regressions passed (202 checks)`
- `xcodebuild -project Inkognito.xcodeproj -scheme Inkognito -sdk macosx build`
  - `BUILD SUCCEEDED`

## Upgrade-Hinweis

- Bei bestehenden Installationen kann ein einmaliger erneuter Modelldownload noetig sein, falls noch ein aelterer, nicht revisionsgebundener Cache genutzt wurde.
- Bei sehr alten Vorabstaenden kann fuer den neuen Distributionspfad zusaetzlich eine bewusste Neuinstallation sinnvoll sein.

## Interne Einordnung

Dieses Release deckt den Feature-Block `PROJ-8` bis `PROJ-20` ab.
