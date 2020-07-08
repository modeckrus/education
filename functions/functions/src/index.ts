
import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();
export const checkFireStorage = functions.https.onRequest((req, resp)=>{
    console.log('Start execution');
    if (req.method === 'POST') {
      console.log('Post method')
      console.log('Body: ', req.body)
      mjAPI.typeset({
              math: req.body,
              format: "TeX", // or "inline-TeX", "MathML"
              svg:true,      // or svg:true, or html:true
            },async function (data: any) {
              if (!data.errors) {
                  let svg = data.svg.toString();
                  svg = svg.replace("currentColor", "");
                  svg = svg.replace("currentColor", "");
                  
                  console.log(svg);
                  resp.send(svg);
              }
          });
  }
})

const mjAPI = require("mathjax-node");
mjAPI.config({
  MathJax: {
    // traditional MathJax configuration
  }
});
mjAPI.start();