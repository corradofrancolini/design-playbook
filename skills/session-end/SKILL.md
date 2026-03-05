---
name: session-end
description: Chiude la sessione creando handoff, session log, e proponendo salvataggio
---

# Session End

L'utente sta per chiudere la sessione. Devi creare l'handoff, il session log e proporre di salvare.

## Fase 0 — Identificazione

Se non conosci il nome dell'utente dalla conversazione:
1. Controlla la lista Team in CLAUDE.md
2. Chiedi: "Con che nome salvo questa sessione?"
3. Fallback: usa `git config user.name` se disponibile

Usa il nome per i filename e il campo Autore.

## Fase 1 — Leggi lo stato

Prima di creare l'handoff, leggi il file piu recente in `docs/handoffs/` per capire da dove si era partiti (potrebbe essere di un'altra persona).

## Fase 2 — Crea handoff

Crea un nuovo file in `docs/handoffs/` con naming: `YYYY-MM-DD_HH-MM_nome.md`

Contenuto del file:

```markdown
# Handoff — [DATA] [ORA]

**Autore:** [nome]

---

## Stato Attuale

- [cosa funziona]
- [cosa e in progress]
- [cosa e bloccato]

---

## Lavoro Completato

1. [Task 1]
2. [Task 2]

---

## Prossimo Step Immediato

- [1 azione concreta]

---

## Problemi Aperti

[lista o "Nessuno"]

---

## File Modificati

| File | Tipo modifica | Note |
|------|---------------|------|
| `path/to/file` | Creato/Modificato | [breve descrizione] |
```

## Fase 3 — Crea/Aggiorna Session Log

Crea `docs/sessions/YYYY-MM-DD_nome.md` usando il template in `docs/sessions/TEMPLATE.md`.

Se esiste gia un session log per lo stesso giorno e la stessa persona, aggiungi il lavoro fatto.

Compila il campo **Autore** con il nome dell'utente.

## Fase 4 — Aggiorna lab/notes.md (se applicabile)

Se ci sono appunti dalla sessione non ancora annotati, aggiungili.
Usa la convenzione: `## [DATA] — [nome]` come intestazione del blocco.

## Fase 5 — Aggiorna CREATIVE_DIRECTION.md (se applicabile)

Se in questa sessione sono state prese decisioni di design mature, trasferiscile da `lab/notes.md` a `CREATIVE_DIRECTION.md`.

Compila la colonna **Chi** con il nome dell'utente.

## Fase 6 — Salvataggio e sincronizzazione

Se il progetto e un repository git:

1. **Mostra** i file modificati in questa sessione (`git status`)
2. **Chiedi**: "Vuoi salvare i cambiamenti?"
   - Se SI: proponi un messaggio di salvataggio basato sul lavoro fatto
     (es. "Aggiornata palette colori e tipografia heading")
   - Se NO: skip (i file restano modificati localmente)
3. Se esiste un remote e l'utente ha salvato:
   - **Chiedi**: "Vuoi sincronizzare con il team?"
   - Se SI: pull prima (per integrare cambiamenti altrui), poi push
   - Se ci sono conflitti: spiega in linguaggio semplice cosa e successo
     e proponi la risoluzione
   - Se NO: skip (il salvataggio resta locale)

**Linguaggio da usare con il team:**
- "salvare" → git add + commit
- "sincronizzare" → git pull + push
- "i cambiamenti di [nome]" → commit altrui
- "sovrapposizione" → merge conflict

## Fase 7 — Conferma

Dopo aver completato tutto, conferma all'utente:
- Quali file sono stati aggiornati
- Se il lavoro e stato salvato e sincronizzato
- Riepilogo brevissimo dello stato
- "Puoi chiudere la sessione."
