FROM  condaforge/miniforge3
LABEL maintainer="GitMA Team" \
      version="0.0.8"

WORKDIR /opt/gitma

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get install -y --fix-missing \
        build-essential cmake\
        git \
        neovim \
        bash \
        curl \
    && apt-get clean -y

RUN ln -sf /bin/bash /bin/sh

RUN git clone https://github.com/forTEXT/gitma.git ./src

RUN conda create --yes \
    --name gitma  \
    --channel conda-forge \
        python=3.9 \
        cvxopt=1.2.7 \
        coin-or-cbc \
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
        tabulate
         
RUN source /opt/conda/bin/activate \
    && conda activate gitma \
    && conda init bash \
    && python -m pip install \ 
        git+https://github.com/forTEXT/gitma \
        "pygamma-agreement[CBC]" \
    && conda clean -afy \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.pyc' -delete \
    && find /opt/conda/ -follow -type f -name '*.js.map' -delete

COPY gitma.sh .
ENTRYPOINT ["/bin/bash", "-c", "./gitma.sh"]
