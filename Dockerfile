
#/usr/src

FROM node:10.15.0 as stage-building
RUN mkdir /app
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH

COPY package.json /app/package.json
RUN npm install
RUN npm install -g @vue/cli
COPY . /app
RUN npm run build
 
FROM nginx
COPY  --from=stage-building /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]



