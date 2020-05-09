
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
FROM nginx:stable-alpine  as production-stage
#change  r00t direct0ry 
COPY --from=build-stage /app/dist /usr/share/nginx/html

#p0rt number 
EXPOSE 80
CMD {"nginx" , "-g" , "daemon off;"}

#del0y l0cally 
#CMD [ "http-server", "dist"]





