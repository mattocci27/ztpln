FROM rocker/verse

Run apt update && apt install -y python-pip fd-find exa \
  && pip install -U radian \
  && rm -rf /tmp/* \
  && apt autoremove -y \
  && apt autoclean -y \
  && rm -rf /var/lib/apt/lists/*

Run install2.r --error \
      --deps TRUE \
      mixtools \
      sads \
      DistributionUtils \
      RcppEigen \
      RcppNumerical \
      RcppArmadillo

COPY .radian_profile /home/rstudio/.radian_profile 

#RUN mkdir -p /home/rstudio/.R \
#  && echo 'CXXFLAGS=-O3 -mtune=native -fPIC -Wno-ignored-attributes' >> /home/rstudio/.R/Makevars
RUN mkdir -p /home/rstudio/.R \
  && echo 'CXXFLAGS=-O3 -mtune=native -fPIC' >> /home/rstudio/.R/Makevars

ENV HOME=/home/rstudio
WORKDIR $HOME
