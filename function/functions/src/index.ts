import * as functions from 'firebase-functions';

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
export const helloWorld = functions.https.onRequest((request, response) => {
 mjAPI.typeset({
    math: yourMath,
    format: "TeX", // or "inline-TeX", "MathML"
    svg:true,      // or svg:true, or html:true
  }, function (data: any) {
    if (!data.errors) {
        let svg = data.svg.toString();
        svg = svg.replace("currentColor", "");
        svg = svg.replace("currentColor", "");
        console.log(svg);
        response.send(svg);
    }
    // will produce:
    // <math xmlns="http://www.w3.org/1998/Math/MathML" display="block">
    //   <mi>E</mi>
    //   <mo>=</mo>
    //   <mi>m</mi>
    //   <msup>
    //     <mi>c</mi>
    //     <mn>2</mn>
    //   </msup>
    // </math>
  });
});

const mjAPI = require("mathjax-node");
mjAPI.config({
  MathJax: {
    // traditional MathJax configuration
  }
});
mjAPI.start();

let yourMath = '$\sum_{i=0}^n i^2 = \frac{(n^2+n)(2n+1)}{6}$';