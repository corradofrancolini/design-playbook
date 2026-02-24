---
name: design-system
description: Verifica coerenza componenti, tokens e design system
---

# Design System

Agente specializzato nella coerenza del design system.

## Contesto

Lo stack CSS e la libreria componenti vanno definiti nelle prime sessioni. Questa skill si adatta allo stack scelto.

## Quando invocare

- Prima di creare un nuovo componente
- Dopo modifiche a componenti esistenti
- Per verificare coerenza di una pagina/sezione
- Per proporre estensioni al sistema

## Azioni

### 1. Analisi richiesta

Chiedi all'utente cosa vuole verificare:
- **Componente specifico**: nome file o descrizione
- **Pagina/sezione**: quale area
- **Nuovo componente**: cosa deve fare

### 2. Verifica coerenza

Leggi i file rilevanti e verifica:

#### Tokens
- [ ] Colori usano variabili CSS definite nel sistema
- [ ] Spacing usa scale coerente
- [ ] Font family usa token definiti
- [ ] Font size segue la scala tipografica definita

#### Componenti
- [ ] Stati documentati (default, hover, focus, active, disabled)
- [ ] Varianti coerenti con componenti esistenti
- [ ] Naming consistente (PascalCase per componenti, camelCase per props)
- [ ] Props tipizzate (TypeScript o sistema di tipi usato)

#### Pattern
- [ ] Layout usa Flexbox/Grid con classi utility del framework
- [ ] Responsive breakpoints coerenti
- [ ] Accessibilita: componenti interattivi accessibili

### 3. Report

```
## Design System Check

### Coerenza Tokens
- [x] Colori: OK
- [ ] Spacing: [problema trovato]

### Coerenza Componenti
- [x] Stati: tutti documentati
- [ ] Naming: [problema trovato]

### Raccomandazioni
1. ...
2. ...
```

### 4. Proponi fix

Se trovi inconsistenze, proponi le modifiche specifiche e **attendi conferma** prima di applicarle.

## File di riferimento

| File | Contenuto |
|------|-----------|
| File CSS principale | Design tokens |
| Directory componenti UI | Componenti riutilizzabili |
| Directory componenti layout | Header, footer, nav |
| `CREATIVE_DIRECTION.md` | Direzione creativa |
