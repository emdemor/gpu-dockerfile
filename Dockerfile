FROM pytorch/pytorch:2.0.0-cuda11.7-cudnn8-devel

WORKDIR /app

RUN apt update && apt-get install pciutils -y
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6 libgl1  -y

COPY project/ /app/project/
COPY ./requirements.txt /app/requirements.txt

RUN pip install -r /app/requirements.txt

EXPOSE 8888

VOLUME /app/project

CMD ["jupyter", "lab", "--ip=*", "--port=8888", "--no-browser", "--notebook-dir=/app/project", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''", "--NotebookApp.default_url='/lab/tree'"]