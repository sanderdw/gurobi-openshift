# gurobi-centos7
FROM openshift/base-centos7

# TODO: Put the maintainer name in the image metadata
MAINTAINER Sander de Wildt <sander.de.wildt@alliander.com>

# TODO: Rename the builder environment variable to inform users about application you provide them
# ENV BUILDER_VERSION 1.0

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Gurpbo optimization Platform" \
      io.k8s.display-name="Gurobi 8.1.1" \
      io.openshift.expose-services="443:https" \
      io.openshift.tags="Solver,Gurobi"

# TODO: Install required packages here:
# RUN yum install -y ... && yum clean all -y
# RUN yum install -y rubygems && yum clean all -y
# RUN gem install asdf

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/
ADD https://sanwil.net/Downloads/Gurobi/gurobi8.1.1_linux64.tar.gz /opt
RUN tar xvfz /opt/gurobi8.1.1_linux64.tar.gz
RUN export GUROBI_HOME="/opt/gurobi810/linux64" 
RUN export PATH="${PATH}:${GUROBI_HOME}/bin" 
RUN export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${GUROBI_HOME}/lib" 

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image
# sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./s2i/bin/ /usr/libexec/s2i

# TODO: Drop the root user and make the content of /opt/gurobi810 owned by user 1001
RUN chown -R 1001:1001 /opt/gurobi810

# This default user is created in the openshift/base-centos7 image
USER 1001

# TODO: Set the default port for applications built using this image
EXPOSE 443

# TODO: Set the default CMD for the image
# CMD ["/usr/libexec/s2i/usage"]
