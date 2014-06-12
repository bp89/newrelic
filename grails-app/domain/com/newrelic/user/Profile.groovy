package com.newrelic.user

class Profile {
    String fullName
    String email
    byte[] portrait

    static belongsTo = [ user: User ]

    static constraints = {
        fullName(blank: false)
        email(nullable: true)
        portrait(nullable: true)
    }
}
