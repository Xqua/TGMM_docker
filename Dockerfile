FROM nvidia/cuda:8.0-devel-ubuntu14.04

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:george-edison55/cmake-3.x
RUN apt-get update
RUN apt-get install -qq -y build-essential git cmake make gcc-4.8 g++-4.8

RUN mkdir /usr/src/app
WORKDIR /usr/src/app

RUN git clone https://git.rcc.uchicago.edu/open-source/TGMM.git
RUN rm -rf TGMM/build && mkdir TGMM/build
WORKDIR /usr/src/app/TGMM/build
RUN sed -i 's@TARGET_LINK_LIBRARIES(TGMM /software/gcc-6.2-el7-x86_64/lib64/libstdc++.so)@@g' ../src/CMakeLists.txt
RUN cat ../src/CMakeLists.txt 
RUN cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_LIBRARY_PATH=/usr/local/cuda/lib64/stubs ../src/
RUN make -j
RUN ln -s /usr/src/app/TGMM/build/TGMM /usr/bin/TGMM
RUN ln -s /usr/src/app/TGMM/build/nucleiChSvWshedPBC/ProcessStack /usr/bin/ProcessStack
RUN mkdir /usr/src/app/TGMM/TGMMruns

RUN apt-get install parallel

WORKDIR /usr/src/app
ADD ./run.sh /usr/src/app/run.sh

ENTRYPOINT ["bash","run.sh"]
