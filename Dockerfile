FROM condaforge/miniforge3
LABEL maintainer="GitMA Team" \
  version="0.0.4"

WORKDIR /opt/gitma

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
  && apt-get install -y \
  build-essential cmake\
  git \
  coinor-cbc coinor-libcbc-dev \
  && apt-get clean -y

RUN git clone https://github.com/forTEXT/gitma.git ./src \
  && conda init bash \
  && conda create -q -y -n gitma \
  && conda install -y -c conda-forge -n gitma\
  glpk \
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
  && source /opt/conda/bin/activate \
  && conda activate gitma \
<<<<<<< HEAD
  && python -m pip install \ 
=======
  && conda install git pip \
  && pip install \ 
>>>>>>> 274470e0f11036cee558617243f1d2cebf53d4f1
  git+https://github.com/forTEXT/gitma \
  "pygamma-agreement[CBC]" \
  && conda clean -afy \
  && conda deactivate

COPY  gitma.sh .
ENTRYPOINT ["/bin/bash", "-c", "./gitma.sh"]
