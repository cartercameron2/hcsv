# hcsv
HCSV is a command line tool written in Haskell to format csv files.

# Setup
If you need to instal Haskell/Cabal see https://www.haskell.org/ghcup/
Otherwise run the following

```
cabal install
```

cabal build will build to ~/.cabal/bin
```
cabal build
```

Add the following to your .bashrc
```
alias = hcsv='~/.cabal/bin/hcsv-exe'
```

# Usage
To format a file named data.csv you would run:
```
hcsv data.csv
```

