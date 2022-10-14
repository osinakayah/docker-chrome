FROM jlesage/baseimage-gui:ubuntu-20.04

WORKDIR /tmp

RUN apt-get update
RUN apt-get update \
    && apt-get install -y libcurl4 curl wget gnupg \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*


RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs


COPY rootfs/ /

WORKDIR /etc/services.d/app
RUN npm install

WORKDIR /tmp

COPY startapp.sh /startapp.sh



ENV APP_NAME="Chrome"
VOLUME ["/config"]
