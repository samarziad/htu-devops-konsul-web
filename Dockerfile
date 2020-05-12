
#/usr/src

FROM node:10.15.0 as stage-building

#create and set working directory 
RUN mkdir /app
WORKDIR /app


# add (my app bin dependincy to env $PATH) `/app/node_modules/.bin` to env $PATH
ENV PATH /app/node_modules/.bin:$PATH

#COPY and install app dependencies 
COPY package.json /app/package.json

#install dependincy n0de.js vue 
RUN npm install
RUN npm install -g @vue/cli


#COPY app pr0ject
COPY . /app

#build app for production 
RUN npm run build
 
#production stage depl0y app using nginx
FROM nginx
COPY  --from=stage-building /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]



