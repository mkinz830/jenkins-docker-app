FROM node:14
WORKDIR /usr/src/app
COPY app.js .
EXPOSE 8080
CMD ["node", "app.js"]

