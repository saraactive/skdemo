const express = require('express');
serveStatic = require('serve-static');
const helmet = require("helmet");
const cors = require("cors");
const path = require("path");
const cookieParser = require("cookie-parser");
const nocache = require('nocache');
const bodyParser = require("body-parser");
const session = require("express-session");
const passport = require("passport");
const appID = require("bluemix-appid");
const express_enforces_ssl = require("express-enforces-ssl");

// const dotenv = require('dotenv');
// dotenv.config();
let app = express();
var miscAttr = JSON.parse(process.env.MISC);
var APPID_CONFIG = JSON.parse(process.env.APPID_SERVICE_BINDING);
const PORT = process.env.PORT;

const sessionObj = {
  secret: "keyboardcat",
  resave: true,
  secure:true,
  saveUninitialized: true
};

app.use(cors());
app.use(cookieParser());
app.use(passport.initialize());
app.use(passport.session());

const isLocal = miscAttr.isLocal;
const config = getLocalConfig();
const WebAppStrategy = appID.WebAppStrategy;
let webAppStrategy = new WebAppStrategy(config);
passport.use(webAppStrategy);

// app.use(bodyParser.json({
//   limit: '5mb'
// }));
// app.use(bodyParser.urlencoded({
//   extended: true,
//   limit: '5mb'
// }));

app.use(session(sessionObj));
const UI_BASE_URL = config["baseDomain"];
const CALLBACK_URL = config["callbackurl"];
configureSecurity();
passport.serializeUser(function (user, cb) {
  cb(null, user);
});
passport.deserializeUser(function (obj, cb) {
  cb(null, obj);
});

function getLocalConfig() {
  if (!isLocal) {
    return {};
  }
  let config = {};
  const requiredParamsMisc = ['profilesUrl', 'isLocal', 'baseDomain', 'callbackurl'];
  const requiredParams = ['clientId', 'secret', 'tenantId', 'oauthServerUrl'];
  // const requiredParams = ['clientId', 'secret', 'tenantId', 'profilesUrl', 'baseUrl', 'port', 'callbackurl', 'isLocal', 'oauthServerUrl', 'domain', 'xFrameWhiteListHost'];
  requiredParamsMisc.forEach(function (requiredParam) {
    if (!miscAttr[requiredParam]) {
      console.error('When running locally, make sure to create a file *config.json* in the root directory. See config.template.json for an example of a configuration file.');
      console.error(`Required parameter is missing: ${requiredParam}`);
      process.exit(1);
    }
    config[requiredParam] = miscAttr[requiredParam];
    console.log(requiredParam + " : " + miscAttr[requiredParam])
  });
  requiredParams.forEach(function (requiredParam) {
    config[requiredParam] = APPID_CONFIG[requiredParam];
    console.log(requiredParam + " : " + APPID_CONFIG[requiredParam])
  });
  config['port'] = PORT;
  if (config['isLocal'] === "true") {
    config['redirectUri'] = `http://localhost:${config['port']}${config['callbackurl']}`;
    console.log("Redirect URL : local : : " + config['redirectUri']);
  } else {
    config['redirectUri'] = `https://${config['baseDomain']}${config['callbackurl']}`;
    console.log("Redirect URL : K8 : : " + config['redirectUri']);
  }
  return config;
}

function configureSecurity() {
  app.use(helmet.referrerPolicy({
    policy: ["origin", "unsafe-url"],
  }));
  app.use(cookieParser());
  app.enable("trust proxy");
  if (!isLocal) {
    app.use(express_enforces_ssl());
  }
}

app.get('/login', (req, res, next) => {
  console.log('Inside POST /login callback')
  passport.authenticate(WebAppStrategy.STRATEGY_NAME, (err, user, info) => {
    console.log('Inside passport.authenticate() callback');
    console.log(`req.session.passport: ${JSON.stringify(req.session.passport)}`)
    console.log(`req.user: ${JSON.stringify(req.user)}`)
    req.login(user, (err) => {
      console.log('Inside req.login() callback')
      console.log(`req.session.passport: ${JSON.stringify(req.session.passport)}`)
      console.log(`req.user: ${JSON.stringify(req.user)}`)
     return res.json({"status":"success", "message":"authentication successful"});
    })
  })(req, res, next);
});

app.get("/auth/logout", function (req, res, next) {
  WebAppStrategy.logout(req);
  res.redirect("/auth/login");
});

app.get(CALLBACK_URL, passport.authenticate(WebAppStrategy.STRATEGY_NAME, {
  allowAnonymousLogin: true
}));

app.disable('x-powered-by');
app.use(helmet.hsts({
  // Must be at least 1 year to be approved
  maxAge: 31536000,
}))
app.use(helmet.noSniff());
app.use(nocache());

app.get('/', (req, res) => {
  console.log('Inside GET / callback')
  console.log(`User authenticated? ${req.isAuthenticated()}`)
  if(req.session['APPID_AUTH_CONTEXT']) {
   console.log("req.session", req.session["APPID_AUTH_CONTEXT"])
   res.sendFile(path.join(__dirname+'/public/HR_JML_TaskList.html'));
  } else {
    res.redirect('/login')
  }
});

app.get('/render_form/joinerform', (req, res) => {
  console.log('Inside GET /render_form/joinerform callback')
  console.log(`User authenticated? ${req.isAuthenticated()}`)
  if(req.session['APPID_AUTH_CONTEXT']) {
   console.log("req.session", req.session["APPID_AUTH_CONTEXT"])
   res.sendFile(path.join(__dirname+'/public/Joiner_Static_Form.html'));
  } else {
    res.redirect('/login')
  }
});

app.post('/get_formdata/joinerform', (req, res) => {
  console.log('Inside POST /get_formdata/joinerform callback')
  console.log(`User authenticated? ${req.isAuthenticated()}`)
  if(req.session['APPID_AUTH_CONTEXT']) {
   console.log("req.session", req.session["APPID_AUTH_CONTEXT"])
   res.sendFile(path.join(__dirname+'/public/Joiner_Static_Form.html'));
  } else {
    res.redirect('/login')
  }
});


function isLoggedIn(req, res, next) {
  if (req.session["APPID_AUTH_CONTEXT"]) {
    console.log("req.session", req.session["APPID_AUTH_CONTEXT"])
    next();
  } else {
    res.redirect("/auth/login");
  }
}
// server listen
app.listen(PORT);
console.log('Server is running on: ' + (PORT));
app.use(function (req, res) {
  console.log(__dirname)
  res.redirect("/login");
});

