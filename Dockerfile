FROM ruby:3.3.0-bullseye
RUN gem install cucumber cuprite rspec-expectations
RUN sh -c 'echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list' &&\
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - &&\
  apt-get update &&\ 
  apt-get install -y google-chrome-stable

WORKDIR /app
ENTRYPOINT ["cucumber"]
