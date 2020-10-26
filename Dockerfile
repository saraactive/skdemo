FROM node:14.14.0-alpine3.12

ADD . /home/node_microservice/
RUN cd /home/node_microservice && npm install --production

WORKDIR /home/node_microservice/
USER node
ENV PORT 5000

ENV MISC '{"profilesUrl": "https://us-south.appid.cloud.ibm.com","isLocal": "true","baseDomain": "microapp-pentest.dws-ipa.com","callbackurl": "/callback", "cookieExpiry":300000}'

ENV APPID_SERVICE_BINDING '{"clientId": "108c1d61-4177-4ab3-80b3-603493e23ad6","oauthServerUrl": "https://us-south.appid.cloud.ibm.com/oauth/v4/1c9e6d22-4f7c-47cd-8f15-ae9e71901d0d","secret": "MDQ0NWUzYTQtNGRjMC00MDcyLTllZTItNTA0OTI0NTkxNzhj","tenantId": "1c9e6d22-4f7c-47cd-8f15-ae9e71901d0d"}'
EXPOSE 5000 5000

CMD ["npm", "start"]

