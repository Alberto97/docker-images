FROM --platform=linux/amd64 debian:bookworm-slim as deps
RUN apt update && \
    apt install --no-install-recommends -y \
        ca-certificates \
        curl \
        tar

RUN mkdir -p /root/.konan/dependencies

RUN curl -OL https://download.jetbrains.com/kotlin/native/libffi-3.2.1-2-linux-x86-64.tar.gz && \
    tar -zxvf libffi-3.2.1-2-linux-x86-64.tar.gz && \
    rm libffi-3.2.1-2-linux-x86-64.tar.gz && \
    mv libffi-3.2.1-2-linux-x86-64 /root/.konan/dependencies

RUN curl -OL https://download.jetbrains.com/kotlin/native/lldb-4-linux.tar.gz && \
    tar -zxvf lldb-4-linux.tar.gz && \
    rm lldb-4-linux.tar.gz && \
    mv lldb-4-linux /root/.konan/dependencies

RUN curl -OL https://download.jetbrains.com/kotlin/native/x86_64-unknown-linux-gnu-gcc-8.3.0-glibc-2.19-kernel-4.9-2.tar.gz  && \
    tar -zxvf x86_64-unknown-linux-gnu-gcc-8.3.0-glibc-2.19-kernel-4.9-2.tar.gz && \
    rm x86_64-unknown-linux-gnu-gcc-8.3.0-glibc-2.19-kernel-4.9-2.tar.gz && \
    mv x86_64-unknown-linux-gnu-gcc-8.3.0-glibc-2.19-kernel-4.9-2 /root/.konan/dependencies

RUN curl -OL https://download.jetbrains.com/kotlin/native/aarch64-unknown-linux-gnu-gcc-8.3.0-glibc-2.25-kernel-4.9-2.tar.gz && \
    tar -zxvf aarch64-unknown-linux-gnu-gcc-8.3.0-glibc-2.25-kernel-4.9-2.tar.gz && \
    rm aarch64-unknown-linux-gnu-gcc-8.3.0-glibc-2.25-kernel-4.9-2.tar.gz && \
    mv aarch64-unknown-linux-gnu-gcc-8.3.0-glibc-2.25-kernel-4.9-2 /root/.konan/dependencies

RUN curl -OL https://download.jetbrains.com/kotlin/native/llvm-11.1.0-linux-x64-essentials.tar.gz && \
    tar -zxvf llvm-11.1.0-linux-x64-essentials.tar.gz && \
    rm llvm-11.1.0-linux-x64-essentials.tar.gz && \
    mv llvm-11.1.0-linux-x64-essentials /root/.konan/dependencies

RUN curl -OL https://download.jetbrains.com/kotlin/native/qemu-aarch64-static-5.1.0-linux-2.tar.gz && \
    tar -zxvf qemu-aarch64-static-5.1.0-linux-2.tar.gz && \
    rm qemu-aarch64-static-5.1.0-linux-2.tar.gz && \
    mv qemu-aarch64-static-5.1.0-linux-2 /root/.konan/dependencies

FROM --platform=linux/amd64 debian:bookworm-slim
ARG KOTLIN_VERSION
ARG KOTLIN_TARGET="linux-x86_64"
RUN apt update && \
    apt install --no-install-recommends -y \
        ca-certificates \
        curl \
        tar
COPY --from=deps /root/.konan/ /root/.konan/
RUN curl -OL https://download.jetbrains.com/kotlin/native/builds/releases/${KOTLIN_VERSION}/${KOTLIN_TARGET}/kotlin-native-prebuilt-${KOTLIN_TARGET}-${KOTLIN_VERSION}.tar.gz && \
    tar -zxvf kotlin-native-prebuilt-${KOTLIN_TARGET}-${KOTLIN_VERSION}.tar.gz && \
    rm kotlin-native-prebuilt-${KOTLIN_TARGET}-${KOTLIN_VERSION}.tar.gz && \
    mv kotlin-native-prebuilt-${KOTLIN_TARGET}-${KOTLIN_VERSION} /root/.konan

RUN echo 'x86_64-unknown-linux-gnu-gcc-8.3.0-glibc-2.19-kernel-4.9-2\n\
lldb-4-linux\n\
llvm-11.1.0-linux-x64-essentials\n\
libffi-3.2.1-2-linux-x86-64\n\
aarch64-unknown-linux-gnu-gcc-8.3.0-glibc-2.25-kernel-4.9-2\n\
qemu-aarch64-static-5.1.0-linux-2\n' > /root/.konan/dependencies/.extracted