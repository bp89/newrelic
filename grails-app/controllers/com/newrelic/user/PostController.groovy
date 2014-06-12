package com.newrelic.user

import grails.plugin.springsecurity.annotation.Secured

class PostController {
    def postService
    def springSecurityService
	
    def defaultAction = "global"
    
    @Secured(['IS_AUTHENTICATED_REMEMBERED'])
    def followAjax () {
        def user = currentUser
        def followUser = User.get(params.id)
        user.addToFollowing(followUser)
        render "You are now following ${followUser.username}"
    }
    
    @Secured(['ROLE_USER', 'IS_AUTHENTICATED_FULLY'])
    def addPostAjax (){
        def user = currentUser
        def post = postService.createNewPost(user.id, params.content)
        render(template: "postentries", model: [post: post])
    }

    def global () {
        def posts = Post.list(sort: "createdOn", order: "desc", max: 10)
        [ posts: posts, postCount: posts.size() ]
    }
    
    @Secured(['ROLE_USER'])
    def timeline () {
        def user = currentUser

        // Exercise: implement this action to return all posts of all
        // users that the current user is following.
        def posts = []
        if (user.following) {
            posts = Post.withCriteria {
                'in'("user", user.following)
                order("createdOn", "desc")
            }
        }
        [ posts: posts, postCount: posts.size() ]
    }

    @Secured(['IS_AUTHENTICATED_REMEMBERED'])
    def personal (){
        // TODO Requires current user
        def user = params.username ? User.findByUsername(params.username) : currentUser
        user.attach()

        // If we can't find the user, it's a 404
        if (!user) {
            response.sendError(404)
            return
        }
        
        // Get all the posts written by the given user
        // Exercise: sort them with most recent first.
        [ posts: user.posts, postCount: user.posts.size(), person: user ]
    }
	
    private getCurrentUser() {
        return User.get(springSecurityService.principal.id)
    }
}
