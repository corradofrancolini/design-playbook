---
name: session-end
description: Chiude la sessione aggiornando SESSION_HANDOFF e session log
---

# Session End

L'utente sta per chiudere la sessione. Devi aggiornare i file di handoff.

## Azioni Obbligatorie

### 1. Aggiorna SESSION_HANDOFF.md

Leggi `SESSION_HANDOFF.md` nella root del progetto e aggiornalo con:

- **Ultimo aggiornamento:** data e ora correnti
- **Ultima sessione:** link al session log di oggi
- **Stato Attuale:** 3 righe max su cosa funziona/in progress/bloccato
- **Ultimo Lavoro Completato:** bullet points del lavoro fatto in questa sessione
- **Prossimo Step Immediato:** 1 azione concreta
- **Problemi Aperti:** lista aggiornata
- **Da Decidere:** tabella aggiornata delle decisioni pendenti
- **File Critici Modificati:** tabella con file modificati oggi

### 2. Aggiorna/Crea Session Log

Se non esiste `docs/sessions/[DATA-OGGI].md`, crealo usando il template in `docs/sessions/TEMPLATE.md`.

Se esiste, aggiungi il lavoro fatto in questa sessione.

### 3. Aggiorna lab/notes.md (se applicabile)

Se ci sono appunti dalla sessione non ancora annotati, aggiungili.

### 4. Aggiorna CREATIVE_DIRECTION.md (se applicabile)

Se in questa sessione sono state prese decisioni di design mature, trasferiscile da `lab/notes.md` a `CREATIVE_DIRECTION.md`.

### 5. Conferma

Dopo aver aggiornato i file, conferma all'utente:
- Quali file sono stati aggiornati
- Riepilogo brevissimo dello stato
- "Puoi chiudere la sessione."
