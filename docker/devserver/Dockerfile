FROM crosslab/edrys_pyxtermjs:latest

# change the user, so that the packages can be installed on top of edrys_pyxtermjs
USER root

RUN apt-get update && apt-get install -y apt-transport-https

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mono-complete mono-mcs

RUN apt-get install -y golang-go

RUN apt-get install -y rustc

RUN apt-get install -y default-jdk

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y r-base r-base-dev r-recommended \
    r-cran-car \
    r-cran-caret \
    r-cran-data.table \
    r-cran-dplyr \
    r-cran-gdata \
    r-cran-ggplot2 \
    r-cran-lattice \
    r-cran-lme4 \
    r-cran-mapdata \
    r-cran-maps \
    r-cran-maptools \
    r-cran-mgcv \
    r-cran-mvtnorm \
    r-cran-nlme \
    r-cran-reshape \
    r-cran-stringr \
    r-cran-survival \
    r-cran-tidyr \
    r-cran-xml \
    r-cran-xml2 \
    r-cran-xtable \
    r-cran-xts \ 
    r-cran-zoo

RUN apt-get install -y julia

RUN apt-get install -y ghc

RUN apt-get install -y clojure

RUN apt-get install -y lua5.3

RUN apt-get install nodejs

# get back to the default appuser
USER appuser

EXPOSE 5000

ENTRYPOINT python3 -m pyxtermjs --cors True --host 0.0.0.0 --command zsh
