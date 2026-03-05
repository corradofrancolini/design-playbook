# {{PROJECT_NAME}} — Session Handoff

> Ultimo handoff: vedi `docs/handoffs/` (file piu recente)

Ogni `/session-end` crea un file in `docs/handoffs/` con data, ora e autore.
Per la prossima sessione, leggi il file piu recente.

---

## Come funziona

- `/session-end` salva lo stato della sessione in `docs/handoffs/YYYY-MM-DD_HH-MM_nome.md`
- Ogni handoff contiene: stato attuale, lavoro completato, prossimo step, problemi aperti
- Nessuna collisione: ogni persona e ogni sessione hanno il proprio file
- Per riprendere: leggi il file piu recente in `docs/handoffs/`
