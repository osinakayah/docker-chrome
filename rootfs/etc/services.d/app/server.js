'use strict';
const puppeteer = require('puppeteer');
const httpProxy = require('http-proxy');
const express = require('express');

(async () => {
  const browser = await puppeteer.launch({
    headless: false,
    args: [
      '--no-sandbox',
      '--remote-debugging-port=9221',
      '--remote-debugging-host=0.0.0.0',
      '--remote-debugging-address=0.0.0.0',
      '--user-data-dir=/config/profile',
    ],
  });
  const browserWSEndpoint = browser.wsEndpoint();

  const app = express();
  const proxy = httpProxy.createProxyServer({
    target: browserWSEndpoint,
    ws: true,
  });
  const server = require('http').createServer(app);

  // Proxy websockets
  server.on('upgrade', function (req, socket, head) {
    console.log('proxying upgrade request', req.url);
    proxy.ws(req, socket, head);
  });

  server.listen(9222, '0.0.0.0');
})();
