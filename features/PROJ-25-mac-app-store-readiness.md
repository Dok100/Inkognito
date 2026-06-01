# PROJ-25 - Mac App Store Readiness

**Status**: In Arbeit

## Ziel

`Inkognito` soll so vorbereitet werden, dass eine spaetere Veroeffentlichung im Mac App Store realistisch planbar wird, ohne den bestehenden Direct-Distribution- und Sparkle-Pfad zu zerstoeren.

## Anlass

Mit dem jetzt verifizierten Apple-Developer-Distributionspfad fuer notarisiertes `dmg` und dem neuen Sparkle-/GitHub-Release-Pfad aus `PROJ-22` ist der Mac App Store nicht mehr nur eine abstrakte Zukunftsoption, sondern ein eigener Folgepfad mit zusaetzlichen technischen, produktseitigen und prozessualen Anforderungen.

## Aktueller Befund

Bereits vorhanden:

- App Sandbox ist aktiv
- `com.apple.security.files.user-selected.read-write`
- `com.apple.security.network.client`
- Bundle Identifier `de.okern.inkognito`
- funktionierender Archive-/Export-/Notarisierungsablauf fuer Direct Distribution
- klarer Produktfokus auf lokale Verarbeitung statt Cloud-Zwang

Noch offen oder kritisch fuer Mac App Store:

- Sparkle-/Feed-Logik ist fuer Direct Distribution gedacht und fuer App-Store-Builds voraussichtlich nicht passend
- `SUFeedURL` und `SUPublicEDKey` stehen aktuell im globalen `Info.plist`
- Sparkle-bezogene Mach-Lookup-Ausnahmen sind in den Entitlements noch aktiv
- es gibt noch keinen getrennten App-Store-Buildpfad
- App-Store-Connect-Metadaten, Screenshots, Datenschutzangaben und Review-Notizen sind noch nicht vorbereitet
- unklar ist noch, wie Apple den Modell-Download, Clipboard-Flow und Netzwerknutzung im Review einordnet

## Warum das ein eigenes Projekt ist

Der Mac App Store ist nicht nur ein anderer Upload-Kanal. Fuer `Inkognito` haengen daran mehrere voneinander getrennte Themen:

1. anderer Distributionspfad statt Developer-ID-`dmg`
2. anderer Update-Mechanismus statt Sparkle
3. zusaetzliche Review- und Policy-Fragen
4. App-Store-Connect-Aufwand fuer Listing, Datenschutz und Freigabeprozess

Diese Fragen sollen nicht still in `PROJ-22` oder `PROJ-24` hineinrutschen, weil dort der aktuelle funktionierende Direct-Distribution-Pfad bereits bewusst separat stabilisiert wurde.

## Readiness-Gaps fuer Inkognito

### 1. Distribution und Build

- App-Store-spezifischen Exportpfad dokumentieren und testen
- pruefen, ob zusaetzliche Signing-/Provisioning-Anpassungen fuer App Store Connect noetig sind
- separaten Build-Modus oder getrennte Build-Konfiguration fuer `Direct Distribution` und `App Store` definieren

### 2. Sparkle und Update-Logik

- Sparkle fuer App-Store-Builds deaktivieren oder sauber ausklammern
- `SUFeedURL` und `SUPublicEDKey` nicht blind in App-Store-Builds mitschleppen
- Sparkle-bezogene Mach-Lookup-Ausnahmen in App-Store-Entitlements hinterfragen

### 3. Sandbox und Berechtigungen

- bestaetigen, dass der dokumentbasierte Dateizugriff ueber `user-selected.read-write` fuer alle Kernflows ausreicht
- pruefen, ob Clipboard-Flow, Dateiimporte und Exporte im App-Store-Kontext sauber erklaerbar bleiben
- Netzwerkzugriffe klar dokumentieren:
  - Modell-Download
  - eventuelle Update-/Metadatenaufrufe

### 4. Produkt- und Review-Risiken

- erklaeren, dass sensible Inhalte lokal verarbeitet werden
- App-Review-taugliche Beschreibung fuer OCR, Modell-Download und Zwischenablage vorbereiten
- pruefen, ob Apple Rueckfragen zu Datenschutz, lokaler KI-Nutzung oder Datenherkunft stellen koennte

### 5. App Store Connect

- Produktbeschreibung, Untertitel und Keywords vorbereiten
- Screenshots fuer macOS erstellen
- Datenschutzangaben und Support-URL vorbereiten
- TestFlight- oder internen Review-Pfad fuer macOS festziehen

## Relevante Dateien

- `Info.plist`
- `Inkognito/Inkognito.entitlements`
- `Inkognito.xcodeproj/project.pbxproj`
- `features/PROJ-22-sparkle-distribution-reset.md`
- `docs/release-checklist.md`
- `docs/apple-direct-distribution.md`
- spaetere App-Store-Connect-Artefakte

## Zielbild

Am Ende dieses Projekts soll klar sein:

- ob `Inkognito` kurzfristig realistisch in den Mac App Store kann
- welche Build- und Konfigurationsunterschiede zwischen `Direct Distribution` und `App Store` gebraucht werden
- welche Review-Risiken vorab entschärft oder dokumentiert werden muessen
- welcher Restaufwand nur noch operativ in App Store Connect liegt

## Definition of Done

`PROJ-25` gilt erst dann als abgeschlossen, wenn:

1. die App-Store-spezifischen Gaps fuer `Inkognito` als Liste `bereit / umzubauen / review-riskant` dokumentiert sind
2. entschieden ist, wie Sparkle und Feed-Logik fuer App-Store-Builds behandelt werden
3. ein separater App-Store-Buildpfad oder eine klare Build-Strategie beschrieben ist
4. die produktseitigen Review-Risiken fuer Modell-Download, Zwischenablage und lokale Verarbeitung dokumentiert sind
5. der App-Store-Connect-Restaufwand als operativer Folgeblock klar beschrieben ist

## Empfohlene Naechste Schritte

1. `Info.plist` und Entitlements auf App-Store-unvertraegliche oder unnoetige Sparkle-Reste pruefen
2. Build-Strategie `Direct Distribution` vs. `App Store` explizit aufschreiben
3. App-Review-Risiken fuer Modell-Download, OCR und Clipboard-Flow als kurze Review-Notiz formulieren
4. App-Store-Connect-Checkliste fuer Listing, Datenschutz und Screenshots vorbereiten

## Abgrenzung

Nicht Teil dieses Projekts:

- der laufende Sparkle-GitHub-Release-Pfad aus `PROJ-22`
- der notarisierten Direct-Distribution-Pfad aus `PROJ-24`
- sofortige Umstellung auf In-App-Kauf, Lizenzserver oder Preislogik
- tatsaechlicher Upload eines Mac-App-Store-Builds ohne vorherige Gap-Klaerung
