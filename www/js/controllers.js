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

})

.controller('MainCtrl', function($http, $scope, $sce, $ionicScrollDelegate){

    $scope.offset = 0;
    $scope.count_total = 1;

    $scope.doRefresh = function(){
        $scope.recent_posts = [];
        $http.get("https://www.wateengast.nl/api/get_posts/").then(function(data){
            console.log(data);
            $scope.recent_posts =data.data.posts;
            $scope.count_total = data.data.count_total;
            $scope.recent_posts.forEach(function(element, index, array){
                element.excerpt = element.excerpt.substr(0,100);
                element.excerpt = element.excerpt + "...meer".bold();
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
        $scope.count_total = data.data.count_total;
        $scope.recent_posts.forEach(function(element, index, array){
            element.excerpt = element.excerpt.substr(0,100);
            element.excerpt = element.excerpt + "...meer".bold();
            element.excertp = $sce.trustAsHtml(element.excerpt);
        })

    }, function(err){

    })

    $scope.canLoadMore = function(){

        return true;
    }

    $scope.loadMore = function(){

        $http.get("https://www.wateengast.nl/api/get_posts/?offset="+$scope.offset).then(function(data){
            var newPosts = data.data.posts;
            $scope.count_total = data.data.count_total;

            newPosts.forEach(function(element, index, array){
                element.excerpt = element.excerpt.substr(0,100);
                element.excerpt = element.excerpt + "...meer".bold();
                element.excertp = $sce.trustAsHtml(element.excerpt);
            })

            $scope.recent_posts.push.apply($scope.recent_posts, newPosts);
            $scope.$broadcast("scroll.infiniteScrollComplete");
            $scope.offset += 10;

    });
    };

    $scope.searchTextChanged = function(){
        $ionicScrollDelegate.$getByHandle('mainScroll').scrollTop(true);
    }
})
.controller('PostCtrl', function($http, $scope, $sce, $stateParams){
    
    $http.get('https://www.wateengast.nl/api/get_post/?id='+$stateParams.postId).then(
        function(data){
            $scope.post_title = data.data.post.title;
            $scope.post_category = data.data.post.categories[0].title ? data.data.post.categories[0]
                .title : 'no category';
            $scope.post_content = $sce.trustAsHtml(data.data.post.content);
            //$scope.post_date = data.data.post.date;
            //$scope.post_authorName = data.data.post.author.first_name + " " + data.data.post.author.last_name;
            //  if($scope.post_authorName.trim() == '')
            //    $scope.post_authorName = "No Name";
            //$scope.post_authorImage = 'http://ionicframework.com/img/docs/mcfly.jpg';
            $scope.post_image = data.data.post.thumbnail_images.full.url;
            $scope.post_commentCount = data.data.post.comment_count;
            $scope.post_views = data.data.post.custom_fields.views[0];
            $scope.post_url = data.data.post.url;
        }, function(err){

        })

})

.controller('CatCtrl', function($http, $scope, $sce, $stateParams){
    $http.get('https://www.wateengast.nl/api/get_category_posts/?id=' + $stateParams.catId).then(
        function(data){
            $scope.category_posts = data.data.posts;
            $scope.category_posts.forEach(function(element, index, array){
              element.excerpt = element.excerpt.substr(0,100);
              element.excerpt = element.excerpt + "...meer".bold();
              element.excertp = $sce.trustAsHtml(element.excerpt);
            })
            $scope.category_title = data.data.category.title;
        }, function(err){

        })
})
