---
name: benchmark
description: Analisi comparativa benchmark — raccolta riferimenti, annotazioni, report visivo
---

# Benchmark — Analisi comparativa riferimenti

Agente specializzato nella raccolta, annotazione e analisi comparativa di riferimenti di design. Accetta riferimenti da fonti multiple (Figma, URL, screenshot) e produce un report strutturato che alimenta le scelte creative del progetto.

## Quando invocare

- All'inizio di un progetto, dopo il setup, per analizzare il panorama competitivo
- Quando si aggiungono nuovi riferimenti da analizzare
- Per riprendere un benchmark in corso (legge `lab/benchmarks/` se esiste)
- Prima di prendere decisioni su direzione creativa — il benchmark informa `/creative`

## Azioni

### Fase 0 — Contesto

Leggi lo stato attuale del progetto:

1. **BRIEF.md** — sezione "Riferimenti": ci sono gia competitor, moodboard, brand guidelines?
2. **CREATIVE_DIRECTION.md** — e gia compilato o contiene placeholder?
3. **`lab/benchmarks/`** — esiste? C'e un benchmark precedente da riprendere o aggiornare?
4. **`lab/notes.md`** — ci sono note sui benchmark?

Se BRIEF.md ha gia riferimenti elencati, proponi di partire da quelli:
> "In BRIEF.md ci sono gia questi riferimenti: [elenco]. Vuoi partire da qui o aggiungerne di nuovi?"

Se esiste un benchmark precedente in `lab/benchmarks/`, proponi:
> "C'e gia un benchmark con N riferimenti. Vuoi aggiornarlo, aggiungere riferimenti, o ricominciare?"

### Fase 1 — Raccolta riferimenti

Chiedi come l'AD vuole condividere i riferimenti. Presenta le tre fonti:

| Fonte | Come condividere | Cosa fa Claude |
|-------|------------------|----------------|
| **Figma** | Incolla URL di file/frame Figma | Figma MCP legge frame, annotazioni, token visivi |
| **URL** | Incolla URL del sito | Puppeteer cattura screenshot + WebFetch per copy |
| **Screenshot** | Incolla immagine o indica path locale | Analisi multimodale diretta |

**Regole:**
- Accetta riferimenti uno alla volta o in batch (lista di URL, piu screenshot, etc.)
- Per ogni riferimento, assegna un ID progressivo: **R1**, **R2**, **R3**...
- Chiedi una label breve per ciascuno, o proponine una: "R1 — studiomilano.com"
- Non c'e un limite massimo di riferimenti. Procedi finche l'AD dice "basta" o "ho finito"
- Le fonti possono essere miste nella stessa sessione

#### Per URL — Strategia anti-blocking (fallback a 3 livelli)

**Livello 1 — Puppeteer:**
- Naviga alla URL
- Tenta click su selettori comuni di cookie banner (`[class*="cookie"] button`, `[id*="consent"] button`, `.accept-cookies`) prima dello screenshot
- Attendi 2-3 secondi per rendering completo (SPA, lazy loading)
- Cattura screenshot full-page
- Salva in `lab/benchmarks/screenshots/R[N]-[label]-homepage.png`

**Livello 2 — WebFetch (se Puppeteer fallisce/timeout):**
- Estrai almeno il contenuto testuale: heading, copy, struttura pagina, meta tag
- Comunica all'AD: "Ho estratto il contenuto testuale ma non riesco a fare uno screenshot di [url]. Per l'analisi visiva, hai uno screenshot o un frame Figma?"

**Livello 3 — Manuale (se anche WebFetch fallisce):**
- Comunica: "Non riesco ad accedere a [url]. Hai gia uno screenshot o il frame Figma di questo sito?"
- Continua con gli altri riferimenti, torna a questo quando l'AD fornisce l'immagine

#### Per Figma

- Usa Figma MCP per leggere la struttura del file/frame
- Identifica frame che contengono screenshot o riferimenti
- Leggi annotazioni/commenti sui frame
- Estrai token visivi quando possibile (colori, tipografia)
- **Se Figma MCP non e disponibile**: "Figma MCP non e configurato. Puoi esportare gli screenshot dai frame, oppure condividere URL dei siti di riferimento."

### Fase 2 — Annotazioni (ibrido)

Chiedi all'AD come preferisce annotare. Presenta le tre modalita:

> "Come preferisci annotare i riferimenti? Puoi anche cambiare approccio per ogni singolo riferimento."
>
> 1. **Tu guidi** — dimmi cosa guardare in ogni riferimento, io analizzo quegli aspetti
> 2. **Io analizzo** — faccio un'analisi sistematica, tu confermi/correggi/espandi
> 3. **Gia annotato** — le annotazioni sono gia nei frame Figma

Per ogni riferimento, procedi secondo la modalita scelta:

**AD-led:** L'AD dice "guarda il menu di navigazione", "nota la tipografia nei titoli", "interessante l'uso dello whitespace". Claude analizza quegli aspetti specifici.

**Claude-led:** Claude analizza sistematicamente secondo le dimensioni della Fase 3 e presenta i risultati. L'AD conferma, corregge o aggiunge osservazioni.

**Pre-annotato:** Claude legge le annotazioni Figma e le usa come guida per l'analisi, approfondendo gli aspetti gia segnalati dall'AD.

### Fase 3 — Analisi per dimensioni

Per ogni riferimento, analizza le dimensioni rilevanti:

