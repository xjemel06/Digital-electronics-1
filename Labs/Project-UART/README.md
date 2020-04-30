# Projekt - UART<h1>
  
## Zadání<h2>
  Universal asynchronous reciever-transmitter tedy univerzální asynchronní přijímač-vysílač. Slouží k sériové komunikaci s možností změny parametru. Signál vysílá po slovech začínajících start bitem a dále pokračujícími datovými bity s hlavní informací, paritním bitem a stop bitem. Za úkol jsme dostali vytvořit pouze vysílač s možností nastavovaní parametrů vysílání.
&nbsp;
  
### Start bit a stop bit<h3>
Start bit a stop bit slouží k určení délky a pomáhají čtení kódu přijímačem. U stop bitu můžeme zvolit jsetli bude jeden nebo budou dva. 
&nbsp;
  
### Datové bity<h3>
  Datových bitů je 8 a nesou samotnou informaci zprávy, kterou chce uživatel vysílat či přijímat. Jsou ovládáné přepínači na přídavné desce. 
&nbsp;
  
### Paritní bit<h3>
  Paritní bit slouží ke kontrole stavu datových bitů. Jestli během přenosu dojde k chybě a jeden datový bit se změní je díky paritnímu bitu možné chybu odhalit.Pro tento projekt je zvolena parita jedniček. Podle toho zda je lichá nebo sudá doplní do slova buď 1 nebo 0.  Pravděpodobně nejjednodušším určním parity jsou použité logické funkce xor.
&nbsp; 

### Baud rate<h3>
  Deska je nastavena na standardní kmitočet 1 MHz. Baud rate se tedy nastavuje dělením tohoto kmitočtu. Je možné tlačítkem vybrat ze dvou standardních baud rate (bitrate) 9600 bps a 19200 bps, 0 je pomalější a 1 rychlejší baud rate. 
&nbsp;


## Struktura
&nbsp;
![taskone](schema.png)
Schéma  č. 1: Vnitřní zapojéní struktury a připojení na desky 
&nbsp;




&nbsp;
![taskone](bsim.png)

&nbsp;
Diagram č. 1: Časový diagram s binárními čísly 
&nbsp;

&nbsp;

&nbsp;
![taskone](hsim.png)
&nbsp;
Diagram č. 2: Časový diagram s hexadecimálními čísly 
&nbsp;

&nbsp;
## Zdroje:<h2>
* předchozí zadání

