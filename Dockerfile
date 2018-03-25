# Use the latest perl image from dockerhub
FROM perl:latest

# Install the web framework mojolicious
RUN curl -L https://cpanmin.us | perl - -M https://cpan.metacpan.org -n Mojolicious

# Instruct mojolicious to listen on port 8080 and open the port
# ENV MOJO_LISTEN http://*:8080
EXPOSE 8080

# add your application code and set the working directory
ADD . /app
WORKDIR /app
COPY lib .
COPY script .
COPY t .
COPY public .
COPY templates .

# To run on Heroku Container :
#CMD ["morbo", "script/yusrideb", "-l", "http://0.0.0.0:${PORT}"]

# To run on App Engine Google Cloud :
CMD ["hypnotoad", "-f", "script/yusrideb"]