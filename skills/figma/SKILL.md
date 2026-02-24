---
name: figma
description: Integrazione bidirezionale con Figma — benchmark, token, prototipazione
---

# Figma — Integrazione bidirezionale

Agente specializzato nell'uso di Figma come strumento di lavoro nel workflow AD + AI.

## Contesto

Figma **non e la source of truth**. Il codice e la fonte primaria. Figma si usa per esplorare, documentare, raffinare — non per generare.

**Prerequisito**: MCP Figma configurato. Setup (una volta per macchina):

```bash
claude mcp add --transport http figma https://mcp.figma.com/mcp
```

**Tool MCP disponibili**:

| Tool | Cosa fa |
|------|---------|
| `get_design_context` | Rappresentazione strutturata di una selezione Figma |
| `get_variable_defs` | Variabili e stili: colori, spacing, tipografia |
| `get_screenshot` | Screenshot di una selezione per riferimento visivo |
| `get_metadata` | Mappa XML con layer ID, nomi, tipi, posizioni |
| `get_code_connect_map` | Mappatura tra nodi Figma e componenti nel codice |
| `create_design_system_rules` | Genera regole per allineare il codice al design system |
| `get_figjam` | Metadati da diagrammi FigJam |

## Quando invocare

- **Fase esplorativa**: leggere benchmark o moodboard da file Figma
- **Estrazione token**: estrarre variabili, colori, tipografia, spacing da Figma
- **Prototipazione verso Figma**: catturare UI dal browser e inviarla a Figma per editing granulare
- **Documentazione**: esportare design system implementato verso Figma per brand guidelines o type specimen

## Azioni

### 1. Benchmark e Moodboard

Chiedi all'utente il file o la pagina Figma di riferimento.

1. Usa `get_screenshot` per cattura visiva dei frame rilevanti
2. Usa `get_design_context` per struttura e composizione
3. Usa `get_metadata` per dati dei layer (gerarchia, dimensioni, posizioni)
4. Se presenti variabili: usa `get_variable_defs` per estrarre i token usati

Output:

```
## Figma Benchmark

### File
[nome e link file Figma]

### Riferimenti visivi
[screenshot e descrizione per ciascun frame analizzato]

### Pattern rilevati
- Layout: ...
- Spacing: ...
- Tipografia: ...
- Colori: ...

### Note per AD
- ...
```

### 2. Estrazione Token

Chiedi all'utente il file Figma con le variabili definite.

1. Usa `get_variable_defs` per estrarre colori, tipografia, spacing
2. Leggi `CREATIVE_DIRECTION.md` per i valori attuali nel progetto
3. Cross-referenzia: cosa e allineato, cosa diverge
4. **Se i token Figma divergono dal codice, il codice ha priorita.** Segnala la discrepanza, non sovrascrivere.

Output:

```
## Token Extraction

### Fonte
[file Figma]

### Colori
| Nome | Valore Figma | Variabile CSS | Allineato |
|------|-------------|---------------|-----------|
| ... | ... | ... | si/no |

### Tipografia
| Nome | Valore Figma | Token Codice | Allineato |
|------|-------------|-------------|-----------|
| ... | ... | ... | si/no |

### Spacing
| Nome | Valore Figma | Token Codice | Allineato |
|------|-------------|-------------|-----------|
| ... | ... | ... | si/no |

### Discrepanze
[elenco con raccomandazioni — il codice ha priorita]
```

### 3. Prototipo Code → Figma

Il prototipo vive nel codice (`lab/` o `src/`).

1. Verifica lo stato attuale dell'implementazione nel browser
2. Se esiste gia una versione in Figma, usa `get_screenshot` per confrontare
3. Documenta le differenze tra codice e Figma
4. L'AD usa Figma per editing granulare (composizione, spacing, dettagli visivi)
5. Le modifiche fatte in Figma vanno riportate nel codice manualmente — il codice resta la fonte

Output:

```
## Code → Figma Handoff

### Stato attuale (codice)
[descrizione o screenshot della UI implementata]

### Differenze con Figma
[se esiste una versione Figma precedente]

### Note per editing in Figma
- ...
```

### 4. Documentazione Design System

1. Usa `create_design_system_rules` per generare regole allineate al design system
2. Usa `get_code_connect_map` per mappare componenti codice → nodi Figma
3. Produci report di copertura: quali componenti sono mappati, quali mancano

Output:

```
## Design System Coverage

### Componenti mappati
| Componente codice | Nodo Figma | Status |
|-------------------|-----------|--------|
| ... | ... | mappato/mancante |

### Regole generate
[sommario delle design system rules]

### Copertura
[X] componenti mappati su [Y] totali — [Z]% copertura
```

## Principi operativi

- **Source of truth**: SEMPRE il codice. Figma segue, non guida.
- **Bidirezionalita controllata**: dal codice si legge e si scrive verso Figma, ma ogni modifica Figma va validata e riportata nel codice dall'AD.
- **Non convergere**: come in tutte le skill, presentare lo spazio delle possibilita. Il confronto Figma/codice genera opzioni, non decisioni automatiche.
- **Attendi conferma** prima di applicare qualsiasi modifica derivata da Figma.

## FigJam

Se l'AD lavora in FigJam per diagrammi o flussi:

1. Usa `get_figjam` per leggere la struttura del diagramma
2. Produci interpretazione testuale: nodi, connessioni, flusso
3. Usa come input per sessioni di lavoro o per documentare decisioni in `BACKLOG.md`
