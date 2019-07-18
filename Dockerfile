FROM centos:7
MAINTAINER Yongqiang Li "jasonleehust@gmail.com"

RUN yum update
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-SCLo

RUN yum-config-manager --enable rhel-server-rhscl-7-rpms

RUN yum -y yum instal devtoolset-7 cmake3 git make centos-release-scl g++ gcc

RUN cd ; git clone https://github.com/llvm-mirror/llvm.git
RUN cd llvm/tools ; git clone https://github.com/llvm-mirror/clang.git 
RUN cd clang/tools ; git clone https://github.com/llvm-mirror/clang-tools-extra.git extra

RUN scl enable devtoolset-7 bash

RUN cd ~/llvm; mdir build ; cd build ; cmake3 -G'Unix Makefiles' -DCMAKE_BUILD_TYPE=Release  -DLLVM_TEMPORARILY_ALLOW_OLD_TOOLCHAIN ..

RUN cat "Ready to make -j2 clang && make -j2 check-clang" > ~/README


