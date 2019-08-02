# jenkins-x64
FROM jenkins/jenkins:lts

# install docker (in docker)
USER root
RUN curl -s https://get.docker.com | bash -s
RUN usermod -aG docker jenkins
USER jenkins
