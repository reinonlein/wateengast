// Ionic Starter App

// angular.module is a global place for creating, registering and retrieving Angular modules
// 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
// the 2nd parameter is an array of 'requires'
angular.module('starter', ['ionic', 'ngStorage'])

.run(function($ionicPlatform) {
  $ionicPlatform.ready(function() {
    // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
    // for form inputs).
    // The reason we default this to hidden is that native apps don't usually show an accessory bar, at
    // least on iOS. It's a dead giveaway that an app is using a Web View. However, it's sometimes
    // useful especially with forms, though we would prefer giving the user a little more room
    // to interact with the app.
    if (window.cordova && window.Keyboard) {
      window.Keyboard.hideKeyboardAccessoryBar(true);
    }

    if (window.StatusBar) {
      // Set the statusbar to use the default style, tweak this to
      // remove the status bar on iOS or change it to use white instead of dark colors.
      StatusBar.styleDefault();
    }
  });
})

.config(function($stateProvider, $urlRouterProvider){
  $stateProvider
    .state('main', {
      url: '/main',
      templateUrl:'templates/menu.html',
      controller: 'MenuCtrl'
    })
    .state('main.contentByCategory', {
      url: '/contentByCategory/:catId',
      templateUrl: 'templates/contentByCategory.html',
      controller: 'CatCtrl'
    })
    .state('main.contentRecent', {
      url: '/contentRecent',
      templateUrl:'templates/menuContent.html',
      controller: 'MainCtrl'
    })
    .state('main.postDetail', {
      url: '/postDetail/:postId',
      templateUrl:'templates/postDetail.html',
      controller: 'PostCtrl'
    });

    $urlRouterProvider.otherwise('/main/contentRecent');  
})