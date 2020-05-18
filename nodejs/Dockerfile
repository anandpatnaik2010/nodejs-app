FROM node:10

# Create app directory

WORKDIR /usr/src/app

COPY nodejs/package*.json ./

RUN npm install

# Bundle app source
COPY nodejs/ .

EXPOSE 3000
#CMD [ "node", "./src/app.js" ]
ENTRYPOINT /bin/sh -c "node ./src/app.js"

