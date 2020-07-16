FROM rocker/verse:4.0.2

ARG USER_NAME

RUN useradd --user-group --create-home --shell /bin/false ${USER_NAME} &&\
  echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${USER_NAME}

ENV HOME=/home/${USER_NAME}

Run install2.r --error \
      --deps TRUE \
      mixtools \
      sads \
      DistributionUtils \
      RcppEigen \
      RcppNumerical \
      rhub

#RUN mkdir -p /home/rstudio/.R \
#  && echo 'CXXFLAGS=-O3 -mtune=native -fPIC -Wno-ignored-attributes' >> /home/rstudio/.R/Makevars
#RUN mkdir -p /home/rstudio/.R \
#  && echo 'CXXFLAGS=-O3 -mtune=native -fPIC' >> /home/rstudio/.R/Makevars

RUN tlmgr update --self \
  && tlmgr install latex-bin luatex xetex \
  && tlmgr install ae bibtex inconsolata listings metafont mfware parskip pdfcrop tex tools url xkeyval amsfonts

RUN chown -R ${USER_NAME}:staff /opt/texlive \
  && chown -R ${USER_NAME}:staff /usr/local/texlive \
  && chmod -R 777 /opt/texlive \
  && chmod -R 777 /usr/local/texlive

#USER ${USER_NAME}

RUN mkdir -p ${HOME} \
  &&  chown -R ${USER_NAME}:${USER_NAME} ${HOME}

RUN mkdir -p ${HOME}/.R \
  && echo 'CXXFLAGS=-O3 -mtune=native -fPIC' >> ${HOME}/.R/Makevars
