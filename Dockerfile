FROM jupyter/datascience-notebook:7a0c7325e470
USER root
RUN apt-get clean
RUN apt-get update

ARG INDEX_URL
ENV PIP_EXTRA_INDEX_URL=$INDEX_URL
RUN echo $PIP_EXTRA_INDEX_URL

RUN apt-get install -y fuse wget pkg-config libudev-dev udev vim
USER $NB_UID 

# Install webhdfs and fuse-webhdfs.
ADD requirements.txt /requirements.txt
RUN pip install -r /requirements.txt
WORKDIR /home/jovyan
RUN mkdir /home/jovyan/ckan_project
ADD webhdfs-fuse.ini /home/jovyan/.config/webhdfs.ini
COPY jupyter_notebook_config.py /home/$NB_USER/.jupyter/jupyter_notebook_config.py
COPY custom.js /home/$NB_USER/.jupyter/custom/
USER $NB_UID
