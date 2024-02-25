FROM --platform=linux/amd64 debian:bookworm-slim

ARG KOTLIN_VERSION
ARG KOTLIN_TARGET="linux-x86_64"
ARG KOTLIN_TOOLCHAIN="kotlin-native-prebuilt-${KOTLIN_TARGET}-${KOTLIN_VERSION}"

ARG LIBFFI_X64="libffi-3.2.1-2-linux-x86-64"
ARG LLDB="lldb-4-linux"
ARG GCC_GLIBC_X64="x86_64-unknown-linux-gnu-gcc-8.3.0-glibc-2.19-kernel-4.9-2"
ARG GCC_GLIBC_AARCH64="aarch64-unknown-linux-gnu-gcc-8.3.0-glibc-2.25-kernel-4.9-2"
ARG LLVM_X64="llvm-11.1.0-linux-x64-essentials"
ARG QEMU_AARCH64="qemu-aarch64-static-5.1.0-linux-2"

RUN apt update && \
    apt install --no-install-recommends -y \
        ca-certificates \
        curl \
        tar

RUN mkdir -p /root/.konan/dependencies

RUN curl -OL https://download.jetbrains.com/kotlin/native/${LIBFFI_X64}.tar.gz && \
    tar -zxf ${LIBFFI_X64}.tar.gz && \
    rm ${LIBFFI_X64}.tar.gz && \
    mv ${LIBFFI_X64} /root/.konan/dependencies

RUN curl -OL https://download.jetbrains.com/kotlin/native/${LLDB}.tar.gz && \
    tar -zxf ${LLDB}.tar.gz && \
    rm ${LLDB}.tar.gz && \
    mv ${LLDB} /root/.konan/dependencies

RUN curl -OL https://download.jetbrains.com/kotlin/native/${GCC_GLIBC_X64}.tar.gz  && \
    tar -zxf ${GCC_GLIBC_X64}.tar.gz && \
    rm ${GCC_GLIBC_X64}.tar.gz && \
    mv ${GCC_GLIBC_X64} /root/.konan/dependencies

RUN curl -OL https://download.jetbrains.com/kotlin/native/${GCC_GLIBC_AARCH64}.tar.gz && \
    tar -zxf ${GCC_GLIBC_AARCH64}.tar.gz && \
    rm ${GCC_GLIBC_AARCH64}.tar.gz && \
    mv ${GCC_GLIBC_AARCH64} /root/.konan/dependencies

RUN curl -OL https://download.jetbrains.com/kotlin/native/${LLVM_X64}.tar.gz && \
    tar -zxf ${LLVM_X64}.tar.gz && \
    rm ${LLVM_X64}.tar.gz && \
    mv ${LLVM_X64} /root/.konan/dependencies

RUN curl -OL https://download.jetbrains.com/kotlin/native/${QEMU_AARCH64}.tar.gz && \
    tar -zxf ${QEMU_AARCH64}.tar.gz && \
    rm ${QEMU_AARCH64}.tar.gz && \
    mv ${QEMU_AARCH64} /root/.konan/dependencies

RUN curl -OL https://download.jetbrains.com/kotlin/native/builds/releases/${KOTLIN_VERSION}/${KOTLIN_TARGET}/${KOTLIN_TOOLCHAIN}.tar.gz && \
    tar -zxf ${KOTLIN_TOOLCHAIN}.tar.gz && \
    rm ${KOTLIN_TOOLCHAIN}.tar.gz && \
    mv ${KOTLIN_TOOLCHAIN} /root/.konan

RUN echo "${GCC_GLIBC_X64}" >> /root/.konan/dependencies/.extracted && \
    echo "${LLDB}" >> /root/.konan/dependencies/.extracted && \
    echo "${LLVM_X64}" >> /root/.konan/dependencies/.extracted && \
    echo "${LIBFFI_X64}" >> /root/.konan/dependencies/.extracted && \
    echo "${GCC_GLIBC_AARCH64}" >> /root/.konan/dependencies/.extracted && \
    echo "${QEMU_AARCH64}" >> /root/.konan/dependencies/.extracted
