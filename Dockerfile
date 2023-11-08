FROM pytorch/pytorch:2.0.0-cuda11.7-cudnn8-devel

RUN apt update
RUN apt-get install pciutils -y

# Install Jupyter
RUN pip install jupyter
RUN pip install ipywidgets
RUN pip install jupyter_contrib_nbextensions

RUN pip install datasets==2.11.0 -q
RUN pip install evaluate==0.4.0 -q
RUN pip install rouge_score==0.1.2 -q
RUN pip install loralib==0.1.1 -q
RUN pip install peft==0.3.0 -q
RUN pip install sentencepiece==0.1.99 -q
RUN pip install pandas==2.0.3 -q
RUN pip install protobuf==4.24.2
RUN pip install tensorflow==2.9.*

RUN mkdir /project
COPY project/ /project/

EXPOSE 8888

CMD jupyter lab --ip=* --port=8888 --no-browser --notebook-dir=/project --allow-root