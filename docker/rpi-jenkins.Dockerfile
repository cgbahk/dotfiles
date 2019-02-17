# rpi-jenkins
# forked from https://github.com/kosmoflyko/rpi-jenkins
FROM resin/rpi-raspbian:latest

# Get system up to date and install deps.
RUN apt-get update; apt-get --yes upgrade; apt-get --yes install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common \
    libapparmor-dev && \
    apt-get clean && apt-get autoremove -q && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man /tmp/*

# The special trick here is to download and install the Oracle Java 8 installer from Launchpad.net
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886

# Make sure the Oracle Java 8 license is pre-accepted, and install Java 8
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
    apt-get update && \
    apt-get --yes install oracle-java8-installer ; apt-get clean

ARG JENKINS_HOME=/usr/local/jenkins
ENV JENKINS_HOME ${JENKINS_HOME}

RUN mkdir -p ${JENKINS_HOME}
RUN useradd --no-create-home --shell /bin/sh jenkins
RUN chown -R jenkins:jenkins ${JENKINS_HOME}
ADD http://mirrors.jenkins-ci.org/war-stable/latest/jenkins.war /usr/local/jenkins.war
RUN chmod 644 /usr/local/jenkins.war

VOLUME ${JENKINS_HOME}

ENTRYPOINT ["/usr/bin/java", "-jar", "/usr/local/jenkins.war"]
EXPOSE 8080
CMD [""]
