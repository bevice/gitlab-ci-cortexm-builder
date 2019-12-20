FROM amd64/alpine
MAINTAINER bevice
RUN apk update && \
	apk upgrade && \
	apk add --no-cache make cmake curl ca-certificates wget bash && \
	wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
	wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk && \
	apk add glibc-2.28-r0.apk && rm -f glibc-2.28-r0.apk
RUN curl -O https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/8-2018q4/gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz2 && \
	tar xf gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz2 -C / && \
	rm -f gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz2
RUN echo export ARM_TOOLCHAIN_PATH=/gcc-arm-none-eabi-8-2018-q4-major >> /etc/profile && \
	echo export PATH=${PATH}:/gcc-arm-none-eabi-8-2018-q4-major/bin >> /etc/profile
RUN apk add git openssh-client
ENV ARM_TOOLCHAIN_PATH /gcc-arm-none-eabi-8-2018-q4-major
ENV PATH ${PATH}:/gcc-arm-none-eabi-8-2018-q4-major/bin
