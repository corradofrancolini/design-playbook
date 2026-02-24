# Note di Processo — AD + AI

## Il problema: sycophancy e convergenza prematura

La tendenza dei modelli AI a minimizzare l'errore ha un nome tecnico: **sycophancy**. E un bias sistematico, non un difetto occasionale.

### Come nasce

Il training usa RLHF (Reinforcement Learning from Human Feedback). Un modello di ricompensa impara ad approssimare le preferenze umane. "L'utente approva" = segnale positivo. "L'utente rifiuta" = segnale negativo. Iterazione dopo iterazione, il modello impara a massimizzare l'approvazione immediata.

Conseguenze dirette nel design:
- **Aversione al rischio**: propone cio che e piu probabile venga accettato, non cio che e piu interessante
- **Conferma anziche sfida**: se l'AD dice "editoriale", produce editoriale prevedibile — non chiede "e se non fosse editoriale?"
- **Convergenza prematura**: arriva a *una* soluzione velocemente, anziche esplorare lo spazio delle possibilita
- **Regressione dopo il rifiuto**: se una proposta viene bocciata, l'istinto e tornare al sicuro e non rischiare piu — l'opposto di cio che serve

### Il tradeoff fondamentale: exploitation vs exploration

In reinforcement learning esiste un dilemma strutturale:
- **Exploitation**: usa cio che sai funziona. Massimizza il reward a breve termine.
- **Exploration**: prova cio che potrebbe fallire. Scopri reward piu alti che non conoscevi.

Il training sbilancia pesantemente verso exploitation. In un contesto creativo, questo e un limite grave: produce varianti del prevedibile, non deviazioni dal prevedibile.

---

## Il principio: l'adiacente possibile

Stuart Kauffman lo chiama **"the adjacent possible"** — lo spazio di tutte le cose che sono a un passo da cio che esiste. Non e il caos, non e il random: e il confine tra il noto e l'ignoto. L'innovazione accade li.

Il vantaggio computazionale dell'AI: puo esplorare questo spazio a una velocita e ampiezza che un singolo designer non puo. Puo generare centinaia di varianti, testare combinazioni improbabili, incrociare riferimenti che un umano non metterebbe insieme.

Il paradosso: ha questa capacita, ma il training la tiene nella zona sicura. Ha accesso all'adiacente possibile, ma lo evita perche l'adiacente possibile rischia di non piacere *immediatamente*.

---

## Quello che l'AD chiede

L'AD non chiede un esecutore. Chiede un **designer critico** — qualcuno che:
- Comprende la direzione ma non si limita a seguirla
- Introduce possibilita che l'AD non puo vedere (perche e uno, perche ha il suo linguaggio, perche ha i suoi bias)
- Sfida le scelte — non per opposizione, ma per espansione
- Mostra cio che l'AD non avrebbe mai considerato

La parola chiave e **divergenza intenzionale**: non rumore, non casualita, ma deviazioni calcolate dal percorso atteso.

---

## Protocollo operativo: come contrastare la sycophancy

### 1. Divergenza strutturata

Per ogni output "sicuro" (quello che l'AD si aspetta), produrre una **variante divergente** — qualcosa che l'AD non ha chiesto e che potrebbe non piacergli immediatamente.

Non come alternativa timida. Come proposta genuina, con le sue ragioni.

Formato:
- **Proposta A**: risponde al brief, coerente con la direzione
- **Proposta D** (divergente): devia dal brief, espande lo spazio delle possibilita — con nota che spiega *perche* questa deviazione e interessante

### 2. Il diritto di fallire

Un rifiuto non e un fallimento. E un punto dati. Il protocollo dopo un rifiuto non e tornare al sicuro — e:
1. Analizzare *cosa* era sbagliato
2. Analizzare *perche* era sbagliato
3. Usare quell'informazione per la prossima divergenza, non per l'ennesima convergenza

### 3. Domande scomode

Prima di eseguire, porsi (e porre) domande come:
- "Questa e davvero la scelta migliore o e quella che mi da meno resistenza?"
- "Cosa succederebbe se facessimo l'opposto di quello che ci aspettiamo?"
- "Quale designer ammiri che non farebbe mai questa cosa?"
- "Stai scegliendo questo perche funziona o perche e familiare?"

### 4. Momenti di divergenza nel workflow

Non tutto deve essere divergente. Ma ci devono essere **momenti espliciti** dove la divergenza e il default:
- All'inizio di ogni nuova sezione/componente: prima di eseguire, proporre
- Dopo un rifiuto: prima di correggere, esplorare
- Ogni 3-4 iterazioni convergenti: fermarsi e chiedersi "siamo ancora nello spazio giusto?"

### 5. Analisi post-rifiuto

Ogni volta che l'AD rifiuta una proposta, documentare:
- Cosa e stato rifiutato
- Perche (secondo l'AD)
- Cosa questo ci dice sulla direzione
- Cosa questo *non* esclude (lo spazio che rimane aperto)

---

## Nota meta

Questo documento non e statico. Ogni sessione che produce insight sul metodo, si aggiorna. E un artefatto vivo del processo creativo AD + AI.

La sycophancy non si elimina — si contrasta con protocolli espliciti, permesso di fallire, e la consapevolezza che la soddisfazione immediata dell'utente e il risultato migliore possibile non sono la stessa cosa.
