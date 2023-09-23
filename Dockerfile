FROM openjdk:8-jre-slim

# Download Spark
RUN apt-get update && \
    apt-get install -y wget && \
    wget -q https://archive.apache.org/dist/spark/spark-1.5.2/spark-1.5.2-bin-hadoop2.6.tgz && \
    tar -xzf spark-1.5.2-bin-hadoop2.6.tgz && \
    mv spark-1.5.2-bin-hadoop2.6 /spark && \
    rm spark-1.5.2-bin-hadoop2.6.tgz

RUN apt-get install python2 -y 
RUN wget https://bootstrap.pypa.io/pip/2.7/get-pip.py  && \ 
    python2 get-pip.py

RUN pip2 install py4j==0.10.4 pyspark

# Define environment variables
ENV SPARK_HOME /spark
ENV PATH $SPARK_HOME/bin:$PATH

ENV PYSPARK_PYTHON 'python2'

WORKDIR $SPARK_HOME

CMD ["bin/spark-submit", "--master", "local[*]", "/spark/bernuy/wordcount.py"]