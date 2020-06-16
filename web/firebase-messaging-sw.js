importScripts('https://www.gstatic.com/firebasejs/7.5.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/7.5.0/firebase-messaging.js');

var firebaseConfig = {
    apiKey: "AIzaSyCzUq2mq1xT71LDQcWZeQmV3XofVDHG8i4",
    authDomain: "education-modeck.firebaseapp.com",
    databaseURL: "https://education-modeck.firebaseio.com",
    projectId: "education-modeck",
    storageBucket: "education-modeck.appspot.com",
    messagingSenderId: "710015013776",
    appId: "1:710015013776:web:6df291f105452ff61a1915",
    measurementId: "G-V0ENWMP6KW"
};


firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();
//messaging.usePublicVapidKey('BI8477Xauy7pEzRpsVrs_kO0DCw6JU8L-F4qX4vTBh7s2b4aVpRRJT3dg0aN4qs5PvY-JSeUzy5F0W9EMnOzyNw');
messaging.setBackgroundMessageHandler(function(payload){
    console.log({'Background: ' : payload});
    return self.ServiceWorkerRegistration.showNotification(title);
});