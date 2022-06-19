# SLBFE-App

API is hosted in - https://slbfe-api-app.herokuapp.com/  
Web client is hosted in - https://slbfe-webapp.netlify.app/  
API documentation - https://documenter.getpostman.com/view/14803467/UyxgHnA7

### How to run
Clone and move to the root directory
```sh
git clone <reponame>
cd <reponame>
```
Run api/server side (you should be on the root directory)
```sh
cd api
npm install
npm start
```
Run client-api (you should be on the root directory)
```sh
cd client-web
npm install
npm start
```

### To run locally both api and client:
- Remove the https://slbfe-api-app.herokuapp.com/ link in the client-web's **index.js** and use http://localhost:5000/
- Change **node** to **nodemon** in the **package.json** file of the api side

### Screenshots
- Web
![Page-33-Image-36](https://user-images.githubusercontent.com/52848335/174471589-924aad29-7d1e-4f9e-9e00-4fd057efc053.png)

- Mobile
<img src="https://user-images.githubusercontent.com/52848335/174471568-4b3ec7c1-2799-4d09-a089-c156fe55921b.png" height="600">
