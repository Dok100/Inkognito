# PROJ-24 – Regelvarianten und Brieftext-Detection nachschärfen

**Status**: Geplant

## Ziel

Eigene Regeln sollen aus sinnvollen Eingaben verlässlicher zusätzliche Varianten ableiten, während die Detection in Briefen weniger unpassende Fließtext-Fragmente fälschlich als Adresse oder personennahe Stelle markiert.

## Schwerpunkte

- automatische Ergänzung sinnvoller Regelvarianten gezielter und nachvollziehbarer machen
- Fehlmarkierungen im Briefkörper, in Anreden und in freien Satzfragmenten spürbar reduzieren
- Adresslogik stärker an Blockstruktur, Dokumentkontext und Plausibilität koppeln
- OCR- und PDF-Textsegmente robuster gegen zu aggressive Einzelphrasen-Treffer absichern

## Problembeispiele

- aus legitimen Regeln sollen sinnvolle Teil-, Block- und Variantenregeln entstehen, ohne unnötige oder irreführende Ableitungen zu erzeugen
- Fließtext-Fragmente wie `heute, wie vertraglich`, `vereinbart, um den` oder `eintragen, nochmals überprüfen` dürfen nicht als adressähnliche Treffer hervorgehoben werden
- Anreden wie `Sehr geehrter Herr Kern,` sollen nicht durch angrenzende Kontextlogik in falsche Adress- oder Blocktreffer kippen
- kurze Satzfragmente mit OCR-Zerfall oder zufälliger Wortnachbarschaft sollen schlechter bewertet oder verworfen werden

## Wichtige Vorsichtspunkte

- keine aggressive Härtung einführen, die echte Empfängerblöcke oder berechtigte Namens-/Adress-Treffer unterdrückt
- Regelvarianten nur dann automatisch ergänzen, wenn der Mehrwert für Nutzer klarer ist als die entstehende Listenlast
- OCR-, Layout- und Textklassifikationsprobleme nicht still in reine Regex-Sonderfälle überführen
- Änderungen an Detection-Heuristiken immer mit neuen Regressionen gegen typische Brief-, Formular- und OCR-Fälle absichern

## Erwartete Deliverables

- nachgeschärfte Heuristiken für Fließtext, Anrede, Empfängerblock und adressähnliche Textsegmente
- klarere Regeln dafür, wann aus einer Nutzerregel zusätzliche Varianten automatisch entstehen
- neue anonymisierte Fixtures für Briefkörper-False-Positives und problematische OCR-Segmentierungen
- erweiterte Detection-Regressionen für Soll-/Nicht-Soll-Treffer rund um Brieftext und Regelvarianten
- dokumentierte Leitlinien, welche automatischen Varianten bewusst erzeugt und welche bewusst vermieden werden

## Relevante Dateien

- `Inkognito/PIIDetector.swift`
- `Inkognito/PatternMatcher.swift`
- `Inkognito/patterns.json`
- `Inkognito/Views/Main/MainView.swift`
- `scripts/run_detection_regressions.swift`
- `fixtures/detection/`

## Sinnvolle Reihenfolge

1. bestehende Fehlmarkierungen aus Briefen und OCR-Fällen sammeln und in Fixtures überführen
2. Detection-Pfade für adressähnliche Fließtext-Fragmente, Anreden und Satzreste gezielt nachschärfen
3. automatische Variantenbildung für eigene Regeln fachlich schärfen und auf nachvollziehbare Fälle begrenzen
4. Diagnose- und Editor-Kommunikation bei Bedarf ergänzen, damit neue Varianten und verworfene Fragmente erklärbarer werden
5. Regressionen ausbauen und gegen typische Brief-, Formular- und Zwischenablagefälle absichern
