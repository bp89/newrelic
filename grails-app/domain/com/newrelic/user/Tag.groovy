package com.newrelic.user

class Tag {
    String label

    static hasMany = [ posts: Post ]
    static belongsTo = Post

    static constraints = {
        label(blank: false)
    }
}
