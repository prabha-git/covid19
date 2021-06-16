# Base image https://hub.docker.com/u/rocker/
FROM rocker/shiny-verse:latest

RUN R -e "install.packages('bigrquery')"
RUN R -e "install.packages('shinycssloaders')"

COPY . ./app

# expose port
EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 3838)"]