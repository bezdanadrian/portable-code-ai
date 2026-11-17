# C# tananyagprofil

Forrás: https://people.vts.su.ac.rs/~probi/oop/

Az olvasható szöveges anyagok alapján készült összefoglaló; nem modell-újratanítás.
A `school-profile.txt` induláskor az AI alaputasításába kerül. Nem szükséges
az egész tananyagot minden kérdéshez bemásolni.

## Ellenőrzött anyagok

- [Első óra](https://people.vts.su.ac.rs/~probi/oop/01_7/2026_10_07.txt): C# alapok, szövegműveletek, ciklusok, tömbök és segédmetódusok.
- [Október 21-i váz](https://people.vts.su.ac.rs/~probi/oop/03_7/Program.cs): fájlolvasás, férfi/női nevek megszámolása, legrövidebb férfinév, adott hosszúságú férfinevek. Ez szándékosan hiányos feladatváz, nem fordítható kész program.
- [Október 28-i mappa](https://people.vts.su.ac.rs/~probi/oop/04_7/Program.cs): sorok olvasása, List<T> és listaműveletek. A forrás végén fölösleges zárójelek is láthatók; nem szabad hibátlan mintaként másolni.
- [Névlista](https://people.vts.su.ac.rs/~probi/oop/fajlok/nevek.txt): név, nem és gyakoriság szóközzel elválasztva; a fejléc nélküli formátum első sorait ellenőriztem.
- A `fajlok` mappában további szöveges bemenetek vannak; nem minden fájl tartalmát vizsgáltam.

## Csak fájlnév alapján azonosított videótémák

Dictionary, HashSet, Stack, kivételkezelés; a `potlas` almappában absztrakt
osztály, interfész és generikus típusok. A videók tartalmát nem dolgoztam fel.

## Saját gyakorló ellenőrző feladatok

1. Számold meg egy mondat szavait és az l/L betűvel kezdődő szavakat.
   Bemenet: `Lila  labda, alma!` Eredmény: 3 szó, 2 l/L kezdetű szó.
2. Névlista: `Adam férfi ritka`, `Eva nő ritka`, `Pal férfi ritka`.
   Eredmény: 2 férfi, 1 nő; legrövidebb férfinév Pal; 3 betűs férfinév: 1.
   Próbáld ki üres fájllal és csak női nevekkel is.
3. Lista: 10,20; AddRange 30,40,50; Insert(1,15); Remove(30); Sort; Reverse.
   Eredmény: 50,40,20,15,10.

Ezek ellenőrzési minták, nem a tanár feladatainak szó szerinti másolatai.
A 10. generációs i5 / 8 GB célgépen az 1–2 perces válaszidő még nincs bemérve.
