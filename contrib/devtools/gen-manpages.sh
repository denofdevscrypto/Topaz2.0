#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

TOPAZD=${TOPAZD:-$BINDIR/topazd}
TOPAZCLI=${TOPAZCLI:-$BINDIR/topaz-cli}
TOPAZTX=${TOPAZTX:-$BINDIR/topaz-tx}
TOPAZQT=${TOPAZQT:-$BINDIR/qt/topaz-qt}

[ ! -x $TOPAZD ] && echo "$TOPAZD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
TOPAZVER=($($TOPAZCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for topazd if --version-string is not set,
# but has different outcomes for topaz-qt and topaz-cli.
echo "[COPYRIGHT]" > footer.h2m
$TOPAZD --version | sed -n '1!p' >> footer.h2m

for cmd in $TOPAZD $TOPAZCLI $TOPAZTX $TOPAZQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${TOPAZVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${TOPAZVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
