# SLBFE-App

API is hosted in - https://slbfe-api-app.herokuapp.com/

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
