#Base Ubuntu image
FROM ubuntu:22.04

#Set environment variables to non-interactive (this prevents some prompts)
ENV DEBIAN_FRONTEND=noninteractive

#Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    cmake \
    build-essential \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv \
    sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

#Install JupyterLab
RUN pip3 install --no-cache-dir jupyterlab

#Install Rust
RUN curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | sh -s -- -y

#**********Start OpenFHE setup**********
#(See https://github.com/openfheorg/openfhe-python/tree/main/docker)

#Install PyBind11
RUN pip3 install "pybind11[global]"

#Clone and build openfhe C++ library
RUN git clone https://github.com/openfheorg/openfhe-development.git \
    && cd openfhe-development \
    && mkdir build \
    && cd build \
    && cmake -DBUILD_UNITTESTS=OFF -DBUILD_EXAMPLES=OFF -DBUILD_BENCHMARKS=OFF .. \
    && make -j$(nproc) \
    && make install

#Assume that OpenFHE installs libraries into /usr/local/lib
#Update LD_LIBRARY_PATH to include this directory
ENV LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH}

#Clone and build openfhe python wrapper
RUN git clone https://github.com/openfheorg/openfhe-python.git \
    && cd openfhe-python \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j$(nproc) \
    && make install

#Install openfhe as a pip package
WORKDIR /openfhe-python
RUN python3 setup.py sdist bdist_wheel && pip3 install dist/openfhe-*.whl
#**********End OpenFHE setup**********


#**********Start TFHE-rs setup**********
#(See https://github.com/zama-ai/tfhe-rs)

#**********End TFHE-rs setup**********



#**********Start Concrete setup**********
#(See https://github.com/zama-ai/concrete)

RUN pip3 --no-cache-dir install concrete-python concrete-ml
#**********End Concrete setup**********


#Expose JupyterLab listen port
EXPOSE 8888

#Set the working directory
WORKDIR /workspace

#Start JupyterLab (with authentication disabled)
CMD ["jupyter-lab", "--ip=0.0.0.0", "--no-browser", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.allow_origin='*'", "--NotebookApp.password=''", "--NotebookApp.password_required=False"]