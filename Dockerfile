FROM alpine:latest

# 安装 rsync 运行必须的软件包，包括证书相关和 ssh 客户端
RUN apk add --no-cache rsync ca-certificates openssh-client && \
    rm -rf /var/cache/apk/*

# XDG目录规范，不使用传统的 FHS 规范
ENV XDG_CONFIG_HOME=/config

# 创建相关目录和配置文件、密码文件。默认安装完 rsync 后会创建配置文件 /etc/rsyncd.conf
RUN mkdir -p ${XDG_CONFIG_HOME} && \
    touch /etc/rsyncd.passwd ${XDG_CONFIG_HOME}/rsync.password && \
    chmod 600 /etc/rsyncd.passwd && \
    chmod 600 ${XDG_CONFIG_HOME}/rsync.password

# 指定工作目录
WORKDIR /rsync

# rsync daemon 873 服务端口
EXPOSE 873/tcp

CMD ["rsync"] 