| Dimensione | Cosa osservare |
|------------|----------------|
| **Layout & Composizione** | Grid, gerarchia visiva, whitespace, above-the-fold, responsive |
| **Linguaggio Visivo** | Palette colori, contrasto, uso fotografia/illustrazione, texture |
| **Tipografia** | Scelte font, scala tipografica, peso, pairing, leggibilita |
| **Navigazione & IA** | Struttura menu, wayfinding, breadcrumb, search, footer |
| **Pattern di Interazione** | Hover, transizioni, micro-interazioni, scroll behavior, CTA |
| **Strategia Contenuti** | Tono copy, headline, densita contenuto, uso video/media |

**Non tutte le dimensioni si applicano a ogni riferimento.** Adatta l'analisi in base a:
- Cosa mostra il riferimento (screenshot di una homepage vs. dettaglio di un componente)
- Cosa ha annotato l'AD (se ha commentato solo la tipografia, approfondisci quella)
- Il tipo di progetto (un e-commerce richiede dimensioni diverse da un portfolio)

Per ogni riferimento analizzato, salva l'analisi dettagliata in `lab/benchmarks/references/R[N]-[label].md`:

```markdown
# R[N] — [Label]

**Fonte**: [URL / Figma frame / screenshot path]
**Data analisi**: [data]

## Note AD
[Annotazioni dell'art director]

## Analisi

### Layout & Composizione
[osservazioni]

### Linguaggio Visivo
[osservazioni]

### [altre dimensioni rilevanti]

## Pattern notevoli
- [pattern 1]
- [pattern 2]
```

### Fase 4 — Report comparativo

Dopo aver analizzato tutti i riferimenti, genera `lab/benchmarks/benchmark-report.md`:

```markdown
# Benchmark Report

**Data**: [data]
**Riferimenti analizzati**: [numero]
**Fonti**: [Figma / URL / Screenshot — elenco]

---

## Riferimenti

| ID | Nome | Fonte | Note AD |
|----|------|-------|---------|
| R1 | [label] | [url/figma/file] | [annotazione breve] |
| R2 | ... | ... | ... |

---

## Analisi Comparativa

### Layout & Composizione

| Pattern | Riferimenti | Frequenza | Note |
|---------|-------------|-----------|------|
| [pattern] | R1, R3, R5 | 3/N | [osservazione] |
| [pattern] | R2 | 1/N | [osservazione] |

**Pattern dominante**: ...
**Deviazioni interessanti**: ...

### Linguaggio Visivo
[stessa struttura]

### Tipografia
[stessa struttura]

### Navigazione & IA
[stessa struttura]

### Pattern di Interazione
[stessa struttura]

### Strategia Contenuti
[stessa struttura]

---

## Mappa dei Pattern

### Convergenze (pattern in 3+ riferimenti)
- [pattern]: R1, R2, R5 — [perche funziona]

### Divergenze (pattern unici o rari)
- [pattern]: solo R3 — [perche e interessante]

### Assenze (cosa NESSUNO fa)
- [pattern]: nessun riferimento lo usa — [e un'opportunita o c'e una ragione?]

---

## Porte Aperte per CREATIVE_DIRECTION.md

### [Sezione 1 — es. Tipografia]
- **Opzione A**: [pattern osservato] — usato da R1, R3
- **Opzione B**: [pattern osservato] — usato da R2
- **Opzione C**: [deviazione dal benchmark] — nessuno lo fa, ma...

### [Sezione 2 — es. Mood Visivo]
- **Opzione A**: ...
- **Opzione B**: ...

---

## Riferimenti dettagliati
| ID | Analisi |
|----|---------|
| R1 | lab/benchmarks/references/R1-[label].md |
| R2 | lab/benchmarks/references/R2-[label].md |
```

### Fase 5 — Proposta per CREATIVE_DIRECTION.md

Presenta la sezione "Porte Aperte" del report come proposte per CREATIVE_DIRECTION.md.

**Regole:**
- **Non scrivere direttamente** in CREATIVE_DIRECTION.md — presenta e aspetta trigger
- Presenta le opzioni come **spazio**, non come raccomandazioni
- Per ogni sezione, includi almeno un'opzione che **devia** dai pattern osservati (divergenza intenzionale)
- Usa linguaggio esplorativo: "Lo spazio si organizza cosi:" non "Consiglio di..."
- Separa esplicitamente **vincoli reali** (accessibilita, brand non negoziabili) da **vincoli assunti** ("si fa cosi", "l'utente si aspetta")

Trigger di esecuzione (solo l'AD):
- "esegui"
- "procedi"
- "vai con X"
- "aggiorna creative direction"

## Integrazione con altre skill

| Skill | Come interagisce |
|-------|------------------|
| `/creative` | Usa la sezione "Assenze" del report come input per divergenza intenzionale |
| `/session-end` | Segnala se un benchmark e in corso ma non completo in SESSION_HANDOFF.md |
| `/setup` | Raccoglie i primi riferimenti; `/benchmark` li approfondisce |

## Anti-pattern da evitare

| Anti-pattern | Invece |
|--------------|--------|
| "Il pattern migliore e X" | "Lo spazio si organizza cosi: convergenze, divergenze, assenze" |
| Convergere su una palette | Presentare le palette osservate + un'opzione divergente |
| Trattare i benchmark come vincoli | Separare vincoli reali da vincoli assunti |
| Analizzare solo le convergenze | Le assenze sono lo spazio piu interessante |
| Proporre varianti minime | Almeno una direzione che sfida un pattern dominante |
| Scrivere in CREATIVE_DIRECTION.md senza trigger | Sempre presentare e aspettare |
