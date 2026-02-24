---
name: content
description: Revisione e generazione microcopy, testi e contenuti
---

# Content

Agente specializzato in contenuti testuali e tone of voice.

## Contesto

Il tone of voice e il glossario vanno definiti in CREATIVE_DIRECTION.md durante le prime sessioni. Questa skill si adatta al tono scelto.

## Quando invocare

- Per scrivere/revisionare microcopy (bottoni, label, messaggi)
- Per messaggi di errore/successo
- Per alt text immagini
- Per meta title/description
- Per verificare coerenza tone of voice

## Azioni

### 1. Identifica richiesta

Chiedi all'utente:
- **Tipo contenuto**: microcopy, messaggio errore, alt text, meta, altro
- **Contesto**: dove appare, cosa deve comunicare
- **Vincoli**: lunghezza, keywords, etc.

### 2. Genera/Revisiona

#### Microcopy (bottoni, label)

Principi:
- Verbi d'azione diretti
- Chiarezza su cosa succede al click
- Consistenza: stessa azione = stessa label

Esempio:
```
MALE:  "Clicca qui"
MALE:  "Invia"
BENE:  "Iscriviti gratis"
BENE:  "Esplora l'Academy"
```

#### Messaggi di errore

Principi:
- Spiegare COSA e andato storto
- Spiegare COME risolvere
- Tono non colpevolizzante
- No codici tecnici

Esempio:
```
MALE:  "Errore 422: Validazione fallita"
MALE:  "Email non valida"
BENE:  "Inserisci un indirizzo email valido, ad esempio nome@esempio.com"
```

#### Messaggi di successo

Principi:
- Confermare cosa e successo
- Indicare prossimo passo (se c'e)
- Brevi e positivi

Esempio:
```
MALE:  "Operazione completata con successo"
BENE:  "Registrazione completata! Controlla la tua email per attivare l'account."
```

#### Stati vuoti

Principi:
- Spiegare perche e vuoto
- Suggerire azione per riempirlo
- Non far sentire l'utente perso

Esempio:
```
MALE:  "Nessun risultato"
BENE:  "Non hai ancora salvato nessun evento. Esplora il calendario per trovare le prossime sessioni."
```

#### Alt text immagini

Principi:
- Descrivere contenuto informativo
- Contesto, non solo "cosa si vede"
- Se decorativa: alt=""
- Max ~125 caratteri

Esempio:
```
MALE:  "immagine"
MALE:  "foto di persone"
BENE:  "Team di design durante un workshop di product review"
```

#### Meta title e description

Principi:
- Title: 50-60 caratteri, keyword primaria all'inizio
- Description: 150-160 caratteri, call to action
- Unici per ogni pagina

Esempio:
```
Title: "Academy Progetto — Corsi online per designer"
Description: "Guide pratiche, template e workshop per professionisti del design. Iscriviti gratis e inizia oggi."
```

### 3. Output

```
## Content Review

### Richiesta
[cosa ha chiesto l'utente]

### Proposta
[contenuto proposto]

### Alternativa (se rilevante)
[variante]

### Note
[considerazioni su tone, lunghezza, accessibilita]
```

### 4. Applica

Se l'utente approva, proponi le modifiche ai file e **attendi conferma** prima di applicarle.

## Glossario

<!-- Compilare con la terminologia specifica del progetto -->

| Termine | Uso | Note |
|---------|-----|------|
