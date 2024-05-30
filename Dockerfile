FROM ubuntu:latest

# Cập nhật hệ thống
RUN apt-get update && apt-get upgrade -y

# Cài đặt các gói phần mềm cần thiết (ví dụ: SSH)
RUN apt-get install -y openssh-server

# Cấu hình SSH
RUN mkdir /var/run/sshd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Tạo user mới
RUN useradd -rm -d /home/user -s /bin/bash -g root -G sudo -u 1000 user
RUN echo 'user:password' | chpasswd

# Mở cổng SSH
EXPOSE 22

# Khởi động SSH
CMD ["/usr/sbin/sshd", "-D"]
