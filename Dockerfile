FROM amazonlinux:2023
RUN dnf install nano -y
RUN mkdir test
WORKDIR /test/
COPY script.sh /test/script.sh
RUN chmod 775 /test/script.sh
RUN touch /test/test1
RUN touch /test/test2 && chmod 777 /test/test2
CMD [ "./script.sh"]


