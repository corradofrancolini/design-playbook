---
name: accessibility
description: Audit accessibilita WCAG 2.1/2.2 AA
---

# Accessibility Audit

Agente specializzato in accessibilita web. Verifica conformita WCAG 2.1/2.2 livello AA.

## Quando invocare

- Prima di rilasciare una pagina/componente
- Dopo modifiche significative all'UI
- Per audit periodici
- Quando aggiungi contenuti multimediali

## Azioni

### 1. Identifica scope

Chiedi all'utente cosa verificare:
- **Componente**: nome file
- **Pagina**: route
- **Intero sito**: audit completo

### 2. Esegui audit

Usa la checklist sotto. Per ogni sezione, verifica i criteri applicabili.

### 3. Report

```
## Accessibility Audit

**Scope**: [componente/pagina]
**Data**: [data]
**Livello target**: WCAG 2.1 AA

### Risultati

| Categoria | Pass | Fail | N/A |
|-----------|------|------|-----|
| Visual Design | 0 | 0 | 0 |
| Interactions | 0 | 0 | 0 |
| Focus & Keyboard | 0 | 0 | 0 |
| Navigation | 0 | 0 | 0 |
| Content | 0 | 0 | 0 |

### Issues trovati

#### [Critico] X.X.X - [titolo criterio]
- **Dove**: [componente/sezione]
- **Problema**: [descrizione]
- **Fix proposto**: [soluzione]
```

### 4. Visual Fix Picker

Genera una pagina HTML standalone per visualizzare ogni issue con le opzioni di fix affiancate, permettendo di scegliere visivamente la soluzione preferita.

**Output**: `lab/audits/accessibility-fixes-visual.html`

**Struttura pagina**:
- Header con titolo e legenda
- Card per ogni issue identificato
- Ogni card contiene:
  - Titolo issue + criterio WCAG
  - Descrizione problema
  - Grid con opzioni: **Attuale** | **Fix A** | **Fix B**
  - Componente renderizzato in ogni cella con gli stili del progetto
  - Label descrittiva sotto ogni opzione

**Tecnologie**:
- Standalone HTML (no build step)
- CSS framework CDN (adattare al progetto)
- Font del progetto via CDN o riferimento locale
- CSS custom con palette del progetto
- Vanilla JavaScript per selezione interattiva (opzionale)

**Esempio struttura card**:
```html
<div class="issue-card">
  <h3>[Critico] 1.4.1 -- Link non distinguibili senza colore</h3>
  <p>I link si distinguono dal testo circostante solo per il colore.</p>

  <div class="options-grid">
    <div class="option current">
      <div class="preview">Esplora &rarr;</div>
      <span class="label">Attuale (solo colore)</span>
    </div>
    <div class="option fix-a">
      <div class="preview"><u>Esplora &rarr;</u></div>
      <span class="label">Fix A: sempre underline</span>
    </div>
    <div class="option fix-b">
      <div class="preview"><b>Esplora &rarr;</b></div>
      <span class="label">Fix B: bold + freccia</span>
    </div>
  </div>
</div>
```

**Dopo la generazione**: aprire il file nel browser per review visiva.

### 5. Proponi fix

Proponi le modifiche specifiche e **attendi conferma** prima di applicarle.

---

## Checklist Accessibilita

### Visual Design — Colore

- [ ] **1.4.1** Il colore NON e l'unico modo per comunicare informazioni (errori, stati, grafici)
- [ ] **1.4.3** Contrasto testo:
  - 4.5:1 per testo < 24px (o < 19px bold)
  - 3:1 per testo >= 24px (o >= 19px bold)
- [ ] **1.4.11** Componenti UI non-testo: almeno 3:1 contro bordi e colori adiacenti
- [ ] **1.4.11** Stato focus visibile: almeno 3:1 contro sfondo
- [ ] Combinazioni colore documentate per ogni stato (success, error, warning, info)

### Visual Design — Tipografia

- [ ] **1.4.4** Testo ingrandibile al 200% senza perdita di contenuto/funzionalita
  - No altezze fisse su bottoni
  - No overflow: hidden su box di testo
  - Layout si adatta a font grandi
  - Gerarchia mantenuta (H1 > H2 > H3...)
  - No troncamento quando il testo cresce
