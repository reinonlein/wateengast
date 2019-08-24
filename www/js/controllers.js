angular.module('starter')
.controller('MenuCtrl', function($http, $scope, $sce, $ionicScrollDelegate){
    
    $scope.categories = [];

    $http.get("https://www.wateengast.nl/api/get_category_index/").then(
        function(returnedData){

            $scope.categories = returnedData.data.categories;
            $scope.categories.forEach(function(element, index, array){
                element.title = $sce.trustAsHtml(element.title);
            })

            console.log(returnedData);

        }, function(err){
            console.log(err);
        })

    $scope.doRefresh = function(){
        $scope.recent_posts = [];
        $http.get("https://www.wateengast.nl/api/get_posts/").then(function(data){
            console.log(data);
            $scope.recent_posts =data.data.posts;

            $scope.recent_posts.forEach(function(element, index, array){
                element.excerpt = element.excerpt.substr(0,100);
                element.excerpt = element.excerpt + "...Lees meer".bold();
                element.excertp = $sce.trustAsHtml(element.excerpt);
            })

            $scope.$broadcast('scroll.refreshComplete');

        }, function(err){

        })
    }

    $scope.recent_posts = [];
    $http.get("https://www.wateengast.nl/api/get_posts/").then(function(data){
        console.log(data);
        $scope.recent_posts =data.data.posts;

        $scope.recent_posts.forEach(function(element, index, array){
            element.excerpt = element.excerpt.substr(0,100);
            element.excerpt = element.excerpt + "...Lees meer".bold();
            element.excertp = $sce.trustAsHtml(element.excerpt);
        })

    }, function(err){

    })

    $scope.searchTextChanged = function(){
        $ionicScrollDelegate.$getByHandle('mainScroll').scrollTop(true);
    }

})
.controller('PostCtrl', function(){
    //alert('Hallo gast!');
})
