FROM d.svideo.site/library/alpine

# 设置 Alpine 的镜像源为清华大学
RUN echo "https://mirrors.tuna.tsinghua.edu.cn/alpine/v3.15/main" > /etc/apk/repositories \
    && echo "https://mirrors.tuna.tsinghua.edu.cn/alpine/v3.15/community" >> /etc/apk/repositories

# 更新本地软件包索引
RUN apk update

WORKDIR /app
COPY ./main.py /app/

# 安装依赖并设置 pip 使用清华大学镜像源
RUN apk add --no-cache curl ca-certificates python3 py3-pip build-base libffi-dev python3-dev \
    && echo "[global]" >> /etc/pip.conf \
    && echo "index-url = https://pypi.tuna.tsinghua.edu.cn/simple" >> /etc/pip.conf \
    && pip install --upgrade pip \
    && pip3 install --no-cache-dir requests \
    && pip3 install --no-cache-dir oci

ENTRYPOINT [ "python3", "main.py" ]