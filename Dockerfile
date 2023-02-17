FROM  condaforge/miniforge3
LABEL maintainer="GitMA Team" \
      version="0.0.5"

WORKDIR /opt/gitma

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND noninteractive
RUN    apt-get update \
    && apt-get install -y \
          build-essential cmake\
          git \
    && apt-get clean -y

RUN    git clone https://github.com/forTEXT/gitma.git ./src \
    && conda init bash \
    && conda create -y \
        --name gitma  \
        --channel conda-forge \
            coin-or-cbc \
            cvxopt=1.2.7 \
            cvxpy \
            glpk \
            jupyterlab \
            matplotlib \
            networkx \
            nltk \
            numpy \
            pandas \
            pip \
            plotly \
            pygit2 \
            python-gitlab \
            qdldl-python \
            scipy \
            spacy \
            tabulate \
            python=3.9 \
  && source /opt/conda/bin/activate \
  && conda activate gitma \
  && python -m pip install \ 
  .src \
  "pygamma-agreement[CBC]" \
  && conda clean -afy \
  && conda deactivate

COPY  gitma.sh .
ENTRYPOINT ["/bin/bash", "-c", "./gitma.sh"]
