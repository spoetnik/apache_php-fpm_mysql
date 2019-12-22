FROM httpd:2.4.41-alpine

ARG WEB_USER
ARG WEB_GROUP
ARG APACHE_ROOT_DIR


RUN deluser ${WEB_USER} \
    && addgroup -g 1000 ${WEB_GROUP} \
    && adduser -u 1000 -G ${WEB_GROUP} -D ${WEB_USER} \
    && chgrp -R ${WEB_GROUP} ${APACHE_ROOT_DIR}

COPY ./httpd.conf ${APACHE_ROOT_DIR}/conf/httpd.conf

RUN chgrp -R ${WEB_GROUP} ${APACHE_ROOT_DIR}/conf/httpd.conf \
 && chgrp -R ${WEB_GROUP} ${APACHE_ROOT_DIR}/conf/extra/httpd-vhosts.conf
 