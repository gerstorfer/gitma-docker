FROM condaforge/miniforge3
LABEL maintainer="GitMA Team" \
  version="0.0.3"

WORKDIR /opt/gitma

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
  && apt-get install -y \
  build-essential cmake\
  git \
  coinor-libcbc-dev \
  && apt-get clean

RUN git clone https://github.com/forTEXT/gitma.git ./src \
  && conda create -q -y -n gitma python=3.9\
  && conda install -c conda-forge -n gitma\
  cvxopt \
  qdldl-python \
  jupyter \
  matplotlib \
  networkx \
  nltk \
  pandas \
  plotly \
  pygit2 \
  scipy \
  spacy \
  && conda clean --all \
  && source /opt/conda/bin/activate \
  && conda activate gitma \
  && pip install \ 
  git+https://github.com/forTEXT/gitma \
  pygamma-agreement \
  && conda deactivate

COPY gitma.sh .
ENTRYPOINT ["/bin/bash", "-c", "bash ./gitma.sh"]
