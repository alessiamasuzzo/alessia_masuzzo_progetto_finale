# Armadio digitale

App Flutter per organizzare il proprio armadio: l'utente carica i propri capi, crea degli outfit e riceve dei consigli in base al meteo. In più può sfogliare un catalogo di abbigliamento online e salvare i capi che gli piacciono.

## Idea dell'app

L'app ha tre sezioni, raggiungibili dalla barra di navigazione in basso, più una pagina Profilo.

| Sezione | Cosa fa |
|---|---|
| **Consiglio** | L'utente inserisce una città. L'app ricava la temperatura attuale da un'API meteo e propone i capi del suo armadio adatti a quella temperatura. |
| **Armadio** | Si divide in **Vestiti** e **Outfit**. Nei Vestiti l'utente carica i capi (foto dalla galleria, nome, stagione, categoria), li filtra per categoria, li segna come preferiti e ne apre il dettaglio. Negli Outfit combina almeno due capi e ottiene una card con il collage delle foto. |
| **Shop** | Mostra capi di abbigliamento da un catalogo online (API), con ricerca per testo e preferiti in una pagina dedicata. |
| **Profilo** | Mostra l'email dell'utente e permette il logout. |

L'app si apre sul **login** (Firebase). Dopo l'accesso non si può tornare alla pagina di login se non facendo il logout.

## Endpoint e servizi usati

| Servizio | Uso | Indirizzo |
|---|---|---|
| DummyJSON | Catalogo dello Shop | `GET https://dummyjson.com/products?limit=0` |
| Open-Meteo Geocoding | Dal nome della città alle coordinate | `GET https://geocoding-api.open-meteo.com/v1/search?name=<città>&count=1&language=it` |
| Open-Meteo Forecast | Temperatura e codice meteo attuali | `GET https://api.open-meteo.com/v1/forecast?latitude=<lat>&longitude=<lon>&current=temperature_2m,weather_code` |
| Firebase Authentication | Login con email e password | SDK `firebase_auth` |

Note:
- Le API pubbliche usate non richiedono una chiave.
- DummyJSON è un catalogo generico: l'app tiene solo le categorie di abbigliamento (`tops`, `womens-dresses`, `mens-shirts`, `womens-shoes`, `mens-shoes`). I dati sono in inglese, quindi la ricerca nello Shop funziona con parole inglesi.

## Requisiti della consegna

### Obbligatori

| Requisito | Stato | Dove |
|---|---|---|
| Almeno una chiamata API con `http` | Soddisfatto | Shop (DummyJSON) e Consiglio (Open-Meteo) |
| Almeno 3 schermate collegate | Soddisfatto | Login, tre tab, hub Armadio, Vestiti, Outfit, dettagli, form di inserimento, Profilo |
| Lista o dettaglio alimentati dall'API | Soddisfatto | Lista dello Shop e blocco meteo del Consiglio |
| Loading ed errore sul flusso di rete | Soddisfatto | Spinner durante il caricamento e messaggio in caso di errore. Nel Consiglio l'errore di rete ("Controlla la connessione dati") è distinto da "Città non trovata". Non c'è un pulsante "Riprova": il caricamento dello Shop riparte rientrando nella tab, e nel Consiglio si ripete la ricerca. |

### Opzionali

| Requisito | Stato |
|---|---|
| Form con validatori | Sì: login, nuovo capo, nuovo outfit |
| Auth / Firebase | Sì: login e logout (un solo utente, vedi sotto) |
| Tema chiaro / scuro | No: solo tema chiaro |
| Persistenza locale | No: vedi le scelte di progetto |
| Test automatici | No |

## Struttura del progetto

```
lib/
├── controllers/   stato condiviso (Provider): armadio, outfit, preferiti dello Shop
├── models/        classi dei dati: capo, outfit, prodotto, categorie, stagioni
├── services/      chiamate esterne: autenticazione, meteo, shop
├── screens/       le schermate
└── theme/         colori, tipografia e tema dell'app
```

Le schermate non conoscono `http` né Firebase: chiedono i dati ai servizi o ai controller. Cambiare un'API significa modificare un solo file.

