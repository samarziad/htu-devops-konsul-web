
#/usr/src

FROM node:12.2.0-alpine as stage-building

#create and set working directory 
RUN mkdir /app
WORKDIR /app



#COPY and install app dependencies 
COPY package.json /app/package.json

#install dependincy n0de.js vue ...
RUN npm install


RUN  npm install --global  @gridsome/cli

#COPY app pr0ject
COPY . /app

#build app for production 

RUN  gridsome build
 
#production stage depl0y app using nginx
FROM nginx
COPY  --from=stage-building /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]



