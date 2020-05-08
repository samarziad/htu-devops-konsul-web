
# build stage 
FROM node:lts-alpine as build-stage

RUN npm install -g http-server

#create directory 
WORKDIR  /app

#COPY package.json  /app/package.json

COPY package*.json ./
#install dependency from .json 
#RUN npm install npm -g
RUN npm install

#RUN  npm install --global @gridsome/cli

#RUN npm install


#COPY all files t0 app
COPY . .

#RUN chmod u+wrx /usr/share/nginx/html
#RUN npm run build
#RUN  gridsome build
RUN npm run build

#production 
#FROM nginx:1.17.10  as production-stage
#COPY --from=build-stage /app/dist /usr/share/nginx/html/app/dist

EXPOSE 8080
#CMD {"nginx" , "-g" , "daemon off;"}
CMD [ "http-server", "dist"]