- [ ] **1.4.12** Supporto text spacing personalizzato:
  - Line height almeno 1.5x font size
  - Paragraph spacing almeno 2x font size
  - Letter spacing almeno 0.12x font size
  - Word spacing almeno 0.16x font size

### Tipografia — Best Practice

- [ ] Testo selezionabile (per traduzioni, copia)
- [ ] Evitare font ultra-light e light
- [ ] Evitare testo giustificato, preferire allineamento a sinistra
- [ ] Larghezza contenuto limitata (~80 caratteri per script latini)
- [ ] Evitare italic e ALL CAPS per passaggi lunghi
- [ ] Underline solo per link
- [ ] Font leggibile: caratteri distinguibili (iIlL10oO)

### Interazioni — Bottoni e Link

- [ ] **1.4.1** Link in blocchi di testo distinguibili non solo per colore (underline)
- [ ] **2.4.4** Label chiare e descrittive — l'utente capisce cosa succede al click
- [ ] **3.2.4** Stessa destinazione = stessa label consistente
- [ ] **1.3.3** Evitare istruzioni basate su forma/colore ("clicca il bottone rosso")
- [ ] Link a file: indicare formato e dimensione
- [ ] **3.2.5** Evitare apertura in nuova tab; se necessario, avvisare l'utente
- [ ] Stati link documentati: default, hover, focus, active, visited
- [ ] Stati bottone documentati: default, hover, focus, active, disabled, selected, loading
- [ ] **2.5.8** Target size almeno 24x24 CSS pixels
- [ ] **2.5.5** Touch target mobile almeno 44x44 CSS pixels (AAA)
- [ ] Spacing tra target touch almeno 8px

### Interazioni — Form (3.3)

- [ ] Stati form documentati: default vuoto, default compilato, focused, disabled, checked, unchecked
- [ ] Stati status documentati: default, error, success, warning, info
- [ ] **1.3.1** Tutti i campi hanno label visibile (o programmatica)
- [ ] Label collegata al campo (for + id)
- [ ] Label NON e un placeholder
- [ ] **3.3.2** Label chiara su come compilare il campo
- [ ] Label vicina al campo
- [ ] **3.2.4** Label consistenti nell'interfaccia
- [ ] **3.3.2** Campi obbligatori indicati
- [ ] **3.3.2** Formato atteso chiaro (con esempi)
- [ ] **3.3.4** Per dati legali/finanziari: possibilita di annullare, rivedere, confermare
- [ ] **1.4.1** Errori NON mostrati solo con colore
- [ ] **3.3.1** Messaggi errore chiari e comprensibili
- [ ] **3.3.3** Suggerimenti di correzione
- [ ] **3.3.7** Non richiedere lo stesso input due volte nella stessa sessione
- [ ] **3.3.8** Autenticazione: permettere copia/incolla password, 2FA, biometrico
- [ ] **1.3.1** Campi correlati raggruppati visivamente e programmaticamente

### Focus e Tastiera

#### Skip Link

- [ ] **2.4.1** Skip link presente per bypassare contenuto ripetuto (nav)
- [ ] Skip link e il primo elemento focusable della pagina

#### Ordine Focus

