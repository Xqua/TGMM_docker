FROM nvidia/cuda:8.0-devel-ubuntu14.04

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:george-edison55/cmake-3.x
RUN apt-get update
RUN apt-get install -qq -y build-essential git cmake make gcc-4.8 g++-4.8
RUN dpkg -l | grep gcc | awk '{print $2}'
#RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 10
#RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/gcc-4.8 10
#RUN update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 30
#RUN update-alternatives --set cc /usr/bin/gcc

#RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 30
#RUN update-alternatives --set c++ /usr/bin/g++

RUN gcc --version


RUN mkdir /usr/src/app
WORKDIR /usr/src/app
# ADD ./tgmm-paper ./tgmm-paper

RUN git clone https://git.rcc.uchicago.edu/open-source/TGMM.git
RUN rm -rf TGMM/build && mkdir TGMM/build
WORKDIR /usr/src/app/TGMM/build
#RUN sed -i 's/set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")/set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")/g' ../src/CMakeLists.txt
#RUN sed -i 's/#set(CMAKE_C_FLAGS "-pthread")/set(CMAKE_C_FLAGS "-pthread")/g' ../src/CMakeLists.txt
RUN sed -i 's@TARGET_LINK_LIBRARIES(TGMM /software/gcc-6.2-el7-x86_64/lib64/libstdc++.so)@@g' ../src/CMakeLists.txt
RUN cat ../src/CMakeLists.txt 
RUN cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_LIBRARY_PATH=/usr/local/cuda/lib64/stubs ../src/
RUN make -j
RUN ln -s /usr/src/app/TGMM/build/TGMM /usr/bin/TGMM
RUN ln -s /usr/src/app/TGMM/build/nucleiChSvWshedPBC/ProcessStack /usr/bin/ProcessStack
ADD ./test_config.txt /usr/src/app/TGMM/data/test_config.txt
RUN mkdir /usr/src/app/TGMM/TGMMruns

RUN apt-get install parallel

RUN echo "TESTING THAT THE COMPILATION WORKED"
#RUN parallel -j 4 ProcessStack /usr/src/app/TGMM/data/test_config.txt {} ::: {0..30}
#RUN TGMM /usr/src/app/TGMM/data/test_config.txt $1 $2

WORKDIR /usr/src/app
ADD ./run.sh /usr/src/app/run.sh
#RUN ln -s /usr/local/cuda/lib/* /usr/lib64

ENTRYPOINT ["bash","run.sh"]
