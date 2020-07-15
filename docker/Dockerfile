FROM rocker/verse:4.0.2

Run install2.r --error \
      --deps TRUE \
      mixtools \
      sads \
      DistributionUtils \
      RcppEigen \
      RcppNumerical \
      RcppArmadillo

#RUN mkdir -p /home/rstudio/.R \
#  && echo 'CXXFLAGS=-O3 -mtune=native -fPIC -Wno-ignored-attributes' >> /home/rstudio/.R/Makevars
RUN mkdir -p /home/rstudio/.R \
  && echo 'CXXFLAGS=-O3 -mtune=native -fPIC' >> /home/rstudio/.R/Makevars

RUN tlmgr update --self \
  && tlmgr install latex-bin luatex xetex \
  && tlmgr install ae bibtex inconsolata listings metafont mfware parskip pdfcrop tex tools url xkeyval amsfonts

RUN chown -R rstudio:staff /opt/texlive \
  && chown -R rstudio:staff /usr/local/texlive \
  && chmod -R 777 /opt/texlive \
  && chmod -R 777 /usr/local/texlive
