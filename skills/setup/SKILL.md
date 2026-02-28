---
name: setup
description: Setup guidato del progetto — compila brief, creative direction e configurazione
---

# Setup — Configurazione guidata

Guida interattiva per configurare un nuovo progetto. Compila BRIEF.md, CREATIVE_DIRECTION.md e adatta CLAUDE.md attraverso una conversazione.

## Quando invocare

- Prima sessione operativa su un nuovo progetto
- Quando BRIEF.md e CREATIVE_DIRECTION.md contengono ancora i placeholder

## Azioni

### 1. Controlla stato attuale

Leggi BRIEF.md e CREATIVE_DIRECTION.md. Se sono gia compilati (non contengono placeholder come `[descrizione in una riga]` o `[Da definire dopo benchmark]`), comunica all'utente che il setup e gia stato fatto e chiedi se vuole aggiornare qualcosa di specifico.

Se contengono ancora placeholder, procedi con il setup.

### 2. Brief del progetto (BRIEF.md)

Guida l'utente attraverso ogni sezione, una alla volta. Per ogni domanda, accetta la risposta o "skip" per lasciare il placeholder.

**Sequenza:**

1. **Progetto**
   - "Descrivi il progetto in una riga — cos'e?"
   - "Per chi e? (cliente, stakeholder, organizzazione)"
   - "Qual e l'obiettivo principale?"

2. **Target**
   - "Chi sono gli utenti primari? Profilo, bisogni, contesto d'uso."
   - "Ci sono utenti secondari?"
   - "Contesto d'uso prevalente? (desktop, mobile, in movimento, etc.)"

3. **Scope**
   - "Cosa e incluso nel progetto? (funzionalita, pagine)"
   - "Cosa e esplicitamente escluso?"

4. **Stack tecnico**
   - "Framework? (Next.js, Nuxt, Astro, etc.)"
   - "CMS? (Payload, Sanity, nessuno, etc.)"
   - "Hosting? (Vercel, Netlify, etc.)"
   - "Database? (PostgreSQL, MongoDB, nessuno, etc.)"
   - "Integrazioni o API esterne?"

5. **Contenuti**
   - "Monolingua o multilingua? Quali lingue?"
   - "Struttura pagine prevista? (homepage, chi siamo, blog, etc.)"
   - "Ci sono contenuti esistenti o va creato tutto?"
   - "Tono di voce? (formale, tecnico, caldo, diretto, etc.)"

6. **Riferimenti**
   - "Competitor o benchmark di riferimento? (link o descrizioni)"
   - "C'e un moodboard Figma? (link)"
   - "Brand guidelines esistenti? (link o file)"

7. **Vincoli**
   - "Deadline o milestone?"
   - "Vincoli tecnici? (browser support, accessibilita, performance)"
   - "Vincoli brand? (elementi non modificabili)"

Dopo ogni risposta, aggiorna la sezione corrispondente in BRIEF.md. Aggiorna anche la data "Ultimo aggiornamento".

### 3. Direzione creativa (CREATIVE_DIRECTION.md)

Prosegui con le domande sulla direzione creativa:

1. **Vincoli di partenza**
   - "Il logo esiste gia o va creato?"
   - "Ci sono colori brand definiti? Quali?"
   - "Come vuoi essere percepito? (posizionamento)"

2. **Tipografia**
   - "Ci sono font gia scelti o vanno definiti?"
   - Se vanno definiti: "Che sensazione vuoi trasmettere? (moderna, classica, tecnica, calda, etc.)"

3. **Mood visivo**
   - "Hai riferimenti visivi? (siti, immagini, mood)"
   - "3 aggettivi che descrivono il look che cerchi?"

Dopo ogni risposta, aggiorna la sezione corrispondente in CREATIVE_DIRECTION.md.

### 4. Configurazione CLAUDE.md

Leggi CLAUDE.md e verifica se la sezione "Struttura progetto" riflette lo stack dichiarato nel BRIEF.

- Se lo stack e stato definito, proponi una struttura progetto coerente (es. per Next.js: `app/`, `components/`, `lib/`, etc.)
- Mostra la proposta e chiedi conferma prima di modificare
- Se l'utente dice "skip", lascia la struttura attuale

### 5. Riepilogo

Alla fine, mostra un riepilogo:

```
## Setup completato

### Compilato
- [elenco sezioni compilate]

### Da completare
- [elenco sezioni saltate, se presenti]

### Prossimi passi
- Usa `/creative` per esplorare direzioni di design
- Usa `/playbook` in qualsiasi momento per una guida rapida
- Chiudi ogni sessione con `/session-end`
```

## Note

- Non forzare risposte: se l'utente non ha ancora deciso qualcosa, "skip" e perfettamente valido
- Raggruppa le domande dove possibile per non essere troppo verboso (es. tutto il blocco "Stack tecnico" puo essere una domanda sola se l'utente e sintetico)
- Adatta il livello di dettaglio all'utente: se risponde in modo conciso, sii conciso. Se elabora, approfondisci.
