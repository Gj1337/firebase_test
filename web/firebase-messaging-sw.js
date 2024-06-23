importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
    apiKey: 'AIzaSyCtaHt48HBuJaGJnbraNLT0mlpDRutu6yg',
    appId: '1:648151005969:web:89fe159e450b4b8b696ab0',
    messagingSenderId: '648151005969',
    projectId: 'fir-test-a1386',
    authDomain: 'fir-test-a1386.firebaseapp.com',
    storageBucket: 'fir-test-a1386.appspot.com',
    measurementId: 'G-DJXKKTT2Y8',
});

const messaging = firebase.messaging();