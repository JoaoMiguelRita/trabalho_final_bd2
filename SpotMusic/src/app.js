const path = require("path");

const express = require("express");

const helmet = require("helmet");

const routes = require("./routes");

const app = express();

app.use(express.json());

app.use(helmet({ contentSecurityPolicy: false }));

app.use(express.static(path.join(__dirname, "public")));

app.use('/api', routes);

module.exports = app;
