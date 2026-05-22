# PROJ-23 – Onboarding- und Regeln-Editor-UX nachschärfen

**Status**: Abgeschlossen

## Ziel

Die ersten Produkttexte und der Regeln-Editor sollen so nachgeschärft werden, dass neue Nutzer Inkognito nicht nur als Schwärzungswerkzeug verstehen und die Arbeit mit eigenen Regeln ohne unnötige Scroll- oder Verständnisbarrieren abschließen können.

## Schwerpunkte

- Begrüßungsbildschirm klar auf Anonymisieren und Dateien ausrichten
- Nutzen von PDFs, Bildern und Zwischenablage im Onboarding deutlicher benennen
- Regeln-Editor so anpassen, dass der Abschluss auch am unteren Seitenende direkt erreichbar bleibt
- Formulierungen zu eigenen Regeln und abgeleiteten Teilregeln verständlicher machen

## Wichtige Vorsichtspunkte

- keine Produktaussagen einführen, die technische Fähigkeiten überziehen
- bestehende Regeln-Logik nicht verändern, nur ihre Kommunikation und Bedienbarkeit
- vorhandene Review- und Export-Begriffe konsistent zu den übrigen App-Flächen halten

## Relevante Dateien

- `Inkognito/Views/Intro/IntroView.swift`
- `Inkognito/Views/Main/MainView.swift`
- `docs/architecture.md`
- das fruehere Commercial-Readiness-Audit bleibt als Referenz im vorherigen Repository

## Ergebnis

- Der Begrüßungsbildschirm spricht klarer über PDFs, Bilder, kopierte Texte und den lokalen Charakter der Anonymisierung.
- Der Zwischenablage-/KI-Flow ist im Onboarding jetzt sichtbar, ohne den Einstieg zu überladen.
- Der Regeln-Editor erklärt eigene Regeln, Variantenbildung und Dokumentvorschau verständlicher und weniger technisch.
- Die feste Abschlussleiste am unteren Rand bleibt der bevorzugte Abschlussweg, damit Nutzer nicht zurück an den Seitenanfang scrollen müssen.
