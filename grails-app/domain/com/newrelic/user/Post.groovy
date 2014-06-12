package com.newrelic.user

class Post {
    String content
    Date createdOn
    
    static belongsTo = [ user: User ]

    static hasMany = [ tags: Tag ]

    static constraints = {
        content(blank: false, maxSize: 160)
        createdOn()
    }

    static mapping = {
        sort createdOn: "desc"
    }
}
