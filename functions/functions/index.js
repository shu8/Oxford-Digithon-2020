const functions = require('firebase-functions');
const admin = require('firebase-admin');

exports.scheduledFunction = functions.pubsub.schedule('0 8 * * *')
  .timeZone('Europe/London')
  .onRun(context => {
    console.log('Cron notification function run!');
    admin.messaging().sendToTopic('daily_reminder', {
      notification: {
        title: 'Daily Challenge available!',
        body: 'Your new daily challenge is available now!',
      },
      data: {
        click_action: 'FLUTTER_NOTIFICATION_CLICK',
      },
    }).then(response => console.log('success', response))
      .catch(error => console.log('error', error));
  });

exports.notify = functions.https.onRequest(async (req, res) => {
  console.log('Cron notification function run!');
  admin.messaging().sendToTopic('daily_reminder', {
    notification: {
      title: 'Daily Challenge available!',
      body: 'Your new daily challenge is available now!',
    },
    data: {
      click_action: 'FLUTTER_NOTIFICATION_CLICK',
    },
  }).then(response => console.log('success', response))
    .catch(error => console.log('error', error));
});
