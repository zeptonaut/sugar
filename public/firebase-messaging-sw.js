importScripts('https://www.gstatic.com/firebasejs/3.5.2/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/3.5.2/firebase-messaging.js');

firebase.initializeApp({
  'messagingSenderId': '915173614937'
});

var messaging = firebase.messaging();
messaging.setBackgroundMessageHandler((payload) => {
  console.log('[firebase-messaging=sw.js] Received background message ', payload);
});