## Scelte di progetto

**Login con Firebase, un solo utente.** L'accesso è gestito da Firebase Authentication con email e password. Non c'è la registrazione: l'utente è creato dalla console di Firebase. Il servizio di autenticazione restituisce alla schermata solo l'esito (nessun errore oppure un messaggio), così la schermata non dipende dal sistema di login. Dopo l'accesso la schermata di login viene sostituita, quindi il tasto indietro non riporta al login.

**Provider per lo stato condiviso.** Armadio, outfit e preferiti dello Shop sono letti da più schermate (per esempio il Consiglio legge i capi caricati nell'Armadio). Per questo vivono in tre controller (`ChangeNotifier`) creati con `MultiProvider` sopra `MaterialApp`: esistono una sola volta e sopravvivono ai cambi di pagina. Le schermate li leggono con `watch` e li modificano con `read`.

**Nessuna persistenza.** Capi, outfit e preferiti restano in memoria finché l'app è aperta e si perdono alla chiusura. La persistenza era opzionale: ho preferito completare prima tutte le funzioni obbligatorie. SharedPreferences non sarebbe adatto, perché è pensato per valori semplici e non per oggetti con immagini. Il salvataggio andrebbe fatto con un database (sqflite o Hive) usato dentro i controller, senza modificare le schermate.

**Foto dalla galleria, come byte.** Le foto si scelgono solo dalla galleria con `image_picker`. Il selettore di sistema consegna all'app soltanto l'immagine scelta, quindi non serve gestire permessi di lettura. L'immagine viene ridimensionata alla scelta e tenuta in memoria come byte (`Uint8List`), mostrata con `Image.memory`: funziona uguale su più piattaforme e non dipende da percorsi di file.

**Categoria e stagione a scelta singola.** Ogni capo ha una sola categoria e una sola stagione, scelte da un elenco. Gli elenchi sono definiti in un solo punto, così i filtri non dipendono da come si scrive un testo.

**Consiglio basato sulla temperatura.** La temperatura diventa una stagione: sotto i 10 gradi Inverno, tra 10 e 20 Primavera e Autunno (con la stessa temperatura non si distinguono), sopra i 20 Estate. Si mostrano i capi dell'armadio con quella stagione. Il codice meteo (sole, pioggia, neve) serve per ora solo a scegliere l'icona, perché i capi non hanno un dato che li descriva per la pioggia. La regola sta nel controller, non nella schermata.

**Shop con filtro e ricerca lato app.** Una sola chiamata scarica il catalogo e il filtro "solo abbigliamento" sta nel servizio. La ricerca filtra la lista già scaricata, senza nuove chiamate, ignorando maiuscole e minuscole. I preferiti salvano il prodotto intero (non solo l'id), così la pagina dei preferiti mostra immagine e titolo anche dopo una nuova ricerca; il confronto si fa per id.

**Interfaccia.** Palette viola e verde con font Fraunces (titoli) e Manrope (testo), definiti nel tema. Colori, card, chip e barra di navigazione vengono dal tema, così lo stile è lo stesso in tutta l'app.

## Come avviare il progetto

1. `flutter pub get`
2. Verifica che i file di configurazione di Firebase siano presenti (`lib/firebase_options.dart` e `android/app/google-services.json`).
3. Avvia un emulatore Android e lancia `flutter run`.
4. Per provare il caricamento dei capi, aggiungi qualche foto alla galleria dell'emulatore (trascinandola sulla finestra).


## Limiti noti

- I dati non sono persistenti (capi, outfit e preferiti si perdono alla chiusura).
- Foto solo dalla galleria, nessuna fotocamera.
- Categoria e stagione a scelta singola.
- Tema solo chiaro.
- La ricerca nello Shop funziona con parole inglesi, perché i dati dell'API sono in inglese.
- Nel Consiglio i capi non tengono conto di pioggia o neve.

## Sviluppi futuri

- Database locale (sqflite o Hive) per capi, outfit e preferiti
- Dettaglio dei prodotti dello Shop
- Modifica ed eliminazione di capi e outfit
- Pulsante "Annulla" nei form (oggi si annulla tornando indietro dalla barra)