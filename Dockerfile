FROM python:3
RUN apt-get update
RUN apt-get install -y apt-utils

# packages for dexy filters (see also dexy_filter_examples package)
RUN apt-get install -y abcm2ps
RUN apt-get install -y asciidoc
RUN apt-get install -y asciidoctor
RUN apt-get install -y ghostscript
RUN apt-get install -y texlive-font-utils
RUN apt-get install -y texlive-latex-recommended
RUN apt-get install -y figlet
RUN apt-get install -y golang
RUN apt-get install -y clojure
RUN apt-get install -y tidy
RUN apt-get install -y julia

# install and generate the site
ENV PYTHONUNBUFFERED 1
RUN mkdir /dexy-site
COPY . /dexy-site
WORKDIR /dexy-site
RUN pip install -r requirements.txt
