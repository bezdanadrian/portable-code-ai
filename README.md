# Portable Code AI

Offline, USB-ről indítható magyar parancssoros programozási segéd Windows 10/11 x64 rendszerhez. C# iskolai alapfeladatokra hangolt utasításokkal; C és Python is kérhető.

## Telepítés

Töltsd le vagy klónozd ezt a repót. PowerShellből a repó mappájában:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\Install-USB.ps1 -Destination E:\Portable-Code-AI
```

Az `E:` helyére az USB tényleges betűjele kerül. A telepítő új mappát hoz létre,
nem formázza a meghajtót. Meglévő csomag esetén a programfájlokat frissíti.
Internet a telepítéshez kell, a használathoz nem. A modell letöltése folytatható;
a telepítő SHA-256 ellenőrzést végez. Opcionális nagyobb modell: `-Include7B`.

Indítás az USB-n: `START.bat`. Nincs szükség Pythonra vagy telepített AI-programra.
Az alapmodell Qwen2.5-Coder-3B-Instruct Q5_K_M (kb. 2,44 GB); llama.cpp b11476
Windows x64 CPU futtatókörnyezettel. A modell és a futtatókörnyezet nincs a Gitben.

## Használat

- `/fajl E:\feladat\Program.cs`: UTF-8 szöveg csatolása, utána írd le a feladatot.
- `/tobbsor`: többsoros bemenet; `/vege`: beküldés.
- `/ujbeszelgetes`: új kontextus.
- `/mentes`: beszélgetés mentése az USB-re.
- `/kilepes`: a chat és a helyi kiszolgáló leállítása.

A válasz folyamatosan jelenik meg. A program nem írja át és nem futtatja a
generált kódot. Fordító, Python és .NET SDK külön szükséges a kód kipróbálásához.
A helyi kiszolgáló csak a saját gépen, 127.0.0.1-en érhető el.

## Iskolai profil és teljesítmény

Cél: 10. generációs i5 vagy hasonló CPU, 8 GB RAM, integrált GPU. CPU-n fut,
legfeljebb 4 fizikai magszál-beállítással, 8192 token kontextussal és legfeljebb
3072 token válasszal. A rövid kódot előnyben részesítő alaputasítás a
`school-profile.txt` fájlban van; a források és minták a [TANANYAG.md](TANANYAG.md)
fájlban. Ez utasításprofil, nem újratanított modell.

Az 1–2 perces megoldás cél, nem garantált sebesség. Az indulás és az első
prompt feldolgozása plusz idő. Hosszú kód vagy gyengébb gép lassabb lehet.
Az iskolai célgépen még szükséges mérés. Céges/sulis futtatási korlátozásokat
nem kerül meg, és nem ígér minden régi processzoron kompatibilitást.

A helyi névlistás próba 54,7 másodperc alatt adott leforduló, négy bemeneti
teszten átment megoldást; a stíluselőírásokat nem mind tartotta be.
A mérés gépe és korlátai: [BENCHMARK.md](BENCHMARK.md).

Ismételhető névlistás sebességpróba az USB mappájából:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\Chat.ps1 -Model 3 -PromptFile .\benchmark-prompt.txt
```

A kiírt válaszidő tartalmazza a prompt feldolgozását és a válasz generálását,
de a modell előzetes betöltését nem. A gyors válasz önmagában nem bizonyítja,
hogy a megoldás helyes: a kódot a példabemenettel és üres fájllal is ellenőrizni kell.

## Licencek

- **A 3B modell Qwen Research License alatt áll:** alapból nem kereskedelmi
  kutatási/értékelési célokra; kereskedelmi használathoz a kiadótól külön licenc kell.
- Az opcionális 7B modell Apache 2.0 licencű.
- llama.cpp: MIT.

A telepítő letölti az eredeti licenceket. A repó nem tartalmazza a tanár
forrásfájljait, videóit, modellfájlokat, felhasználói projekteket vagy beszélgetéseket.
