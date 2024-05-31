# Sử dụng Ubuntu làm base image
FROM ubuntu:latest

# Cập nhật và cài đặt các gói cần thiết
RUN apt-get update && apt-get install -y \
    openssh-server \
    nginx \
    sudo \
    nano \
    wget \
    curl

# Tạo thư mục cho SSH daemon
RUN mkdir /var/run/sshd

# Tạo một người dùng mới và đặt mật khẩu
RUN useradd -m -s /bin/bash vpsuser && echo 'vpsuser:password' | chpasswd

# Cho phép người dùng vpsuser sử dụng sudo
RUN usermod -aG sudo vpsuser

# Thay đổi cài đặt SSH để cho phép xác thực mật khẩu
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Mở cổng 22 cho SSH và cổng 80 cho Nginx
EXPOSE 22 80

# Khởi động SSH và Nginx khi container bắt đầu
CMD service ssh start && service nginx start && bash
