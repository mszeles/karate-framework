# karate-framework

This project is a framework to automatize API testing using Karate. It contains many features and examples.
It is based on the excellent Karate DSL course on Udemy: https://www.udemy.com/course/karate-dsl-api-automation-and-performance-from-zero-to-hero

In order to run the tests, you should clone and run the following project: 
https://github.com/cirosantilli/node-express-sequelize-nextjs-realworld-example-app
```
npm install --force
npm run dev
```
In case it is not starting, modify in package.json scripts.dev to
```
"dev": "cross-env NODE_OPTIONS='--unhandled-rejections=strict' nodemon ./app.js"
```
