# Helyi próba — 2026-11-17

Gép: AMD Ryzen 5 5625U, 16 GB rendszermemória; CPU-futtatás, 4 szál.
Modell: Qwen2.5-Coder-3B-Instruct Q5_K_M, llama.cpp b11476.
Ez nem a megcélzott iskolai i5 / 8 GB gépen végzett mérés.

| Próba | Válaszidő, betöltés nélkül | Eredmény |
|---|---:|---|
| Első névlistás feladat, korábbi profil | 46,8 s | Hiányzó System.IO import és elégtelen szóközkezelés; nem elfogadható kész megoldás. |
| Magyar benchmark-prompt, kiegészített profil | 54,7 s | A generált kód lefordult, és négy bemeneti teszt átment. |

A második megoldást módosítás nélkül fordítottam le a helyi PowerShell
Add-Type C# fordítójával, majd futtattam: normál példa; ismételt szóközök,
tabok, üres és hiányos sor; csak női nevek; üres bemenet. A várt számlálók
és legrövidebb férfinév mind egyeztek, nem keletkezett futási hiba.

Korlát: a modell a kért külön segédmetódusok helyett Main-be tette a logikát,
és a „csak kód” kérés ellenére rövid kimeneti példát is hozzáadott. A négy
teszt nem bizonyít általános hibamentességet, és nem teljes tananyagi benchmark.
Nem történt 200–300 soros megoldások átfogó vizsgálata.

A streaming feldolgozás külön tesztje az ékezetes részleteket, sortöréseket,
befejezési jelzést, megszakadt adatfolyamot és szerverhibát is ellenőrzi.
Futtatás: `powershell.exe -NoProfile -File .\Test-Streaming.ps1`.

Az iskolai célgépen futtasd a README-ben szereplő benchmark-parancsot.
Az 1–2 perc továbbra is cél, nem minden feladatra vállalt határidő.
