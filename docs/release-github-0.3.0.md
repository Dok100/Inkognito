## Inkognito 0.3.0

`0.3.0` macht Inkognito spürbar reifer für den produktiven Einsatz auf dem Mac: bessere Erkennung in echten Dokumenten, klarerer Review-Workflow und stärkere Unterstützung für eigene Regeln.

Inkognito anonymisiert sensible Inhalte lokal auf deinem Gerät. PDFs, Bilder und Zwischenablage-Texte bleiben auf dem Mac, während Erkennung, OCR, Review und Export direkt vor Ort laufen.

### Highlights

- robustere Erkennung für Rechnungen, Formulare, Bankseiten, DIN-5008-Briefe und E-Rechnungen
- klarerer Review-Workflow mit Seitenstatus, sichtbaren Unsicherheiten und schnelleren Sammelaktionen
- verständlichere Export-Zusammenfassung und stärkere Vertrauenssignale nach dem Speichern
- produktreifere Diagnoseansicht mit Developer-Modus und JSON-Export
- stärkere Assistenz für eigene Regeln mit Vorlagen, Qualitäts-Hinweisen und Vorschau im aktuellen Dokument
- konsistentere Sprache und ruhigere Produktkommunikation in der gesamten App

### Technischer Stand

- Detection-Regressionen laufen aktuell mit `202` Checks grün
- `xcodebuild -project Inkognito.xcodeproj -scheme Inkognito -sdk macosx build` ist erfolgreich
- die neue Produktbasis liegt jetzt sauber im Repository `Dok100/Inkognito`

### Bitte beachten

- Bei bestehenden Installationen kann einmalig ein erneuter Modelldownload nötig sein, falls noch ein älterer, nicht revisionsgebundener Cache genutzt wurde.
- Der Sparkle-/Distributionsreset ist nicht Teil dieses Releases und bleibt bewusst separat in `PROJ-22`.
