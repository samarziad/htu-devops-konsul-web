
# build stage 
FROM node:12.2.0-alpine as build-stage

#RUN npm install -g http-server

#create directory 
WORKDIR  /app

#COPY package.json /app/package.json

#ENV PATH /app/node_modules/.bin:$PATH



COPY package*.json ./
#install dependency from .json 
#RUN npm install npm -g

#RUN apt-get install -y nginx 
RUN npm install

#RUN  npm install --global  @gridsome/cli 
#RUN npm install @vue/cli@3.7.0


#COPY all files t0 app
COPY . .


 
RUN npm run build



#production 
FROM nginx:latest  as production-stage

#change  r00t direct0ry 
RUN mkdir /app
COPY --from=build-stage /app/dist /usr/share/nginx/html/dist

#RUN rm /etc/nginx/conf.d/default.conf
#COPY  nginx.conf /etc/nginx/conf.d

#p0rt number 
EXPOSE 80
CMD {"nginx" , "-g" , "daemon off;"}

#del0y l0cally 
#CMD [ "http-server", "dist"]





