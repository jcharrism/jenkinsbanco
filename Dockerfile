FROM registry.access.redhat.com/ubi8/ubi-minimal as builder



 

RUN microdnf update && microdnf install util-linux curl tar

 

ARG USERNAME
ARG PASSWORD
ARG DOWNLOAD_URL=http://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/integration/12.0.4.0-ACE-LINUX64-DEVELOPER.tar.gz

 

RUN mkdir -p /opt/ibm/ace-12 \
&& if [ -z $USERNAME ]; then curl ${DOWNLOAD_URL}; else curl -u "${USERNAME}:${PASSWORD}" ${DOWNLOAD_URL}; fi | \
    tar zx --absolute-names \
    --strip-components 1 \
    --directory /opt/ibm/ace-12

 

FROM registry.access.redhat.com/ubi8/ubi-minimal

 

RUN microdnf update && microdnf install findutils util-linux && microdnf clean all

 

# Force reinstall tzdata package to get zoneinfo files
RUN microdnf reinstall tzdata -y

 

# Install ACE v12.0.4.0 and accept the license
COPY --from=builder /opt/ibm/ace-12 /opt/ibm/ace-12
RUN /opt/ibm/ace-12/ace make registry global accept license deferred \
&& useradd --uid 1001 --create-home --home-dir /home/aceuser --shell /bin/bash -G mqbrkrs aceuser \
&& su - aceuser -c "export LICENSE=accept && . /opt/ibm/ace-12/server/bin/mqsiprofile && mqsicreateworkdir /home/aceuser/ace-server" \
&& echo ". /opt/ibm/ace-12/server/bin/mqsiprofile" >> /home/aceuser/.bashrc


 
#Crea carpetas
RUN mkdir /home/aceuser/build
RUN mkdir /home/aceuser/bar

#Copia archivos
COPY . /home/aceuser/build


#Lista archivos
RUN cd /home/aceuser/build && ls
 

# Add required license as text file in Liceses directory (GPL, MIT, APACHE, Partner End User Agreement, etc)

 

USER root

 

# Expose ports.  7600, 7800, 7843 for ACE;
EXPOSE 7600 7800 7843

 

# Set entrypoint to run the server
ENTRYPOINT ["bash", "-c", ". /opt/ibm/ace-12/server/bin/mqsiprofile && IntegrationServer -w /home/aceuser/ace-server"]