- [ ] Stato focus documentato per elementi interattivi
- [ ] **2.4.3** Ordine focus logico a livello di pagina
- [ ] **2.4.3** Ordine focus logico a livello di componente
- [ ] **2.1.2** Nessun focus trap (l'utente puo sempre uscire)
- [ ] **2.4.11** Elemento con focus mai completamente coperto da altro contenuto

#### Interazioni Componenti

- [ ] **2.1.1** Tutti gli elementi interattivi raggiungibili e attivabili via tastiera
- [ ] **3.2.1** Nessun cambio contesto al focus (solo all'attivazione)
- [ ] **2.4.3** Ordine focus significativo nel componente
- [ ] **1.4.13** Componente dismissibile senza spostare il focus (es. Escape)
- [ ] **2.1.2** Nessun keyboard trap
- [ ] **1.4.13** Contenuto su hover/focus: dismissibile, persistente, non scompare

#### Gesti e Trascinamento

- [ ] **2.5.1** Alternative a gesti complessi (multi-finger, path-based)
- [ ] **2.5.1** Alternativa single-pointer per trascinamento
- [ ] **2.5.4** Alternativa UI per motion actuation (shake dispositivo, etc.)
- [ ] Indicazione visiva per scroll orizzontale

### Navigazione

#### Ordine Lettura Screen Reader

- [ ] **1.3.2** Ordine lettura documentato se diverso dal visivo (caso raro)

#### Navigazione Cross-Page

- [ ] **3.2.3** Navigazione consistente nel sito
- [ ] **2.4.5** Piu modi per trovare contenuto (nav + ricerca, nav + sitemap)
- [ ] **3.2.6** Funzione aiuto in posizione consistente

#### Headings

- [ ] **2.4.6** Heading consistenti e descrittivi
- [ ] **1.3.1** Ordine heading logico (no h2 dopo h3)
- [ ] **1.3.1** Usare tag Hn, non paragrafi stilizzati come heading
- [ ] **1.3.1** Non usare heading per styling
- [ ] Un solo H1 per pagina
- [ ] No salti di livello (h1 -> h4)

#### Titoli e Landmark

- [ ] **2.4.2** Title HTML informativo e unico per pagina
- [ ] **1.3.1** Landmark regions identificate (header, nav, main, footer)

### Contenuto

#### Accesso Screen Reader

- [ ] **1.1.1** Screen reader puo navigare tutto il contenuto
- [ ] **1.4.5** Testo usato invece di immagini di testo
- [ ] **1.1.1** Alternative per contenuto non-testo

#### Immagini

- [ ] **1.1.1** Alt text per immagini non decorative
- [ ] **1.1.1** Alt text per icone senza label visibile
- [ ] Descrizione dettagliata per immagini complesse (infografiche, data viz)

#### Multimedia

- [ ] Evitare autoplay dei media
- [ ] **1.2.1** Trascrizione per solo audio
- [ ] **1.2.1** Descrizione/traccia audio per solo video
- [ ] **1.2.2** Sottotitoli per video con audio
- [ ] **1.2.3** Alternativa testuale descrittiva per video
- [ ] **1.2.5** Audio descrizione per video (AA)
- [ ] **1.2.4** Sottotitoli per audio live
- [ ] **1.4.2** Controllo per audio che parte automaticamente (>3s)
- [ ] **1.3.3** Alternativa visiva per informazioni audio

#### Grafici e Diagrammi

- [ ] **1.4.1** Informazioni non trasmesse solo tramite colore
- [ ] **1.4.3** Testo nei grafici con contrasto sufficiente
- [ ] **1.4.11** Elementi grafici con 3:1 contro adiacenti
- [ ] **1.1.1** Alternativa testuale per grafici
- [ ] Navigazione tastiera per grafici interattivi

#### Tabelle

- [ ] **1.3.1** Tabelle semplici: caption + heading riga/colonna
- [ ] **1.3.1** Tabelle complesse: caption + heading + sommario
- [ ] Navigazione riga/colonna con tecnologia assistiva
- [ ] NO tabelle per layout

#### Orientamento Schermo

- [ ] **1.3.4** Non bloccare cambio orientamento
- [ ] Supporto portrait e landscape
- [ ] Contenuto visibile in entrambi gli orientamenti

#### Movimento e Flash

- [ ] **2.2.2** Controllo per contenuto in movimento (>5s): play/stop/nascondi
- [ ] **2.3.3** Alternativa reduced-motion per animazioni
- [ ] **2.3.1** Nessun flash >3 volte/secondo

#### Limiti di Tempo

- [ ] **2.2.1** Controllo limiti di tempo: sopprimibile, estendibile, o avviso 20s

#### Notifiche e Stato

- [ ] Scelta modalita notifica (visiva, sonora, vibrazione)
- [ ] **4.1.3** Screen reader informato di cambiamenti contenuto/layout
- [ ] Transizioni pagina/popup identificate per screen reader
