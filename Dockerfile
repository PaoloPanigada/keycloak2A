FROM centos:latest
USER root

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 10.0.0.Final
ENV JB_CON wildfly-mongo.jarvis-sit.svc
ENV JBOSS_HOME /wildfly
#ENV JBOSS_KEYCLOAK $JBOSS_HOME/keycloak-1.9.4.Final

# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place

RUN cd $HOME && \
    cd $JBOSS_HOME
    #wget "http://downloads.jboss.org/keycloak/1.9.4.Final/keycloak-1.9.4.Final.tar.gz" && \
    #tar zxvf keycloak-1.9.4.Final.tar.gz && \
    #cd $JBOSS_KEYCLOAK

#RUN $JBOSS_KEYCLOAK/bin/add-user.sh admin P@ssw0rd10 --silent
#ADD mongojdbc1.2.jar $JBOSS_HOME/bin/standalone/deployments
#ADD postgresql-9.4.1208.jar $JBOSS_HOME/standalone/deployments
#ADD standalone.xml $JBOSS_KEYCLOAK/standalone/configuration
#RUN sed -i 's/jboss.bind.address.management:127.0.0.1/jboss.bind.address.management:0.0.0.0/g' $JBOSS_KEYCLOAK/standalone/configuration/standalone.xml && \
#RUN $JBOSS_KEYCLOAK/bin/add-user-keycloak.sh -r master -u admin -p P@ssw0rd10

# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true

# Expose the ports we're interested in
EXPOSE 8080 9990

#: For systemd usage this changes to /usr/sbin/init
# Keeping it as /bin/bash for compatability with previous
#CMD ["$JBOSS_KEYCLOAK/bin/standalone.sh", "-b", "0.0.0.0"]
CMD ["$JBOSS_HOME/bin/standalone.sh", "-b", "0.0.0.0"]
