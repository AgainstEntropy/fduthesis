#!/usr/bin/env sh

# From latex3
# https://github.com/latex3/latex3/blob/master/support/texlive.sh

# This script is used for testing using Travis
# It is intended to work on their VM set up: Ubuntu 12.04 LTS
# A minimal current TL is installed adding only the packages that are
# required

# export REPO=http://ftp.math.utah.edu/pub/tlpretest
export REPO=https://mirrors.rit.edu/CTAN/systems/texlive/tlnet

# See if there is a cached version of TL available
export PATH=/tmp/texlive/bin/x86_64-linux:$PATH
if ! command -v texlua > /dev/null; then
  # Obtain TeX Live
  wget $REPO/install-tl-unx.tar.gz
  tar -xzf install-tl-unx.tar.gz
  cd install-tl-2019

  # Install a minimal system
  ./install-tl --profile ../.travis/texlive.profile --repository $REPO
  cd ..
fi

# Change default package repository
tlmgr option repository $REPO

# Packages
tlmgr install           \
  adobemapping          \
  amsfonts              \
  amsmath               \
  arphic-ttf            \
  babel-japanese        \
  baekmuk               \
  biber                 \
  biblatex              \
  biblatex-gb7714-2015  \
  bibtex                \
  caption               \
  cm                    \
  ctablestack           \
  ctex                  \
  currfile              \
  dvipdfmx              \
  environ               \
  etex                  \
  etoolbox              \
  fancyhdr              \
  fandol                \
  filehook              \
  fontspec              \
  footmisc              \
  gbt7714               \
  geometry              \
  graphics              \
  graphics-cfg          \
  graphics-def          \
  hyperref              \
  ifluatex              \
  ifxetex               \
  ipaex                 \
  japanese-otf          \
  kantlipsum            \
  knuth-lib             \
  l3build               \
  l3experimental        \
  l3kernel              \
  l3packages            \
  latex-bin             \
  latexmk               \
  libertinus-fonts      \
  lm                    \
  lm-math               \
  logreq                \
  lualatex-math         \
  lualibs               \
  luaotfload            \
  luatex                \
  luatex85              \
  luatexbase            \
  luatexja              \
  metafont              \
  mfware                \
  ms                    \
  natbib                \
  ntheorem              \
  oberdiek              \
  pgf                   \
  platex                \
  platex-tools          \
  preview               \
  psnfss                \
  ptex                  \
  ptex-base             \
  ptex-fontmaps         \
  ptex-fonts            \
  siunitx               \
  standalone            \
  symbol                \
  tex                   \
  tex-gyre              \
  tex-gyre-math         \
  tex-ini-files         \
  tools                 \
  trimspaces            \
  ucharcat              \
  ulem                  \
  unicode-data          \
  unicode-math          \
  uplatex               \
  uptex                 \
  uptex-base            \
  uptex-fonts           \
  url                   \
  varwidth              \
  xcolor                \
  xecjk                 \
  xetex                 \
  xits                  \
  xkeyval               \
  xstring               \
  xunicode              \
  zapfding              \
  zhlipsum              \
  zhmetrics-uptex       \
  zhnumber

# Keep no backups (not required, simply makes cache bigger)
tlmgr option -- autobackup 0

# Update the TL install but add nothing new
tlmgr update --self --all --no-auto-install

# Install fonts
# See https://tex.stackexchange.com/q/257231/136923 and
# https://www.tug.org/texlive/doc/texlive-en/texlive-en.html#x1-340003.4.4
cp -r /tmp/texlive/texmf-dist/fonts/opentype                 \
  /home/travis/.fonts
cp /tmp/texlive/texmf-var/fonts/conf/texlive-fontconfig.conf \
  /home/travis/.fonts.conf
fc-cache -fv
