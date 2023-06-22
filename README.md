# AlarmClock-doc
Toto je hlavní repozitář s dokumentací k projektu [AlarmClock](https://github.com/ondras12345/AlarmClock).
Obsahuje zdrojové kódy dokumentu (sázecí systém LaTeX) a obrázky. Zip soubor,
který v práci nazývám elektronickou přílohou, lze stáhnout  z příslušného
[release](https://github.com/ondras12345/AlarmClock-doc/releases).

Repozitáře s firmware a návrhem desky plošných spojů jsou přidané jako
[git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules).

## Závislosti (využitý software)
Na Ubuntu 20.04.3 je potřeba nainstalovat následující balíčky:
```sh
sudo apt install make git \
    inkscape gnuplot \
    texlive biber texlive-lang-czechslovak texlive-lang-english \
    texlive-science texlive-science-doc
```

### Python venv
[git-archive-all](https://github.com/Kentzo/git-archive-all) slouží
k vytvoření finálního `.zip` souboru. Lze jej snadno nainstalovat například ve
virtuálním prostředí `venv`.
```sh
python3 -m venv .venv
. ./.venv/bin/activate
pip3 install git-archive-all
```

## Sestavení
Je využit build systém `make`.
```sh
# nápověda
make help

# sestavení pdf dokumentace a elektronických příloh
make

# vytvoření finálního .zip souboru s elektronickou přílohou
make archive
```
