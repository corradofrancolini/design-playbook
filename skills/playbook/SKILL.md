---
name: playbook
description: Guida rapida al design-playbook — file, skill, metodo, stato progetto
---

# Playbook — Guida rapida

Riferimento rapido per il design-playbook. Mostra cosa e installato, cosa fare, e quando usare ogni skill.

## Azioni

### 1. Controlla stato progetto

Leggi questi file e identifica il loro stato:

- **BRIEF.md** — contiene ancora placeholder come `[descrizione in una riga]` oppure e stato compilato?
- **CREATIVE_DIRECTION.md** — contiene ancora `[Da definire dopo benchmark]` oppure ha contenuti reali?
- **SESSION_HANDOFF.md** — qual e l'ultima sessione registrata?

### 2. Mostra guida

Genera questo output, adattando la sezione "Stato" in base a quello che hai trovato:

```
## design-playbook — Guida rapida

### Stato progetto

- BRIEF.md: [compilato / da compilare]
- CREATIVE_DIRECTION.md: [compilato / da compilare]
- Ultima sessione: [numero e nome da SESSION_HANDOFF.md]

### Metodo

Questo progetto usa l'Adiacente Possibile: Claude mappa le opzioni
e i trade-off, non converge. Esegui solo con trigger esplicito
("esegui", "procedi", "vai con X").

Dettagli: CLAUDE.md (protocollo), lab/PROCESS.md (metodologia)

### Skill disponibili

| Skill | Quando |
|-------|--------|
| /setup | Configurazione iniziale — compilare brief e creative direction |
| /creative | Bivio creativo — esplorare direzioni alternative |
| /review | Componente o feature completata — code review |
| /accessibility | Prima di rilasciare una pagina — audit WCAG |
| /content | Scrivere testi, label, messaggi errore |
| /design-system | Verificare coerenza token e componenti |
| /seo | Prima di rilasciare — audit SEO e performance |
| /project-index | Mappare visivamente la struttura del progetto |
| /storybook | Configurare component library e test |
| /session-end | Fine sessione — aggiornare handoff (sempre) |
| /playbook | Questa guida |

### File di processo

| File | Scopo |
|------|-------|
| CLAUDE.md | Protocollo di progetto (caricato automaticamente) |
| BRIEF.md | Brief di progetto — scope, target, stack, vincoli |
| CREATIVE_DIRECTION.md | Direzione creativa — palette, tipografia, mood |
| SESSION_HANDOFF.md | Stato sessione — continuita tra sessioni |
| BACKLOG.md | Backlog e decisioni |
| lab/PROCESS.md | Metodologia anti-sycophancy (riferimento) |
| lab/notes.md | Note di lavoro |
| docs/sessions/ | Log delle sessioni |
```

### 3. Suggerimenti contestuali

In base allo stato del progetto:

- Se BRIEF.md non e compilato: "Suggerisco `/setup` per una configurazione guidata, oppure compila BRIEF.md manualmente."
- Se CREATIVE_DIRECTION.md non e compilato: "Compila CREATIVE_DIRECTION.md prima di iniziare a progettare."
- Se entrambi sono compilati: "Il progetto e configurato. Puoi iniziare a lavorare o usare `/creative` per esplorare direzioni."

### 4. Rispondi a domande

Se l'utente chiede dettagli su una skill specifica, leggi il SKILL.md corrispondente in `.claude/skills/<nome>/SKILL.md` e riassumi cosa fa e quando usarla.
