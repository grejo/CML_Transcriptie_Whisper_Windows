# CML Transcriptie Tool - Windows

Automatische transcriptie van audio- en videobestanden naar Word documenten met WhisperX.
Deze versie is specifiek voor **Windows** en detecteert automatisch of er een NVIDIA GPU beschikbaar is.

> Samengesteld door **[Hogeschool PXL](https://www.pxl.be/) - Zorginnovatie**

> Andere versies: [macOS Apple Silicon](https://github.com/grejo/CML_Transcriptie_Whisper) | [macOS Intel](https://github.com/grejo/CML_Transcriptie_Whisper_Intel)

---

## Installatie

### Vereisten

- Windows 10 of hoger
- Optioneel: NVIDIA GPU met recente drivers (voor snellere verwerking)

### Stappen

1. **Download het project**

   Klik op de groene knop **"Code"** bovenaan deze pagina en kies **"Download ZIP"**.
   Pak het ZIP-bestand uit in een map naar keuze, bijvoorbeeld `C:\Programmas\`.

   Of via Command Prompt:
   ```cmd
   cd C:\Programmas
   git clone https://github.com/grejo/CML_Transcriptie_Whisper_Windows.git
   ```

2. **Start de tool**

   Open de uitgepakte map in Verkenner en **dubbelklik op `start.bat`**.

   > Windows kan een beveiligingswaarschuwing tonen ("Windows heeft je pc beschermd").
   > Klik dan op **"Meer info"** en vervolgens **"Toch uitvoeren"**.
   > Dit hoef je maar 1 keer te doen.

3. **Eerste keer: automatische installatie**

   Bij de eerste start worden automatisch geinstalleerd (indien nodig):
   - Python 3.11 (via `winget`)
   - ffmpeg (via `winget`)
   - Alle Python-afhankelijkheden (WhisperX, PyTorch met CUDA, etc.)

   Dit kan **10-15 minuten** duren. Daarna starten volgende keren direct.

   > **Let op:** Als Python voor het eerst wordt geinstalleerd, moet je het venster sluiten en `start.bat` opnieuw dubbelklikken zodat Python correct in het PATH geladen wordt.

---

## Gebruik

Na het opstarten worden er twee vragen gesteld:

### 1. Kies de taal

```
  1. Nederlands (nl)  (standaard)
  2. English (en)
  3. Francais (fr)
  ...
```

Typ het nummer van de taal en druk op Enter. Standaard is Nederlands.

### 2. Kies het model

```
  1. tiny       - 39M params   - Snelst, basis kwaliteit
  2. base       - 74M params   - Snel, redelijke kwaliteit
  3. small      - 244M params  - Goede kwaliteit
  4. medium     - 769M params  - Zeer goed (aanbevolen)
  5. large      - 1550M params - Beste kwaliteit, langzaam
  6. large-v3   - 1550M params - Nieuwste, beste voor NL
```

Typ het nummer en druk op Enter. Standaard is `medium` (aanbevolen).

> **Tip:** Gebruik `tiny` of `base` om snel te testen. Gebruik `large-v3` voor de beste kwaliteit.

### 3. Selecteer een bestand

Een bestandsdialoog wordt geopend. Selecteer een audio- of videobestand.

**Ondersteunde formaten:**
- Audio: MP3, WAV, M4A, OGG, FLAC, AAC
- Video: MP4, MOV, AVI, MKV, WEBM, FLV, WMV

### 4. Wacht op de transcriptie

De voortgang wordt getoond met een gedetailleerde progressiebalk:

```
  Transcriptie: [===============>          ]  45.67%
```

De tool detecteert automatisch of je een NVIDIA GPU hebt:
- **Met NVIDIA GPU:** Gebruikt CUDA (float16) - veel sneller
- **Zonder NVIDIA GPU:** Gebruikt CPU (int8) - trager maar werkt overal

### 5. Resultaat

Het Word-document wordt automatisch opgeslagen in je **Downloads-map** (`C:\Users\<jouw naam>\Downloads\`) met dezelfde naam als het bronbestand. Verkenner opent automatisch bij het bestand.

---

## Veelgestelde vragen

**Hoe lang duurt een transcriptie?**
Dat hangt af van de hardware, de duur van het bestand en het gekozen model. Een schatting wordt getoond voor de start. Met een NVIDIA GPU is het 5-10x sneller dan op CPU.

**Kan ik het programma afbreken?**
Ja, druk op `Ctrl+C` in het opdrachtvenster.

**Waar worden de modellen opgeslagen?**
In `C:\Users\<jouw naam>\.cache\huggingface\`. De eerste keer dat je een model gebruikt wordt het gedownload (500MB - 3GB afhankelijk van het model).

**Python of ffmpeg kon niet automatisch geinstalleerd worden?**
Installeer ze handmatig:
- Python: download van [python.org](https://www.python.org/downloads/) en vink **"Add Python to PATH"** aan
- ffmpeg: voer in Command Prompt uit: `winget install ffmpeg`

**Ik wil opnieuw beginnen met een schone installatie?**
Verwijder de `venv` map in de projectmap en start opnieuw.

---

## Bouwstenen

Deze tool is opgebouwd met de volgende open-source componenten:

| Component | Beschrijving | Link |
|---|---|---|
| **WhisperX** | Snelle spraakherkenning met woordniveau-timestamps, gebaseerd op OpenAI Whisper | [github.com/m-bain/whisperX](https://github.com/m-bain/whisperX) |
| **OpenAI Whisper** | Het onderliggende spraakherkenningsmodel van OpenAI | [github.com/openai/whisper](https://github.com/openai/whisper) |
| **Faster Whisper** | CTranslate2-backend voor snellere inferentie van Whisper-modellen | [github.com/SYSTRAN/faster-whisper](https://github.com/SYSTRAN/faster-whisper) |
| **CTranslate2** | Geoptimaliseerde inferentie-engine voor Transformer-modellen | [github.com/OpenNMT/CTranslate2](https://github.com/OpenNMT/CTranslate2) |
| **PyTorch** | Machine learning framework | [pytorch.org](https://pytorch.org/) |
| **Hugging Face Transformers** | Platform voor het laden van voorgetrainde AI-modellen | [huggingface.co](https://huggingface.co/) |
| **FFmpeg** | Audio- en videoconversie | [ffmpeg.org](https://ffmpeg.org/) |
| **python-docx** | Word-documenten genereren vanuit Python | [github.com/python-openxml/python-docx](https://github.com/python-openxml/python-docx) |
| **librosa** | Audioanalyse en -verwerking | [github.com/librosa/librosa](https://github.com/librosa/librosa) |
