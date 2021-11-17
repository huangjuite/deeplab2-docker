FROM tensorflow/tensorflow:2.5.0-gpu-jupyter

ENV HOME /root
ENV PROJECT ${HOME}/bmtt-deeplab2

RUN apt-get update && apt-get install -y \
    git \
    python3-pip \
    protobuf-compiler

RUN pip3 install -U pip setuptools

RUN pip3 install -U \
    numpy \
    scipy \
    matplotlib \
    cython \
    pillow


RUN mkdir ${PROJECT}

RUN cd ${PROJECT} && git clone https://github.com/google-research/deeplab2.git

RUN cd ${PROJECT} && git clone https://github.com/tensorflow/models.git

RUN cd ${PROJECT} && git clone https://github.com/cocodataset/cocoapi.git \
    && cd cocoapi/PythonAPI \
    && make \
    && cd ${PROJECT}

RUN cd ${PROJECT} && source deeplab2/compile.sh

RUN echo "export PYTHONPATH=$PYTHONPATH:${PROJECT}:${PROJECT}/models:${PROJECT}/cocoapi/PythonAPI" >> /root/.bashrc

WORKDIR ${HOME}


